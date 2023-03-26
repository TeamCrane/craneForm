package com.cafe24.craneform.service;

import com.cafe24.craneform.dao.SurveyDAO;
import com.cafe24.craneform.dto.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class SurveyService {

    /* TODO
     *   진행 상태 & 종료일 - 추가 작업 필요
     * */

    @Autowired
    private SurveyDAO surveyDAO;

    // 설문 제출
    public int Submit(Map<String, String> jsonData, HttpSession session) {

        SurveyInfoDTO surveyInfoDTO = new SurveyInfoDTO(); // 설문 정보
        SurveyConditionDTO surveyConditionDTO = new SurveyConditionDTO(); // 설문 조건
        QuestionDTO questionDTO = new QuestionDTO(); // 질문
        SelectOptionDTO selectOptionDTO = new SelectOptionDTO(); // 객관식 옵션
        EssayOptionDTO essayOptionDTO = new EssayOptionDTO(); // 주관식 옵션

        // 설문 정보 테이블에 유저 정보 담기
        int no = (int) session.getAttribute("no");
        surveyInfoDTO.setSi_ui_no(no);

        // 설문을 저장할 배열, 질문과 옵션을 저장할 map 생성
        String[] surveyArr = new String[5];
        Map<String, Map<String, String>> questionMap = new LinkedHashMap<>();
        Map<String, String> innerMap = null; // 값이 섞이는 걸 방지하기 위해 필요할 때마다 초기화

        String questionNo = ""; // 질문 순서 (qs_order 칼럼)
        String questionType = ""; // 질문 유형 (qs_type 칼럼)
        Map<String, Integer> oCnt = new LinkedHashMap<>(); // 답변 수

        // json 데이터를 문자열로 받아와서 분리
        String formData = jsonData.get("form_data");
        String[] parts = formData.split("&");

        /* TODO 수정 필요 임시 파트 : */
        surveyInfoDTO.setSi_state("진행 중");
        LocalDate now = LocalDate.now();
        surveyInfoDTO.setSi_end_date(Date.valueOf(now));


        for (String part : parts) {
            String[] keyValue = part.split("="); // key == 유형, value == 내용
            String key = keyValue[0]; // 유형
            String value = URLDecoder.decode(keyValue[1], StandardCharsets.UTF_8).trim(); // 내용 (내용에 =가 있어도 오류 나지 않게 이 타이밍에 디코드)
            String[] keyArr = key.split("_");

            if (key.contains("title")) { // 설문지 제목
                surveyInfoDTO.setSi_subtitle(value);

            } else if (key.contains("description")) { // 설문지 설명
                surveyInfoDTO.setSi_detail(value);

            } else if (key.contains("question") && keyArr[1].matches("\\d*")) { // 질문 제목 (정규식을 사용해서 하나 이상의 숫자가 포함되는지 확인)
                if (questionNo.equals("")) { // 최초에
                    questionNo = keyArr[1];
                    innerMap = new LinkedHashMap<>();
                } else if (!questionNo.equals(keyArr[1])) { // 질문 순서(qs_order)가 달라지면
                    questionMap.put(questionNo, innerMap);
                    innerMap = new LinkedHashMap<>();
                    questionNo = keyArr[1];
                }
                innerMap.put("question", value);

            } else if (key.contains("question_type")) { // 질문 유형
                questionType = value;
                innerMap.put("question_type", value);

            } else if (key.contains("question_required")) { // 필수 여부
                innerMap.put("question_required", value);

            } else if (key.contains("option")) {
                // 옵션 파트. 질문 유형에 따라 분기
                switch (questionType) {
                    case "객관식", "체크박스", "셀렉트박스" -> {
                        innerMap.put("option_"+keyArr[2], value);
                        oCnt.put(keyArr[1], Integer.parseInt(keyArr[2])+1); // key == 질문 순서, value == 해당 질문 순서에 속해있는 옵션 수
                    }
                    case "주관식 - 단답형", "주관식 - 장문형" -> {
                        innerMap.put("option_"+keyArr[1], value);
                        oCnt.put(keyArr[2], 1); // key == 질문 순서, value == 1
                    }
                    case "객관식 표", "체크박스 표" -> innerMap.put(key, value);
                }
            }

        }

        int surveyCnt = surveyDAO.insertSurveyInfo(surveyInfoDTO); // 설문 제출
        questionMap.put(questionNo, innerMap); // 마지막 반복 때엔 질문 순서(qs_order)의 변화가 없으니 넣어준다.

        // 질문 제출
        for (int i = 0; i < questionMap.size(); i++) {
            String str_i = String.valueOf(i); // i의 문자열화

            questionDTO.setQs_order(i); // 질문 순서
            questionDTO.setQs_type(questionMap.get(str_i).get("question_type")); // 질문 유형
            if (questionMap.get(str_i).get("question_required") == null) { // 질문 필수 여부
                questionDTO.setQs_required("");
            } else {
                questionDTO.setQs_required(questionMap.get(str_i).get("question_required"));
            }
            questionDTO.setQs_detail(questionMap.get(str_i).get("question")); // 질문 내용
            questionDTO.setQs_si_no(surveyCnt); // 설문 번호
            int questionCnt = surveyDAO.insertQuestion(questionDTO);

            // 옵션 제출
            if (questionDTO.getQs_type().equals("객관식") || questionDTO.getQs_type().equals("체크박스") || questionDTO.getQs_type().equals("셀렉트박스")) {
                for (int j = 0; j < oCnt.get(str_i); j++) {
                    selectOptionDTO.setSo_qs_no(questionCnt);
                    selectOptionDTO.setSo_order(j);
                    selectOptionDTO.setSo_detail(questionMap.get(str_i).get("option_"+j));
                    int optionCnt = surveyDAO.insertSelectOption(selectOptionDTO);
                }
            } else if (questionDTO.getQs_type().equals("주관식 - 단답형") || questionDTO.getQs_type().equals("주관식 - 장문형")) {
                essayOptionDTO.setEo_qs_no(questionCnt);
                essayOptionDTO.setEo_min(Integer.parseInt(questionMap.get(str_i).get("option_min")));
                essayOptionDTO.setEo_max(Integer.parseInt(questionMap.get(str_i).get("option_max")));
                int optionCnt = surveyDAO.insertEssayOption(essayOptionDTO);
            }
        }

        return 1;
    }

    // 답변 제출
    public int submitAnswer(Map<String, String> jsonData, HttpSession session) {

        SelectAnswerDTO selectAnswerDTO = new SelectAnswerDTO();
        EssayAnswerDTO essayAnswerDTO = new EssayAnswerDTO();

        // json 데이터를 문자열로 받아와서 분리
        String formData = jsonData.get("form_data");
        String[] parts = formData.split("&");

        String question_type = ""; // 질문 유형
        int no = (int) session.getAttribute("no"); // 유저 번호
        int cnt = 0;

        for (String part : parts) {
            String[] keyValue = part.split("="); // key == 유형, value == 내용
            String key = keyValue[0]; // 유형
            String value = URLDecoder.decode(keyValue[1], StandardCharsets.UTF_8).trim(); // 내용 (내용에 =가 있어도 오류 나지 않게 이 타이밍에 디코드)
            String[] keyArr = key.split("_");

            if (key.contains("answer_type")) { // 질문 유형
                question_type = value;
                continue;
            }

            if (question_type.equals("객관식") || question_type.equals("셀렉트박스")) { // 객관식
                selectAnswerDTO.setSa_ui_no(no);
                selectAnswerDTO.setSa_qs_no(Integer.parseInt(keyArr[1]));
                selectAnswerDTO.setSa_so_no(Integer.parseInt(value));
                cnt = surveyDAO.insertSelectAnswer(selectAnswerDTO);

            } else if (question_type.equals("체크박스")) { // 다중 선택이 가능하기에 분리
                selectAnswerDTO.setSa_ui_no(no);
                selectAnswerDTO.setSa_qs_no(Integer.parseInt(keyArr[1]));
                selectAnswerDTO.setSa_so_no(Integer.parseInt(keyArr[2]));
                cnt = surveyDAO.insertSelectAnswer(selectAnswerDTO);

            } else if (question_type.equals("주관식 - 단답형") || question_type.equals("주관식 - 장문형")) { // 주관식
                essayAnswerDTO.setEa_ui_no(no);
                essayAnswerDTO.setEa_qs_no(Integer.parseInt(keyArr[1]));
                essayAnswerDTO.setEa_content(value);
                cnt = surveyDAO.insertEssayAnswer(essayAnswerDTO);
            }
        }

        return 1;
    }

}
