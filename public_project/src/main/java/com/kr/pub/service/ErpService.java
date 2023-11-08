package com.kr.pub.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kr.pub.dao.ItemDAO;
import com.kr.pub.dao.PaymentDAO;
import com.kr.pub.dto.SearchDTO;


@Service
public class ErpService {
	
	@Autowired
	private ItemDAO itemDAO;
	
	@Autowired
	private PaymentDAO paymentDAO;
	
	//매출 내역
	public List<Map<String, Object>> salesList() throws Exception{
		Map<String, Object> params = new HashMap<>();
		
		List<Map<String, Object>> paymentList = paymentDAO.salesList(params);
		
		indexList(paymentList);
		
		return paymentList;
	}
	
	//입출고 조회
	public List<Map<String, Object>> statusSearch(SearchDTO search) throws Exception {
		Map<String, Object> params = new HashMap<>();
		
		params.put("startDate", search.getStartDate());
		params.put("endDate", search.getEndDate());
		params.put("statusCode", search.getCode());
		params.put("stockStatus", search.getStatus());
		params.put("statusName", search.getName());
		
		List<Map<String, Object>> statusList = itemDAO.statusList(params);
        
		indexList(statusList);
		

		System.out.println("서비스 확인1 : " + params);
            return statusList;      
    }
	
	//입출고 목록 
	public List<Map<String, Object>> statusList() throws Exception{
		
		Map<String, Object> Params = new HashMap<>();
		
		List<Map<String, Object>> statusList = itemDAO.statusList(Params);
		
		indexList(statusList);
		
		return statusList;
	}
		
	//재고 조회
	public List<Map<String, Object>> itemSearch(SearchDTO search) throws Exception {
		Map<String, Object> searchParams = new HashMap<>();
		
		searchParams.put("startDate", search.getStartDate());
        searchParams.put("endDate", search.getEndDate());
        searchParams.put("itemName", search.getName());
        searchParams.put("itemSelect", search.getSelect());
        searchParams.put("stockItem", search.getStock());
		
		List<Map<String, Object>> itemList = itemDAO.itemList(searchParams);
        
        indexList(itemList);
        
            return itemList;      
    }
	
	//재고 목록
	public List<Map<String, Object>> itemList() throws Exception {
		
		Map<String, Object> params = new HashMap<>();
		
		List<Map<String, Object>> itemList = itemDAO.itemList(params);

        indexList(itemList);
        
            return itemList;      
    }
	
	//index 항목 추가하기
	private void indexList(List<Map<String, Object>> list) {
		for(int i = 0; i < list.size(); i++) {
			list.get(i).put("index", i + 1);
		}
	}
	
//	@Transactional
//	public void download(ExcelDTO excelDTO, ResultRowDataHandler resultRowDataHandler) throws Exception{	      
//		  List<ExcelDTO> excelData = itemDAO.excelDownload(excelDTO, resultRowDataHandler);
//
//	}
	
}
