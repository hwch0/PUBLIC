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
               <li id="orderBtn22"><a href="javascript:void(0);" onClick="navBtn(this);"></a>주문</li>
               <li id ="rechargeBtn"><a href="javascript:void(0);" onClick="navBtn(this);"></a>충전</li>
               <li id ="chattingBtn"><a href="javascript:void(0);" onClick="navBtn(this);"></a>채팅</li>
            </ul>
         </div>
      </div>
      <div class="cont-bot-wrap">
         <!-- 채팅 영역 -->
         <jsp:include page="userChat.jsp"></jsp:include>
         <!-- 장바구니 영역 -->
         <jsp:include page="userCart.jsp"></jsp:include>
         <!-- 시간충전 영역 -->
         <div class="bot wrap_recharge">
			<div class="div-recharge">
				<p>충전 시간</p>
                    
               <div class="charge_time">
               		<span class="btn_charge minus"><a href="javascript:void(0);">-</a></span>
               		<p>
                    	<em id="chargeTime">1</em>시간
               		</p>
                   <span class="btn_charge plus"><a href="javascript:void(0);">+</a></span>
               </div>
               <div class="order-recharge"><a href="javascript:void(0);" onclick="rechargeBtn();">충전하기</a></div>
			</div>
      </div>
      <div class="cont-modal-wrap" style="display:none;">
          <jsp:include page="userFood.jsp"></jsp:include>
      </div>
      <jsp:include page="userPayment.jsp"></jsp:include>
   </div>
</body>
<script type="text/javascript" src="/mqtt/mqttClient.js"></script>
<script type="text/javascript" src="/js/user.js"></script>
</html>