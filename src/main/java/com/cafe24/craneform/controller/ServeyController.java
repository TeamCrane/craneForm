package com.cafe24.craneform.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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

    @GetMapping("/detail/{si_no}")
    public ModelAndView surveyDetail(@PathVariable int si_no) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/survey/detail");
        return mav;
    }
}
