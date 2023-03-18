package com.cafe24.craneform.dao;

import com.cafe24.craneform.dto.UserInfoDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO {

    @Autowired
    private SqlSession sqlSession;

    public UserInfoDTO loginUser(String email, String pwd) {
         UserInfoDTO user = new UserInfoDTO();
         user.setUi_email(email);
         user.setUi_password(pwd);

         return sqlSession.selectOne("user.login", user);
    }

    public boolean dupChkEmail(String email) { return sqlSession.selectOne("user.dup_email", email); }

    public void signupUser(UserInfoDTO user) { sqlSession.insert("user.signup", user); }

    public void modifyUser(UserInfoDTO user) { sqlSession.update("user.modify", user); }
}
