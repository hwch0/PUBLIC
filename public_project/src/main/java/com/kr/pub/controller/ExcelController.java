package com.kr.pub.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kr.pub.dto.SearchDTO;
import com.kr.pub.service.ErpService;

@Controller
public class ExcelController {
	
	@Autowired
	private ErpService erpService;


	@GetMapping("/sales")
	public String sales(Model model) {
		return "/reference/salesLayout";
	}
	
	//재고 목록
	@GetMapping("/stock")
	public String itemSearch(Model model) throws Exception {
	    
		SearchDTO search = new SearchDTO();
		
		List<Map<String, Object>> itemList = erpService.itemList(search);
		
		model.addAttribute("stock", itemList);
	    System.out.println("dateCheck: " + itemList);
		return "/reference/stockLayout";
	}
	
	//재고 조회 조건
	@PostMapping("/search")
	@ResponseBody
	public Map<String, Object> itemSearch(@RequestBody SearchDTO search) throws Exception{		
		Map<String, Object> itemSearch = new HashMap<>();
		
		List<Map<String, Object>> searchResults = erpService.itemList(search);
		
		itemSearch.put("itemsearch", searchResults);		
		System.out.println("조회 조건 DATA확인: " + searchResults);
		
		return itemSearch;
	}
	
}
