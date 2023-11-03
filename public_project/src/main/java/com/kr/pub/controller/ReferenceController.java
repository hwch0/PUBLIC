package com.kr.pub.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReferenceController {
	
	@GetMapping("/pos")
	public String pos(Model model) {
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
