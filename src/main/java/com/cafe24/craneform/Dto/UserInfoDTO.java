package com.cafe24.craneform.Dto;

import lombok.Data;

import java.util.Date;

@Data
public class UserInfoDTO {
    private Integer ui_no;
    private String ui_name;
    private String ui_email;
    private String ui_addr;
    private String ui_phone;
    private Character ui_gender;
    private Date ui_birth;
    private String ui_password;
    private Date ui_created_date;
}
