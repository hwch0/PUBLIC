package com.kr.pub.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PaymentDAO {

	//매출 조회
	public List<Map<String, Object>> salesSearch(Map<String, Object> params) throws Exception;
	
	//매출 내역
	public List<Map<String, Object>> salesList()throws Exception;
}
