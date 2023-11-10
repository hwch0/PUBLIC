package com.kr.pub.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kr.pub.dao.AdminDAO;
import com.kr.pub.dao.ItemDAO;
import com.kr.pub.dao.MenuDAO;
import com.kr.pub.dao.OrderDAO;
import com.kr.pub.dto.ItemDTO;
import com.kr.pub.dto.MenuDTO;
import com.kr.pub.dto.OrderListDTO;

@Service
public class AdminService {
	
	@Autowired
	private AdminDAO adminDAO;
	
	@Autowired
	private OrderDAO orderDAO;
	
	@Autowired
	private MenuDAO menuDAO;
	
	public List<MenuDTO> getMenuList() {
		return menuDAO.getMenuList();
	}
	
	@Transactional(readOnly = true)
	public List<Map<String, Object>> getMenuWithItems(String menuChecked, String category) {
		if(category.equals("N")) {
			category=null;
		}
		MenuDTO menu = MenuDTO.builder()
						.menuChecked(menuChecked)
						.menuCategoryCode(category)
						.build();
		return menuDAO.getMenuWithItems(menu);
	}
	
	@Transactional(readOnly = true)
	public List<Map<String, Object>> getMenuCategory() {
		return menuDAO.getMenuCategory();
	}
	
	@Transactional(readOnly = true)
	public Map<String, Object> getMenu(String itemId) {
		return menuDAO.getMenu(itemId);
	}
	
	@Transactional()
	public boolean deleteMenu(String itemId) {
		MenuDTO menu = MenuDTO.builder()
						.itemId(itemId)
						.build();
		return menuDAO.deleteMenu(menu) != 0;
	}


	public Map<String, Object> getChartData() {
		Map<String, Object> result = new HashMap<>();
		List<Map<String, Object>> rawData = adminDAO.getChartData();
		List<String> month = new ArrayList<>();
		List<String> menu = new ArrayList<>();
		List<String> pc = new ArrayList<>();
		List<String> total = new ArrayList<>();
		List<String> users = new ArrayList<>();
		
		List<Map<String, Object>> rawData2 = adminDAO.getMonthlyUsers();
		
		for(Map<String, Object> data : rawData) {
			month.add(data.get("PAYMENT_MONTH").toString());
			menu.add(data.get("PT002").toString());
			pc.add(data.get("PT001").toString());
			total.add(data.get("TOTAL_SALES").toString());
		};
		
		for(Map<String, Object> data : rawData2) {
			users.add(data.get("USERCOUNT").toString());
		};
		
		result.put("month", month);
		result.put("menu", menu);
		result.put("pc", pc);
		result.put("total", total);
		result.put("users", users);
		
		System.out.println("result >>> " +  result);
		
		return result;
	}
	
	
	public List<Map<String, Object>> getMonthlyUsers() {
		return adminDAO.getMonthlyUsers();
	}
	
	public List<OrderListDTO> getOrderList() {
		return orderDAO.getOrderList();
	}
	
	public Map<String, Object> getPieChartData() {
		Map<String, Object> result = new HashMap<>(); 
		String[] typeList = {"year", "month" ,"day"};
		
		for(String type : typeList) {
			Map<String, Object> dataList = new HashMap<>(); // 각 반복마다 초기화
			List<String> top6Menu = new ArrayList<>();
			List<String> top6Sales = new ArrayList<>();

			List<Map<String, Object>> rawData = adminDAO.getPieChartData(type);
			for(Map<String, Object> data : rawData) {
				top6Menu.add(data.get("ITEM_NAME").toString());
				top6Sales.add(data.get("TOTAL_COUNT").toString());
				
			};
			dataList.put("top6Menu", top6Menu);
			dataList.put("top6Sales", top6Sales);
			result.put(type, dataList);
		}
		System.out.println("result >>>> " + result);
		return result; // year -> ITEM_NAME, TOTAL_COUNT / month -> ITEM_NAME, TOTAL_COUNT / day -> ITEM_NAME, TOTAL_COUNT
	}
	
	
	public Map<String, Object> getUserCount() {
		Map<String, Object> result = new HashMap<>(); 
		//[{DAY=2023-11-09, USERCOUNT=1}, {DAY=2023-11-10, USERCOUNT=1}]
		List<Map<String, Object>> dataMap = adminDAO.getUserCount();
		
		result.put("lastday", dataMap.get(0));
		result.put("today", dataMap.get(1));
		
		return result;
	}
	
}
