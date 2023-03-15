package com.cafe24.craneform.service;

import com.cafe24.craneform.dao.UserDAO;
import com.cafe24.craneform.dto.UserInfoDTO;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import javax.sound.midi.Soundbank;
import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class HomeService {

    @Autowired
    private UserDAO userDAO;

    public Map<String, Object> login (HttpSession session, @RequestParam String email, @RequestParam String pwd) {

        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
         UserInfoDTO loginUser = userDAO.loginUser(email, pwd);

        if(loginUser == null) {
            resultMap.put("status", false);
            resultMap.put("message", "아이디 또는 비밀번호가 틀렸습니다.");
        }
        else {
            session.setAttribute("user", loginUser);
            resultMap.put("status", true);
            resultMap.put("message", "로그인 되었습니다.");
        }

        return resultMap;
    }

    public Map<String, Object> logout(HttpSession session) {
        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
        session.setAttribute("user", null);
        resultMap.put("status", true);
        resultMap.put("message", "로그아웃 되었습니다.");

        return resultMap;
    }

    public Map<String, Object> signup (@RequestBody UserInfoDTO user) {
        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
        if(user.getUi_name().length() > 20) {
            resultMap.put("status", false);
            resultMap.put("message", "이름은 20자를 넘을 수 없습니다.");
            return resultMap;
        }
        else if(user.getUi_email().split("@").length != 2) {
            resultMap.put("status", false);
            resultMap.put("message", "이메일 형식을 확인해주세요.");
            return resultMap;
        }
        else if(user.getUi_password().length() > 16 || user.getUi_password().length() < 2) {
            resultMap.put("status", false);
            resultMap.put("message", "비밀번호는 2 ~ 16자 제한입니다.");
            return resultMap;
        }
        else if(user.getUi_phone().length() != 12 && user.getUi_phone().length() != 13) {
            resultMap.put("status", false);
            resultMap.put("message", "전화번호 형식을 확인해주세요.\nex) 010XXXXOOOO");
            return resultMap;
        }

//        member_mapper.insertMemberJoin(user);
        userDAO.signupUser(user);
        resultMap.put("status", true);
        resultMap.put("message", "가입되었습니다.");

        return resultMap;
    }
}
