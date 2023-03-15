package com.cafe24.craneform.dto;

import lombok.Data;

@Data
public class SelectAnswerDTO {

    private Integer sa_no; // 객관식 답변 일련번호
    private Integer sa_qs_no; // 질문 일련번호 (질문)
    private Integer sa_ui_no; // 유저 일련번호 (유저)
    private Integer sa_so_no; // 객관식 옵션 일련번호 (객관식 옵션)

}
