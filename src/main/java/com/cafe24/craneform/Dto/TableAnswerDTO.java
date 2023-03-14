package com.cafe24.craneform.Dto;

import lombok.Data;

@Data
public class TableAnswerDTO {
    private Integer ta_no;
    private Integer ta_qs_no;
    private Integer ta_row;
    private Integer ta_column;
    private Character ta_check;
}
