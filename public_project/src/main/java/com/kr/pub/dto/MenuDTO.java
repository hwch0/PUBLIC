package com.kr.pub.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MenuDTO {
	private String itemId;
	private String imgId;
	private String menuCategoryCode;
	private int menuChecked;
}
