package com.kr.pub.controller;


import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kr.pub.dto.ImageDTO;
import com.kr.pub.dto.MenuDTO;
import com.kr.pub.service.ImageService;
import jakarta.servlet.http.HttpServletResponse;
import com.kr.pub.service.AdminService;

@Controller
public class AdminController {
	@Autowired
	private ImageService imageService;
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/admin")
	public String adminMain() {
		return "/admin/adminLayout";
	}
	
	@ResponseBody
	@PostMapping("/admin/addMenu")
	public Map<String, Object> addMenu(MultipartHttpServletRequest multipartRequest, HttpServletResponse res) throws IOException {
		System.out.println("AdminController addMenu");
		Map<String,Object> result = new HashMap<>();
		
		ImageDTO image = imageService.imageProcess(multipartRequest);
		System.out.println(image);
		image.setItemId("ITEM000001");
		boolean status = imageService.insertImage(image);
		
		result.put("status", status);
		result.put("message", status ? "메뉴가 등록되었습니다." : "메뉴 등록 중 오류 발생");
		System.out.println("result");
		
		return result;
	}
	
	@ResponseBody
	@GetMapping("/admin/menulist")
	public Map<String, Object> getMenuList() {
		System.out.println("AdminController getMenuList");
		Map<String,Object> result = new HashMap<>();
		
		List<MenuDTO> menuList = adminService.getMenuList();
		boolean status = menuList != null;
		
		result.put("status", status);
		
		
		return result;
	}
	

}
