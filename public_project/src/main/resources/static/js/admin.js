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

// 메뉴 관리 모달창
const menuModal = $("#menuModal");

const openMenuController = $(".openMenuController");

openMenuController.on("click" , () => {
//	menuModal.css('display', 'block');
	menuModal.addClass('on');
})

$(window).on('click', (e) => {
    if (e.target === menuModal) {
        menuModal.removeClass('on'); 
    }
});

$('.close').on('click', () => {
	 menuModal.removeClass('on');  
});

$("#addMenuBnt").on("click", () => {
	alert("메뉴 등록");
	
	const formData = new FormData($("#menuForm")[0]);
	const url = "/admin/addMenu";
	
	fetch(url, {
		method:'POST',
		body: formData
	})
	.then((response) => response.json())
	.then((data) => {
		if(data.status) {
			alert(data.message); // 
		}
	})
	
})

// 메뉴 리스트 가져오기
$(document).ready(() => {
	
	const url = "/admin/menulist";
	const option = { method: 'GET' };
	
	myFetch(url, option, response => {
		console.log(response.list);
	})
	
})


/* 첨부파일 이벤트 핸들러 */
$(document).on("change", ".form-control", function(){
    var selectedFile = this.files[0];
    var preView = $("#preview")[0]; // jQuery 객체를 JavaScript DOM 요소로 변환

    if (selectedFile) {
        var reader = new FileReader();
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