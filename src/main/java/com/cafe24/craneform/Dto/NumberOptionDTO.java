package com.cafe24.craneform.Dto;

import lombok.Data;

@Data
public class NumberOptionDTO {

    private Integer no_no; // 숫자 옵션 일련번호
    private Integer no_qs_no; // 질문 일련번호 (질문)
    private Integer no_min; // 최소값
    private Integer no_max; // 최대값
    private Integer no_increase; // 증가값

}
