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
public class PaymentDTO {
	private String paymentId;
	private String paymentTypeCode;
	private String paymentMethodCode;
	private Date paymentDate;
	private String orderId;
}
