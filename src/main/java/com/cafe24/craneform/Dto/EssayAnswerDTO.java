package com.cafe24.craneform.Dto;

import lombok.Data;

@Data
public class EssayAnswerDTO {
    
    private Integer ea_no; // 주관식 답변 일련번호
    private Integer ea_qs_no; // 질문 일련번호 (질문)
    private Integer ea_ui_no; // 유저 일련번호 (유저)
    private String ea_content; // 답변 내용

}
