package com.cafe24.craneform.Dto;

import lombok.Data;

import java.util.Date;

@Data
public class SurveyInfoDTO {
    private Integer si_no;
    private String si_ui_no;
    private String si_subtitle;
    private String si_detail;
    private Date si_date;
    private Date si_start;
    private Date si_end;
    private String si_state;
}
