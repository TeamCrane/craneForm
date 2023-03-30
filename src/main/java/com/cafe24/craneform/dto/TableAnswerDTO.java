package com.cafe24.craneform.dto;

import lombok.Data;

@Data
public class TableAnswerDTO {

    private Integer ta_no; // 표 답변 일련번호
    private Integer ta_qs_no; // 질문 일련번호 (질문)
    private Integer ta_ui_no; // 유저 일련번호 (유저)
    private Integer ta_row; // 행 번호
    private Integer ta_column; // 열 번호

}
