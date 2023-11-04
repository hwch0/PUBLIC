package com.kr.pub.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	public Optional<UserDTO> searchUser(List<UserDTO> userList, UserDTO input) {
		Optional<UserDTO> optionalUser = userList.stream()
			    .filter(user -> user.getUserId().equals(input.getUserId()))
			    .findFirst();
		return optionalUser;
	}
	
	@PostMapping("/loggedInUserList")
	@ResponseBody
	public Map<String, List<UserDTO>> getLoggedInUser(){
		Map<String, List<UserDTO>> result = new HashMap<>();
		result.put("result", (List<UserDTO>) app.getAttribute("loggedInUserList"));
		return result;
	}
	
	@PostMapping("/getUserById")
	@ResponseBody
	public Map<String, Optional<UserDTO>> getUserById(@RequestBody UserDTO user){
		Map<String, Optional<UserDTO>> result = new HashMap<>();
		result.put("result", searchUser((List<UserDTO>) app.getAttribute("loggedInUserList"), user));
		return result;
	}
 }

//	@GetMapping("/getAppUser")
//	@ResponseBody
//	public Map<String, Object> getAppUser() {
//	    Map<String, Object> map = new HashMap<>();
//	    List<String> attributeNames = new ArrayList<>();
//	    
//	    // Enumeration을 List로 복사
//	    Enumeration<String> attributeNamesEnum = app.getAttributeNames();
//	    while (attributeNamesEnum.hasMoreElements()) {
//	        attributeNames.add(attributeNamesEnum.nextElement());
//	    }
//	    
//	    map.put("result", attributeNames);
//	    return map;
//	}
//	@GetMapping("/getAppUser")
//	@ResponseBody
//	public Map<String, List<UserDTO>> getAppUser(){
//		Map<String, List<UserDTO>> map = new HashMap<>();
//		map.put("result", (List<UserDTO>) app.getAttribute("loggedInUserList"));
//		return map;
//	}

