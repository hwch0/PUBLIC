<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 화면</title>
</head>
<link rel="stylesheet" href="css/user.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
    <div class="body-wrap">
        <div class="nav-wrap">
            <div>
                <a href="/user/logout">로그아웃</a>
            </div>
        </div>
        <div class="chat-wrap">
            <h1>카운트다운: <span id="remainingTime">0</span> </h1>
        </div>
    </div>
</body>
<script>
//시간 js
var remainingTimeElement = document.getElementById("remainingTime");
var remainingTime = ${sessionScope.remainingTime};

function formatTime(seconds) {
    var hours = Math.floor(seconds / 3600);
    var minutes = Math.floor((seconds % 3600) / 60);
    var remainingSeconds = seconds % 60;

    return hours + " 시간 " + minutes + " 분 " + remainingSeconds + " 초";
}

function updateCountdown() {
    remainingTimeElement.textContent = formatTime(remainingTime);
    if (remainingTime > 0) {
        remainingTime--; 
        setTimeout(function () {
            updateCountdown();
        }, 1000); // 
    } else {
        location.href = "/user/main";
    }
}

function updateRemainingTime() {
    // 서버에 잔여 시간을 요청
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "/user/getRemainingTime", true);
    xhr.onload = function () {
        if (xhr.status === 200) {
            var response = JSON.parse(xhr.responseText);
            remainingTime = response.remainingTime; 
            if (remainingTime >= 0) {
                updateCountdown();
            } else {
                location.href = "/user/main";
            }
        }
    };
    xhr.send();
}

window.onload = function () {
    updateCountdown();
    updateRemainingTime();
};

</script>
</html>
