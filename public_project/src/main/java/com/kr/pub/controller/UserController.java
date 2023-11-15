package com.kr.pub.controller;

import java.sql.Timestamp;
import java.time.Duration;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kr.pub.dto.MenuDTO;
import com.kr.pub.dto.UserDTO;
import com.kr.pub.service.AdminService;
import com.kr.pub.service.MqttService;
import com.kr.pub.service.UserService;
import com.kr.pub.util.TimeApi;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@GetMapping("")
    public String login() {
		return "/user/login";
    }
	@GetMapping("/test")
    public String testIp() {
        return "/user/ipTest";
    }
	
    @GetMapping("/main")
  	public String Main() {
  		return "/user/main";
  	}
    @GetMapping("/userTest")
    public String userTest() {
    	return "/user/userTest";
    }
    
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
	@PostMapping("/getUser")
	@ResponseBody
	public Map<String, UserDTO> getUser(@RequestBody UserDTO userDTO){
		System.out.println("getUser 호출");
		System.out.println(userDTO);
		Map<String, UserDTO> result = new HashMap<>();
		result.put("result", userService.getUser(userDTO));
		return result;
	}
}
