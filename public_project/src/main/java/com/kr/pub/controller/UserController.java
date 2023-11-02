package com.kr.pub.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kr.pub.dto.UserDTO;
import com.kr.pub.service.MqttService;
import com.kr.pub.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private MqttService mqttService;
	
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
	@GetMapping("/userTest")
	public String userTest() throws Exception {
		mqttService.publishMessage("안녕하세요","/public/order");
		/*
		 * 순서:
		 * 1.사용자가 주문 버튼 누름
		 * 2.DB에 insert하는 api호출
		 * 3.Admin에게 알림 보내기
		 * 4.Admin측에서 알림이 오면 Ajax로 api호출해서
		 * update되지 않은 데이터 모두 가져와서 뷰단에 동적으로 출력
		 * 
		 * 주문이 DB에 insert 되면 Admin에게 알림 보내서
		 * insert된 Data를 Admin측에서 select
		 * select할때 화면상에 위치하는 가장 위의 데이터 보다
		 * 최근인 데이터들만 가져와서 뷰단에 동적으로 출력 
		 * */
		
		return "/user/userTest";
	}
	
}
