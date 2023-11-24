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
         <div class="bot chat-wrap">
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
   		 <!-- 장바구니 영역 -->
         <div class="bot wrap_cart">
        	 <div class="cart-header">
				<ul>
					<li>상품명</li>
					<li>수량</li>
					<li>취소</li>
				</ul>
			</div>
         	<div class="addCart">
         		<ul>
         			
         		</ul>
         	</div>
         	<div class="cart-btn-grp"> <!-- id= "orderBtn" -->
         		<a href="javascript:void(0);" onClick="order();">주문하기</a>
         		<a href="javascript:void(0);" onClick="removeCartAll();">장바구니 초기화</a>
         	</div>
         </div>
      </div>
      <div class="cont-modal-wrap" style="display:none;">
      	<div class="modal modal-food">
      		<div class="menu-category">
      			<ul>
      				<li id="menu01" class="on"><a href="javascript:void(0);" onclick="showCategory(1);">밥</a></li>
      				<li id="menu02"><a href="javascript:void(0);"  onclick="showCategory(2);">라면</a></li>
      				<li id="menu03"><a href="javascript:void(0);"  onclick="showCategory(3);">음료</a></li>
      				<li id="menu04"><a href="javascript:void(0);"  onclick="showCategory(4);">스낵</a></li>
      			</ul>
      		</div>
      		<div class="cont-food">
      			<!-- 밥 종류 리스트 -->
      			<div class="food">
	      			<ul class="food-list">
	      			</ul>
	      		</div>
      		</div>
      	</div>
      	<div class="modal modal-payment">
			
      	</div>
      </div>
   </div>
</body>
<script type="text/javascript" src="/mqtt/mqttClient.js"></script>
<script type="text/javascript" src="/js/user.js"></script>
</html>