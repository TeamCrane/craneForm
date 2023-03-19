package com.cafe24.craneform.controller;

import com.cafe24.craneform.dao.SurveyDAO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

    @Autowired
    private SurveyDAO surveyDAO;

    public HomeController() {
        System.out.println("----- HomeController 객체 생성");
    }

    @GetMapping("/")
    public ModelAndView Home(HttpSession session) {
        ModelAndView mav = new ModelAndView();
        if (session.getAttribute("user") == null) {
            mav.setViewName("redirect:/login");
        } else {
            mav.addObject("surveyInfoList", surveyDAO.surveyInfoList());
            mav.addObject("ui_no", session.getAttribute("no"));
            mav.setViewName("/index");
        }
        return mav;
    }

    @GetMapping("/login")
    public String login(HttpSession session) {
        if (session.getAttribute("user") != null) { return "redirect:/"; }
        return "/user/login";
    }

    @GetMapping("/signup")
    public String signup() {
        return "/user/signup";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
