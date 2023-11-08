package com.kr.pub.service;

import java.util.List;
import java.util.Map;

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

	public List<OrderListDTO> getOrderList() {
		return orderDAO.getOrderList();
	}
	
}
