package com.kr.pub.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kr.pub.dto.OrderListDTO;

@Mapper
public interface OrderDAO {

	List<OrderListDTO> getOrderList();

	public List<Map<String, Object>> erpOrderSearch(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> erpOrderList() throws Exception;
	
	public List<Map<String, Object>> erpOrderView(Map<String, Object> params) throws Exception;
}
