package com.cafe24.craneform.dto;

import lombok.Data;

@Data
public class QuestionDTO {

    private Integer qs_no; // 질문 일련번호
    private Integer qs_si_no; // 설문 일련번호 (설문)
    private String qs_type; // 질문 유형
    private String qs_detail; // 질문 내용
    private String qs_required; // 필수 여부
    private Integer qs_order; // 질문 순번

}
