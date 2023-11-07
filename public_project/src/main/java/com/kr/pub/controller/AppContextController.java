package com.kr.pub.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kr.pub.dto.UserDTO;

import jakarta.servlet.ServletContext;

@Controller
@SuppressWarnings("unchecked")
public class AppContextController {
	@Autowired
	private ServletContext app;
	public static boolean searchUser(List<UserDTO> userList, UserDTO input) {
		boolean result=false;
		Optional<UserDTO> optionalUser = userList.stream()
			    .filter(user -> user.getUserId().equals(input.getUserId()))
			    .findFirst();
		if (optionalUser.isPresent()) {
			result = true;}
		return result;
	}
	
	@GetMapping("/loggedInUserList")
	@ResponseBody
	public Map<String, List<UserDTO>> getLoggedInUser(){
		Map<String, List<UserDTO>> result = new HashMap<>();
		result.put("result", (List<UserDTO>) app.getAttribute("loggedInUserList"));
		return result;
	}
	
	@PostMapping("/getUserById")
	@ResponseBody
	public Map<String, UserDTO> getUserById(@RequestBody UserDTO input){
		Map<String, UserDTO> result = new HashMap<>();
		List<UserDTO> userList = (List<UserDTO>) app.getAttribute("loggedInUserList");
		if(userList != null) {
			Optional<UserDTO> optionalUser = userList.stream()
				    .filter(user -> user.getUserId().equals(input.getUserId()))
				    .findFirst();
			if (optionalUser.isPresent()) {result.put("result", optionalUser.get());}
		}
		return result;
	}
 }


