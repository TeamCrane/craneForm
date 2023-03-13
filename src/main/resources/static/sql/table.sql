CREATE DATABASE survey_db;
USE survey_db;

CREATE TABLE member_tb (
                           user_no       INT             NOT NULL        AUTO_INCREMENT      PRIMARY KEY,
                           name          VARCHAR(20)     NOT NULL,
                           email         VARCHAR(50)     NOT NULL        UNIQUE,
                           addr          VARCHAR(200)                    DEFAULT null,
                           phone         VARCHAR(20)     NOT NULL,
                           gender        char(1)                         DEFAULT null,
                           birth         DATE                            DEFAULT null,
                           password      VARCHAR(64)     NOT NULL,
                           created_date  DATETIME        NOT NULL        DEFAULT NOW()
);

CREATE TABLE survey_tb (
                           sv_no         INT             NOT NULL        AUTO_INCREMENT      PRIMARY KEY,
                           user_no       INT             NOT NULL,
                           sv_subtitle   VARCHAR(255)    NOT NULL,
                           sv_detail     VARCHAR(255)    NOT NULL,
                           sv_date       DATE            NOT NULL        DEFAULT NOW(),
                           sv_start      DATE,
                           sv_end        DATE,
                           sv_state      VARCHAR(50)     NOT NULL
);

CREATE TABLE condition_tb (
                              cd_no         INT             NOT NULL        AUTO_INCREMENT      PRIMARY KEY,
                              sv_no         INT             NOT NULL,
                              cd_type       VARCHAR(50)     NOT NULL,
                              cd_detail     VARCHAR(255)    NOT NULL
);

CREATE TABLE questions_tb (
                              qs_no         INT             NOT NULL        AUTO_INCREMENT      PRIMARY KEY,
                              sv_no         INT             NOT NULL,
                              qs_type       VARCHAR(50)     NOT NULL,
                              qs_detail     VARCHAR(255)    NOT NULL,
                              qs_required   char(1)         NOT NULL
);

CREATE TABLE select_tb (
                           sl_no         INT             NOT NULL        AUTO_INCREMENT      PRIMARY KEY,
                           qs_no         INT             NOT NULL,
                           sl_detail     VARCHAR(255)    NOT NULL
);

CREATE TABLE multiple_choice_answer_tb (
                                           mc_no         INT             NOT NULL        AUTO_INCREMENT      PRIMARY KEY,
                                           qs_no         INT             NOT NULL,
                                           user_no       INT             NOT NULL,
                                           sl_no         INT             NOT NULL
);


CREATE TABLE essay_answer_tb (
                                 ea_no         INT             NOT NULL        AUTO_INCREMENT      PRIMARY KEY,
                                 qs_no         INT             NOT NULL,
                                 user_no       INT             NOT NULL,
                                 ea_content    TEXT(5000)      NOT NULL
);


CREATE TABLE analysis_tb (
                             al_no         INT             NOT NULL        AUTO_INCREMENT      PRIMARY KEY,
                             qs_no         INT             NOT NULL,
                             sl_no         INT             NOT NULL
);
