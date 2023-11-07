<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 화면</title>
</head>
<link rel="stylesheet" href="/css/user.css">
<link rel="stylesheet" href="/css/clientChat.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/mqtt/mqtt.min.js"></script>
<body>
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
					<li><a href="javascript:void(0);">주문</a></li>
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
	</div>
</body>
<script type="text/javascript" src="/mqtt/mqttClient.js"></script>
<script>
$('#logoutBtn').on('click', function(){
	location.href = "/user/logout/"+localStorage.getItem("userId");
});

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

function updateRemainingTime() {
	const data = {userId : localStorage.getItem("userId")}; //JWT 토큰 구현 이후 userID가져와야함
	ajaxResponse('POST', '/getUserById', data)
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
    updateRemainingTime();
    
    var userIdElement = document.getElementById("userId");
    var loggedInUserId = localStorage.getItem("userId"); 
    userIdElement.textContent = loggedInUserId;
}
</script>
</html>
