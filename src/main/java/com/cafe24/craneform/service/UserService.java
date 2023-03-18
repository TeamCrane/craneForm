package com.cafe24.craneform.service;

import com.cafe24.craneform.dao.UserDAO;
import com.cafe24.craneform.dto.UserInfoDTO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.text.SimpleDateFormat;
import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class UserService {

    @Autowired
    private UserDAO userDAO;

    public Map<String, Object> userModify(HttpSession session, @RequestBody UserInfoDTO user) {
        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();

        if(user.getUi_phone().length() != 12 && user.getUi_phone().length() != 13) {
            resultMap.put("status", false);
            resultMap.put("message", "전화번호 형식을 확인해주세요.\nex) 010XXXXOOOO");
            return resultMap;
        }

        userDAO.modifyUser(user);
        resultMap.put("status", true);
        resultMap.put("message", "변경되었습니다.");

        UserInfoDTO loginUser = userDAO.loginUser((String)session.getAttribute("email"), (String)session.getAttribute("password"));

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

        return resultMap;
    }
}
