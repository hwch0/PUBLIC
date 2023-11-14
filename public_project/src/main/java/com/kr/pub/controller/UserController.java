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
import com.kr.pub.dto.OrderDTO;
import com.kr.pub.dto.OrderListDTO;
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
	private AdminService adminService;
	@Autowired
	private UserService userService;
	@Autowired
	private MqttService mqttService;
	@Autowired
	private ServletContext app;
	
	
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
	public String getUser(@RequestBody UserDTO userDTO) throws JsonProcessingException {
		ObjectMapper objectMapper = new ObjectMapper();
        String json = objectMapper.writeValueAsString(userService.getUser(userDTO));
		return json;
	}

	@GetMapping("/getMenuList")
	@ResponseBody 
	public Map<String, Object> getMenuList(Model model) throws Exception {
	    
		List<Map<String, Object>> menuList = userService.getMenuList();
	    System.out.println("메뉴 리스트: " + menuList);

//	    ObjectMapper objectMapper = new ObjectMapper();
//	    String jsonMenuList = objectMapper.writeValueAsString(menuList);

	    Map<String, Object> rs  = new HashMap<>();
	    rs.put("menuList", menuList);
	    return rs;
	}
	

	@PostMapping("/order")
	@ResponseBody
	public Map<String, String> order(@RequestBody Map<String, String> request) {
	   String userId = request.get("userId");
	   System.out.println("사용자 아이디 : " + userId);
	   
	   Map<String, String> map = new HashMap<>();

	   try {
	       userService.insertOrder(userId);

	       map.put("rs", "success");
	   } catch (Exception e) {
	       map.put("rs", "failure");
	   }

	   return map;
	}
	
	@PostMapping("/orderItems")
	@ResponseBody
	public Map<String, Object> orderItems(@RequestBody Map<String, List<Map<String, Object>>> request) {
	    List<Map<String, Object>> orderList = request.get("cartItems");
	    System.out.println(orderList);
	    
	    String orderId = userService.getOrderId();
	    System.out.println(orderId);
	    
	    System.out.println("주문 리스트: " + orderList);

	    Map<String, Object> map = new HashMap<>();

	    try {
	        userService.insertOrderItems(orderList); 
	        map.put("rs", "success");
	    } catch (Exception e) {
	        map.put("rs", "failure");
	    }

	    return map;
	}
}
