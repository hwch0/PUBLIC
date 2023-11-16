package com.kr.pub.controller;


import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kr.pub.dto.ImageDTO;
import com.kr.pub.dto.OrderListDTO;
import com.kr.pub.dto.UserDTO;
import com.kr.pub.service.AdminService;
import com.kr.pub.service.ImageService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	CacheManager cacheManager;
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private ImageService imageService;
	
	@Autowired
	private AdminService adminService;
	
	
	@Value("${file.upload.directroy}")
	private String filePath;
	
	@GetMapping("")
	public String adminMain(Model model) {
		List<Map<String, Object>> menuList = adminService.getMenuWithItems("Y", "N");
		List<Map<String, Object>> menuCategory = adminService.getMenuCategory();
		
		model.addAttribute("menuList", menuList);
		model.addAttribute("menuCategory", menuCategory);
		
//		String classpath = System.getProperty("java.class.path"); // 클래스 패스
//		String os = System.getProperty("os.name").toLowerCase(); // os 정보
		// "public_project" 까지의 클래스 패스 가져오기
//		int endIndex = classpath.indexOf("public_project") + "public_project".length();
//		String pathUpToPublicProject = classpath.substring(0, endIndex);
		
		// static 이미지 폴더 경로 추가
//		String addPath = os.contains("win") ? "\\src\\main\\resources\\static\\images\\menu\\" : "/src/main/resources/static/images/menu/";
//		String newPath = pathUpToPublicProject + addPath;
		
		// 어플리케이션 영역에 경로 저장
		servletContext.setAttribute("newPath", filePath);
		System.out.println(filePath);
		return "/admin/adminLayout";
	}
	
	@ResponseBody
	@PostMapping("/addMenu")
	public Map<String, Object> addMenu(MultipartHttpServletRequest multipartRequest, HttpServletResponse res) throws IOException {
		System.out.println("AdminController addMenu");
		Map<String,Object> result = new HashMap<>();
		String itemId = multipartRequest.getParameter("selectedItem");
		ImageDTO image = imageService.imageProcess(multipartRequest);
		image.setItemId(itemId);
		boolean status = imageService.insertImage(image);
		
		result.put("status", status);
		result.put("message", status ? "메뉴가 등록 되었습니다." : "메뉴 등록 중 오류 발생");
		result.put("menu",  status ? adminService.getMenu(itemId) : "");
		return result;
	}
	
	@ResponseBody
	@GetMapping("/menulist/{menuChecked}/{category}")
	public Map<String, Object> getMenuList(@PathVariable String menuChecked, @PathVariable String category) {
		System.out.println("AdminController getMenuList");
		Map<String,Object> result = new HashMap<>();

		List<Map<String, Object>> menuList = adminService.getMenuWithItems(menuChecked, category);
		boolean status = menuList != null;
		
		result.put("status", status);
		if(status) {
			result.put("menuList", menuList);
		}
		return result;
	}
	
	@ResponseBody
	@GetMapping("/deleteMenu/{itemId}")
	public Map<String, Object> deleteMenu(@PathVariable String itemId) {
		System.out.println("AdminController deleteMenu");
		Map<String, Object> result = new HashMap<>();
		
		boolean status = adminService.deleteMenu(itemId);
		result.put("status", status);
		result.put("message", status ? "메뉴가 삭제 되었습니다." : "메뉴 삭제 중 오류 발생");
		
		return result;
	}
	

	@ResponseBody
	@GetMapping("/chartData")
	public Map<String, Object> getChartData() {
		System.out.println("AdminController getChartData");
		Map<String, Object> result = new HashMap<>();
		
		Map<String, Object> data = adminService.getChartData();
		boolean status = data != null;
		
		result.put("status", status);
		result.put("data", data); // data -> month, menu, pc, total
		System.out.println(">>>>>>>>>>>>>>>>>>> data : " + result);
		
		return result;
	}
	
	@ResponseBody
	@GetMapping("/chartMontlyUsers")
	public void chartMontlyUsers() {
		System.out.println("AdminController chartMontlyUsers");
		System.out.println(">>>>>>>>>>>> " + adminService.getMonthlyUsers());;
	}
	

	@GetMapping("/getOrderList")
	@ResponseBody
	public Map<String, Object> getOrderList() {
		Map<String, Object> result = new HashMap<>();
		List<OrderListDTO> originalResult = adminService.getOrderList();
		Map<String, List<OrderListDTO>> groupedResult = new HashMap<>();

		for (OrderListDTO item : originalResult) {
			String paymentId = item.getPaymentId();
			if (!groupedResult.containsKey(paymentId)) {
				groupedResult.put(paymentId, new ArrayList<>());
			}
			groupedResult.get(paymentId).add(item);
		}

		result.put("result", groupedResult);
		System.out.println(result);
		return result;
	}
	

	@ResponseBody
	@GetMapping("/chartPieData")
	public Map<String, Object> getPieChartData() {
		System.out.println("AdminController getPieChartData");
		Map<String, Object> result = new HashMap<>();
		
		Map<String, Object> data = adminService.getPieChartData();
		boolean status = data != null;
		
		result.put("status", status);
		result.put("data", data);
		System.out.println(">>>>>>>>>>>>>>>>>>> data : " + result);
		
		return result;
	}
	
	@ResponseBody
	@GetMapping("/getUserCount")
	public Map<String, Object> getUserCount() {
		System.out.println("AdminController getUserCount");
		Map<String, Object> result = new HashMap<>();
		Map<String, Object> data= adminService.getUserCount();
		boolean status = data != null;
		result.put("status", status);
		result.put("data", data);
		return result;
	}

	@Scheduled(cron = "0 0 * * * *")
	@ResponseBody
	@GetMapping("/getHourlyUsers")
	public Map<String, Object> getHourlyUsers() {
		System.out.println("AdminController getHourlyUsers");
		Map<String, Object> result = new HashMap<>();
		
		Map<String, Object> data = adminService.getHourlyUsers();
		boolean status = data != null;
		
		result.put("status", status);
		result.put("data", data);
		return result;
		
	}
	
	
	//admin 좌석 부분
	
	@GetMapping("/loggedInUserList")
	@ResponseBody
	public Map<String, List<UserDTO>> getLoggedInUser(){
		Map<String, List<UserDTO>> result = new HashMap<>();
		Cache.ValueWrapper valueWrapper = cacheManager.getCache("loggedInUserList").get("allUsers");
		if(valueWrapper != null) {
			System.out.println("controller -> CACHE=>"+valueWrapper.get());
		}
		result.put("result", adminService.getLoggedInUserList());
		return result;
	}
	
	
