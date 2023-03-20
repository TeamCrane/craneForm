package com.cafe24.craneform.api;

import com.cafe24.craneform.service.AnalysisService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/analysis")
public class AnalysisAPIController {

    @Autowired
    AnalysisService analysis_service;

    @GetMapping("/select")
    public Map<String, Object> getAnalysisSelect(HttpSession session) {
        return analysis_service.selectResult((int)session.getAttribute("no"));
    }

}
