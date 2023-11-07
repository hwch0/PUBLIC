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
public class ExcelDTO {
	
	private String itemId;
	private String itemName;
	private String type;
	private Date storeDate;
	private int stock;
	private int price;
		
}
