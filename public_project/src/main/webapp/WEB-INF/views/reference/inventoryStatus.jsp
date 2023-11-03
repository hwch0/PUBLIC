<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입·출고현황</title>
<link rel="stylesheet" href="css/reference.css">
</head>

<body>
    <div class="content" id="inventoryStatus" style="display:none;">
        <div class="cont_top" style="height: 100%;">
        <div class="header-content">
            <h2>
                <em><img src="/images/icon1.png" alt="아이콘"></em>
                입·출고 현황
            </h2>
			<div class="button-group">
	            <img id="refresh" src="/images/refresh.png" alt="새로고침" style="width:20px">
	            <button class="check" id="testCheck">조회</button>
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


                        <td class="tr_th">품목코드</td>
                        <td style="padding: 0 30px;">
                            <input type="text" class="itemName">
                            <button id="check">조회</button>
                        </td>

                    </tr>


                    <tr>
                        <td class="tr_th">입·출고상세</td>
                        <td style="padding: 0 30px;">
                            <select class="itemSelect">
                                <option value="1">입고</option>
                                <option value="2">기타입고</option>
                                <option value="3">판매</option>
                                <option value="4">분실</option>
                                <option value="5">기타출고</option>
                            </select>
                        </td>


                        <td class="tr_th">재고량</td>
                        <td style="padding: 0 30px;">
						    <label style="font-size: 13px"><input type="radio" name="inventorystockOption" checked> 모두 보기</label>
                            <label style="font-size: 13px"><input type="radio" name="inventorystockOption"> 입고</label>
						    <label style="font-size: 13px"><input type="radio" name="inventorystockOption"> 출고</label>
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
			        <th style="width: 71px;" class="sortable statusSortable" data-sort="입·출고상세">상세</th>
			        <th style="width: 90px;" class="sortable statusSortable" data-sort="입·출고수량">수량</th>
			        <th style="width: 99px;" class="sortable statusSortable amount-cell" data-sort="입·출고단가">단가</th>
			        <th style="width: 120px;"class="sortable statusSortable amount-cell" data-sort="총금액">총금액</th>
			    </thead>

                <tbody class="statusTbody statusScroll">
                    <tr>
                        <td>1</td>
                        <td>ITEM000001</td>
                        <td>코카콜라</td>
                        <td>2023-11-02</td>
                        <td>판매</td>
                        <td>1EA</td>
                        <td class="amount-cell">￦1,450</td>
                        <td class="amount-cell">￦1,500</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>ITEM000002</td>
                        <td>삼성전자 DDR4-3200(16G)</td>
                        <td>2023-11-12</td>
                        <td>입고</td>
                        <td>10EA</td>
                        <td class="amount-cell">￦73,000</td>
                        <td class="amount-cell">￦80,000</td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>ITEM000003</td>
                        <td>사이다</td>
                        <td>2023-11-19</td>
                        <td>판매</td>
                        <td>2EA</td>
                        <td class="amount-cell">￦1,450</td>
                        <td class="amount-cell">￦1,500</td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>ITEM000003</td>
                        <td>ㄴ</td>
                        <td>2023-11-26</td>
                        <td>판매</td>
                        <td>8EA</td>
                        <td class="amount-cell">￦100,000</td>
                        <td class="amount-cell">￦110,000</td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td>ITEM000003</td>
                        <td>가나초콜릿</td>
                        <td>2023-11-30</td>
                        <td>판매</td>
                        <td>7EA</td>
                        <td class="amount-cell">￦235,000</td>
                        <td class="amount-cell">￦258,500</td>
                    </tr>
                    <tr>
                        <td>6</td>
                        <td>ITEM000003</td>
                        <td>ㄷ</td>
                        <td>2023-11-22</td>
                        <td>판매</td>
                        <td>12EA</td>
                        <td class="amount-cell">￦1,450</td>
                        <td class="amount-cell">￦1,500</td>
                    </tr>
                    <tr>
                        <td>7</td>
                        <td>ITEM000003</td>
                        <td>ㄹ</td>
                        <td>2023-11-12</td>
                        <td>판매</td>
                        <td>13EA</td>
                        <td class="amount-cell">￦1,450</td>
                        <td class="amount-cell">￦1,500</td>
                    </tr>
                    <tr>
                        <td>8</td>
                        <td>ITEM000003</td>
                        <td>ㅁ</td>
                        <td>2023-11-09</td>
                        <td>판매</td>
                        <td>17EA</td>
                        <td class="amount-cell">￦1,450</td>
                        <td class="amount-cell">￦1,500</td>
                    </tr>
                    <tr>
                        <td>9</td>
                        <td>ITEM000003</td>
                        <td>ㅂ</td>
                        <td>2023-11-08</td>
                        <td>판매</td>
                        <td>9EA</td>
                        <td class="amount-cell">￦900</td>
                        <td class="amount-cell">￦120</td>
                    </tr>
                    <tr>
                        <td>10</td>
                        <td>ITEM000003</td>
                        <td>사이다</td>
                        <td>2023-11-07</td>
                        <td>판매</td>
                        <td>5EA</td>
                        <td class="amount-cell">￦12,250</td>
                        <td class="amount-cell">￦200</td>
                    </tr>
                    <tr>
                        <td>11</td>
                        <td>ITEM000003</td>
                        <td>ㅇ</td>
                        <td>2023-11-06</td>
                        <td>판매</td>
                        <td>7EA</td>
                        <td class="amount-cell">￦250</td>
                        <td class="amount-cell">￦350,000</td>
                    </tr>
                    <tr>
                        <td>12</td>
                        <td>ITEM000003</td>
                        <td>ㅈ</td>
                        <td>2023-11-03</td>
                        <td>판매</td>
                        <td>4EA</td>
                        <td class="amount-cell">￦450</td>
                        <td class="amount-cell">￦720</td>
                    </tr>
                 </tbody>
            </table>
           </div>           
        </div>
</body>
</html>