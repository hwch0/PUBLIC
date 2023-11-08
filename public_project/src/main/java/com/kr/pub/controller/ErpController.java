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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kr.pub.dto.StatusDTO;
import com.kr.pub.dto.SearchDTO;
import com.kr.pub.service.ErpService;

import jakarta.servlet.http.HttpServletResponse;


@Controller
@RequestMapping("/erp")
public class ErpController {
//	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private ErpService erpService;


	@GetMapping("/sales")
	public String sales(Model model) {
		return "/reference/salesLayout";
	}
	

	
	//재고 조회 조건
	@PostMapping("/search")
	@ResponseBody
	public Map<String, Object> itemSearch(HttpServletResponse res, @RequestBody SearchDTO search) throws Exception{
		Map<String, Object> itemSearch = new HashMap<>();		
		
		List<Map<String, Object>> searchResults = erpService.itemSearch(search);
		
		itemSearch.put("itemsearch", searchResults);		
		System.out.println("조회 조건 DATA확인: " + searchResults);
		
		return itemSearch;
	}
	
	//재고 목록,입출고 목록
	@GetMapping("/stock")
	public String itemSearch(Model model) throws Exception {

		List<Map<String, Object>> statusList = erpService.statusList();
		List<Map<String, Object>> itemList = erpService.itemList();
		
		model.addAttribute("stock", itemList);
		model.addAttribute("status", statusList);
//	    System.out.println("dateCheck: " + itemList);
		return "/reference/stockLayout";
	}
	
	// 재고 목록 엑셀 DB 다운로드
//	@GetMapping("/download")
//	public void itemExcelDownload(HttpServletResponse response) throws Exception {
//		ExcelDTO excelDTO = new ExcelDTO();
//		ResultRowDataHandler resultRowDataHandler = new ResultRowDataHandler(response);
//		 try {
//	            erpService.download(excelDTO, resultRowDataHandler);
//	        } catch (Exception e) {
//	            logger.error("ExcelDownload Controller Exception: {}", e);
//	        }finally {
//				if(resultRowDataHandler != null) {
//					resultRowDataHandler.close();
//				}
//			}
//	}

	
}
