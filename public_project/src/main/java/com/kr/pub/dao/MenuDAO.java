package com.kr.pub.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kr.pub.dto.ImageDTO;
import com.kr.pub.dto.MenuDTO;

@Mapper
public interface MenuDAO {
	
	public boolean updateMenu(MenuDTO menuDTO);

	public List<MenuDTO> getMenuList();

}
