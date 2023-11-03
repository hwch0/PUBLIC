package com.kr.pub.controller;

import java.sql.Timestamp;
import java.time.Duration;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kr.pub.dto.UserDTO;
import com.kr.pub.service.MqttService;
import com.kr.pub.service.UserService;
import com.kr.pub.util.TimeApi;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private MqttService mqttService;
	
	@GetMapping("/")
    public String login() {
        return "/user/login";
    }
	
    @GetMapping("/main")
  	public String Main() {
  		return "/user/main";
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
	@GetMapping("/userTest")
	public String userTest(Model model) throws Exception {
		model.addAttribute("time" ,TimeApi.getTime());
		//mqttService.publishMessage(TimeApi.getTime(),"/public/order");
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
	
	
	// 로그인
    @PostMapping("/login")
    @ResponseBody
    public Map<String, Object> login(@RequestBody UserDTO user, HttpServletRequest request) throws Exception {
        HttpSession session = request.getSession();
        Map<String, Object> map = new HashMap<>();

        // 현재시간 (서울 기준)
        Timestamp loginTime = new Timestamp(System.currentTimeMillis());

        UserDTO rs = userService.login(user);

        // 잔여시간
        int remainingTime = userService.getRemainingTime(user);
        
        System.out.println(rs);
        
        if (rs != null) {
            session.setAttribute("remainingTime", remainingTime);
            session.setAttribute("LoginTime", loginTime);
            session.setAttribute("LoginMember", rs);
            map.put("rs", rs);
            map.put("message", "로그인 성공했습니다.");
            
            // 로그인 성공 시 loginTime 삽입
            rs.setLoginTime(loginTime);
            userService.updateLoginTime(rs);
        } else {
            map.put("message", "로그인 실패했습니다.");
        }
        return map;
    }
    
	// 로그아웃
    @GetMapping("/logout")
    @ResponseBody
    public String logout(HttpServletRequest request) throws Exception {
        HttpSession session = request.getSession();
        
        // 세션에서 LoginMember 속성 가져오기
        UserDTO loginMember = (UserDTO) session.getAttribute("LoginMember");
        if(loginMember != null) {
	        int remainingTime = (int) session.getAttribute("remainingTime");
	        
	        // 입장시간
	        Timestamp loginTime = loginMember.getLoginTime();
	        // 퇴장시간
	        Timestamp logoutTime = new Timestamp(System.currentTimeMillis());
	        // 입장시간 - 퇴장시간
	        Duration duration = Duration.between(loginTime.toInstant(), logoutTime.toInstant());
	        // 잔여시간 - 사용시간
	        int seconds = (int) duration.getSeconds();
	        
	        remainingTime = (remainingTime - seconds);
	        
	        UserDTO updateMember = new UserDTO();
	        
	        updateMember.setUserId(loginMember.getUserId());
	        updateMember.setLogoutTime(loginTime);
	        updateMember.setRemainingTime(remainingTime);
	        
	        
	        System.out.println("업데이트 된 목록 : " + updateMember);
	        
	        userService.updateAllTime(updateMember);
        } 
        session.removeAttribute("LoginMember");
        session.removeAttribute("LoginTime");
        session.removeAttribute("remainingTime");

        return "/user/";
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
            Timestamp now = new Timestamp(System.currentTimeMillis());

            // 입장 시간부터 현재 시간까지의 시간 차이 계산
            Duration duration = Duration.between(loginTime.toInstant(), now.toInstant());
            int seconds = (int) duration.getSeconds();

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
