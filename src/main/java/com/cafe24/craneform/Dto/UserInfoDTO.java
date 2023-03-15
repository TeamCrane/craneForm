package com.cafe24.craneform.Dto;

import lombok.Data;

import java.util.Date;

@Data
public class UserInfoDTO {

    private Integer ui_no; // 유저 일련번호
    private String ui_name; // 이름
    private String ui_email; // 이메일
    private String ui_addr; // 주소
    private String ui_phone; // 번호
    private Character ui_gender; // 성별
    private Date ui_birth; // 생년월일
    private String ui_password; // 비밀번호
    private Date ui_created_date; // 가입일
    
}
