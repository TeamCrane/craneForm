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
    public Map<String, Object> login (HttpSession session, @RequestParam String email, @RequestParam String pwd) {
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

    public Map<String, Object> signUp (@RequestBody UserInfoDTO user) {
        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
        if(user.getUi_name().length() > 20) {
            resultMap.put("status", false);
            resultMap.put("message", "이름은 20자를 넘을 수 없습니다.");
            return resultMap;
        }
        else if(user.getUi_email().split("@").length == 2) {
            resultMap.put("status", false);
            resultMap.put("message", "이메일 형식을 확인해주세요.");
            return resultMap;
        }
        else if(user.getUi_password().length() > 16) {
            resultMap.put("status", false);
            resultMap.put("message", "비밀번호는 16자를 넘을 수 없습니다.");
            return resultMap;
        }
        else if(user.getUi_phone().length() != 10 && user.getUi_phone().length() != 11) {
            resultMap.put("status", false);
            resultMap.put("message", "전화번호 형식을 확인해주세요.\nex) 010XXXXOOOO");
            return resultMap;
        }

//        member_mapper.insertMemberJoin(user);
        resultMap.put("status", true);
        resultMap.put("message", "가입되었습니다.");

        return resultMap;
    }
}
