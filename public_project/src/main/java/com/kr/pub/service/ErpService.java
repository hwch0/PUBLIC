package com.kr.pub.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kr.pub.dao.ItemDAO;
import com.kr.pub.dto.SearchDTO;

@Service
public class ErpService {
	
	@Autowired
	private ItemDAO itemDAO;
	
	public List<Map<String, Object>> itemList(SearchDTO search) throws Exception {
		Map<String, Object> searchParams = new HashMap<>();
		
		searchParams.put("startDate", search.getStartDate());
        searchParams.put("endDate", search.getEndDate());
        searchParams.put("itemName", search.getItemName());
        searchParams.put("registrationDay", search.getRegistrationDay());
        searchParams.put("itemSelect", search.getItemSelect());

        List<Map<String, Object>> itemList = itemDAO.itemList(searchParams);

        // 검색 결과에 순번 추가
        for (int i = 0; i < itemList.size(); i++) {
            itemList.get(i).put("index", i + 1);
        }
        
            return itemList;      
    }
	
}
