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
                <a id="logout" href="/user/logout">로그아웃</a>
            </div>
        </div>
        <div class="chat-wrap">
            <h1>카운트다운: <span id="remainingTime">0</span> </h1>
        </div>
    </div>
</body>
<script>
// 시간 js
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
    	alert("잔여시간이 없습니다.")
        location.href = "/user/";
    }
}

function updateRemainingTime() {
    var remainingTime = ${sessionScope.remainingTime}; 

    if (remainingTime >= 0) {
        var now = new Date().getTime();
        var loginTime = new Date("${sessionScope.LoginMember.loginTime}").getTime();
        var durationTime = now - loginTime;
        remainingTime = remainingTime - Math.floor(durationTime / 1000);
        updateCountdown(remainingTime);
    } else {
    	alert("잔여시간이 없습니다.")
        location.href = "/user/";
    }
}

window.onload = function () {
    updateRemainingTime();
}
</script>

</html>
