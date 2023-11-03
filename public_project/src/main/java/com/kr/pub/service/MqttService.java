package com.kr.pub.service;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kr.pub.config.MqttConfig;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MqttService {
	@Autowired
	MqttConfig.OutboundGateway outboundGateway;
	
	public void publishMessage(String message, String topic) throws Exception {
		outboundGateway.sendToMqtt(message, topic);
    }
	
	public void execute(String topic, String payload) {
    String [] cmdParams = StringUtils.split(topic, "/");
    System.out.println("topic = " + topic);
    System.out.println("payload = " + payload);
	}
	
}
