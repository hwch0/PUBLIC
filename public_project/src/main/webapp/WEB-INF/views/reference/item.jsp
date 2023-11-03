<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고관리</title>
<link rel="stylesheet" href="css/reference.css">
</head>

<body>
    <div class="content" id="item" style="display:block;">
        <div class="cont_top" style="height: 100%;">
        <div class="header-content">
            <h2>
                <em><img src="/images/icon1.png" alt="아이콘"></em>
                재고 관리
            </h2>
			<div class="button-group">
	            <img id="refresh" src="/images/refresh.png" alt="새로고침" style="width:20px">
	            <button class="check" id="itemCheck" onclick="loading()">조회</button>
	            <button id="Excel">
					 <img src="/images/xlsx.png" alt="Excel Icon" style="vertical-align: middle; width:20px"> 엑셀
				</button>
	        </div>
		</div>
		
            <div class="inquiry">
                <table>
                    <tr>
                       <td class="tr_th">입고 일자</td>
			            <td style="padding:0 10px;">
						    <div class="input-group date" style="display: inline-block;">
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


                        <td class="tr_th">등록 일자</td>
                        <td style="padding: 0 30px;">
                            <input type="text" class="itemName">
                        </td>

                    </tr>


                    <tr>
                        <td class="tr_th">품목 유형</td>
                        <td style="padding: 0 30px;">
                            <select class="itemSelect">
                                <option value="1">상품</option>
                                <option value="2">비품</option>
                                <option value="3">소모품</option>
                            </select>
                        </td>


                        <td class="tr_th">품목 이름</td>
                        <td style="padding: 0 30px;">
                            <input type="text" class="itemName">
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="cont_area">
            <h2>
                <em><img src="/images/icon1.png" alt="아이콘"></em>
                재고 목록
            </h2>
            <table style="width: 100%;border-color: #a49f9f; border-collapse:collapse; display:block;">
                <thead>
			        <th style="width: 45px;">순번</th>
			        <th style="width: 135px;" class="sortable itemSortable" data-sort="품목코드">품목코드</th>
			        <th style="width: 236px;" class="sortable itemSortable" data-sort="품목명">품목명</th>
			        <th style="width: 71px;">품목유형</th>
			        <th style="width: 109px;" class="sortable itemSortable" data-sort="등록일">등록일</th>
			        <th style="width: 90px;" class="sortable itemSortable" data-sort="입고일자">입고일</th>
			        <th style="width: 90px;" class="sortable itemSortable" data-sort="현재재고">현재재고</th>
			        <th style="width: 128px;" class="sortable itemSortable amount-cell" data-sort="평균단가">입고단가</th>
			    </thead>

                <tbody class="itemTbody itemScroll">
                    <tr>
                        <td>1</td>
                        <td>ITEM000001</td>
                        <td>인텔 코어 i7-13세대 14700K</td>
                        <td>비품</td>
                        <td>2020-03-01</td>
                        <td>2023-02-13</td>
                        <td>30EA</td>
                        <td class="amount-cell">￦350,000</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>ITEM000002</td>
                        <td>삼성전자 DDR4-3200(16G)</td>
                        <td>비품</td>
                        <td>2020-03-01</td>
                        <td>2023-11-03</td>
                        <td>50EA</td>
                        <td class="amount-cell">￦250,000</td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>ITEM000003</td>
                        <td>신라면</td>
                        <td>상품</td>
                        <td>2019-04-02</td>
                        <td>2023-11-02</td>
                        <td>151EA</td>
                        <td class="amount-cell">￦1,200</td>
                    </tr>                    <tr>
                        <td>4</td>
                        <td>ITEM000004</td>
                        <td>육개장</td>
                        <td>상품</td>
                        <td>2019-04-02</td>
                        <td>2023-11-02</td>
                        <td>133EA</td>
                        <td class="amount-cell">￦800</td>
                    </tr>                    <tr>
                        <td>5</td>
                        <td>ITEM000005</td>
                        <td>열라면</td>
                        <td>상품</td>
                        <td>2019-04-02</td>
                        <td>2023-11-01</td>
                        <td>40EA</td>
                        <td class="amount-cell">￦900</td>
                    </tr>                    <tr>
                        <td>6</td>
                        <td>ITEM000006</td>
                        <td>삼양라면</td>
                        <td>상품</td>
                        <td>2019-05-01</td>
                        <td>2023-10-31</td>
                        <td>50EA</td>
                        <td class="amount-cell">￦1,300</td>
                    </tr>                    <tr>
                        <td>7</td>
                        <td>ITEM000007</td>
                        <td>코카콜라</td>
                        <td>상품</td>
                        <td>2019-05-05</td>
                        <td>2023-10-31</td>
                        <td>20EA</td>
                        <td class="amount-cell">￦1,100</td>
                    </tr>                    <tr>
                        <td>8</td>
                        <td>ITEM000008</td>
                        <td>펩시</td>
                        <td>상품</td>
                        <td>2019-05-05</td>
                        <td>2023-10-30</td>
                        <td>50EA</td>
                        <td class="amount-cell">￦1,000</td>
                    </tr>                    <tr>
                        <td>9</td>
                        <td>ITEM000009</td>
                        <td>새우깡</td>
                        <td>상품</td>
                        <td>2019-06-13</td>
                        <td>2023-10-30</td>
                        <td>20EA</td>
                        <td class="amount-cell">￦700</td>
                    </tr>                    <tr>
                        <td>10</td>
                        <td>ITEM000010</td>
                        <td>츄팝츄스</td>
                        <td>상품</td>
                        <td>2019-08-11</td>
                        <td>2023-10-29</td>
                        <td>80EA</td>
                        <td class="amount-cell">￦150</td>
                    </tr>                    <tr>
                        <td>11</td>
                        <td>ITEM000002</td>
                        <td>촉촉한 초코칩</td>
                        <td>상품</td>
                        <td>2019-09-11</td>
                        <td>2023-10-29</td>
                        <td>30EA</td>
                        <td class="amount-cell">￦1,400</td>
                    </tr>                    <tr>
                        <td>12</td>
                        <td>ITEM000012</td>
                        <td>이클립스</td>
                        <td>상품</td>
                        <td>2019-10-11</td>
                        <td>2023-10-28</td>
                        <td>7EA</td>
                        <td class="amount-cell">￦1,250</td>
                    </tr>                                       
                 </tbody>
            </table>
        </div>
    </div>
</body>
</html>