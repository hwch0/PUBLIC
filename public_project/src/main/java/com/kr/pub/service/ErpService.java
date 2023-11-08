package com.kr.pub.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kr.pub.dao.ItemDAO;
import com.kr.pub.dto.StatusDTO;
import com.kr.pub.dto.SearchDTO;

@Service
public class ErpService {
	
	@Autowired
	private ItemDAO itemDAO;
	
	
	//입출고 목록 
	public List<Map<String, Object>> statusList() throws Exception{
		
		Map<String, Object> Params = new HashMap<>();
		
		List<Map<String, Object>> statusList = itemDAO.statusList(Params);
		
		for(int i = 0; i < statusList.size(); i++) {
			statusList.get(i).put("index", i + 1);
		}
		
		return statusList;
	}
	
	
	
	//재고 조회
	public List<Map<String, Object>> itemSearch(SearchDTO search) throws Exception {
		Map<String, Object> searchParams = new HashMap<>();
		
		searchParams.put("startDate", search.getStartDate());
        searchParams.put("endDate", search.getEndDate());
        searchParams.put("itemName", search.getItemName());
        searchParams.put("itemSelect", search.getItemSelect());
        searchParams.put("stockStatus", search.getStockStatus());
		
		List<Map<String, Object>> itemList = itemDAO.itemList(searchParams);
        
            return itemList;      
    }
	
	//재고 목록
	public List<Map<String, Object>> itemList() throws Exception {
		
		Map<String, Object> params = new HashMap<>();
		
		List<Map<String, Object>> itemList = itemDAO.itemList(params);

        // 검색 결과에 순번 추가
        for (int i = 0; i < itemList.size(); i++) {
            itemList.get(i).put("index", i + 1);
        }
        
            return itemList;      
    }
	
//	@Transactional
//	public void download(ExcelDTO excelDTO, ResultRowDataHandler resultRowDataHandler) throws Exception{	      
//		  List<ExcelDTO> excelData = itemDAO.excelDownload(excelDTO, resultRowDataHandler);
//
//	}
	
}
