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
	private String imgId;
	private String itemName;
	private String itemDesc;
	private int sellingPrice;
	private int stock;
	private String menu;
	private String itemTypeCode;

}
