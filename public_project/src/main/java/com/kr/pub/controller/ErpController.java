package com.kr.pub.controller;

import java.util.Arrays;
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
import com.kr.pub.dto.ItemDTO;
import com.kr.pub.service.ErpService;
import com.kr.pub.service.ExcelService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/erp")
public class ErpController {
//	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private ErpService erpService;
	
	@Autowired
	private ExcelService excelService;

	//회원 리스트
	@GetMapping("/user")
	public String userList(Model model) throws Exception{
		List<Map<String, Object>> userList = erpService.userList();
		
		model.addAttribute("userList", userList);
		System.out.println(" userList확인용: " + userList);
		
		return "/reference/userList";
	}
	
	//품목 코드 리스트
	@GetMapping("/statusCode")
	@ResponseBody
	public List<Map<String, Object>> itemCode(ItemDTO itemId) throws Exception {
	    
	    List<Map<String, Object>> statusCodeList = erpService.statusCode();
	    
	    return statusCodeList;
	}	
	
	//입고 등록하기
	@PostMapping("/insertStatus")
	@ResponseBody
	public Map<String, Object> insertStock(@RequestBody ItemDTO itemId) throws Exception{
		System.out.println("등록확인");
		
		Map<String, Object> result = new HashMap<>();
		
		if(erpService.insertStock(itemId)) {
				
		result.put("message", "입고 등록이 완료 되었습니다.");
		}else {
			result.put("message", "입고 등록중 오류가 발생했습니다.");
		}
		return result;
	}
	
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
	public Map<String, Object> salesSearch(@RequestBody ErpDTO search, HttpSession session) throws Exception{
		Map<String, Object> salesSearch = new HashMap<>();
		
		List<Map<String, Object>> salesResult = erpService.salesSearch(search);
		
		session.setAttribute("setErpDTO", salesResult);
		
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
	    System.out.println("입 출고dateCheck: " + statusList);
		return "/reference/stockLayout";
	}
	
	//매출목록 다운로드
	@PostMapping("/salesExcel")
	public void salceExcelDownload(HttpServletResponse res, ErpDTO erpDTO, HttpSession session) throws Exception {
		List<Map<String, Object>> salesResult = (List<Map<String, Object>>) session.getAttribute("setErpDTO");
	    
			
		List<String> headerNames = Arrays.asList("index","paymentId", "orderId", "paymentDate", "uname", "type", "price", "netProfit");
		List<String> headerLabels = Arrays.asList("순번","매출 전표", "주문 저표", "매출 일자", "회원 이름", "구분 상태", "매출액", "순이익");
		String sheetName = "매출내역";
		String fileName = "sales_excel_download";

		
		excelService.excelDownload(res, sheetName, headerNames, headerLabels, salesResult, fileName);

	}

	// 입출고 목록 업로드용 엑셀 다운로드
	@GetMapping("/excelDownload")
	public void excelDownload(HttpServletResponse res) throws Exception {
		List<String> headerNames = Arrays.asList("품목명", "일자", "상세", "수량", "단가");
		String fileName = "excel_download";
			
		excelService.excelDownloads(res, headerNames, fileName);
	}
	
	// 입출고 목록 엑셀 DB 다운로드
	@ResponseBody
	@GetMapping("/statusDownload")
	public Map<String, Object> statusExcelDownload(HttpServletResponse res) throws Exception {
		List<Map<String, Object>> dataList = erpService.statusList();
		List<String> headerNames = Arrays.asList("index","ITEM_ID", "ITEM_NAME", "STATUSDATE", "INCDEC", "STOCK", "PRICE");
		List<String> headerLabels = Arrays.asList("순번","품목코드", "품목명", "일자", "상세", "수량", "단가");
		String sheetName = "입고출고내역";
		String fileName = "status_excel_download";
		
		System.out.println("데이터 확인: " + dataList);
		
		excelService.excelDownload(res, sheetName, headerNames, headerLabels, dataList, fileName);
		Map<String, Object> result = new HashMap<>();
		result.put("message", "성공했습니다");
		return result;
	}

	// 재고 목록 엑셀 DB 다운로드
	@GetMapping("/download")
	public void itemExcelDownload(HttpServletResponse res, ErpDTO erpDTO) throws Exception {
		List<Map<String, Object>> dataList = erpService.itemSearch(erpDTO);
		 
		List<String> headerNames = Arrays.asList("index","ITEMID", "ITEMNAME", "TYPE", "STOREDATE", "STOCK", "PRICE");
		List<String> headerLabels = Arrays.asList("순번","품목코드", "품목명", "품목유형", "입고일", "현재재고", "입고단가");
		String sheetName = "재고목록";
		String fileName = "stock_excel_download";		
	
		System.out.println("데이터 확인: " + dataList);
		
		excelService.excelDownload(res, sheetName, headerNames, headerLabels, dataList, fileName);		
	}
	

	
}