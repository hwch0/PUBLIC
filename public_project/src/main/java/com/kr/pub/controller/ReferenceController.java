package com.kr.pub.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kr.pub.dto.UserDTO;

import jakarta.servlet.ServletContext;

@Controller
public class ReferenceController {
	@Autowired
	private ServletContext app;
	
	@GetMapping("/pos")
	@SuppressWarnings("unchecked")
	public String pos(Model model) {
		List<UserDTO> loggedInUserList = (List<UserDTO>) app.getAttribute("loggedInUserList");
		model.addAttribute("loggedInUserList", loggedInUserList);
		return "/reference/pos";
	}

	@GetMapping("/stock")
	public String erp(Model model) {
		return "/reference/stockLayout";
	}

	@GetMapping("/sales")
	public String sales(Model model) {
		return "/reference/salesLayout";
	}

	//	@GetMapping("/erp2")
//	public String erp2(Model model) {
//		return "/reference/erp2";
//	}
}
