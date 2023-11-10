package com.kr.pub.service;

import java.sql.Timestamp;
import java.time.Duration;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.Random;
import java.util.stream.Collectors;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import com.kr.pub.controller.AppContextController;
import com.kr.pub.dao.UserDAO;
import com.kr.pub.dto.UserDTO;
import com.kr.pub.exception.ExistMemberException;
import com.kr.pub.util.TimeApi;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class UserService {
	
//	@Autowired
	final private UserDAO userDAO;
//	@Autowired
	final private MqttService mqttService;
	@Autowired
	private ServletContext app;
//	@Autowired
	final private PasswordEncoder passwordEncoder;
	
	
	public UserDTO findByUserId(String userId) {
		return userDAO.findByUserId(userId);
	}
	
	public List<UserDTO> getUserList() {
		return userDAO.getUserList();
	}
	
	public UserDTO getUser(UserDTO user) {
		return userDAO.getUser(user);
	}
	
	public UserDTO getUser(String userId) {
		return userDAO.getUser(userId);
	}
	
	public UserDTO login(UserDTO user) {
        // 로그인 로직 구현
        UserDTO rs = userDAO.login(user);

        // 잔여시간
        int remainingTime = getRemainingTime(user);
        
        if (rs != null) {
            if (remainingTime != 0) {
                // 잔여시간이 있을 경우
                Timestamp loginTime = TimeApi.encodingTime(ZonedDateTime.now(ZoneId.of("Asia/Seoul")));
                rs.setLoginTime(loginTime);
                Random random = new Random();
                // 1부터 50 사이의 랜덤 숫자 생성
                int randomNumber = random.nextInt(50) + 1;
                rs.setSeatNo(randomNumber);//테스트를 위해 랜덤 숫자 생성
                updateLoginTime(rs);
            }
        }
        
        return rs;
    }
	
	public void insertMember(UserDTO user) throws Exception {
		try {
			if (user == null ||
				Objects.isNull(user.getEmail())) {
				throw new Exception("아이디는 필수 정보입니다");
			} else if (Objects.isNull(user.getOauth()) && Objects.isNull(user.getPassword())) {
				throw new Exception("비밀번호는 필수 정보입니다");
			}
			UserDTO existMember = userDAO.findByEmail(user.getEmail());
			if (existMember != null && !Objects.isNull(user.getEmail())) {
				throw new ExistMemberException(user.getEmail());
			}
			//비밀번호 암호화 한다
			//비밀번호가 있을때만 암호화를 진행한다.
			if(Objects.isNull(user.getOauth())) {
				user.setPassword(passwordEncoder.encode(user.getPassword()));
			}
			userDAO.insertMember(user);
			System.out.println(user);
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		}
	}
	
	public Map<String, Object> login2(@RequestBody UserDTO user, HttpServletRequest request) throws Exception {
		Map<String, Object> map = new HashMap<>();
        UserDTO rs = login(user);
        if (rs.getRemainingTime() > 0) {
            map.put("rs", rs);
            map.put("message", "로그인 성공했습니다.");
			List<UserDTO> loggedInUserList = (List<UserDTO>) app.getAttribute("loggedInUserList");//app영역에서 로그인되어있는 회원의 배열 가져오기
            System.out.println("application=> " + loggedInUserList);
            	if(loggedInUserList != null) {//로그인된 회원이 있을떄
            		if(!AppContextController.searchUser(loggedInUserList, rs)){//리스트에서 현재 로그인한 회원을 스트림으로 찾고 없다면
            				loggedInUserList.add(rs);//로그인유저 리스트에 추가
                        app.setAttribute("loggedInUsserList", loggedInUserList);//app영역에 update하기
            			}
            	}else {
            		loggedInUserList = new ArrayList<>();//현재 로그인한 회원이 아무도 없다면(배열이 null) 새로운 배열 객체 만들기
            		loggedInUserList.add(rs);//로그인 유저 리스트에 추가
            		app.setAttribute("loggedInUserList", loggedInUserList);//app영역에 update
            		System.out.println("getapplication=>" + app.getAttribute("loggedInUserList"));
            	}
            	//좌석정보 가져오는 루틴 필요(밑의 함수 파라미터에 넣어주기)
            	loginSeat(rs);//random번 사용중으로 변경
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
    
	public void updateLoginTime(UserDTO user) {
    	userDAO.updateLoginTime(user);
    }
    
    public int getRemainingTime(UserDTO user) {
    	return userDAO.getRemainingTime(user);
    }

	public void updateAllTime(UserDTO user) {
		userDAO.updateAllTime(user);
		
	}
	public void loginSeat(UserDTO user) {
		userDAO.loginSeat(user);
	}
	public void logoutSeat(UserDTO user) {
		userDAO.logoutSeat(user);
	}


	public UserDTO loginHistory(UserDTO user) {
		return userDAO.loginHistory(user);
	}

	
	public void logout(UserDTO userInfo) throws Exception {
	    System.out.println(userInfo);
	    List<UserDTO> loggedInUserList = (List<UserDTO>) app.getAttribute("loggedInUserList");
	    
	    if (loggedInUserList != null) {
	        Optional<UserDTO> logoutUserOptional = loggedInUserList.stream()
	                .filter(user -> user.getUserId().equals(userInfo.getUserId()))
	                .findFirst();

	        if (logoutUserOptional.isPresent()) {
	            UserDTO logoutUser = logoutUserOptional.get();
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

	            if (remainingTime <= 0) {
	                logoutUser.setRemainingTime(0);
	            } else {
	                logoutUser.setRemainingTime(remainingTime);
	            }

	            updateAllTime(logoutUser); // DB에 업데이트

	            System.out.println(logoutUser);
	            logoutSeat(logoutUser);

	            JSONObject jsonObject = new JSONObject(Map.of(
	                    "type", "LOGOUT",
	                    "receiver", "admin"
	            ));
	            mqttService.publishMessage(jsonObject.toString(), "/public/login"); // 로그아웃한 알림 관리자에게
	            loggedInUserList = loggedInUserList.stream()
	                    .filter(user -> !user.getUserId().equals(userInfo.getUserId())) // 특정 아이디와 일치하지 않는 요소를 필터링
	                    .collect(Collectors.toCollection(ArrayList::new)); // 필터링된 요소로 새 ArrayList 생성
	            app.setAttribute("loggedInUserList", loggedInUserList);//app 영역에 업데이트
	            // 삭제된 후의 ArrayList 출력
	            System.out.println(loggedInUserList);
	        } else {
	            // 해당 사용자 정보를 찾을 수 없는 경우에 대한 처리
	            System.out.println("User not found in loggedInUserList");
	        }
	    }

	    return; // 로그인 페이지로 리다이렉트
	}
}
