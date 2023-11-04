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
public class SearchDTO {

	private Date startDate;
	private Date endDate;
	private String itemName;
	private String registrationDay;
	private String itemSelect;
}
