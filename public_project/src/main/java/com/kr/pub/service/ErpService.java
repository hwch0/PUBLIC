package com.kr.pub.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kr.pub.dao.ItemDAO;
import com.kr.pub.dto.ExcelDTO;
import com.kr.pub.dto.SearchDTO;
import com.kr.pub.util.ResultRowDataHandler;

import jakarta.servlet.http.HttpServletResponse;

@Service
public class ErpService {
	
	@Autowired
	private ItemDAO itemDAO;
	
	
	//재고 목록,excel 다운
	public List<Map<String, Object>> itemList(SearchDTO search) throws Exception {
		Map<String, Object> searchParams = new HashMap<>();
		
		searchParams.put("startDate", search.getStartDate());
        searchParams.put("endDate", search.getEndDate());
        searchParams.put("itemName", search.getItemName());
        searchParams.put("itemSelect", search.getItemSelect());
        searchParams.put("stockStatus", search.getStockStatus());
		
		List<Map<String, Object>> itemList = itemDAO.itemList(searchParams);

        // 검색 결과에 순번 추가
        for (int i = 0; i < itemList.size(); i++) {
            itemList.get(i).put("index", i + 1);
        }
        
            return itemList;      
    }
	
	//재고 조회
//	public List<Map<String, Object>> itemSearch(SearchDTO search) throws Exception {
//		Map<String, Object> searchParams = new HashMap<>();
//		
//		searchParams.put("startDate", search.getStartDate());
//        searchParams.put("endDate", search.getEndDate());
//        searchParams.put("itemName", search.getItemName());
//        searchParams.put("registrationDay", search.getRegistrationDay());
//        searchParams.put("itemSelect", search.getItemSelect());
//
//        List<Map<String, Object>> itemList = itemDAO.itemList(searchParams);
//        
//            return itemList;      
//    }
	
	@Transactional
	public void download(ExcelDTO excelDTO, HttpServletResponse response) throws Exception{
		 ResultRowDataHandler resultRowDataHandler = new ResultRowDataHandler(response);
		 System.out.println("open확인하기: "+  resultRowDataHandler);
	        try {
	            itemDAO.excelDownload(excelDTO, resultRowDataHandler);
	        } finally {
	            resultRowDataHandler.close();
	        }
	}
	
}
