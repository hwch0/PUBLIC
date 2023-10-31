package com.kr.pub.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {
	
	@GetMapping("/admin")
	public String adminMain() {
		
		return "/admin/adminLayout";
	}

}
