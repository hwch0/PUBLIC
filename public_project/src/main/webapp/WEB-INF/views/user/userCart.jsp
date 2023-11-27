<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<a href="javascript:void(0);" onClick="orderBtn();">주문하기</a>
		<a href="javascript:void(0);" onClick="removeCartAll();">장바구니 초기화</a>
	</div>
</div>