package com.kr.pub.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class SearchDTO {
	
	private LocalDate startDate;
	private LocalDate endDate;
	private String name;
	private String select;
	private int stock;	
	private String code;
	private String status;
	
}
