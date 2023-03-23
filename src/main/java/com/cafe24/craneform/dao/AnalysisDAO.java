package com.cafe24.craneform.dao;

import com.cafe24.craneform.dto.result.SelectResultDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class AnalysisDAO {

    @Autowired
    private SqlSession sqlSession;

    public List<SelectResultDTO> selectResult(int ui_no) { return sqlSession.selectList("analysis.select_result", ui_no); }

    public void insertResult(Map<String, Object> list) { sqlSession.insert("select_save", list); }

}