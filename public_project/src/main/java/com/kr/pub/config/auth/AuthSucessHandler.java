package com.kr.pub.config.auth;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.kr.pub.dao.UserDAO;
import com.kr.pub.dto.UserDTO;
import com.kr.pub.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class AuthSucessHandler extends SimpleUrlAuthenticationSuccessHandler {
	
	//@Autowired
	final private UserDAO userDAO;
	
	//@Autowired
	final private UserService userService;
	
	@Override
    public void onAuthenticationSuccess(
    		HttpServletRequest request
    		, HttpServletResponse response
    		, Authentication authentication //로그인한 사용자 정보가 있는 객체 
    		) throws IOException, ServletException {
	      
		System.out.println("authentication ->" + authentication);
		String url = "";
      
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;

		UserDTO userInfo = ((PrincipalDetails) principal).getUser();

		
			
		for (GrantedAuthority role : authentication.getAuthorities()) {
		     if (role.getAuthority().contains("RT004")) {
		    	 url = "/admin";
		     } else if (role.getAuthority().contains("RT001")) {
		    	 try {
					userService.login2(userInfo, request);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		    	url = "/user/main";
		     } else {
		    	 url = "/";
		     }
		  }
      
        setDefaultTargetUrl(url);
        
        super.onAuthenticationSuccess(request, response, authentication);
    }
}