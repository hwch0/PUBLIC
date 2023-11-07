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
public class ItemDTO {
	private String itemId;
	private String itemName;
	private int sellingPrice;
	private int stock;
	private Date regDate;
	private String itemTypeCode;

}
