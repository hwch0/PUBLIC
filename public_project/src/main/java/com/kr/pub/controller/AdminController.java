package com.kr.pub.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kr.pub.dto.ImageDTO;
import com.kr.pub.service.ImageService;

import jakarta.servlet.http.HttpServletResponse;

@Controller("/admin")
public class AdminController {
	
	@Autowired
	private ImageService imageService;
	
	@GetMapping("/")
	public String adminMain() {
		
		return "/admin/adminLayout";
	}
	
	@ResponseBody
	@PostMapping("/addMenu")
	public Map<String, Object> addMenu(MultipartHttpServletRequest multipartRequest, HttpServletResponse res) throws IOException {
		
		Map<String,Object> result = new HashMap<>();
		List<ImageDTO> image = imageService.imageProcess(multipartRequest);
		
		
		
		return result;
	}
	

}
