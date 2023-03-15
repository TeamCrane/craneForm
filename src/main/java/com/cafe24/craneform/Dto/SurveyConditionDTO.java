package com.cafe24.craneform.Dto;

import lombok.Data;

@Data
public class SurveyConditionDTO {

    private Integer sc_no; // 조건 일련번호
    private Integer sc_si_no; // 설문 일련번호 (설문)
    private String sc_type; // 조건 종류
    private String sc_detail; // 조건 내용

}
