package com.kr.pub.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kr.pub.dto.UserDTO;
import com.kr.pub.service.CacheService;

@Controller
public class CacheController {
	@Autowired
	CacheService cacheService;
	
	@Autowired
	CacheManager cacheManager;
	
	@GetMapping("/testCache")
	@ResponseBody
	public List<UserDTO> loggedInUserList(){
//		if(cacheManager.getCache("loggedInUserList").get("allUsers") != null) {
//			Cache.ValueWrapper valueWrapper = cacheManager.getCache("loggedInUserList").get("allUsers");
//			System.out.println("controller -> CACHE=>"+valueWrapper.get());
//		}
		
		return cacheService.loggedInUserList();
	}
}
