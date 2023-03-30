package com.cafe24.craneform.controller;

import com.cafe24.craneform.dao.SurveyDAO;
import com.cafe24.craneform.service.SurveyService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
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

    @Autowired
    private SurveyDAO surveyDAO = new SurveyDAO();

    // 폼 작성 페이지 이동
    @GetMapping("/form")
    public String addSurvey(HttpSession session) {
        if (session.getAttribute("user") != null) { return "/survey/form"; }
        return "redirect:/";
    }

    // 설문 상세 페이지 이동
    @GetMapping("/detail/{si_no}")
    public ModelAndView surveyDetail(@PathVariable int si_no) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("surveyInfo", surveyDAO.surveyInfoOne(si_no)); // 설문 정보
        mav.addObject("allInfo", surveyDAO.allSurveyInfo(si_no)); // 질문, 옵션
        mav.setViewName("/survey/detail");
        return mav;
    }

}
