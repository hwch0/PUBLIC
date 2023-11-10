package com.kr.pub.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kr.pub.dto.ErpDTO;

@Mapper
public interface ItemDAO {

	//재고 목록 출력
	public List<Map<String, Object>> itemList(Map<String, Object> params) throws Exception;
	
	//재고 토탈 카운트
	public int itemTotalCount(ErpDTO erpDTO)throws Exception;

	//입출고 목록 출력
	public List<Map<String, Object>> statusList(Map<String, Object> params) throws Exception;
	
//	public List<ExcelDTO> excelDownload(ExcelDTO excelDTO, ResultRowDataHandler resultRowDataHandler)throws Exception;
}