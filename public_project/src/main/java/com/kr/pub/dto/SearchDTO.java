package com.kr.pub.dto;

import java.time.LocalDate;
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

	private String itemid;
	private LocalDate startDate;
	private LocalDate endDate;
	private String itemName;
	private String itemSelect;
	private int stockStatus;	
	
}
