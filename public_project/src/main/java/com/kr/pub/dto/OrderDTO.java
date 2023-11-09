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
public class OrderDTO {
	private String orderId;
	private Date orderDate;
	private String userId;
	private String code;
	private String remarks;
	private String served;
}
