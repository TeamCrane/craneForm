package com.cafe24.craneform.dto;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class AllSurveyInfoDTO {

    private int qs_no; // 질문 번호 (질문)
    private int qs_order; // 질문 순서 (질문)
    private String qs_detail; // 질문 제목 (질문)
    private String qs_type; // 질문 유형 (질문)
    private String qs_required; // 필수 여부 (질문)
    List<SelectOptionDTO> selectOptionList = new ArrayList<>(); // 객관식 옵션 리스트
    List<EssayOptionDTO> essayAnswerList = new ArrayList<>(); // 주관식 옵션 리스트
    List<TableOptionDTO> tableOptionList = new ArrayList<>(); // 표 옵션 리스트

}
