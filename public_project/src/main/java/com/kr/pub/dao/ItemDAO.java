package com.kr.pub.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ItemDAO {

	//재고 목록 출력
	public List<Map<String, Object>> itemList(Map<String, Object> searchParams) throws Exception;
}
