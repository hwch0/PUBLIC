package com.kr.pub.dto;

import java.util.List;

public class OrderHistoryDTO {
	private String orderId;
	private List<ItemDTO> items; // item_id 컬럼
	private int quantity;
	private int price;
	
}
