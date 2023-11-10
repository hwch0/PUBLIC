package com.kr.pub.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kr.pub.service.MqttService;
import com.kr.pub.service.UserService;

import jakarta.servlet.ServletContext;

@Controller
public class LoginController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private MqttService mqttService;
	@Autowired
	private ServletContext app;
	
	@GetMapping("/")
	public String main(Model model) {
		return "login";
	}

	//로그인 양식 
	@GetMapping("/loginForm")
	public String loginForm(Model model,
			@RequestParam(value = "error", required = false) String error, 
			@RequestParam(value = "exception", required = false) String exception) {
		model.addAttribute("error", error);
		model.addAttribute("exception", exception);
		return "login";
	}
	
	
}
