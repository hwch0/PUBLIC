package com.kr.pub.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kr.pub.dao.ItemDAO;
import com.kr.pub.dao.OrderDAO;
import com.kr.pub.dao.PaymentDAO;
import com.kr.pub.dto.ErpDTO;
import com.kr.pub.dto.ItemDTO;


@Service
public class ErpService {
	
	@Autowired
	private ItemDAO itemDAO;
	
	@Autowired
	private PaymentDAO paymentDAO;
	
	@Autowired
	private OrderDAO orderDAO;
	
	//itemId 찾기
	public List<ItemDTO> itemIdSearch(ItemDTO itemDTO) throws Exception{
		
		
		return null;
	}
	
	//주문 내역 상세보기
	public List<Map<String, Object>> orderView(String orderId) throws Exception{
		Map<String, Object> params = new HashMap<>();
		params.put("orderId", orderId);
		
		List<Map<String, Object>> orderView = orderDAO.erpOrderView(params);
		
		indexList(orderView);
		
		return orderView;
	}
	
	//주문 내역 조회
	public List<Map<String, Object>> orderSearch(ErpDTO search) throws Exception{
		Map<String, Object> params = new HashMap<>();
		
		params.put("startDate", search.getStartDate());
		params.put("endDate", search.getEndDate());
		params.put("orderId", search.getOrderId());
		params.put("paymentMethod", search.getSelect());
		params.put("orderOption", search.getCode());
		
		List<Map<String, Object>> orderList = orderDAO.erpOrderList(params);
		
		indexList(orderList);
		System.out.println("서비스 확인: " + params);
		return orderList;
	}
	
	//주문 내역
	public List<Map<String, Object>> orderList() throws Exception{
		Map<String, Object> params = new HashMap<>();
		
		List<Map<String, Object>> orderList = orderDAO.erpOrderList(params);
		
		indexList(orderList);
		
		return orderList;
	}
	
	//매출 내역 조회
	public List<Map<String, Object>> salesSearch(ErpDTO search) throws Exception{
		Map<String, Object> params = new HashMap<>();
		
		params.put("startDate", search.getStartDate());
		params.put("endDate", search.getEndDate());
		params.put("paymentId", search.getPaymentId());
		params.put("orderId", search.getOrderId());
		params.put("unme", search.getUnme());
		
		List<Map<String, Object>> salesList = paymentDAO.salesList(params);
		System.out.println("서비스 확인: " + params);
		indexList(salesList);
		
		return salesList;
	}
	//매출 내역
	public List<Map<String, Object>> salesList() throws Exception{
		Map<String, Object> params = new HashMap<>();
		
		List<Map<String, Object>> paymentList = paymentDAO.salesList(params);
		
		indexList(paymentList);
		
		return paymentList;
	}
	
	//입출고 조회
	public List<Map<String, Object>> statusSearch(ErpDTO search) throws Exception {
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
	public List<Map<String, Object>> itemSearch(ErpDTO erpDTO) throws Exception {
		Map<String, Object> searchParams = new HashMap<>();
		
//		searchParams.put("startNo", erpDTO.getStartNo());
//		searchParams.put("endNo", erpDTO.getPageSize());	
		
		searchParams.put("startDate", erpDTO.getStartDate());
        searchParams.put("endDate", erpDTO.getEndDate());
        searchParams.put("itemName", erpDTO.getName());
        searchParams.put("itemSelect", erpDTO.getSelect());
        searchParams.put("stockItem", erpDTO.getStock());
		
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
