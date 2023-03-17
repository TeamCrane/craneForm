package com.cafe24.craneform.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/user")
public class UserController {

    @GetMapping("/profile")
    public String getUserProfile(@RequestParam String no) { return "/user/profile"; }

    @GetMapping("/modify")
    public String getUserModify(@RequestParam String no) { return "/user/modify"; }
}
