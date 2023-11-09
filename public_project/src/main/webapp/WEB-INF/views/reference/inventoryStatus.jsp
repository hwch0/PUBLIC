<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입·출고현황</title>
</head>

<body>
    <div class="content" id="inventoryStatus" style="display:none;">
        <div class="cont_top" style="height: 100%;">
        <div class="header-content">
            <h2>
                <img src="/images/icon1.png" alt="아이콘">
                입·출고 현황
            </h2>
			<div class="button-group">
	            <img id="refresh" src="/images/refresh.png" alt="새로고침" style="width:20px">
	            <button class="check" id="testCheck" onclick="statusSearch()">조회</button>
	            <button id="uplode">등록</button>
	            <button id="delete">삭제</button>
	        </div>
		</div>
		
            <div class="inquiry">
                <table>
                    <tr>
                       <td class="tr_th">일자</td>
			            <td style="padding:0 10px;">
						    <div class="input-group date" style="display: inline-block; ">
						        <input type="text" class="form-control" id="startDate2" readonly style="background-color: #d3d3d3; color: black; font-weight: bold;">
						        <span class="input-group-addon datepicker-icon" style="display: table-cell;">
						            <img src="/images/calendar.png" alt="아이콘" style="width: 10px;">
						        </span>
						    </div>
						    
						    <div style="display: inline-block; margin: 0 10px;">~</div>
						    
						    <div class="input-group date" style="display: inline-block;">
						        <input type="text" class="form-control" id="endDate2" readonly style="background-color: #d3d3d3; color: black; font-weight: bold;">
						        <span class="input-group-addon datepicker-icon" style="display: table-cell;">
						            <img src="/images/calendar.png" alt="아이콘" style="width: 10px;">
						        </span>
						    </div>
						 </td>


                        <td class="tr_th">품목 코드</td>
                        <td style="padding: 0 30px;">
                            <input type="text" class="statusCode">
                            <button id="check">조회</button>
                        </td>

                    </tr>


                    <tr>
                      <td class="tr_th">구분 상세</td>
                        <td style="padding: 0 30px;">
						    <label style="font-size: 13px"><input type="radio" name="status" value="all" checked> 모두 보기</label>
                            <label style="font-size: 13px"><input type="radio" name="status" value="입고"> 입고</label>
						    <label style="font-size: 13px"><input type="radio" name="status" value="출고"> 출고</label>
                        </td>
                       
					  <td class="tr_th">품목 이름</td>
                        <td style="padding: 0 30px;">
                            <input type="text" class="statusName">
                        </td>
                        
                    </tr>
                </table>
            </div>
        </div>


        <div class="cont_area">
            <h2>
                <em><img src="/images/icon1.png" alt="아이콘"></em>
                입고·출고 목록
            </h2>

            <table style="width: 100%; border-color: #a49f9f;  border-collapse: collapse; display:block;">
                <thead>
			        <th style="width: 45px;">순번</th>
			        <th style="width: 132px;" class="sortable statusSortable" data-sort="품목코드">품목코드</th>
			        <th style="width: 236px;" class="sortable statusSortable" data-sort="품목명">품목명</th>
			        <th style="width: 109px;" class="sortable statusSortable" data-sort="일자">일자</th>
			        <th style="width: 80px;">상세</th>
			        <th style="width: 72px;" class="sortable statusSortable" data-sort="입·출고수량">수량</th>
			        <th style="width: 108px;" class="amount-cell">단가</th>
			        <th style="width: 120px;"class="amount-cell">총금액</th>
			    </thead>

                <tbody class="statusTbody statusScroll" id="statusTbody" varStatus="loop">
                    <c:forEach var="status" items="${status}">
                    	<tr>
                    		<td>${status['index']}</td>
							<td>${status['ITEM_ID']}</td>
							<td>${status['ITEM_NAME']}</td>
							<td>${status['STATUSDATE']}</td>
							<td style="color: ${status['INCDEC'] eq '입고' ? 'blue' : status['INCDEC'] eq '출고' ? 'red' : 'black'}">
							${status['INCDEC']}</td>
							<td>${status['STOCK']}</td>
							<td>₩<fmt:formatNumber value="${status['PRICE']}" /></td>
							<td>₩<fmt:formatNumber value="${status['STOCK'] * status['PRICE']}" /></td>
                    	</tr>                    	
                    </c:forEach>
                 </tbody>
            </table>
           </div>           
        </div>
</body>
</html>