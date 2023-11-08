package com.kr.pub.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kr.pub.dto.OrderListDTO;

@Mapper
public interface OrderDAO {

	List<OrderListDTO> getOrderList();

}
