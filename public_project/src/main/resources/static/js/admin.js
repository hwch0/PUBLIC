/*function myFetch(url, param, handler) {

	fetch(url, {
		method:'POST',
		headers: {
			"Content-Type" : "application/json; charset=UTF-8",
			},        
		body: JSON.stringify(param),
	})
	.then((response) => response.json())
	.then((data) => {
		if(data.status) {
			if (handler != null) {
				handler(data); // 응답데이터로 처리할 로직을 handler 함수에 정의
			}
		}
	})
}*/

/* fetch 함수 */
function myFetch(url, option,  handler) {

	fetch(url, option)
	.then((response) => response.json())
	.then((data) => {
		if(data.status) {
			if (handler != null) {
				handler(data); // 응답데이터로 처리할 로직을 handler 함수에 정의
			}
		}
	})
}

/* 메뉴 관리 모달창 */
const menuModal = $("#menuModal");

/* 메뉴 관리 모달창 > select option 목록 이벤트 핸들러 */
$(".openMenuController").on("click" , () => {
	const menuSelectListBody = $("#tbody");
	const menuItem = $("#menu-item");
	const url = "/admin/menulist/N/N"; // 등록여부: N, 카테고리: N 인 모든 목록 조회
	
	myFetch(url,{method: "GET"}, data => {
		console.log(data);
		// 상품 리스트 테이블에 가져온 상품 목록을 하나씩 추가
		const menuListData = data.menuList; 
		menuListData.forEach((menu) =>{
			menuItemClone = menuItem.clone();
			menuItemClone.find(".category").text(menu.MENU_CATEGORY);
			menuItemClone.find(".menuName").text(menu.ITEM_NAME);
			menuItemClone.find(".menuPrice").text(menu.SELLING_PRICE);
			menuItemClone.find(".menuId").text(menu.ITEM_ID);
			menuItemClone.show();
			menuSelectListBody.append(menuItemClone);
		})
		
		menuModal.addClass('on');
	} )
	
})

/* 메뉴 관리 모달창 > select option 목록 이벤트 핸들러 */
 $('.form-select').on('change', ()=>{
    let selectedValue =  $('.form-select').find(":selected").val();
    console.log('선택한 값: ' + selectedValue);
    
	const menuSelectListBody = $("#tbody");
	const menuItem = $("#menu-item");
	const url = "/admin/menulist/N/" + selectedValue;
	menuSelectListBody.empty();
	
	myFetch(url,{method: "GET"}, data => {
		console.log(data);
		const menuListData = data.menuList;
		menuListData.forEach((menu) =>{
			menuItemClone = menuItem.clone();
			menuItemClone.find(".category").text(menu.MENU_CATEGORY);
			menuItemClone.find(".menuName").text(menu.ITEM_NAME);
			menuItemClone.find(".menuPrice").text(menu.SELLING_PRICE);
			menuItemClone.find(".menuId").text(menu.ITEM_ID);
			menuItemClone.show();
			menuSelectListBody.append(menuItemClone);
		})
		
		menuModal.addClass('on');
	} )
    
    
    
  });

/* 메뉴 관리 모달창 닫기 */
$('#closeModalBtn').on('click', () => {
	console.log("닫힘");
    // 모달 창이 닫힐 때 id="selectedItem"의 값을 초기화
    $('.form-select').val('N');
    
    // 이미지의 src를 초기화
    $('#inputGroupFile02').val('');
    $('#preview').attr('src', '');
    $('#preview').css('display', 'none');
	 
	 menuModal.removeClass('on');  
});

/* 메뉴 삭제 (menu_checked : N => Y) */
$("#addMenuBnt").on("click", () => {
	alert("메뉴 등록");
	// 체크된 tr의 menuId 클래스명을 가진 요소의 텍스트 값을 저장할 배열을 만듭니다.
	let checkedMenuIds = [];
	
	// 'menuChecked' 클래스명을 가진 체크박스 중에서 체크된 항목을 찾습니다.
	$('.menuChecked #checkedBox:checked').each(function() {
	    // 각 체크된 항목의 부모 <tr>에서 menuId 클래스명을 가진 요소의 텍스트 값을 가져와서 배열에 추가합니다.
	    let menuIdText = $(this).closest('tr').find('.menuId').text();
	    checkedMenuIds.push(menuIdText);
	});
	
	
	if(checkedMenuIds.length == 0) {
		alert("등록하실 메뉴를 선택해주세요.")
	} else if(checkedMenuIds.length > 1) {
		alert("메뉴는 한 개만 선택해주세요.")
	} else {
		
	// 체크된 항목의 menuId 값을 확인합니다.
	$('#selectedItem').val(checkedMenuIds[0]);
	console.log($('#selectedItem').val());
		
		const formData = new FormData($("#menuForm")[0]);
		const url = "/admin/addMenu";
		
		fetch(url, {
			method:'POST',
			body: formData
		})
		.then((response) => response.json())
		.then((data) => {
			if(data.status) {
				
				alert(data.message); 
				console.log(data.menu);
				
				// 메뉴 등록 후 반환받은 정보를 menuList 그리드에 추가
				const cardDate = data.menu;
				const menuList = $('.menuList');
				const cardItem = $('#cardItem').clone();
				cardItem.find('img').attr('src', '/image/download/' + cardDate.IMG_ID);
				cardItem.find('.fw-bolder.menuName').text(cardDate.ITEM_NAME);
				cardItem.find('.fw-bolder.menuPrice').text(cardDate.SELLING_PRICE);
				cardItem.find('#deleteMenuBnt').attr('menuId', cardDate.ITEM_ID);
				cardItem.show();
				
				menuList.append(cardItem);
				menuModal.removeClass('on'); 

			}
		})
	}
})

/* 메뉴 삭제 (menu_checked : Y => N) */
function deleteMenu(element) {
    let menuId = element.getAttribute('menuId');
//    alert("attr 속성 값: " + menuId);
    
    let url = "/admin/deleteMenu/" + menuId; // menuId = item테이블의 item_id
    
	myFetch(url, {mothod: "GET"}, data => {
		if(data.status) {
			alert(data.message);
			
			// 메뉴판에서 해당 메뉴 삭제하는 코드 추가
		    element.closest('.col.mb-5').remove();
		}
	})

}

/* 첨부파일 이벤트 핸들러 */
$(document).on("change", ".form-control", function(){
    let selectedFile = this.files[0];
    let preView = $("#preview")[0]; // jQuery 객체를 JavaScript DOM 요소로 변환

    if (selectedFile) {
        let reader = new FileReader();
        reader.onload = function(e) {
            preView.src = e.target.result;
            preView.style.display = "block";
        }
        reader.readAsDataURL(selectedFile);
    } else {
        alert("이미지 파일을 선택하세요");
        $(this).val(""); // 파일 입력 내용 지우기
        preView.src = ""; // 미리보기 이미지 제거
    }
});