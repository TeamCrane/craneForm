package com.cafe24.craneform.service;

import com.cafe24.craneform.dao.SurveyDAO;
import com.cafe24.craneform.dto.QuestionDTO;
import com.cafe24.craneform.dto.SelectOptionDTO;
import com.cafe24.craneform.dto.SurveyConditionDTO;
import com.cafe24.craneform.dto.SurveyInfoDTO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;

@Service
public class SurveyService {

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
        String[] optionArray = new String[0]; // [index: 옵션 순번, value: 옵션 내용] / 질문 순번은 아래서 구분

        int questionCnt = 0; // 질문 순번
        int questionNo = 0; // 질문 번호 (select 결과)
        int optionIdx = 0; // 옵션에서 쓸 index

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

            // 설문 정보 insert
            // int cnt = surveyDAO.insertSurveyInfo(surveyInfoDTO);

            // -------------------------------------------- 순서 체크
            System.out.println(1);


            int qCnt = Collections.frequency(Arrays.asList(parts), "question_type"); // 질문 수를 알기 위해 질문 유형이 몇개 있는지 카운트
            int oCnt = Collections.frequency(Arrays.asList(parts), "option_" + qCnt + "_"); // 옵션 수 카운트

            System.out.println(qCnt); // 오류 발생. 수정 필요

            // 질문 정보과 옵션 정보
            if (key.contains("question")) { // 질문의 경우
                String[] keyArray = key.split("_");

                // -------------------------------------------- 순서 체크
                System.out.println(2);


                // 선언되지 않았을 때만 선언
                if (questionArray == null) {
                    questionArray = new String[qCnt][4];
                }

                // 질문 순번이 0번이 아닐 때마다 질문 insert
                if (Integer.parseInt(keyArray[1]) == 0) {
                    questionCnt = Integer.parseInt(keyArray[1]);
                } else {
                    questionDTO.setQs_order(questionCnt);
                    questionDTO.setQs_type(questionArray[questionCnt][0]);

                    questionArray[questionCnt][1] = (questionArray[1] == null) ? "" : questionArray[questionCnt][1]; // 필수 순번이 없다면 채우기
                    questionArray[questionCnt][2] = (questionArray[2] == null) ? "" : questionArray[questionCnt][2]; // 다중 선택이 없다면 채우기
                    questionDTO.setQs_required(questionArray[questionCnt][1]);
                    questionDTO.setQs_multi(questionArray[questionCnt][2]);
                    questionDTO.setQs_detail(questionArray[questionCnt][2]);



                    // questionNo = surveyDAO.insertQuestion(questionCnt, questionArray[questionCnt]);
                    questionCnt = Integer.parseInt(keyArray[1]);
                }

                if (key.contains("question_type")) { // 질문 유형
                    questionArray[questionCnt][0] = URLDecoder.decode(value, StandardCharsets.UTF_8).trim();
                } else if (key.contains("question_required")) { // 필수 여부
                    questionArray[questionCnt][1] = URLDecoder.decode(value, StandardCharsets.UTF_8).trim();
                } else if (key.contains("question_multi")) { // 다중 선택 여부
                    questionArray[questionCnt][2] = URLDecoder.decode(value, StandardCharsets.UTF_8).trim();
                } else if (key.equals("question_"+keyArray[1])) { // 질문 내용
                    questionArray[questionCnt][3] = URLDecoder.decode(value, StandardCharsets.UTF_8).trim();
                }
            } else if (key.contains("option")) { // 옵션의 경우

                // -------------------------------------------- 순서 체크
                System.out.println(3);

                String[] keyArray = key.split("_");

                // 옵션의 갯수가 달라지면 새로 선언
                if (oCnt != optionArray.length) {
                    optionArray = new String[oCnt];
                    optionIdx = 0;
                }

                optionArray[optionIdx++] = URLDecoder.decode(value, StandardCharsets.UTF_8).trim();
            }

        }

        return 1;
    }

}
