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
public class ImageDTO {
	private String imgId;
	private Date regDate;
	private int length;
	private String imgNameReal;
	private char deleted;
	private String contentType;
	private String imgNameOrg;
		
}
