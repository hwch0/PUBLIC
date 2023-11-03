package com.kr.pub.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kr.pub.dto.ImageDTO;
import com.kr.pub.service.ImageService;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class ImageController {
	
	private static String CURR_IMAGE_REPO_PATH = "C:\\file_repo";
	
	private ImageService imageService;
	
	@ResponseBody
	@PostMapping(value="/image/insertImage")
	public Map<String, Object> imageInsert(MultipartHttpServletRequest multipartRequest, HttpServletResponse res) {
		//List<ImageDTO> imageList = fileProcess(multipartRequest);
		
		
		return null;
		
	}
	
	

}
