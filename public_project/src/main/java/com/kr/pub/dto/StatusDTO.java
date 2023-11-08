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
public class StatusDTO {
	
	private String itemId;
	private String itemName;
	private String incDec;
	private Date statusDate;
	private int stock;
	private int price;
	private int index;
}
