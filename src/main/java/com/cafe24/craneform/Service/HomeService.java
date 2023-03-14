package com.cafe24.craneform.Service;

import com.cafe24.craneform.Dto.UserInfoDTO;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class HomeService {
    public Map<String, Object> login (HttpSession session, @RequestParam String id, @RequestParam String pwd) {
        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
        UserInfoDTO user = null;

        if(user == null) {
            resultMap.put("status", false);
            resultMap.put("message", "아이디 또는 비밀번호가 틀렸습니다.");
        }
        else {
            session.setAttribute("user", user);
            resultMap.put("status", true);
            resultMap.put("message", "로그인 되었습니다.");
        }

        return resultMap;
    }

    public Map<String, Object> join (@RequestBody UserInfoDTO user) {
        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();

        return resultMap;
    }
}
