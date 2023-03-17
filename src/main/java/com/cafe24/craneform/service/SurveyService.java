package com.cafe24.craneform.service;

import com.cafe24.craneform.dto.QuestionDTO;
import com.cafe24.craneform.dto.SelectOptionDTO;
import com.cafe24.craneform.dto.SurveyConditionDTO;
import com.cafe24.craneform.dto.SurveyInfoDTO;
import org.springframework.stereotype.Service;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.Map;

@Service
public class SurveyService {

    SurveyInfoDTO surveyInfoDTO = new SurveyInfoDTO(); // 설문 정보
    SurveyConditionDTO surveyConditionDTO = new SurveyConditionDTO(); // 설문 조건
    QuestionDTO questionDTO = new QuestionDTO(); // 질문
    SelectOptionDTO selectOptionDTO = new SelectOptionDTO(); // 객관식 옵션

    // 설문 제출
    public int submit(Map<String, String> jsonData) {

        // json 데이터를 문자열로 받아와서 분리
        String formData = jsonData.get("form_data");
        String[] parts = formData.split("&");

        String question = "";
        String option = "";

        // '='을 기준으로 자르기
        for (String part : parts) {
            String[] pair = part.split("=");
            String key = pair[0];
            String value = pair[1];

            if (key.equals("question")) {
                question = URLDecoder.decode(value, StandardCharsets.UTF_8);
            } else if (key.equals("option")) {
                option = URLDecoder.decode(value, StandardCharsets.UTF_8);
            }

            System.out.println(question.trim());
            System.out.println(option.trim());
        }

        return 1;
    }

}
