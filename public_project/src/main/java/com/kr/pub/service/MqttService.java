package com.kr.pub.service;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kr.pub.config.MqttConfig;
import com.kr.pub.dto.ChatDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MqttService {
	@Autowired
	MqttConfig.OutboundGateway outboundGateway;
	@Autowired
	ChatService chatService;
	public void publishMessage(String message, String topic) throws Exception {
		outboundGateway.sendToMqtt(message, topic);
    }
	
	public void execute(String topic, String payload) throws Exception {//채팅 저장 로직
    String [] cmdParams = StringUtils.split(topic, "/");
	if(cmdParams[1].equals("chat")) {
		ChatDTO chat = new ObjectMapper().readValue(payload, ChatDTO.class);
		System.out.println("MQTTSERVICE=>" + chat);
		if (chat != null && chat.getType().equals("CHAT")) {
			chatService.insert(chat);
		}
	}
   
	}
}
