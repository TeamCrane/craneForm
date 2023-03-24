package com.cafe24.craneform.service;

import com.cafe24.craneform.dao.AnalysisDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class AnalysisService {

    @Autowired
    AnalysisDAO analysisDAO;

    public Map<String, Object> selectResult(int no) {
        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();

        resultMap.put("select_result", analysisDAO.selectResult(no));

        List<Object> save_options = new ArrayList<Object>();
        if(analysisDAO.saveOptions(no).size()!=0) {
            save_options.add(analysisDAO.saveOptions(no).get(0).getSan_qs_no());
            List<Integer> optionList = new ArrayList<Integer>();
            for (int i = 0; i < analysisDAO.saveOptions(no).size(); i++) {
                optionList.add(analysisDAO.saveOptions(no).get(i).getSan_so_no());
            }
            save_options.add(optionList);
        }

        resultMap.put("save_options", save_options);

        return resultMap;
    }

    public Map<String, Object> insertResult(Map<String, Object> list, int no) {
        Map<String, Object> resultMap = new LinkedHashMap<String, Object>();

        analysisDAO.deleteResult(no);
        if(list.get("qs_no")!=null) { analysisDAO.insertResult(list); }

        resultMap.put("status", true);
        resultMap.put("message", "저장되었습니다.");

        return resultMap;
    }

}
