package com.kr.pub.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kr.pub.dao.UserDAO;
import com.kr.pub.dto.UserDTO;

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
	
	// 로그인 + 시간
	public UserDTO login(UserDTO user) {
        return userDAO.login(user);
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


}
