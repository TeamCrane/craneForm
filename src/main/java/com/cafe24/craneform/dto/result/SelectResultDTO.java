package com.cafe24.craneform.dto.result;

import lombok.Data;

@Data
public class SelectResultDTO {

    private Integer si_no; // 설문 일련번호
    private String si_subtitle; // 설문 제목

    private Integer qs_no; // 질문 일련번호
    private String qs_type; // 질문 유형
    private String qs_detail; // 질문 내용
    private Integer qs_order; // 질문 순번

    private String so_detail; // 옵션 내용
    private Integer so_order; // 옵션 순번

    private Integer sa_count; // 객관식 답변 개수

}
