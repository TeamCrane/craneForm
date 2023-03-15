package com.cafe24.craneform.dto;

import lombok.Data;

@Data
public class TableOptionDTO {

    private Integer to_no; // 표 옵션 일련번호
    private Integer to_qs_no; // 질문 일련번호 (질문)
    private String to_detail; // 옵션 내용
    private Character to_matrix; // 행렬
    private Integer to_order; // 행렬 순번

}
