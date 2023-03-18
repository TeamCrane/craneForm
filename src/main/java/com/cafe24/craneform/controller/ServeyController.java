package com.cafe24.craneform.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/survey")
public class ServeyController {

    public ServeyController() {
        System.out.println("----- ServeyController 객체 생성");
    }

    @GetMapping("/form")
    public String AddSurvey(HttpSession session) {
        if (session.getAttribute("user") != null) { return "/survey/form"; }
        return "redirect:/";
    }

}
