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
public class OrderListDTO {//사용자가 주문한 데이터를 출력하기 위한 용도
	
	private String paymentId;
	private Date paymentDate;
	private String itemName;
	private int sellingPrice;
	private int quantity;
	private String userId;
	private String orderId;
	private String seatNo;
	private char served;
}
