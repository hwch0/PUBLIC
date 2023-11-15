<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 화면</title>
</head>
<link rel="stylesheet" href="/css/user.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/plugins/jquery/jquery.min.js"></script>
<link rel="stylesheet" href="/css/clientChat.css">
<script type="text/javascript" src="/mqtt/mqtt.min.js"></script>
<body>
<input type="hidden" id="userInfo" value="${map.rs}">
   <div class="body-wrap">
      <div class="cont-top-wrap">
         <div class="cont-header">
            <span></span>
            <p>PUBLIC</p>
         </div>
         <div class="seat-wrap">   
            <h4>
               NO.
               <span id="seatNum">06</span>
            </h4>
            <div class="seat-btn">
               <ul>
                  <li><a href="javascript:void(0);">자리이동</a></li>
                  <li id="logoutBtn"><a href="javascript:void(0);">사용 종료</a></li>
               </ul>
            </div>
         </div>
         <div class="info-wrap">
            <em id="userId">user1</em> 님
         </div>
         <div class="time-wrap">
            <p id="remainingTime">0</p>
         </div>
         <div class="nav-btn-wrap">
            <ul>
               <li id ="orderBtn"><a href="javascript:void(0);">주문</a></li>
               <li><a href="javascript:void(0);">충전</a></li>
               <li><a href="javascript:void(0);">채팅</a></li>
            </ul>
         </div>
      </div>
      <div class="cont-bot-wrap">
         <div class="chat-wrap">
            <div class="wrap_chat">
               <div class="wrap_chat_main">
                  <ul id="chatList">
                  </ul>
                  <footer>
                     <textarea placeholder="Type your message" id="chatInputBox"></textarea>
                     <a href="javascript:void(0);" id="send_chat_button">Send</a>
                  </footer>
               </div>
            </div>
         </div>
      </div>
      <div class="cont-modal-wrap">
      	<div class="modal modal-food">
      		<div class="menu-category">
      			<ul>
      				<li class="on"><a href="javascript:void(0);">밥</a></li>
      				<li><a href="javascript:void(0);">라면</a></li>
      				<li><a href="javascript:void(0);">음료</a></li>
      				<li><a href="javascript:void(0);">스낵</a></li>
      			</ul>
      		</div>
      		<div class="cont-food">
      			<!-- 밥 종류 리스트 -->
      			<div class="food rice">
	      			<ul class="food-list">
	      				<!-- 상품반복 시작 -->
	      				<li>
	      					<div class="img-wrap">
	      						<img alt="상품이미지" src="">
	      					</div>
	      					<div class="food-info-wrap">
	      						<p class="food-name"></p>
	      						<p class="food-price"></p>
								<div class="food-option">
			                    	<span class="btn-option minus"><a href="javascript:void(0);">-</a></span>
			                    	<p>
				                        <em id="foodNum">1</em>
				                    </p>
			                        <span class="btn-option plus"><a href="javascript:void(0);">+</a></span>
			                    </div>
		      					<div class="food-select-btn">
		      						<a href="javascript:void(0);">장바구니에 담기</a>
		      					</div>
	      					</div>
	      				</li>
	      				<!-- 상품반복 끝 -->
	      			</ul>
	      		</div>
      			<!-- 라면 종류 리스트 -->
      			<!-- 음료 종류 리스트 -->
      			<!-- 스낵 종류 리스트 -->
      		</div>
      	</div>
      </div>
   </div>
</body>
<script type="text/javascript" src="/mqtt/mqttClient.js"></script>
<script>
// 로그아웃
$('#logoutBtn').on('click', function(){
	location.href = "/logout";
});

// 채팅 모달
$(".nav-btn-wrap li").on('click', function(){
	$(".cont-bot-wrap").css('display','block');
});

// 시간 js
function ajaxResponse(method, url, params) {
    return new Promise(function(resolve, reject) {
        $.ajax({
            url: url,
            method: method,
            data: JSON.stringify(params),
            contentType: 'application/json',
            success: function(response) {
                resolve(response);
            },
            error: function(error) {
                reject(error);
            }
        });
    });
}


var remainingTimeElement = document.getElementById("remainingTime");

function formatTime(seconds) {
    var hours = Math.floor(seconds / 3600);
    var minutes = Math.floor((seconds % 3600) / 60);
    var remainingSeconds = seconds % 60;

    return hours + " : " + minutes + " : " + remainingSeconds ;
}


function updateCountdown(remainingTime) {
    remainingTimeElement.textContent = formatTime(remainingTime);
    if (remainingTime > 0) {
        remainingTime--;
        setTimeout(function () {
            updateCountdown(remainingTime);
        }, 1000);
    } else if (remainingTime <= 300 && remainingTime > 0) {
        remainingTimeElement.style.color = "red";
   }else {
        location.href = "/user/logout/"+localStorage.getItem("userId");
    }
}

function updateRemainingTime(userIdValue) {
   const data = {userId : userIdValue}; //JWT 토큰 구현 이후 userID가져와야함
   ajaxResponse('POST', '/user/getUser', data)
      .then(function(response) {         
         var userInfo = response.result;
         localStorage.setItem("seatNo", userInfo.seatNo);//테스트용 userId저장
         var remainingTime = userInfo.remainingTime;
         if (remainingTime >= 0) {
              var now = new Date().getTime();
              var loginTime = new Date(userInfo.loginTime).getTime();
              var durationTime = now - loginTime;
              remainingTime = remainingTime - Math.floor(durationTime / 1000);
              updateCountdown(remainingTime);
          } else {
             alert("잔여시간이 없습니다.")
                 location.href = "/user";
          } 
      })
      .catch(function(error) {
         console.error("로그인 정보 가져오는중 에러 발생: " + error);
      });
}

window.onload = function () {
	const userInfoData = $('#userInfo').val();
	
	// 쿠키에서 모든 쿠키를 가져옵니다.
	var allCookies = document.cookie;

	// 각 쿠키를 분리합니다.
	var cookiesArray = allCookies.split(';');

	// userId 쿠키를 찾습니다.
	var userIdCookie = cookiesArray.find(function(cookie) {
	    return cookie.trim().startsWith('userId=');
	});

	// userId 쿠키에서 값만 추출합니다.
	var userIdValue = userIdCookie ? userIdCookie.split('=')[1] : null;

	// userId 값을 출력합니다.
	console.log('userId 값:', userIdValue);

	
    updateRemainingTime(userIdValue);
    
    var userIdElement = document.getElementById("userId");
    //var loggedInUserId = localStorage.getItem("userId"); 
    var loggedInUserId = userIdValue; 
    userIdElement.textContent = loggedInUserId;
}

//메뉴수량 조절
let foodNum = 1;

$('.minus').on('click', function(e) {
    if (foodNum > 1) {
    	foodNum--; 
        updatefoodNum();
    }
});

$('.plus').on('click', function(e) {
	foodNum++; 
	updatefoodNum();
});


function updatefoodNum() {
    $('.foodNum').text(foodNum);
}

</script>
</html>