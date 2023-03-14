package com.cafe24.craneform.Dto;

import lombok.Data;

@Data
public class QuestionDTO {
    private Integer qs_no;
    private Integer qs_si_no;
    private String qs_type;
    private String qs_detail;
    private Character qs_required;
    private Integer qs_order;
}
