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
	@GetMapping("/erp")
	public String erp(Model model) {
		return "/reference/erp";
	}
	@GetMapping("/inventoryStatus")
	public String inventoryStatus(Model model) {
	    return "/reference/inventoryStatus";
	}
	@GetMapping("/erp2")
	public String erp2(Model model) {
		return "/reference/erp2";
	}
}
