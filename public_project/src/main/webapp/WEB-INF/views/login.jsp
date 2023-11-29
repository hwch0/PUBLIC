<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %><!-- 태크라이브러리 -->

<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal" var="principal"/>
</sec:authorize>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<!-- <link rel="stylesheet" href="/css/user.css"> -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
@charset "UTF-8";
/* 폰트 */
@font-face {
    font-family: "Noto Sans KR";
    font-style: normal;
    font-weight: 400;
    font-display: swap;
    src: url(https://fonts.gstatic.com/s/notosanskr/v13/PbykFmXiEBPT4ITbgNA5Cgm203Tq4JJWq209pU0DPdWuqxJFA4GNDCBYtw.0.woff2)
        format("woff2");
}

@font-face {
    font-family: "Noto Sans KR";
    font-style: normal;
    font-weight: 700;
    font-display: swap;
    src: url(https://fonts.gstatic.com/s/notosanskr/v13/PbykFmXiEBPT4ITbgNA5Cgm203Tq4JJWq209pU0DPdWuqxJFA4GNDCBYtw.0.woff2)
        format("woff2");
}

@font-face {
    font-family: "Noto Sans KR";
    font-style: normal;
    font-weight: 900;
    font-display: swap;
    src: url(https://fonts.gstatic.com/s/notosanskr/v13/PbykFmXiEBPT4ITbgNA5Cgm203Tq4JJWq209pU0DPdWuqxJFA4GNDCBYtw.0.woff2)
        format("woff2");
}

*  {
    padding: 0;
    margin: 0;
    font-family: "Noto Sans KR";
    font-weight: 600;
    list-style: none;
    text-decoration: none;
}


body {
    width: 100vw;
    height: 100vh;
    overflow: hidden;
    background-image: url('/images/bg_login.jpg');
    background-size: cover;
}

.logo {
    position: absolute;
    width: 200px;
    top: 50px;
    left: 50px;
}

.logo img {
    width: 100%;
    height: auto;
}

.login_content {
    position: absolute;
    top: 50%;
    left: 50%;
    margin: -275px 0 0 -250px;
    padding: 50px 75px;
    width: 500px;
    height: 550px;
    box-sizing: border-box;
    border-radius: 5px;
    background-color: rgba(0,0,0,0.6);
}

.id_pw_form h2 {
    font-size: 28px;
    color: #fff;
}

.ipt {
    position: relative;
}

.ipt + .ipt {
    margin-top: 20px;
}

label {
    display: none;
}

.ipt span {
    position: absolute;
    display: block;
    top: 50%;
    left: 10px;
    margin-top: -15px;
    width: 30px;
    height: 30px;
    background-image: url('/images/id_on.png');
    background-size: cover;
}

.ipt_pwd span {
    background-image: url('/images/key_off.png');
}

.id_pw_form form {
    margin-top: 30px;
}

.id_pw_form input {
    padding: 0 20px;
    width: 350px;
    height: 50px;
    line-height: 50px;
    font-size: 18px;
    text-indent: 30px;
    border: none;
    border-radius: 5px;
    box-sizing: border-box;
    background-color: #333;
    color: #fff;
}

.login_btn {
    margin-top: 50px;
    width: 350px;
    height: 50px;
    line-height: 50px;
    font-size: 18px;
    color: #fff;
    cursor: pointer;
    border: none;
    border-radius: 5px;
    background-color: #440977;
}

.kakao_btn {
    margin-top: 20px;
    width: 350px;
    height: 50px;
    border-radius: 5px;
    overflow: hidden;
}

.kakao_btn a {
    display: block;
    height: 50px;
}

.kakao_btn a img {
    width: 100%;
}

.li_login {
    margin-top: 20px;
    width: 350px;
    height: 30px;
}

.li_login li {
    float: left;
    width: 50%;
}

.li_login li a {
    display: block;
    line-height: 30px;
    text-align: center;
    font-size: 14px;
    color: #fff;
}




.body-wrap {
    width: 100vw;
    height: 100vh;
    background-image: url("/images/bg_common.jpg");
    background-size: auto 100%;
    background-position: center bottom;
}

.cont-top-wrap {
    position: fixed;
    top: 5%;
    right: 25px;
    width: 400px;
    height: 30%;
    background-color: rgba(51,51,51,0.9);
}
.cont-top-wrap > div {
   padding: 0 10px;
   box-sizing: border-box;
}

.cont-header {
   width: 100%;
   height: 30px;
   line-height: 30px;
   background-color: rgba(0,0,0,0.5);
}

.cont-header span {
   display: block;
   float: left;
   width: 30px;
   height: 30px;
   background-image: url("/images/logo_s.png");
   background-size:auto 80%;
   background-repeat: no-repeat;
   background-position: center;
}

.info-wrap {
}

.cont-header p {
   color: rgba(255,255,255,0.7);
}
.seat-wrap {
   position: relative;
   height: 50px;
}

.seat-wrap h4 {
   height: 100%;
   line-height: 50px;
   font-size: 16px;
   color: #fff;
}

#seatNum {
   color: #ffca28;
   font-size: 24px;
}
.seat-wrap .seat-btn {
   position: absolute;
   top: 50%;
   right: 0;
   margin-top: -13px;
   width: 70%;
   height: 26px;
}

.seat-wrap .seat-btn ul {
   width: 100%;
   height: 100%;
}
.seat-wrap .seat-btn li {
   float: left;
   margin: 0 5%;
   width: 40%;
   height: 100%;
   background-color: #000;
}

.seat-wrap .seat-btn li a {
   display: block;
   height: 100%;
   line-height: 26px;
   text-align: center;
   font-size: 12px;
   color: #fff;
}

.info-wrap {
   position: relative;
   margin: 0 10px;
   padding: 0 25px !important;
   height: 30px;
   line-height: 30px;
   text-align: right;
   color: #fff;
   background-color: rgba(102,102,102,0.9);
}
.info-wrap:after {
   content: "";
   position: absolute;
   top: 50%;
   right: 100px;
   margin-top: -13px;
   width: 26px;
   height: 26px;
   background-image:url("/images/user.png");
   background-size: 100%;
}

.getUserId {
   color: #ffca28;
}
.time-wrap {
   height: 70px;
}

.time-wrap p {
   height: 100%;
   line-height: 70px;
   font-size: 40px;
   color: #fff;
   text-align: center;
}
.nav-btn-wrap ul {
   margin: 20px 0;
   width: 100%;
   height: 50px;
}
.nav-btn-wrap li {
   position: relative;
   float:left;
   width: 30%;
   height: 50px;
   line-height: 50px;
   text-indent: 50px;
   font-size: 14px;
   color: #fff;
   background-color: rgba(102,102,102,0.9);
}

.nav-btn-wrap li:after {
   content: "";
   position: absolute;
   top: 50%;
   left: 20px;
   margin-top: -13px;
   width: 26px;
   height: 26px;
   
   background-image:url("/images/order-user.png");
   background-size: 100%;
}
.nav-btn-wrap li:nth-child(2):after {
   background-image:url("/images/recharge-user.png");
}

.nav-btn-wrap li:nth-child(3):after {
   background-image:url("/images/chat-user.png");
}

.nav-btn-wrap li + li {
   margin-left: 5%;
}
.nav-btn-wrap li a {
   position: absolute;
   z-index: 100;
   top: 0;
   right: 0;
   left: 0;
   bottom: 0;
}

.cont-bot-wrap {
    position: fixed;
    display: none;
    bottom: 5%;
    right: 25px;
    width: 400px;
    height: 55%;
    background-color: #fff;
}
.cont-bot-wrap .bot {
   display: none;   
}

.cont-bot-wrap .bot.on {
   display: block;   
}


.cart-btn-grp {
	display: flex;
	width: 100%;
	height: 50px;
   width: 100%;
   height: 30px;
}
#orderBtn {
   width: 100px;
   height: 50px;
}

.cart-btn-grp a {
	margin: 0 10%;
	width: 30%;
	height: 50px;
	line-height: 50px;
	text-align: center;
	font-size: 14px;
	color: #fff;
	background-color: #440977;
}

.cont-modal-wrap {
   position: fixed;
   top:5%;
   left:25px;
   width: calc(100vw - 475px);
   height: calc(100vh - 10%);
   background-color: rgba(0,0,0,0.9);
}

.modal-food {
   position: relative;
   padding: 125px 0 50px 0;
   width: 100%;
   height: 100%;
   box-sizing: border-box;
}

.modal-food .menu-category {
   position: absolute;
   width: 50%;
   height: 40px;
   top: 50px;
   left: 50%;
   margin-left: -25%;
   border-radius: 20px;
   background-color: #fff;
}

.modal-food .menu-category ul {
   margin: 0 auto;
   width: 100%;
   height: 100%;
}

.modal-food .menu-category li {
   float: left;
   width: 25%;
   height: 100%;
   text-align: center;
}

.modal-food .menu-category li a {
   display: block;
   line-height: 40px;
   font-size: 18px;
   color: #666;
}
.modal-food .menu-category li.on a {
   color:  #440977;
   font-weight: bold;
}

.modal-food .cont-food .food {
   overflow-y: scroll;
}

.food::-webkit-scrollbar {
  display: none;
}

.modal-food .cont-food .food ul {
   display: flex;
   flex-wrap: wrap;
   margin-left: 30px;
   width: 100%;
   height: 700px;
   padding: 0 10px;
   box-sizing: border-box;
}

.modal-food .cont-food .food li {
   position: relative;
   margin: 20px;
   width: 250px;
   height: 300px;
   border-radius: 5px;
   box-sizing: border-box;
   overflow: hidden;
   background-color: #fff;
}

.modal-food .cont-food .food li a {
   display: none;
   position: absolute;
   z-index: 2;
   top: 0;
   right: 0;
   left: 0;
   bottom: 0;
   text-align: left;
   background-color: rgba(0,0,0,0.5);
}

.modal-food .cont-food .food li:hover a {
   display: block;
   
}
.food-info-wrap{
	width: 100%;
	padding:0 10px;
	box-sizing: border-box;
}
.food-name{
	text-align: left;
	margin-top: 20px; 
	font-size: 18px;
	font-weight: 900; 
	line-height: 24px;
}
.food-price-wrap {
	margin-top:5px; 
	text-align: left;
	line-height:24px; 
	font-size: 18px;
}
.modal-food .cont-food .food li .img-wrap {
	position: relative;
   width: 100%;
   height: 70%;
}
.modal-food .cont-food .food li:nth-child(even) .img-wrap::before {
	content: "BEST!";
	position: absolute;
	bottom: -15px;
	left: 0;
	width: 100px;
	height: 30px;
	text-align: center;
	line-height: 28px;
	font-size: 14px;
	font-weight: 600;
	color: #fff;
	background-color: rgb(255, 0, 0);
}
.modal-food .cont-food .food li img {
   width: 100%;
   height: 100%;
}
.addCart {
   padding: 10px;
   box-sizing: border-box;
}
.addCart {
	padding: 10px;
	height: 100%;
	overflow-y: scroll;
}
.addCart::-webkit-scrollbar {
  display: none;
}
.addCart ul {
	padding:0 10px;
	box-sizing: border-box;
	
}
.addCart ul li {
	position: relative;
	padding: 20px 0;
	width: 100%;
	
}
.addCart ul li + li {
	border-top: 2px solid #999;
}
.addCart ul li .food-name {
	margin:0;
	text-align: left;
	line-height: 30px;
	font-weight: 800;
	font-size: 16px;
}

.addCart ul li .food-price {
	position: absolute;
    bottom: 25px;
    right: 10px;
    font-size: 20px;
    color: blue;
}
.addCart ul li .food-option {
	position: relative;
	margin-top: 10px;
	width: 100px;
  	height: 30px;
}
.addCart ul li .food-option p {
	width: 100%;
	height: 30px;
	line-height: 30px;
	text-align: center;
}

.addCart ul li .food-option span {
	position: absolute;
	display: block;
	top: 0;
	left: 0;
	width: 30px;
	height: 30px;
	font-size: 20px;
	color: #fff;
	font-weight: 900;
	text-align: center;
	text-indent: 1px;
	line-height: 25px;
	border-radius: 50%;
	cursor: pointer;
	background-color: #440977;
}

.addCart ul li .food-option span.plus {
	right: 0;
	left: auto;
}

.addCart ul li .remove-from-cart {
	position: absolute;
	top: 25px;
	right: 10px;
}
.addCart ul .itemId { display: none; }

.modal-payment {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(0,0,0,0.5);
}

.modal-payment .modal-paymentList {
	position: absolute;
	top: 50%;
	left: 50%;
	margin: -250px 0 0 -200px;
	width: 400px;
	height: 500px;
	background-color: #fff;
}

.modal-payment .modal-order{
	display: none;
	position: absolute;
	top: 50%;
	left: 50%;
	margin:-100px 0 0 -200px;
	width: 400px;
	height: 200px;
	background-color: #fff;
}

</style>


<script src="/plugins/jquery/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
.payment_content {
   display: none;
   position: absolute;
   top: 50%;
   left: 50%;
   margin: -275px 0 0 -250px;
   padding: 50px 75px;
   width: 500px;
   height: 550px;
   box-sizing: border-box;
   border-radius: 5px;
   background-color: rgba(0,0,0,0.6);
}

.payment_content h2 {
    font-size: 28px;
    color: #fff;
}

.payment_form {
    margin-top: 30px;
}

.payment_form li {
    position: relative;
    height: 20px;
    color: #fff;
}

.payment_form li:last-child {
    height: 80px;
}

.payment_form li + li {
    margin-top: 30px;
}

.payment_form li:last-child > p {
	height: 30px;
	line-height: 30px;
}

.payment_form .charge_time {
	position: relative;
	margin-top: 10px;
	height: 40px;
}

.payment_form .charge_time p {
	height: 40px;
	line-height: 40px;
    text-align: center;
    font-size: 14px;
}
.payment_form .charge_time p em {
	padding: 0 5px;
	font-size: 22px;
	font-weight: bold;
	font-style: normal;
}
.payment_form li .btn_charge {
    position: absolute;
    display: block;
    top: 50%;
    margin-top: -15px;
    width: 30px;
    height: 30px;
    overflow: hidden;
    border-radius: 50%;
    background-color: #fff;
}

.payment_form li .btn_charge.minus {
	left: 30px;
	background: url("/images/minus-button.png") no-repeat center;
	background-size: 100%;
}
.payment_form li .btn_charge.plus {
	right: 30px;
	background: url("/images/plus-button.png") no-repeat center;
	background-size: 100%;
}

.payment_form li .btn_charge a {
    display: block;
    line-height: 30px;
    text-indent: -999em;
}
.payment_form li .charge_time {
    text-align: center;
}
.li_paymethod ul {
    padding: 0;
}

.li_paymethod li {
    margin-top: 30px;
    width: 350px;
    height: 50px;
    border: none;
    border-radius: 5px;
    background-color: #440977;
}
.li_paymethod a {
    display: block;
    line-height: 50px;
    font-size: 18px;
    color: #fff;
    text-align: center;
}
.canclePayment {
	position: absolute;
	top: 25px;
	right: 25px;
	text-indent: -999em;
	overflow: hidden;
	cursor: pointer;
	border-radius: 50%;
	background-color: none;
	background: url("/images/cancle.png") no-repeat center;
	background-size: 100%;
}
.canclePayment a {
	display: block;
	width: 40px;
	height: 40px;
}
</style>
<body>
    <div class="logo"><img src="/images/logo_w.png" alt="로고"></div>
    <div class="login_content" style="${showPaymentContent ? 'display:none;' : 'display:block;'}">
        <div class="id_pw_form">
            <h2>로그인</h2>
            <form id="loginForm" method="post" action="/login" >
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            
                <div class="ipt ipt_id">
                    <label class="placeLabel">아이디</label>
                    <span></span>
                    <input type="text" name="username" id="userId" placeholder="아이디">
                </div>
                <div class="ipt ipt_pwd">
                    <label class="placeLabel">비밀번호</label>
                    <span></span>
                    <input type="password" name="password" id="password" placeholder="비밀번호">
                </div>
                <button class="btn login_btn" type="submit" id="login">로그인</button>
            </form>
            
            <div class="btn kakao_btn">
                <a href="https://kauth.kakao.com/oauth/authorize?client_id=f9233fa5fb65f7da3addba11aa52d18a&redirect_uri=http://localhost:8282/auth/kakao/callback&response_type=code">
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
	<div class="payment_content" style="${showPaymentContent ? 'display:block;' : 'display:none;'}">

        <h2>시간 충전</h2>
        <div class="payment_form">
            <ul>
                <li>
                    <p><span id="userId" class="getUserId">${principal.user.userId }</span>님!</p>
                </li>
                <li>
                    <p>충전 시간</p>
                    
                    <div class="charge_time">
                    	<span class="btn_charge minus"><a href="javascript:void(0);">-</a></span>
                    	<p>
	                        <em id="chargeTime">1</em>시간
	                    </p>
                        <span class="btn_charge plus"><a href="javascript:void(0);">+</a></span>
                    </div>
                    
                </li>
            </ul>
        </div>
        <div class="li_paymethod">
            <ul>
                <li id="card">
                    <a href="javascript:void(0);">
                        카드결제
                    </a>
                </li>
                <li id="cash">
                    <a href="javascript:void(0);">
                        계좌이체
                    </a>
                </li>
                <li id="smart">
                    <a href="javascript:void(0);">
                        간편결제
                    </a>
                </li>
            </ul>
        </div>
       <div class="canclePayment"><a>취소</a></div> 
    </div>
</body>
<script>
// 잔여시간 없음
window.addEventListener('DOMContentLoaded', (event) => {
    const showPaymentContent = ${showPaymentContent};
//     const userId = "${userId}";
//     $('.getUserId').text(userId);
    
    if (!showPaymentContent) {
        document.querySelector('.login_content').style.display ="none";
        document.querySelector('.payment_content').style.display = 'block';
    }
});

// 시간 충전
$('.li_paymethod li').on('click', function(e) {
    const userId = $('.getUserId').text();
    const chargeTime = $('#chargeTime').text();
    const paymentMethodCode = $(this).attr('id');

    const param = {
        userId: userId,
        remainingTime: chargeTime * 3600,
        paymentMethodCode: paymentMethodCode
    };
	console.log(">>>> " + userId +" "+ chargeTime * 3600+ " "+paymentMethodCode);
    fetch('/user/rechargeTime', {
        method: "POST",
        headers: {
            "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify(param),
    })
    .then((rs) => rs.json())
    .then((json) =>{
        if (json.rs == "success") {
        	 swal({
			  title: "Success!",
			  text: "충전이 정상적으로 처리되었습니다.",
			  icon: "success",
			}).then((value) => {
			  if (value) {
				 location.href = "/";
			  }
			});
        } else {
        	swal({
  			  title: "Error",
  			  text: "충전이 정삭적으로 처리되지 않았습니다.",
  			  icon: "warning",
  			}).then((value) => {
  			  if (value) {
  				 location.href = "/";
  			  }
  			});
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
	$('.payment_content').css('display', 'none');
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