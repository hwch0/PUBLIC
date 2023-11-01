<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고관리</title>
<link rel="stylesheet" href="css/reference.css">

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>
<!-- 날자관련 링크 -->
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">

</head>

<body>
 <div class="header">
        <!-- ********** 상단 왼쪽 영역 시작 ********** -->
        <div class="hd hd_lft">
            <!-- 로고 영역 -->
            <div class="logo">
                <img src="/images/logo_w.png" alt="로고">
            </div>
            <!-- 화면 전화 버튼 영역 -->
            <div class="btn_toggle">
                <ul>
                    <li class="btn btn_pos">
                        <a href="/pos">POS</a>
                    </li>
                    <li class="btn btn_ERP on">
                        <a href="/erp">ERP</a>
                    </li>
                </ul>
            </div>
        </div>
        <!-- ********** 상단 왼쪽 영역 끝 ********** -->

        <!-- ********** 상단 오른쪽 영역 시작 ********** -->
        <div class="hd hd_rgt">
            <div class="btn_grp">
                <ul>
                    <li class="on"><a href="javascript:void(0);">알림</a></li>
                    <li><a href="javascript:void(0);">채팅</a></li>
                    <li><a href="javascript:void(0);">좌석</a></li>
                    <li><a href="javascript:void(0);">대시보드</a></li>
                    <li><a href="javascript:void(0);">설정</a></li>
                </ul>
            </div>
        </div>
        <!-- ********** 상단 오른쪽 영역 끝 ********** -->


        <!-- ########## 네비게이션 영역 시작 ########## -->
        <div class="nav">
            <ul class="main_nav">
                <li class="on">
                    <em class="arrow"><img src="/images/sub_nav.png" alt="화살표"></em>
                    <a href="/erp" onclick="navOn(this);">재고관리</a>
                   	<ul class="sub_nav">
		                <li><a href="javascript:void(0);" onclick="loadPage('/erp');">품목</a></li>
		                <li><a href="javascript:void(0);" onclick="loadPage('/inventoryStatus');">입·출고현황</a></li>
		            </ul>
                </li>
                <li>
                	<em class="arrow"><img src="/images/sub_nav.png" alt="화살표"></em>
                    <a href="/erp2" onclick="navOn(this);">매출관리</a>
                </li>
                <li>
                	<em class="arrow"><img src="/images/sub_nav.png" alt="화살표"></em>
                    <a href="javascript:void(0);" onclick="navOn(this);">회원관리</a>
                </li>
            </ul>
        </div>
        <!-- ########## 네비게이션 영역 끝 ########## -->
    </div>


    <div class="content" id="dynamicContent">
        <div class="cont_top" style="height: 100%;">
        <div class="header-content">
            <h2>
                <em><img src="/images/icon1.png" alt="아이콘"></em>
                재고관리
            </h2>
			<div class="button-group">
	            <img id="refresh" src="/images/refresh.png" alt="새로고침" style="width:20px">
	            <button id="check">조회</button>
	            <button id="Excel">엑셀</button>
	        </div>
		</div>
		
            <div class="inquiry">
                <table>
                    <tr>
                       <td class="tr_th">등록일</td>
			            <td style="padding:0 10px;">
						    <div class="input-group date" style="display: inline-block; ">
						        <input type="text" class="form-control" id="startDate" readonly>
						        <span class="input-group-addon datepicker-icon" style="display: table-cell;">
						            <img src="/images/calendar.png" alt="아이콘" style="width: 10px;">
						        </span>
						    </div>
						    
						    <div style="display: inline-block; margin: 0 10px;">~</div>
						    
						    <div class="input-group date" style="display: inline-block;">
						        <input type="text" class="form-control" id="endDate" readonly>
						        <span class="input-group-addon datepicker-icon" style="display: table-cell;">
						            <img src="/images/calendar.png" alt="아이콘" style="width: 10px;">
						        </span>
						    </div>
						 </td>


                        <td class="tr_th">품목명</td>
                        <td style="padding: 0 30px;">
                            <input type="text" class="itemName">
                        </td>

                    </tr>


                    <tr>
                        <td class="tr_th">품목유형</td>
                        <td style="padding: 0 30px;">
                            <select class="itemSelect">
                                <option value="1">상품</option>
                                <option value="2">비품</option>
                                <option value="3">소모품</option>
                            </select>
                        </td>


                        <td class="tr_th">재고량</td>
                        <td style="padding: 0 30px;">
						    <label style="font-size: 13px"><input type="radio" name="stockOption" checked> 모두 보기</label>
                            <label style="font-size: 13px"><input type="radio" name="stockOption"> 현재 재고</label>
						    <label style="font-size: 13px"><input type="radio" name="stockOption"> 전월 재고</label>
                        </td>
                    </tr>
                </table>
            </div>
        </div>


        <div class="cont_area">
            <h2>
                <em><img src="/images/icon1.png" alt="아이콘"></em>
                재고품목
            </h2>
            <table style="width: 100%;border-color: #a49f9f;">
                <thead>
			        <th style="width: 5%;">순번</th>
			        <th style="width: 15%;" class="sortable" data-sort="품목코드">품목코드</th>
			        <th style="width: 25%;" class="sortable" data-sort="품목명">품목명</th>
			        <th style="width: 8%;">품목유형</th>
			        <th style="width: 12%;" class="sortable" data-sort="등록일">등록일</th>
			        <th style="width: 10%;" class="sortable" data-sort="현재재고">현재재고</th>
			        <th style="width: 10%;" class="sortable" data-sort="전월재고">전월재고</th>
			        <th style="width: 15%;" class="sortable amount-cell" data-sort="평균단가">평균단가(단위 원)</th>
			    </thead>

                <tbody class="itemTbody">
                    <tr>
                        <td>1</td>
                        <td>ITEM000001</td>
                        <td>인텔 코어 i7-13세대 14700K</td>
                        <td>비품</td>
                        <td>2020-03-01</td>
                        <td>150EA</td>
                        <td>30EA</td>
                        <td class="amount-cell">￦350,000</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>ITEM000002</td>
                        <td>삼성전자 DDR4-3200(16G)</td>
                        <td>비품</td>
                        <td>2020-03-01</td>
                        <td>51EA</td>
                        <td>50EA</td>
                        <td class="amount-cell">￦250,000</td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>ITEM000003</td>
                        <td>신라면</td>
                        <td>상품</td>
                        <td>2019-04-02</td>
                        <td>152EA</td>
                        <td>151EA</td>
                        <td class="amount-cell">￦1,200</td>
                    </tr>                    <tr>
                        <td>4</td>
                        <td>ITEM000004</td>
                        <td>육개장</td>
                        <td>상품</td>
                        <td>2019-04-02</td>
                        <td>141EA</td>
                        <td>133EA</td>
                        <td class="amount-cell">￦800</td>
                    </tr>                    <tr>
                        <td>5</td>
                        <td>ITEM000005</td>
                        <td>열라면</td>
                        <td>상품</td>
                        <td>2019-04-02</td>
                        <td>80EA</td>
                        <td>40EA</td>
                        <td class="amount-cell">￦900</td>
                    </tr>                    <tr>
                        <td>6</td>
                        <td>ITEM000006</td>
                        <td>삼양라면</td>
                        <td>상품</td>
                        <td>2019-05-01</td>
                        <td>120EA</td>
                        <td>50EA</td>
                        <td class="amount-cell">￦1,300</td>
                    </tr>                    <tr>
                        <td>7</td>
                        <td>ITEM000007</td>
                        <td>코카콜라</td>
                        <td>상품</td>
                        <td>2019-05-05</td>
                        <td>300EA</td>
                        <td>20EA</td>
                        <td class="amount-cell">￦1,100</td>
                    </tr>                    <tr>
                        <td>8</td>
                        <td>ITEM000008</td>
                        <td>펩시</td>
                        <td>상품</td>
                        <td>2019-05-05</td>
                        <td>150EA</td>
                        <td>50EA</td>
                        <td class="amount-cell">￦1,000</td>
                    </tr>                    <tr>
                        <td>9</td>
                        <td>ITEM000009</td>
                        <td>새우깡</td>
                        <td>상품</td>
                        <td>2019-06-13</td>
                        <td>70EA</td>
                        <td>20EA</td>
                        <td class="amount-cell">￦700</td>
                    </tr>                    <tr>
                        <td>10</td>
                        <td>ITEM000010</td>
                        <td>츄팝츄스</td>
                        <td>상품</td>
                        <td>2019-08-11</td>
                        <td>100EA</td>
                        <td>80EA</td>
                        <td class="amount-cell">￦150</td>
                    </tr>                    <tr>
                        <td>11</td>
                        <td>ITEM000002</td>
                        <td>촉촉한 초코칩</td>
                        <td>상품</td>
                        <td>2019-09-11</td>
                        <td>200EA</td>
                        <td>30EA</td>
                        <td class="amount-cell">￦1,400</td>
                    </tr>                    <tr>
                        <td>12</td>
                        <td>ITEM000012</td>
                        <td>이클립스</td>
                        <td>상품</td>
                        <td>2019-10-11</td>
                        <td>30EA</td>
                        <td>7EA</td>
                        <td class="amount-cell">￦1,250</td>
                    </tr>                                       
                 </tbody>
            </table>
        </div>
    </div>
</body>


<script>
function navOn(element) {
    const navLi = $(element).parent();
    $(".main_nav li.on").removeClass("on");
    $(navLi).addClass("on");
}
</script>


<script src="js/erpmain.js"></script>
<script src="js/erpitem.js"></script>

</html>