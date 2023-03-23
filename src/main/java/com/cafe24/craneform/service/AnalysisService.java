package com.cafe24.craneform.service;

import com.cafe24.craneform.dao.AnalysisDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class AnalysisService {

    @Autowired
    AnalysisDAO analysisDAO;

    public Map<String, Object> selectResult(int no) {
        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();

        resultMap.put("select_result", analysisDAO.selectResult(no));

        return resultMap;
    }

    public Map<String, Object> insertResult(Map<String, Object> list) {
        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();

        analysisDAO.insertResult(list);

        return resultMap;
    }

}
