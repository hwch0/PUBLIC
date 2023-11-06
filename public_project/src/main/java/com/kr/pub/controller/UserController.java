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
import com.kr.pub.dto.UserDTO;
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
	@Autowired
	private MqttService mqttService;
	@Autowired
	private ServletContext app;
	
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
		
	
	// 로그인

    @PostMapping("/login")
    @ResponseBody
    @SuppressWarnings("unchecked")
    public Map<String, Object> login2(@RequestBody UserDTO user, HttpServletRequest request) throws Exception {
        Map<String, Object> map = new HashMap<>();
        UserDTO rs = userService.login(user);
        if (rs.getRemainingTime() > 0) {
            map.put("rs", rs);
            map.put("message", "로그인 성공했습니다.");
			List<UserDTO> loggedInUserList = (List<UserDTO>) app.getAttribute("loggedInUserList");//app영역에서 로그인되어있는 회원의 배열 가져오기
            System.out.println("application=> " + loggedInUserList);
            	if(loggedInUserList != null) {//로그인된 회원이 있을떄
            		if(!AppContextController.searchUser(loggedInUserList, rs)){//리스트에서 현재 로그인한 회원을 스트림으로 찾고 없다면
            				loggedInUserList.add(rs);//로그인유저 리스트에 추가
                        app.setAttribute("loggedInUserList", loggedInUserList);//app영역에 update하기
            			}
            	}else {
            		loggedInUserList = new ArrayList<>();//현재 로그인한 회원이 아무도 없다면(배열이 null) 새로운 배열 객체 만들기
            		loggedInUserList.add(rs);//로그인 유저 리스트에 추가
            		app.setAttribute("loggedInUserList", loggedInUserList);//app영역에 update
            		System.out.println("getapplication=>" + app.getAttribute("loggedInUserList"));
            	}
            	//좌석정보 가져오는 루틴 필요(밑의 함수 파라미터에 넣어주기)
            	userService.loginSeat(rs);//random번 사용중으로 변경
            	JSONObject jsonObject = new JSONObject(Map.of(
            		    "type", "LOGIN",
            		    "receiver", "admin"
            		));
            mqttService.publishMessage(jsonObject.toString() ,"/public/login");//로그인한 알림 관리자에게
        }  else if(rs.getRemainingTime() == 0) {
	    	map.put("message", "잔여시간이 없습니다.");
            map.put("rs", 0);
	    } else {
            map.put("message", "로그인 실패했습니다.");
        }
        return map;
    }

    @GetMapping("/logout/{userId}")//POST로 변환
    public String logout(@PathVariable("userId") String userId) throws Exception {
    	System.out.println(userId);
    	UserDTO logoutUser;
    	List<UserDTO> loggedInUserList = (List<UserDTO>) app.getAttribute("loggedInUserList");
    	if(loggedInUserList != null) {
    		logoutUser = loggedInUserList.stream().filter(user -> user.getUserId().equals(userId)).findFirst().get();
    		System.out.println(logoutUser);
    		int remainingTime = logoutUser.getRemainingTime();
    		 // 입장시간
	        Timestamp loginTime = logoutUser.getLoginTime();
	        // 퇴장시간
	        Timestamp logoutTime = TimeApi.encodingTime(ZonedDateTime.now(ZoneId.of("Asia/Seoul")));
	        // 입장시간 - 퇴장시간
	        Duration setDuration = Duration.between(loginTime.toInstant(), logoutTime.toInstant());
	        // 잔여시간 - 사용시간
	        int seconds = (int) setDuration.getSeconds();
	        remainingTime = (remainingTime - seconds);
	        logoutUser.setLogoutTime(logoutTime);
    		logoutUser.setRemainingTime(remainingTime);
    		userService.updateAllTime(logoutUser);//DB에 업데이트
    		
    		System.out.println(logoutUser);
    	 	userService.logoutSeat(logoutUser);
    	 	
    	 	JSONObject jsonObject = new JSONObject(Map.of(
        		    "type", "LOGOUT",
        		    "receiver", "admin"
        		));
    	 	mqttService.publishMessage(jsonObject.toString() ,"/public/login");//로그아웃한 알림 관리자에게
    		loggedInUserList = loggedInUserList.stream()
                    .filter(user -> !user.getUserId().equals(userId)) // 특정 아이디와 일치하지 않는 요소를 필터링
                    .collect(Collectors.toCollection(ArrayList::new)); // 필터링된 요소로 새 ArrayList 생성
    		app.setAttribute("loggedInUserList", loggedInUserList);//app영역에 업데이트
                // 삭제된 후의 ArrayList 출력
    		System.out.println(loggedInUserList);
    	}
        return "/user/login"; // 로그인 페이지로 리다이렉트
    }
    
    // 시간계산 
    @GetMapping("/getRemainingTime")
    @ResponseBody
    public Map<String, Integer> getRemainingTime(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Map<String, Integer> response = new HashMap<>();

        UserDTO loginMember = (UserDTO) session.getAttribute("LoginMember");
        if (loginMember != null) {
        	
        	Timestamp loginTime = loginMember.getLoginTime();
        	Timestamp now = TimeApi.encodingTime(ZonedDateTime.now(ZoneId.of("Asia/Seoul")));

            // 입장 시간부터 현재 시간까지의 시간 차이 계산
        	Duration setDuration = Duration.between(loginTime.toInstant(), now.toInstant());
        	int seconds = (int) setDuration.getSeconds();

            // 현재 잔여 시간에서 사용된 시간을 뺀 값 전송
            int remainingTime = loginMember.getRemainingTime() - seconds;
            response.put("remainingTime", remainingTime);
        } else {
            // 사용자가 로그인하지 않은 경우 처리
            response.put("remainingTime", 0);
        }

        return response;
    }

    

}
