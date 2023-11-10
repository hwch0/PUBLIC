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

import com.kr.pub.dto.ErpDTO;
import com.kr.pub.service.ErpService;




@Controller
@RequestMapping("/erp")
public class ErpController {
//	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private ErpService erpService;

	//주문 상세보기
	@PostMapping("/orderView")
	@ResponseBody
	public Map<String, Object> orderView(@RequestBody Map<String, Object> requestData) throws Exception{
		Map<String, Object> orderView = new HashMap<>();
		
		String orderId = (String) requestData.get("orderId");
		System.err.println("orderId확인: " + orderId);
		
		List<Map<String, Object>> orderResult = erpService.orderView(orderId);
		
		orderView.put("orderView", orderResult);
		System.out.println("data확인: " + orderResult);
		return orderView;
	}
	
	//주문 내역 조회조건
	@PostMapping("/orderSearch")
	@ResponseBody
	public Map<String, Object> orderSearch(@RequestBody ErpDTO search) throws Exception {
		Map<String, Object> orderSearch = new HashMap<>();
		
		List<Map<String, Object>> orderResult = erpService.orderSearch(search);
		
		orderSearch.put("orderSearch", orderResult);
		System.out.println("조건 Data확인: " + orderResult);
		return orderSearch; 
	}
	
	//매출 내역 조회조건
	@PostMapping("/salesSearch")
	@ResponseBody
	public Map<String, Object> salesSearch(@RequestBody ErpDTO search) throws Exception{
		Map<String, Object> salesSearch = new HashMap<>();
		
		List<Map<String, Object>> salesResult = erpService.salesSearch(search);
		
		salesSearch.put("salesSearch", salesResult);
		System.out.println("조회 조건 Data확인: " + salesResult);
		return salesSearch;
	}
	
	//매출 내역, 주문 내역
	@GetMapping("/sales")
	public String sales(Model model) throws Exception {
		
		List<Map<String, Object>> paymentList = erpService.salesList();
		List<Map<String, Object>> orderList = erpService.orderList();
		
		model.addAttribute("sales", paymentList);
		model.addAttribute("order", orderList);
		
//		System.out.println("data확인: " + paymentList);
//		System.out.println("data확인: " + orderList);
		return "/reference/salesLayout";
	}
	
	//입출고 조회
	@PostMapping("/statusStatus")
	@ResponseBody
	public Map<String, Object> statusStatus(@RequestBody ErpDTO search)throws Exception{
		Map<String, Object> statusSearch = new HashMap<>();
		
		List<Map<String, Object>> searchResult = erpService.statusSearch(search);
		
		statusSearch.put("statusSearch", searchResult);
//		System.out.println("조회 조건 Data확인: " + searchResult);
		return statusSearch;
	}
	
	//재고 조회 조건
	@RequestMapping("/search")
	@ResponseBody
	public Map<String, Object> itemSearch(@RequestBody ErpDTO search) throws Exception{
		Map<String, Object> itemSearch = new HashMap<>();		
		
		List<Map<String, Object>> searchResults = erpService.itemSearch(search);
		
		itemSearch.put("itemsearch", searchResults);
//		System.out.println("조회 조건 DATA확인: " + searchResults);
		
		return itemSearch;
	}
	
	//재고 목록,입출고 목록
	@GetMapping("/stock")
	public String itemList(Model model) throws Exception {

		List<Map<String, Object>> statusList = erpService.statusList();
		List<Map<String, Object>> itemList = erpService.itemList();
		
		model.addAttribute("stock", itemList);
		model.addAttribute("status", statusList);
		
	    System.out.println("dateCheck: " + itemList);
		return "/reference/stockLayout";
	}
	
//	@GetMapping("/stock")
//	public String stockList(Model model, ErpDTO erpDTO)throws Exception{
//		Map<String, Object> result = new HashMap<>();
//		
//		List<Map<String, Object>> stockResult = erpService.itemList(erpDTO);
//
//		result.put("stock", stockResult);
//
//		model.addAttribute("stock", erpService.itemList(erpDTO));
//		return "/reference/stockLayout";
//	}
	
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
