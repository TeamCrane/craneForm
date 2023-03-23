package com.cafe24.craneform.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AllSurveyInfoDTO {

    private Integer qs_no; // 질문 일련번호
    private Integer qs_si_no; // 설문 일련번호 (설문)
    private String qs_type; // 질문 유형
    private String qs_detail; // 질문 내용
    private String qs_required; // 필수 여부
    private Integer qs_order; // 질문 순번
    private List<SelectOptionDTO> selectOptionList; // 객관식 옵션 리스트
    private List<EssayOptionDTO> essayOptionList; // 주관식 옵션 리스트
    private List<TableOptionDTO> tableOptionList; // 표 옵션 리스트

}
