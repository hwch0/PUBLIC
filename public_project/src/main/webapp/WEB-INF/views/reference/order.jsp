<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문관리</title>
<link rel="stylesheet" href="css/reference.css">
</head>
<body>

    <div class="content" id="order" style="display:none;">
        <div class="cont_top" style="height: 100%;">
        <div class="header-content">
            <h2>
                <em><img src="/images/icon1.png" alt="아이콘"></em>
                주문 내역
            </h2>
			<div class="button-group">
	            <img id="refresh" src="/images/refresh.png" alt="새로고침" style="width:20px">
	            <button id="paymCheck">조회</button>
	            <button id="Excel">엑셀</button>
	        </div>
		</div>
		
            <div class="inquiry">
                <table>
                    <tr>
                       <td class="tr_th">주문 일자</td>
			            <td style="padding:0 10px;">
						    <div class="input-group date" style="display: inline-block; ">
						        <input type="text" class="form-control" id="startDate" readonly style="background-color: #d3d3d3; color: black; font-weight: bold;">
						        <span class="input-group-addon datepicker-icon" style="display: table-cell;">
						            <img src="/images/calendar.png" alt="아이콘" style="width: 10px;">
						        </span>
						    </div>
						    
						    <div style="display: inline-block; margin: 0 10px;">~</div>
						    
						    <div class="input-group date" style="display: inline-block;">
						        <input type="text" class="form-control" id="endDate" readonly style="background-color: #d3d3d3; color: black; font-weight: bold;">
						        <span class="input-group-addon datepicker-icon" style="display: table-cell;">
						            <img src="/images/calendar.png" alt="아이콘" style="width: 10px;">
						        </span>
						    </div>
						 </td>


                        <td class="tr_th">주문 전표</td>
                        <td class="changePadding" style="padding: 0 30px;">
                            <input type="text" class="orderName" readonly style="background-color: #d3d3d3; outline: none;">
                            <button id="orderCodeFide">검색</button>
                        </td>

                    </tr>


                    <tr>
                        <td class="tr_th">구분 상세</td>
                        <td style="padding: 0 30px;">
                            <select class="itemSelect">
                                <option value="1">PC이용</option>
                                <option value="2">상품</option>

                            </select>
                        </td>


                        <td class="tr_th">결재 방법</td>
                        <td  class="changePadding"style="padding: 0 30px;">
						    <label style="font-size: 13px"><input type="radio" name="itemStockOption" checked> 모두 보기</label>
                            <label style="font-size: 13px"><input type="radio" name="itemStockOption"> 카드</label>
						    <label style="font-size: 13px"><input type="radio" name="itemStockOption"> 현금</label>
                        </td>
                    </tr>
                </table>
            </div>
        </div>


        <div class="cont_area">
            <h2>
                <em><img src="/images/icon1.png" alt="아이콘"></em>
                주문 목록
            </h2>            
            <table style="width: 100%;border-color: #a49f9f; border-collapse:collapse; display:block;">
                <thead>
                    <th style="width: 45px;">순번</th>
                    <th style="width: 140px;" class="sortable orderSortable" data-sort="주문전표">주문 전표</th>
                    <th style="width: 140px;" class="sortable orderSortable" data-sort="일자">주문일자</th>
                    <th style="width: 110px;">구분</th>
                    <th style="width: 100px;"class="sortable orderSortable" data-sort="건수">건수</th>
                    <th style="width: 140px;" class="sortable orderSortable amount-cell" data-sort="총 금액">총 금액</th>
                    <th style="width: 110px;">결제 방법</th>
                    <th style="width: 118px;" >결재 상태</th>
                </thead>

                <tbody class="orderTbody orderScroll">
                    <tr>
                        <td>1</td>
                        <td>ORDER000001</td>
                        <td>2023-11-01</td>
                        <td>PC이용</td>
                        <td>1건</td>
                        <td class="amount-cell">￦2,000</td>
                        <td>카드</td>
                        <td>완료</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td id="orderCode">ORDER000002</td>
                        <td>2023-11-01</td>
                        <td>상품</td>
                        <td>3건</td>
                        <td class="amount-cell">￦5,000</td>
                        <td>카드</td>
                        <td>완료</td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>ORDER000003</td>
                        <td>2023-11-01</td>
                        <td>PC이용</td>
                        <td>1건</td>
                        <td class="amount-cell">￦3,000</td>
                        <td>현금</td>
                        <td>완료</td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>ORDER000004</td>
                        <td>2023-11-01</td>
                        <td>상품</td>
                        <td>1건</td>
                        <td class="amount-cell">￦2,000</td>
                        <td>카드</td>
                        <td>취소</td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td id="orderCode1">ORDER000005</td>
                        <td>2023-11-01</td>
                        <td>상품</td>
                        <td>4건</td>
                        <td class="amount-cell">￦8,000</td>
                        <td>카드</td>
                        <td>완료</td>
                    </tr>
                    <tr>
                        <td>6</td>
                        <td>ORDER000006</td>
                        <td>2023-11-01</td>
                        <td>PC이용</td>
                        <td>1건</td>
                        <td class="amount-cell">￦2,000</td>
                        <td>현금</td>
                        <td>완료</td>
                    </tr>
                    <tr>
                        <td>7</td>
                        <td>ORDER000007</td>
                        <td>2023-11-01</td>
                        <td>상품</td>
                        <td>2건</td>
                        <td class="amount-cell">￦6,000</td>
                        <td>카드</td>
                        <td>완료</td>
                    </tr>
                    <tr>
                        <td>8</td>
                        <td>ORDER000008</td>
                        <td>2023-11-01</td>
                        <td>PC이용</td>
                        <td>2건</td>
                        <td class="amount-cell">￦3,000</td>
                        <td>현금</td>
                        <td>완료</td>
                    </tr>
                    <tr>
                        <td>9</td>
                        <td>ORDER000009</td>
                        <td>2023-11-01</td>
                        <td>PC이용</td>
                        <td>1건</td>
                        <td class="amount-cell">￦2,000</td>
                        <td>현금</td>
                        <td>완료</td>
                    </tr>
                    <tr>
                        <td>10</td>
                        <td>ORDER000010</td>
                        <td>2023-11-01</td>
                        <td>상품</td>
                        <td>1건</td>
                        <td class="amount-cell">￦1,800</td>
                        <td>현금</td>
                        <td>취소</td>
                    </tr>
                    <tr>
                        <td>11</td>
                        <td>ORDER000011</td>
                        <td>2023-11-01</td>
                        <td>상품</td>
                        <td>5건</td>
                        <td class="amount-cell">￦25,000</td>
                        <td>현금</td>
                        <td>완료</td>
                    </tr>
                    <tr>
                        <td>12</td>
                        <td>ORDER000012</td>
                        <td>2023-11-01</td>
                        <td>상품</td>
                        <td>1건</td>
                        <td class="amount-cell">￦2,000</td>
                        <td>카드</td>
                        <td>완료</td>
                    </tr>
                 </tbody>
            </table>
        </div>

		  <div class="detail" style="display:none;">
	        <span class="orderDetail"></span>
	        
		        <div class="cont_area orderDetail">
		            <h2>
		                <em><img src="/images/icon1.png" alt="아이콘"></em>
		                상세
		            </h2>            
		            <table style="width: 100%;border-color: #a49f9f; border-collapse:collapse; display:block;">
		                <thead>
		                    <th style="width: 45px;">순번</th> 
		                    <th style="width: 130px;">주문 전표</th>
		                    <th style="width: 125px;">주문일자</th>
		                    <th style="width: 100px;">주문자</th>
		                    <th style="width: 170px;">품목명</th>
		                    <th style="width: 78px;">수량</th>
		                    <th style="width: 110px;">단가</th>
		                    <th style="width: 128px;">총 금액</th>
		                </thead>
		
		                <tbody class="orderDetailTbody orderDetailScroll">
                  	<tr>
                        <td>1</td>
                        <td>ORDER000002</td>
                        <td>2023-11-01</td>
                        <td>홍길동</td>
                        <td>짜장라면</td>
                        <td>1</td>
                        <td class="amount-cell">￦2,000</td>
                        <td>￦2,000</td>
                    </tr>
                  	<tr>
                        <td>2</td>
                        <td>ORDER000002</td>
                        <td>2023-11-01</td>
                        <td>홍길동</td>
                        <td>코카콜라</td>
                        <td>2</td>
                        <td class="amount-cell">￦1,500</td>
                        <td>￦3,000</td>
                    </tr>
		                 </tbody>
		            </table>
		        </div>
	        </div>

    </div>
    
</body>
</html>