package com.cafe24.craneform.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/analysis")
public class AnalysisController {

    @GetMapping("/select")
    public String getAnalysisSelect(@RequestParam String no) {
        return "/analysis/select";
    }
}
