package com.cafe24.craneform.api;

import com.cafe24.craneform.service.SurveyService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class SurveyAPIController {

    @Autowired
    private SurveyService surveyService;

    // 설문 제출
    @PostMapping(value = "/submitSurvey")
    public int submitSurvey(@RequestBody Map<String, String> json_data, HttpSession session) {
        return surveyService.submit(json_data, session);
    }
}
