package com.kr.pub.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ErpDTO {
	
	private String startDate;
	private String endDate;
	private String name;
	private String select;
	private int stock;	
	private String code;
	private String status;
	
	private String paymentId;
	private String orderId;
	private String unme;

	//페이징
//	private int startNo = 1; 	//시작 번호
//	private int totalCount;	//전체 건수
//	private int totalPageSize;	//전체 페이지 수
//	private int pageSize = 20;	//한페이지의 길이 
//	private boolean moreData;
//	
//	public void setTotalCount(int totalCount) {
//		this.totalCount = totalCount;
//		
//		//전체 페이지 건수 계산
//		totalPageSize =(int) Math.ceil((double) totalCount / pageSize);
//		
//		//더 이상 데이터 로드할 필요 없는지 여부
//		moreData = startNo + pageSize <= totalCount;
//	}
//	
//	public int getNextStartNo() {
//		return startNo + pageSize;
//	}
}
