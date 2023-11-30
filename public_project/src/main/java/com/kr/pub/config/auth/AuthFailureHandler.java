package com.kr.pub.config.auth;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import com.kr.pub.dao.UserDAO;
import com.kr.pub.dto.UserDTO;
import com.kr.pub.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class AuthFailureHandler extends SimpleUrlAuthenticationFailureHandler {
	
	
	@Autowired
	private UserDAO userDAO;
	
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
		
	    String msg = "Invalid Email or Password";
	    String username = request.getParameter("username");
	    
	    if (exception instanceof LockedException) {
        	msg = "loginLock";
	    } else if (exception instanceof DisabledException) {
        	msg = "DisabledException account";
        } else if(exception instanceof CredentialsExpiredException) {
        	msg = "CredentialsExpiredException account";
        } else if(exception instanceof BadCredentialsException ) {
              System.out.println(username);

              userDAO.failLogin(username);
              userDAO.updateRole(username);
              
              int loginFailures = userDAO.getLoginFailures(username);
              
              if(loginFailures >= 3) {
            	  msg = "loginLock";
              } else {
            	  msg = "failLogin";
              }
        }
	
	    
	    setDefaultFailureUrl("/loginForm?error=true&exception=" + msg);
	
	    super.onAuthenticationFailure(request, response, exception);
	}
}
