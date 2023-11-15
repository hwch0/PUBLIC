package com.kr.pub.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kr.pub.dao.ChatDAO;
import com.kr.pub.dto.ChatDTO;

@Service
public class ChatService {
	@Autowired
	ChatDAO chatDAO;

	public boolean insert(ChatDTO chatDTO) {
		return chatDAO.insert(chatDTO) != 0;
	}

	public List<ChatDTO> getChatList() {
		return chatDAO.getChatLIst();
	}
	public List<ChatDTO> getChatLIstById(ChatDTO chatDTO) {return chatDAO.getChatLIst();}
	
}
