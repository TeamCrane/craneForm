package com.cafe24.craneform.api;

import com.cafe24.craneform.dto.UserInfoDTO;
import com.cafe24.craneform.service.HomeService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class HomeAPIController {

    @Autowired HomeService home_service;

    @GetMapping("/login")
    public Map<String, Object> getLogin(HttpSession session, @RequestParam String email, @RequestParam String pwd) {
        return home_service.login(session, email, pwd);
    }

    @PutMapping("/sign_up")
    public Map<String, Object> putSignUp(@RequestBody UserInfoDTO user) {
        return home_service.signUp(user);
    }
}