//	@PostMapping("/chargeUserTime")
//	@ResponseBody
//	public void chargeUserTime(@RequestBody UserDTO input) {
//	    List<UserDTO> userList = adminService.getLoggedInUserList();
//
//	    if (userList != null) {
//	    		System.out.println("first userList =>" + userList);
//	        Optional<UserDTO> optionalUser = userList.stream()
//	                .filter(user -> user.getUserId().equals(input.getUserId()))
//	                .findFirst();
//
//	        optionalUser.ifPresent(user -> {
//	            user.setRemainingTime(user.getRemainingTime() + input.getChargeTime());
//	            // 리스트에서 해당 사용자를 교체하고 업데이트
//	            List<UserDTO> updatedList = userList.stream()
//	                    .map(obj -> obj.getUserId().equals(user.getUserId()) ? user : obj)
//	                    .collect(Collectors.toList());
//	            app.setAttribute("loggedInUserList", updatedList);
//	            //유저리스트를 가져오는게 아니라 유저가 사용중 시간 충전되면 캐시 무효화, 
//			javascript에서는 로그아웃, 시간충전등 loggedInUserList에 변화가 생기면 좌석리스트
// 			다시 뿌리는 식으로 해야됨
//	        });//컨트롤러 충전 부분에 합치는게  좋을듯, DB에 저장하기, mqtt도 같이 보내기
//	    }
//	}
}
