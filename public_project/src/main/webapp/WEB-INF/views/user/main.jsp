<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 화면</title>
</head>
<link rel="stylesheet" href="/css/user.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
    <div class="body-wrap">
        <div class="nav-wrap">
            <div>
                <!-- <a href="/user/logout">로그아웃</a> -->
                <button id="logoutBtn">로그아웃</button>
            </div>
        </div>
        <div class="chat-wrap">
            <h1>카운트다운: <span id="remainingTime">0</span> </h1>
        </div>
    </div>
</body>
<script>
$('#logoutBtn').on('click', function(){
	location.href = "/user/logout/"+localStorage.getItem("userId");
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

    return hours + " 시간 " + minutes + " 분 " + remainingSeconds + " 초";
}

function updateCountdown(remainingTime) {
    remainingTimeElement.textContent = formatTime(remainingTime);
    if (remainingTime > 0) {
        remainingTime--;
        setTimeout(function () {
            updateCountdown(remainingTime);
        }, 1000);
    } else {
        location.href = "/user/login";
    }
}

function updateRemainingTime() {
	const data = {userId : localStorage.getItem("userId")}; //JWT 토큰 구현 이후 userID가져와야함
	ajaxResponse('POST', '/getUserById', data)
		.then(function(response) {			
			var userInfo = response.result;
			var remainingTime = userInfo.remainingTime;
			if (remainingTime >= 0) {
		        var now = new Date().getTime();
		        var loginTime = new Date(userInfo.loginTime).getTime();
		        var durationTime = now - loginTime;
		        remainingTime = remainingTime - Math.floor(durationTime / 1000);
		        updateCountdown(remainingTime);
		    } else {
		       alert("잔여시간이 없습니다.")
        		   location.href = "/user/";
		    } 
		})
		.catch(function(error) {
			console.error("로그인 정보 가져오는중 에러 발생: " + error);
		});

}

window.onload = function () {
    updateRemainingTime();
}
</script>
</html>
