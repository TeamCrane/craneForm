package com.cafe24.craneform.dto;

import lombok.Data;

import java.util.Date;

@Data
public class SurveyInfoDTO {

    private Integer si_no; // 설문 일련번호
    private Integer si_ui_no; // 유저 일련번호 (유저)
    private String si_subtitle; // 설문 제목
    private String si_detail; // 설문 내용
    private Date si_created_date; // 생성일
    private Date si_start_date; // 시작일
    private Date si_end_date; // 종료일
    private String si_state; // 진행 상태

}
