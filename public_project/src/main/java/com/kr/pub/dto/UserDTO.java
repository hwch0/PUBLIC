package com.kr.pub.dto;


import java.sql.Timestamp;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO implements UserDetails{
    private static final long serialVersionUID = -951226953749557253L;
	
	private Long id;
	
	private String userId;
	private String password;
	private String uname;
	private String birthdate;
	private String phonenumber;
	private String address;
	private String email;
	private int loginFailure;
	private Timestamp loginTime;
	private Timestamp logoutTime;
	private String regDate;
	private int remainingTime;
	private String roleId;
	private String oauth;
	
	private int seatNo;
	private int chargeTime;//시간 충전을 위한 필드
	// ENUM으로 안하고 ,로 해서 구분해서 ROLE을 입력 -> 그걸 파싱!!
	// 예제 ROLL 값 : "ROLE_USER","ROLE_MANAGER","ROLE_ADMIN"  
	public List<String> getRoleList() {
//	    if (this.roleId.length() > 0) {
//	        return Arrays.asList(this.roleId.split(","));
//	    }
//	    return new ArrayList<>();
		System.out.println("getRoleList()->" + Arrays.toString(this.roleId.split(",")));
		return Arrays.asList(this.roleId.split(","));
	}
	public UserDTO(int remainingTime) {
        this.remainingTime = remainingTime;
    }
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return false;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return false;
	}
	
}
