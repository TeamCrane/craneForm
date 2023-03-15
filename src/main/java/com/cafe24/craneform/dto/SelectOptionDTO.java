package com.cafe24.craneform.dto;

import lombok.Data;

@Data
public class SelectOptionDTO {

    private Integer so_no; // 객관식 옵션 일련번호
    private Integer so_qs_no; // 질문 일련번호 (질문)
    private String so_detail; // 옵션 내용
    private Integer so_order; // 옵션 순번

}
