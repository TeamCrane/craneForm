package com.cafe24.craneform.dao;

import com.cafe24.craneform.dto.SelectAnalysisDTO;
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

    public void insertResult(Map<String, Object> list) { sqlSession.insert("analysis.select_save", list); }

    public void deleteResult(int ui_no) { sqlSession.delete("analysis.analysis_delete", ui_no); }

    public List<SelectAnalysisDTO> saveOptions(int ui_no) { return sqlSession.selectList("analysis.check", ui_no); }

}