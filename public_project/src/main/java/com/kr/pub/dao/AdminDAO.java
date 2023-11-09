package com.kr.pub.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminDAO {
	
	public List<Map<String, Object>> getChartData();
	
	public List<Map<String, Object>> getPieChartData(String dateType);
	
}
