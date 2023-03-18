package com.cafe24.craneform.dao;

import com.cafe24.craneform.dto.QuestionDTO;
import com.cafe24.craneform.dto.SurveyInfoDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SurveyDAO {

    @Autowired
    private SqlSession sqlSession;

    // 설문 정보 제출
    public int insertSurveyInfo(SurveyInfoDTO surveyInfoDTO) {
        return sqlSession.insert("survey.insertSurveyInfo", surveyInfoDTO);
    }

    public int insertQuestion(int questionOrder, String[] questionArray) {
        QuestionDTO questionDTO = new QuestionDTO();
        questionDTO.setQs_order(questionOrder);
        questionDTO.setQs_type(questionArray[0]);

        questionArray[1] = (questionArray[1] == null) ? "" : questionArray[1]; // 필수 순번이 없다면 채워주기
        questionArray[2] = (questionArray[2] == null) ? "" : questionArray[2]; //

        return sqlSession.insert("survey.insertQuestion");
    }
}
