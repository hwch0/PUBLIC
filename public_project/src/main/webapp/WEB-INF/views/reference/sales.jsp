<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출내역</title>
</head>
<body>

    <div class="content" id="sales" style="display:block;">
        <div class="cont_top" style="height: 100%;">
        <div class="header-content">
            <h2>
                <img src="/images/icon1.png" alt="아이콘">
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
                    <th style="width: 130px;" class="sortable salesSortable" data-sort="매출전표">매출 코드</th>
                    <th style="width: 130px;" class="sortable salesSortable" data-sort="주문전표">주문 전표</th>
                    <th style="width: 110px;" class="sortable salesSortable" data-sort="매출일자">매출 일자</th>
                    <th style="width: 110px;" class="sortable salesSortable" data-sort="회원이름">회원 이름</th>
                    <th style="width: 110px;" class="sortable salesSortable" data-sort="구분 상태">구분 상태</th>
                    <th style="width: 130px;" class="sortable salesSortable amount-cell" data-sort="매출액">매출액</th>
                    <th style="width: 138px;" class="sortable salesSortable amount-cell" data-sort="순이익">순이익</th>
                </thead>

                <tbody class="paymTbody paymScroll" id="paymTbody" varStatus="loop">
                   
                   	<c:forEach var="paym" items="${sales}">
                   		<tr>
                   			<td>${paym['index']}</td>
                   			<td>${paym['PAYMENTID']}</td>
                   			<td>${paym['index']}</td>
                   		</tr>
                   	</c:forEach>
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