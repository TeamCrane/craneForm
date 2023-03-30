package com.cafe24.craneform.dao;

import com.cafe24.craneform.dto.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SurveyDAO {

    @Autowired
    private SqlSession sqlSession;

    // 설문 정보 제출
    public int insertSurveyInfo(SurveyInfoDTO surveyInfoDTO) {
        int cnt = sqlSession.insert("survey.insertSurveyInfo", surveyInfoDTO); // 설문 제출
        if (cnt == 1) {
            return sqlSession.selectOne("survey.searchSurveyNo", surveyInfoDTO); // 설문 번호 검색
        } else {
            return 0;
        }
    }

    // 질문 제출
    public int insertQuestion(QuestionDTO questionDTO) {
        int cnt = sqlSession.insert("survey.insertQuestion", questionDTO); // 질문 제출
        if (cnt == 1) {
            return sqlSession.selectOne("survey.searchQuestionNo", questionDTO); // 질문 번호 검색
        } else {
            return 0;
        }
    }

    // 객관식 옵션 제출
    public int insertSelectOption(SelectOptionDTO selectOptionDTO) {
        return sqlSession.insert("survey.insertSelectOption", selectOptionDTO);
    }

    // 주관식 옵션 제출
    public int insertEssayOption(EssayOptionDTO essayOptionDTO) {
        return sqlSession.insert("survey.insertEssayOption", essayOptionDTO);
    }

    public int insertTableOption(TableOptionDTO tableOptionDTO) {
        return sqlSession.insert("survey.insertTableOption", tableOptionDTO);
    }

    // index 설문조사 리스트
    public List<SurveyInfoDTO> surveyInfoList() {
        return sqlSession.selectList("survey.surveyInfoList");
    }

    // 설문조사 상세
    public SurveyInfoDTO surveyInfoOne(int si_no) {
        return sqlSession.selectOne("survey.surveyInfoOne", si_no);
    }

    // 질문과 옵션 상세
    public List<AllSurveyInfoDTO> allSurveyInfo(int si_no) {
        return sqlSession.selectList("survey.allSurveyInfo", si_no);
    }

    // 객관식 답변 제출
    public int insertSelectAnswer(SelectAnswerDTO selectAnswerDTO) {
        return sqlSession.insert("survey.insertSelectAnswer", selectAnswerDTO);
    }

    // 주관식 답변 제출
    public int insertEssayAnswer(EssayAnswerDTO essayAnswerDTO) {
        return sqlSession.insert("survey.insertEssayAnswer", essayAnswerDTO);
    }

    public int insertTableAnswer(TableAnswerDTO tableAnswerDTO) {
        return sqlSession.insert("insertTableAnswer", tableAnswerDTO);
    }
}
