package com.kr.pub.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.kr.pub.dto.UserDTO;

import jakarta.servlet.ServletContext;

@Component
public class AppContextListener implements ServletContextListener {
//	@Autowired
//	private ServletContext app;
//	
//	@Override
//    public void contextInitialized(ServletContextEvent sce) {
//		System.out.println("어플리케이션 영역 초기화");
//        List<UserDTO> loggedInUserList = new ArrayList<>();
//        //원하는 데이터 초기화
//        app.setAttribute("loggedInUserList", loggedInUserList);
//    }
}
