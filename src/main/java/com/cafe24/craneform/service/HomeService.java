package com.cafe24.craneform.service;

import com.cafe24.craneform.dao.UserDAO;
import com.cafe24.craneform.dto.UserInfoDTO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class HomeService {

    @Autowired
    private UserDAO userDAO;

    public Map<String, Object> login (HttpSession session, String email, String pwd) {

        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
         UserInfoDTO loginUser = userDAO.loginUser(email, pwd);

        if(loginUser == null) {
            resultMap.put("status", false);
            resultMap.put("message", "이메일 또는 비밀번호가 틀렸습니다.");
        }
        else {
            session.setAttribute("user", loginUser);
            session.setAttribute("no", loginUser.getUi_no());
            session.setAttribute("name", loginUser.getUi_name());
            session.setAttribute("email", loginUser.getUi_email());
            session.setAttribute("addr", loginUser.getUi_addr());
            session.setAttribute("phone", loginUser.getUi_phone());
            session.setAttribute("gender", loginUser.getUi_gender()==null?"선택안함":loginUser.getUi_gender().equals('m')?"남":"여");
            session.setAttribute("birth", new SimpleDateFormat("yyyy-MM-dd").format(loginUser.getUi_birth()));
            session.setAttribute("birthStr", new SimpleDateFormat("yyyy년 MM월 dd일").format(loginUser.getUi_birth()));
            session.setAttribute("password", loginUser.getUi_password());
            session.setAttribute("created_date", new SimpleDateFormat("yyyy년 MM월 dd일").format(loginUser.getUi_created_date()));
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

    public Map<String, Object> signup (UserInfoDTO user) {
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
        else if(userDAO.dupChkEmail(user.getUi_email())) {
            resultMap.put("status", false);
            resultMap.put("message", "이미 사용 중인 이메일입니다.");
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

        userDAO.signupUser(user);
        resultMap.put("status", true);
        resultMap.put("message", "가입되었습니다.");

        return resultMap;
    }
}
