CREATE DATABASE survey_db;
USE survey_db;

CREATE TABLE user_info_tb -- 유저 정보
(
    ui_no           INT         NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 유저 일련번호
    ui_name         VARCHAR(20) NOT NULL,                            -- 이름
    ui_email        VARCHAR(50) NOT NULL UNIQUE,                     -- 이메일
    ui_addr         VARCHAR(200)         DEFAULT null,               -- 주소
    ui_phone        VARCHAR(20) NOT NULL,                            -- 번호
    ui_gender       char(1)              DEFAULT null,               -- 성별
    ui_birth        DATE                 DEFAULT null,               -- 생년월일
    ui_password     VARCHAR(64) NOT NULL,                            -- 비밀번호
    ui_created_date DATETIME    NOT NULL DEFAULT NOW()               -- 가입일
);

CREATE TABLE survey_info_tb -- 설문 정보
(
    si_no           INT          NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 설문 일련번호
    si_ui_no        INT          NOT NULL,                            -- 유저 일련번호
    si_subtitle     VARCHAR(255) NOT NULL,                            -- 설문 제목
    si_detail       VARCHAR(255) NOT NULL,                            -- 설문 내용
    si_created_date DATE         NOT NULL DEFAULT NOW(),              -- 생성일
    si_start_date   DATE         NOT NULL DEFAULT NOW(),              -- 시작일
    si_end_date     DATE,                                             -- 종료일
    si_state        VARCHAR(50)  NOT NULL                             -- 진행상태
);

CREATE TABLE survey_condition_tb -- 설문 조건
(
    sc_no     INT          NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 조건 일련번호
    sc_si_no  INT          NOT NULL,                            -- 설문 일련번호
    sc_type   VARCHAR(50)  NOT NULL,                            -- 조건 종류
    sc_detail VARCHAR(255) NOT NULL                             -- 조건 내용
);

CREATE TABLE question_tb -- 질문
(
    qs_no       INT          NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 질문 일련번호
    qs_si_no    INT          NOT NULL,                            -- 설문 일련번호
    qs_type     VARCHAR(50)  NOT NULL,                            -- 질문 유형
    qs_detail   VARCHAR(255) NOT NULL,                            -- 질문 내용
    qs_required VARCHAR(2)   NOT NULL,                            -- 필수 여부
    qs_order    INT          NOT NULL                             -- 질문 순번
);

CREATE TABLE select_option_tb -- 객관식 옵션
(
    so_no     INT          NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 객관식 옵션 일련번호
    so_qs_no  INT          NOT NULL,                            -- 질문 일련번호
    so_detail VARCHAR(255) NOT NULL,                            -- 옵션 내용
    so_order  INT          NOT NULL                             -- 옵션 순번
);

CREATE TABLE essay_option_tb -- 주관식 옵션
(
    eo_no    INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 주관식 옵션 일련번호
    eo_qs_no INT NOT NULL,                            -- 질문 일련번호
    eo_min   INT NOT NULL,                            -- 최소 문자 길이
    eo_max   INT NOT NULL                             -- 최대 문자 길이
);

CREATE TABLE number_option_tb -- 숫자 옵션
(
    no_no       INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 숫자 옵션 일련번호
    no_qs_no    INT NOT NULL,                            -- 질문 일련번호
    no_min      INT NOT NULL,                            -- 최소값
    no_max      INT NOT NULL,                            -- 최대값
    no_increase INT NOT NULL                             -- 증가값
);

CREATE TABLE table_option_tb -- 표 옵션
(
    to_no     INT          NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 표 옵션 일련번호
    to_qs_no  INT          NOT NULL,                            -- 질문 일련번호
    to_detail VARCHAR(255) NOT NULL,                            -- 옵션 내용
    to_matrix CHAR(1)      NOT NULL,                            -- 행렬
    to_order  INT          NOT NULL                             -- 행렬 순번
);

CREATE TABLE select_answer_tb -- 객관식 답변
(
    sa_no    INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 객관식 답변 일련번호
    sa_qs_no INT NOT NULL,                            -- 질문 일련번호
    sa_ui_no INT NOT NULL,                            -- 유저 일련번호
    sa_so_no INT NOT NULL                             -- 객관식 옵션 일련번호
);

CREATE TABLE essay_answer_tb -- 주관식 답변
(
    ea_no      INT        NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 주관식 답변 일련번호
    ea_qs_no   INT        NOT NULL,                            -- 질문 일련번호
    ea_ui_no   INT        NOT NULL,                            -- 유저 일련번호
    ea_content TEXT(5000) NOT NULL                             -- 답변 내용
);

CREATE TABLE table_answer_tb -- 표 답변
(
    ta_no     INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 표 답변 일련번호
    ta_qs_no  INT NOT NULL,                            -- 질문 일련번호
    ta_ui_no  INT NOT NULL,                            -- 유저 일련번호
    ta_row    INT NOT NULL,                            -- 행 번호
    ta_column INT NOT NULL                             -- 열 번호
);

CREATE TABLE select_analysis_tb -- 객관식 분석
(
    san_no    INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 객관식 분석 일련번호
    san_qs_no INT NOT NULL,                            -- 질문 일련번호
    san_so_no INT NOT NULL                             -- 객관식 옵션 일련번호
);
