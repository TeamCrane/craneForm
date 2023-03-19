package com.cafe24.craneform.service;

import com.cafe24.craneform.dao.SurveyDAO;
import com.cafe24.craneform.dto.QuestionDTO;
import com.cafe24.craneform.dto.SelectOptionDTO;
import com.cafe24.craneform.dto.SurveyConditionDTO;
import com.cafe24.craneform.dto.SurveyInfoDTO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class SurveyService {

    /* TODO
    *   진행 상태 & 종료일 - 추가 작업 필요
    * */

    @Autowired
    private SurveyDAO surveyDAO;

    // 설문 제출
    public int submit(Map<String, String> jsonData, HttpSession session) {

        SurveyInfoDTO surveyInfoDTO = new SurveyInfoDTO(); // 설문 정보
        SurveyConditionDTO surveyConditionDTO = new SurveyConditionDTO(); // 설문 조건
        QuestionDTO questionDTO = new QuestionDTO(); // 질문
        SelectOptionDTO selectOptionDTO = new SelectOptionDTO(); // 객관식 옵션

        // 설문 정보 테이블에 유저 정보 담기
        int no = (int) session.getAttribute("no");
        surveyInfoDTO.setSi_ui_no(no);

        // json 데이터를 문자열로 받아와서 분리
        String formData = jsonData.get("form_data");
        String[] parts = formData.split("&");

        // 질문과 옵션을 저장하기 위한 배열 선언
        String[][] questionArray = null; // [질문 순번][질문 유형, 필수 여부, 다중 선택, 질문 내용] / 질문이 여러개일 수 있으니 이차 배열
        List<String> optionList = new ArrayList<>(); // [index: 옵션 순번, value: 옵션 내용] / 질문 순번은 아래서 구분

        int surveyNo = 0; // 설문 번호 (db에 저장된 값)
        List<Integer> questionNoList = new ArrayList<>(); // 질문 번호 (db에 저장된 값)
        int questionIdx = 0; // 질문 순번
        int cnt = 0; // 최종 결과

        int qCnt = 0; // 질문 수를 알기 위해 질문 유형이 몇개 있는지 카운트
        for (String s : parts) {
            if (s.contains("question_type")) {
                qCnt++;
            }
        }

        int[] oCnt = new int[qCnt]; // 옵션 수 카운트
        int oCntIdx = 0; // 옵션 수에 쓸 인덱스
        for (String s : parts) {
            if (s.contains("option_" + oCntIdx)) {
                oCnt[oCntIdx]++;
            } else if (s.contains("option_" + (oCntIdx + 1))) {
                oCnt[oCntIdx + 1]++;
                oCntIdx++;
            }
        }

        // '='을 기준으로 잘라서 db에 insert 가능하도록 가공
        for (String part : parts) {
            String[] pair = part.split("=");

            // key와 value 분리
            String key = pair[0];
            String value = "";
            if (pair.length < 2) { // value 값이 없는 경우
                value = "";
            } else {
                value = pair[1];
            }

            switch (key) {
                // 설문 정보
                case "title" -> surveyInfoDTO.setSi_subtitle(URLDecoder.decode(value, StandardCharsets.UTF_8).trim());
                case "description" -> surveyInfoDTO.setSi_detail(URLDecoder.decode(value, StandardCharsets.UTF_8).trim());
                // 설문 조건
            }

            // 진행 상태 & 종료일 - 추가 작업 필요
            surveyInfoDTO.setSi_state("진행 중");
            LocalDate now = LocalDate.now();
            surveyInfoDTO.setSi_end_date(Date.valueOf(now));

            // 질문 정보과 옵션 정보
            if (key.contains("question")) { // 질문의 경우
                String[] keyArray = key.split("_");

                // 선언되지 않았을 때만 선언
                if (questionArray == null) {
                    questionArray = new String[qCnt][4];
                }

                // question_ 다음에 오는게 숫자인지 판단. 숫자라면 questionIdx를 갱신한다
                if (keyArray[1].matches("\\d*")) {
                    questionIdx = Integer.parseInt(keyArray[1]);
                }

                if (key.contains("question_type_")) { // 질문 유형
                    questionArray[questionIdx][0] = URLDecoder.decode(value, StandardCharsets.UTF_8).trim();
                } else if (key.contains("question_required_")) { // 필수 여부
                    questionArray[questionIdx][1] = URLDecoder.decode(value, StandardCharsets.UTF_8).trim();
                } else if (key.contains("question_multi_")) { // 다중 선택 여부
                    questionArray[questionIdx][2] = URLDecoder.decode(value, StandardCharsets.UTF_8).trim();
                } else if (key.equals("question_"+questionIdx)) { // 질문 내용
                    questionArray[questionIdx][3] = URLDecoder.decode(value, StandardCharsets.UTF_8).trim();
                }

            } else if (key.contains("option")) { // 옵션의 경우

                // list에 담아서 아래에서 oCnt 배열에 담긴 숫자만큼 자른다
                optionList.add(URLDecoder.decode(value, StandardCharsets.UTF_8).trim());
            }

        }

        // 설문 정보 insert (진행 상태 & 종료일 수정 후 추가 작업 필요)
        surveyNo = surveyDAO.insertSurveyInfo(surveyInfoDTO);

        // dto에 정보 담고 질문 insert
        if (surveyNo > 0) {
            for (int i = 0; i < qCnt; i++) {
                questionDTO.setQs_order(i);
                questionDTO.setQs_si_no(surveyNo);
                assert questionArray != null;
                questionDTO.setQs_type(questionArray[i][0]);
                questionArray[i][1] = (questionArray[i][1] == null) ? "" : questionArray[i][1]; // 필수 순번이 없다면 채우기
                questionArray[i][2] = (questionArray[i][2] == null) ? "" : questionArray[i][2]; // 다중 선택이 없다면 채우기
                questionDTO.setQs_required(questionArray[i][1]);
                questionDTO.setQs_multi(questionArray[i][2]);
                questionDTO.setQs_detail(questionArray[i][3]);
                questionNoList.add(surveyDAO.insertQuestion(questionDTO));
            }
        }

        if (questionNoList.size() == qCnt) { // questionNoList가 질문 수를 제대로 가져왔으면
            int tmp_oCnt = 0;

            for (int i = 0; i < qCnt; i++) {
                for (int j = 0; j < oCnt[i]; j++) {
                    selectOptionDTO.setSo_qs_no(questionNoList.get(i));
                    selectOptionDTO.setSo_order(j);
                    selectOptionDTO.setSo_detail(optionList.get(tmp_oCnt++));
                    cnt += surveyDAO.insertSelectOption(selectOptionDTO);
                }
            }
        }

        return cnt;
    }

}
