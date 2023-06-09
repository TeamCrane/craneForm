package com.cafe24.craneform.api;

import com.cafe24.craneform.dto.UserInfoDTO;
import com.cafe24.craneform.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/user")
public class UserAPIController {

    @Autowired UserService user_service;

    @PatchMapping("/modify")
    public Map<String, Object> patchUserModify(HttpSession session, @RequestBody UserInfoDTO user) {
        return user_service.userModify(session,user);
    }
}
