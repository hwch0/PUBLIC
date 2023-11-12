package com.kr.pub.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kr.pub.dto.ErpDTO;

@Mapper
public interface PaymentDAO {

	//매출 내역
	public List<Map<String, Object>> salesList(Map<String, Object> params)throws Exception;

	public List<Map<String, Object>> getSalesList(ErpDTO search);
}
