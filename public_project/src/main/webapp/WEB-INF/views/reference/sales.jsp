<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출관리</title>
</head>
<body>

    <div class="content" id="sales" style="display:block;">
        <div class="cont_top" style="height: 100%;">
        <div class="header-content">
            <h2>
                <em><img src="/images/icon1.png" alt="아이콘"></em>
                매출 내역
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
                       <td class="tr_th">매출 일자</td>
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


                        <td class="tr_th">매출 전표</td>
                        <td style="padding: 0 30px;">
                            <input type="text" class="paymName" readonly style="background-color: #d3d3d3; outline: none;">
                            <button id="paymCodeFide">검색</button>
                        </td>

                    </tr>


                    <tr>
                        <td class="tr_th">주문 전표</td>
                        <td style="padding: 0 30px;">
                        	<input type="text" class="userName">                       	
                        </td>


                        <td class="tr_th">회원 이름</td>
                        <td style="padding: 0 30px;">
                        	<input type="text" class="userName">                       	
                        </td>
                    </tr>
                </table>
            </div>
        </div>


        <div class="cont_area">
            <h2>
                <em><img src="/images/icon1.png" alt="아이콘"></em>
                매출 목록
            </h2>            
            <table style="width: 100%;border-color: #a49f9f; border-collapse:collapse; display:block;">
                <thead>
                    <th style="width: 45px;">순번</th>
                    <th style="width: 130px;" class="sortable salesSortable" data-sort="매출전표">매출 전표</th>
                    <th style="width: 130px;" class="sortable salesSortable" data-sort="주문전표">주문전표</th>
                    <th style="width: 110px;" class="sortable salesSortable" data-sort="매출일자">매출일자</th>
                    <th style="width: 110px;" class="sortable salesSortable" data-sort="회원이름">회원이름</th>
                    <th style="width: 110px;" class="sortable salesSortable" data-sort="이용금액">이용금액</th>
                    <th style="width: 130px;" class="sortable salesSortable amount-cell" data-sort="부가상품매출">부가상품매출</th>
                    <th style="width: 138px;" class="sortable salesSortable amount-cell" data-sort="총 매출">총 매출</th>
                </thead>

                <tbody class="paymTbody paymScroll">
                    <tr>
                        <td>1</td>
                        <td>PAYM000001</td>
                        <td>ORDER000001</td>
                        <td>2023-11-04</td>
                        <td>홍길동</td>
                        <td class="amount-cell">￦1,000</td>
                        <td class="amount-cell">￦5,000</td>
                        <td class="amount-cell">￦6,000</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>PAYM000002</td>
                        <td>2023-11-01</td>
                        <td>홍길자</td>
                        <td>2시간</td>
                        <td class="amount-cell">￦2,000</td>
                        <td class="amount-cell">￦5,000</td>
                        <td class="amount-cell">￦7,000</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>PAYM000002</td>
                        <td>2023-11-02</td>
                        <td>김갑용</td>
                        <td>3시간</td>
                        <td class="amount-cell">￦3,000</td>
                        <td class="amount-cell">￦15,000</td>
                        <td class="amount-cell">￦18,000</td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>PAYM000003</td>
                        <td>2023-11-03</td>
                        <td>김갑자</td>
                        <td>2시간</td>
                        <td class="amount-cell">￦2,000</td>
                        <td class="amount-cell">￦8,000</td>
                        <td class="amount-cell">￦10,000</td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>PAYM000004</td>
                        <td>2023-11-01</td>
                        <td>이정수</td>
                        <td>5시간</td>
                        <td class="amount-cell">￦5,000</td>
                        <td class="amount-cell">￦8,000</td>
                        <td class="amount-cell">￦13,000</td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td>PAYM000005</td>
                        <td>2023-11-01</td>
                        <td>이영표</td>
                        <td>1시간</td>
                        <td class="amount-cell">￦1,000</td>
                        <td class="amount-cell">￦0</td>
                        <td class="amount-cell">￦1,000</td>
                    </tr>
                    <tr>
                        <td>6</td>
                        <td>PAYM000006</td>
                        <td>2023-11-01</td>
                        <td>이을용</td>
                        <td>6시간</td>
                        <td class="amount-cell">￦6,000</td>
                        <td class="amount-cell">￦8,500</td>
                        <td class="amount-cell">￦14,500</td>
                    </tr>
                    <tr>
                        <td>7</td>
                        <td>PAYM000007</td>
                        <td>2023-11-01</td>
                        <td>이천수</td>
                        <td>4시간</td>
                        <td class="amount-cell">￦4,000</td>
                        <td class="amount-cell">￦4,500</td>
                        <td class="amount-cell">￦8,500</td>
                    </tr>
                    <tr>
                        <td>8</td>
                        <td>PAYM000008</td>
                        <td>2023-11-01</td>
                        <td>오징어</td>
                        <td>2시간</td>
                        <td class="amount-cell">￦2,000</td>
                        <td class="amount-cell">￦1000</td>
                        <td class="amount-cell">￦10,000</td>
                    </tr>
                    <tr>
                        <td>9</td>
                        <td>PAYM000009</td>
                        <td>2023-11-01</td>
                        <td>이광수</td>
                        <td>2시간</td>
                        <td class="amount-cell">￦2,000</td>
                        <td class="amount-cell">￦25,000</td>
                        <td class="amount-cell">￦27,000</td>
                    </tr>
                    <tr>
                        <td>10</td>
                        <td>PAYM000010</td>
                        <td>2023-11-01</td>
                        <td>유재석</td>
                        <td>3시간</td>
                        <td class="amount-cell">￦3,000</td>
                        <td class="amount-cell">￦9,200</td>
                        <td class="amount-cell">￦12,200</td>
                    </tr>
                    <tr>
                        <td>11</td>
                        <td>PAYM000011</td>
                        <td>2023-11-01</td>
                        <td>김촉촉</td>
                        <td>2시간</td>
                        <td class="amount-cell">￦2,000</td>
                        <td class="amount-cell">￦5,500</td>
                        <td class="amount-cell">￦7,500</td>
                    </tr>
                    <tr>
                        <td>12</td>
                        <td>PAYM000012</td>
                        <td>2023-11-01</td>
                        <td>김가을</td>
                        <td>3시간</td>
                        <td class="amount-cell">￦3,000</td>
                        <td class="amount-cell">￦2,500</td>
                        <td class="amount-cell">￦5,500</td>
                    </tr>
                 </tbody>
            </table>
        </div>
    </div>
   
   <div id="erpModal" class="modal">
  	 <div class="modal-content">
	   <span class="close" id="closeModalBtn">&times;</span> 
  			<div class="tab__content-wrapper">
	 			<div id="tab2" class="tab__content">
                      <tr>
                      	<td class="modelPaym">매출일자</td>
                        	<td style="width:85px;">
                        		<input type="text" class="userName">                       	
                        </td>
                      </tr>
                       <tr>
	                       <td class="modelPaym">회원이름</td>
	                        <td style="width:85px;">
	                        	<input type="text" class="userName">                       	
	                        </td>
                        </tr>
                        <button id="modelFind">검색하기</button>
	  				<table class="table-fill">
						<thead>
							<tr>
								<th>매출전표코드</th>
								<th>매출일자</th>
								<th>이름</th>
							</tr>
						</thead>
						<tbody class="table-hover">
							<tr>
								<td class="text-left">2023-10-10</td>
								<td class="text-left">라면</td>
								<td class="text-left">3</td>
							</tr>
							<tr>
								<td class="text-left">2023-10-10</td>
								<td class="text-left">라면</td>
								<td class="text-left">3</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>