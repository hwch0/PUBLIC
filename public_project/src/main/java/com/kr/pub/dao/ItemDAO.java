package com.kr.pub.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kr.pub.dto.ExcelDTO;
import com.kr.pub.dto.SearchDTO;
import com.kr.pub.util.ResultRowDataHandler;

@Mapper
public interface ItemDAO {

	//재고 목록 출력
	public List<Map<String, Object>> itemList(Map<String, Object> searchParams) throws Exception;

	public List<ExcelDTO> excelDownload(ExcelDTO excel, ResultRowDataHandler resultRowDataHandler)throws Exception;
}
