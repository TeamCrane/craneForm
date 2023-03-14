package com.cafe24.craneform.Api;

import com.cafe24.craneform.Dto.UserInfoDTO;
import com.cafe24.craneform.Service.HomeService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class HomeAPIController {
    @Autowired HomeService home_service;
    @GetMapping("/login")
    public Map<String, Object> getLogin(HttpSession session, @RequestParam String id, @RequestParam String pwd) {
        return home_service.login(session, id, pwd);
    }
    @PutMapping("/join")
    public Map<String, Object> putJoin(@RequestBody UserInfoDTO user) {
        return null;
    }
}
