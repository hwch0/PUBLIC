package com.kr.pub.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kr.pub.dto.UserDTO;

@Mapper
public interface UserDAO {
	
	public List<UserDTO> getUserList();
	
	public UserDTO getUser(UserDTO user);
	public UserDTO getUser(String userId);

}