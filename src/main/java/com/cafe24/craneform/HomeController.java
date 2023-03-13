package com.cafe24.craneform;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

    public HomeController() {
        System.out.println("----- HomeController 객체 생성");
    }

    @GetMapping("/")
    public String Home(HttpSession session) {
        if (session.getAttribute("id") != null) {
            return "index";
        } else {
            return "/member/login";
        }
    }
}
