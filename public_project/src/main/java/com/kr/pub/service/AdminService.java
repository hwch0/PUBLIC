package com.kr.pub.service;

import java.util.List;

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
	
}
