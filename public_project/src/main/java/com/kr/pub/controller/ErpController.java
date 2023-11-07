package com.kr.pub.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kr.pub.dto.ExcelDTO;
import com.kr.pub.dto.SearchDTO;
import com.kr.pub.service.ErpService;
import com.kr.pub.util.ResultRowDataHandler;

import jakarta.servlet.http.HttpServletResponse;


@Controller
@RequestMapping("/erp")
public class ErpController {
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private ErpService erpService;


	@GetMapping("/sales")
	public String sales(Model model) {
		return "/reference/salesLayout";
	}
	
	//재고 목록
	@GetMapping("/stock")
	public String itemSearch(Model model, SearchDTO list) throws Exception {
		
		List<Map<String, Object>> itemList = erpService.itemList(list);
		
		model.addAttribute("stock", itemList);
	    System.out.println("dateCheck: " + itemList);
		return "/reference/stockLayout";
	}
	
	//재고 조회 조건
	@PostMapping("/search")
	@ResponseBody
	public Map<String, Object> itemSearch(HttpServletResponse res, @RequestBody SearchDTO search) throws Exception{
		Map<String, Object> itemSearch = new HashMap<>();		
		
		List<Map<String, Object>> searchResults = erpService.itemList(search);
		
		itemSearch.put("itemsearch", searchResults);		
		System.out.println("조회 조건 DATA확인: " + searchResults);
		
		return itemSearch;
	}
	
	// 재고 목록 엑셀 DB 다운로드
	@GetMapping("/download")
	public void itemExcelDownload(HttpServletResponse response) throws Exception {
		ExcelDTO excelDTO = new ExcelDTO();
		 try {
	            erpService.download(excelDTO, response);
	        } catch (Exception e) {
	            logger.error("ExcelDownload Controller Exception: {}", e);
	        }
	}

	
}
