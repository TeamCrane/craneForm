package com.cafe24.craneform.Dto;

import lombok.Data;

@Data
public class TableAnswerDTO {

    private Integer ta_no; // 표 답변 일련번호
    private Integer ta_qs_no; // 질문 일련번호 (질문)
    private Integer ta_row; // 행 번호
    private Integer ta_column; // 열 번호
    private Character ta_check; // 체크 여부

}
