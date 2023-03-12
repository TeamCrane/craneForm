package com.cafe24.craneform;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

    public HomeController() {
        System.out.println("----- HomeController 객체 생성");
    }

    @RequestMapping("/")
    public String Home() {
        return "index";
    }
}
