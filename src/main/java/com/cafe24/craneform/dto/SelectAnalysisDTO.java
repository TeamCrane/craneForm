package com.cafe24.craneform.dto;

import lombok.Data;

@Data
public class SelectAnalysisDTO {

    private Integer san_no; // 분석 일련번호
    private Integer san_qs_no; // 질문 일련번호 (질문)
    private Integer san_sl_no; // 객관식 옵션 일련번호 (객관식 옵션)

}
