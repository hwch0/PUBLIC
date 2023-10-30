package com.kr.pub.dto;


import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO {
	private String userId;
	private String password;
	private String uname;
	private String birthdate;
	private String phonenumber;
	private String address;
	private String email;
	private int loginFailure;
	private Date loginTime;
	private Date logoutTime;
	private Date regDate;
	private int remainingTime;
	private String roleId;
	
}
