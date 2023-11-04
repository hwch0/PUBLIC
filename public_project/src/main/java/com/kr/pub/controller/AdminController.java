package com.kr.pub.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.kr.pub.service.AdminService;

@Controller
public class AdminController {
	@Autowired
	AdminService adminService;
	@GetMapping("/admin")
	public String adminMain() {
		return "/admin/adminLayout";
	}
}
