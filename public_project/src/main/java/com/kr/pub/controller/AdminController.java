package com.kr.pub.controller;


import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kr.pub.dto.ImageDTO;
import com.kr.pub.service.ImageService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletResponse;
import com.kr.pub.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private ImageService imageService;
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("")
	public String adminMain(Model model) {
		List<Map<String, Object>> menuList = adminService.getMenuWithItems("Y", "N");
		List<Map<String, Object>> menuCategory = adminService.getMenuCategory();
		
		model.addAttribute("menuList", menuList);
		model.addAttribute("menuCategory", menuCategory);
		
		String classpath = System.getProperty("java.class.path");
				
		// "public_project" 까지의 클래스 패스 가져오기
		int endIndex = classpath.indexOf("public_project") + "public_project".length();
		String pathUpToPublicProject = classpath.substring(0, endIndex);
		
		// static 이미지 폴더 경로 추가
		String newPath = pathUpToPublicProject + "\\src\\main\\resources\\static\\images\\menu\\";
		
		// 어플리케이션 영역에 경로 저장
		servletContext.setAttribute("newPath", newPath);
		System.out.println("newPath >>>>>>>>>" + newPath);
		return "/admin/adminLayout";
	}
	
	@ResponseBody
	@PostMapping("/admin/addMenu")
	public Map<String, Object> addMenu(MultipartHttpServletRequest multipartRequest, HttpServletResponse res) throws IOException {
		System.out.println("AdminController addMenu");
		Map<String,Object> result = new HashMap<>();
		String itemId = multipartRequest.getParameter("selectedItem");
		ImageDTO image = imageService.imageProcess(multipartRequest);
		image.setItemId(itemId);
		boolean status = imageService.insertImage(image);
		
		result.put("status", status);
		result.put("message", status ? "메뉴가 등록 되었습니다." : "메뉴 등록 중 오류 발생");
		result.put("menu",  status ? adminService.getMenu(itemId) : "");
		return result;
	}
	
	@ResponseBody
	@GetMapping("/admin/menulist/{menuChecked}/{category}")
	public Map<String, Object> getMenuList(@PathVariable String menuChecked, @PathVariable String category) {
		System.out.println("AdminController getMenuList");
		Map<String,Object> result = new HashMap<>();

		List<Map<String, Object>> menuList = adminService.getMenuWithItems(menuChecked, category);
		boolean status = menuList != null;
		
		result.put("status", status);
		if(status) {
			result.put("menuList", menuList);
		}
		return result;
	}
	
	@ResponseBody
	@GetMapping("/admin/deleteMenu/{itemId}")
	public Map<String, Object> deleteMenu(@PathVariable String itemId) {
		System.out.println("AdminController deleteMenu");
		Map<String, Object> result = new HashMap<>();
		
		boolean status = adminService.deleteMenu(itemId);
		result.put("status", status);
		result.put("message", status ? "메뉴가 삭제 되었습니다." : "메뉴 삭제 중 오류 발생");
		
		return result;
	}
	
	
}
