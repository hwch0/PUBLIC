<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<link rel="stylesheet" href="/css/user.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	
</style>
<body>
    <div class="logo"><img src="/images/logo_w.png" alt="로고"></div>
    <div class="login_content">
        <div class="id_pw_form">
            <h2>로그인</h2>
            <form id="loginForm">
                <div class="ipt ipt_id">
                    <label class="placeLabel">아이디</label>
                    <span></span>
                    <input type="text" name="userId" id="userId" placeholder="아이디">
                </div>
                <div class="ipt ipt_pwd">
                    <label class="placeLabel">비밀번호</label>
                    <span></span>
                    <input type="password" name="password" id="password" placeholder="비밀번호">
                </div>
                <button class="btn login_btn" type="button" id="login">로그인</button>
            </form>
            
            <div class="btn kakao_btn">
                <a href="https://kauth.kakao.com/oauth/authorize?client_id=c3fed459f31a0ba7732ba1f69446b5d1&redirect_uri=http://localhost:9000/auth/kakao/callback&response_type=code">
                    <img src="/images/kakao_login.png" alt="kakao">
                </a>
            </div>

            <div class="li_login">
                <ul>
                    <li><a href="javascript:void(0);">회원가입</a></li>
                    <li><a href="javascript:void(0);">아이디 / 비번찾기</a></li>
                </ul>
            </div>
        </div>
    </div>
	<div class="pay_content" style="display:none;">
        <h2>시간 충전</h2>
        <div class="pay_form">
            <ul>
                <li>
                    <p><span id="userId" class="getUserId"></span>님</p>
                </li>
                <li>
                    <p>충전 시간</p>
                    
                    <div class="charge_time">
                    	<span class="btn_charge minus"><a href="javascript:void(0);">-</a></span>
                    	<p>
	                        <em>1</em>시간
	                    </p>
                        <span class="btn_charge plus"><a href="javascript:void(0);">+</a></span>
                    </div>
                    
                </li>
            </ul>
        </div>
        <div class="li_pay">
            <ul>
                <li>
                    <a href="javascript:void(0);">
                        카드결제
                    </a>
                </li>
                <li>
                    <a href="javascript:void(0);">
                        계좌이체
                    </a>
                </li>
                <li>
                    <a href="javascript:void(0);">
                        간편결제
                    </a>
                </li>
            </ul>
        </div>
        <button class="canclePayment">취소</button>
    </div>
</body>

<script> 
//로그인
document.querySelector("#login").addEventListener("click", e => {
	 const userId = $("#userId").val();
 	 const password = $("#password").val();
	 const param = {
		userId: userId,
		password: password
	};

	fetch('/user/login',{
		method: "POST",
		headers: {
			"Content-Type": "application/json; charset=UTF-8",
		},
		body: JSON.stringify(param),
	})
	.then((rs) => rs.json())
	.then((json) =>{
		alert(json.message);
		if (json.rs != null) {
			if (json.rs != 0) {
				location.href = "/user/main";	
			} else {
				$('.login_content').css('display','none');
				$('.pay_content').css('display','block');
			}	
		}
	});
});

// 충전시간 조절
let chargeTime = 1;

$('.minus').on('click', function(e) {
    if (chargeTime > 1) {
        chargeTime--; 
        updateChargeTime();
    }
});

$('.plus').on('click', function(e) {
    chargeTime++; 
    updateChargeTime();
});


function updateChargeTime() {
    $('.charge_time em').text(chargeTime);
}


$('.canclePayment').on('click', function(e){
	$('#password').val('');
	$('.login_content').css('display', 'block');
	$('.pay_content').css('display', 'none');
});



// 로그인 폼 스타일
window.addEventListener('DOMContentLoaded', (event) => {
    const inputId = document.querySelectorAll('.ipt_id input');
    const inputPwd = document.querySelectorAll('.ipt_pwd input');

    inputId.forEach((input) => {
        input.addEventListener('focus', () => {
            const spanIcon = input.previousElementSibling;
            spanIcon.style.backgroundImage = 'url("/images/id_off.png")';
        });

        input.addEventListener('blur', () => {
            const spanIcon = input.previousElementSibling;
            spanIcon.style.backgroundImage = 'url("/images/id_on.png")';
        });
    });

    inputPwd.forEach((input) => {
        input.addEventListener('focus', () => {
            const spanIcon = input.previousElementSibling;
            spanIcon.style.backgroundImage = 'url("/images/key_on.png")';
        });

        input.addEventListener('blur', () => {
            const spanIcon = input.previousElementSibling;
            spanIcon.style.backgroundImage = 'url("/images/key_off.png")';
        });
    });
});
</script>

</html>