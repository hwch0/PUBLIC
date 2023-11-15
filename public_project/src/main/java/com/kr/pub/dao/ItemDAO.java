package com.kr.pub.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kr.pub.dto.ErpDTO;
import com.kr.pub.dto.ItemDTO;
import com.kr.pub.dto.OrderHistoryDTO;

import io.lettuce.core.dynamic.annotation.Param;

@Mapper
public interface ItemDAO {

	//itemId 찾기
	public List<ItemDTO> selectItemId(ItemDTO itemDTO)throws Exception;
	
	//입고 등록
	public List<Map<String, Object>> insertStoreData()throws Exception;
	
	//재고 목록 출력
	public List<Map<String, Object>> itemList(Map<String, Object> params) throws Exception;
	
	//재고 토탈 카운트
	public int itemTotalCount(ErpDTO erpDTO)throws Exception;

	//입출고 목록 출력
	public List<Map<String, Object>> statusList(Map<String, Object> params) throws Exception;
	
	//주문완료 후 수량 업데이트
	public void updateItemStock(OrderHistoryDTO orderHistory);
}