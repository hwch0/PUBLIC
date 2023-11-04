package com.kr.pub.service;

import java.sql.Timestamp;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kr.pub.dao.UserDAO;
import com.kr.pub.dto.UserDTO;
import com.kr.pub.util.TimeApi;

@Service
public class UserService {
	
	@Autowired
	private UserDAO userDAO;
	
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
    
    public void updateLoginTime(UserDTO user) {
    	userDAO.updateLoginTime(user);
    }
    
    public int getRemainingTime(UserDTO user) {
    	return userDAO.getRemainingTime(user);
    }

	public void updateAllTime(UserDTO user) {
		userDAO.updateAllTime(user);
		
	}
	public void updateSeat(UserDTO user) {
		userDAO.updateSeat(user);
	}


	public UserDTO loginHistory(UserDTO user) {
		return userDAO.loginHistory(user);
	}

}
