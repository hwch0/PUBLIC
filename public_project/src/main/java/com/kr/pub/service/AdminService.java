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
import com.kr.pub.dto.ItemDTO;
import com.kr.pub.dto.MenuDTO;

@Service
public class AdminService {
	
	@Autowired
	private AdminDAO adminDAO;
	
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
		
		for(Map<String, Object> data : rawData) {
			month.add(data.get("PAYMENT_MONTH").toString());
			menu.add(data.get("PT002").toString());
			pc.add(data.get("PT001").toString());
			total.add(data.get("TOTAL_SALES").toString());
		};
		
		result.put("month", month);
		result.put("menu", menu);
		result.put("pc", pc);
		result.put("total", total);
		
		return result;
	}
	
}
