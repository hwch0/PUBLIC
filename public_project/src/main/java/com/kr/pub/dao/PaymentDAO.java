package com.kr.pub.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kr.pub.dto.OrderDTO;
import com.kr.pub.dto.OrderHistoryDTO;

@Mapper
public interface PaymentDAO {

	//매출 조회
	public List<Map<String, Object>> salesSearch(Map<String, Object> params) throws Exception;
	
	//매출 내역
	public List<Map<String, Object>> salesList()throws Exception;

	public void insertPayment(OrderDTO order);
}
