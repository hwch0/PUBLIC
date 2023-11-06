package com.kr.pub.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kr.pub.dao.AdminDAO;
import com.kr.pub.dao.MenuDAO;
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
	
	public List<Map<String, Object>> getMenuCategory() {
		return menuDAO.getMenuCategory();
	}
	
	public Map<String, Object> getMenu(String itemId) {
		return menuDAO.getMenu(itemId);
	}
	
}
