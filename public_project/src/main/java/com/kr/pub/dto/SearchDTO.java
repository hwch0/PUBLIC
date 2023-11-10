package com.kr.pub.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class SearchDTO {
	
	private String startDate;
	private String endDate;
	private String name;
	private String select;
	private int stock;	
	private String code;
	private String status;
	
	private String paymentId;
	private String orderId;
	private String unme;

}
