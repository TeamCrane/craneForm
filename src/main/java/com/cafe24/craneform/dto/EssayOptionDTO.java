package com.cafe24.craneform.dto;

import lombok.Data;

@Data
public class EssayOptionDTO {
    
    private Integer eo_no; // 주관식 옵션 일련번호
    private Integer eo_qs_no; // 질문 일련번호 (질문)
    private Integer eo_min; // 최소 문자 길이
    private Integer eo_max; // 최대 문자 길이

}
