package com.kr.pub.controller;

import java.net.http.HttpResponse;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kr.pub.dto.UserDTO;
import com.kr.pub.service.UserService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@GetMapping("/list")
	public String userList(Model model) {
		List<UserDTO> result = userService.getUserList();
		System.out.println(result);
		model.addAttribute("result",  result);
		return "/user/userList";
	}
	
	@GetMapping("/{userId}")
	public String userInfo(Model model, @PathVariable String userId) {
		UserDTO result = userService.getUser(userId);
		model.addAttribute("result", result);
		return "/user/userList";
	}
	@GetMapping("/userChatTest")
	public String userChatTest() {
		return "/user/userTest";
	}
	
}
