package com.kr.pub.service;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MqttService {
	public void execute(String topic, String payload) {
    String [] cmdParams = StringUtils.split(topic, "/");
    System.out.println("topic = " + topic);
    System.out.println("payload = " + payload);
	}
}
