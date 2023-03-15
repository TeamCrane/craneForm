package com.cafe24.craneform.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    public HomeController() {
        System.out.println("----- HomeController 객체 생성");
    }

    @GetMapping("/")
    public String Home(HttpSession session) {
        if (session.getAttribute("user") == null) { return "redirect:/login"; }
        return "index";
    }

    @GetMapping("/login")
    public String login(HttpSession session) {
        if (session.getAttribute("user") != null) { return "redirect:/"; }
        return "/user/login";
    }

    @GetMapping("/signup")
    public String signup(HttpSession session) {
        return "/user/signup";
    }
}
