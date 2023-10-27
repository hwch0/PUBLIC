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

}
