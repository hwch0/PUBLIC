<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입·출고현황</title>
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
                입·출고 현황
            </h2>
			<div class="button-group">
	            <img id="refresh" src="/images/refresh.png" alt="새로고침" style="width:20px">
	            <button id="check">조회</button>
	            <button id="Excel">엑셀</button>
	            <button id="delete">삭제</button>
	        </div>
		</div>
		
            <div class="inquiry">
                <table>
                    <tr>
                       <td class="tr_th">일자</td>
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


                        <td class="tr_th">품목코드</td>
                        <td style="padding: 0 30px;">
                            <input type="text" class="itemName">
                            <button id="check">조회</button>
                        </td>

                    </tr>


                    <tr>
                        <td class="tr_th">입출고상세</td>
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
						    <label style="font-size: 13px"><input type="radio" name="stockOption" checked> 모두 보기</label>
                            <label style="font-size: 13px"><input type="radio" name="stockOption"> 입고</label>
						    <label style="font-size: 13px"><input type="radio" name="stockOption"> 출고</label>
                        </td>
                    </tr>
                </table>
            </div>
        </div>


        <div class="cont_area" id="inventoryTableArea">
            <h2>
                <em><img src="/images/icon1.png" alt="아이콘"></em>
                목록
            </h2>
            <table style="width: 100%;border-color: #a49f9f;">
                <thead>
			        <th style="width: 5%;">순번</th>
			        <th style="width: 5%;">품목코드</th>
			        <th style="width: 5%;">품목명</th>
			        <th style="width: 5%;">품목유형</th>
			        <th style="width: 5%;">일자</th>
			        <th style="width: 5%;">입·출고상세</th>
			        <th style="width: 5%;">비고란</th>
			        <th style="width: 5%;">입고</th>
			        <th style="width: 5%;">출고</th>
			        <th style="width: 5%;">현재재고</th>
			        <th style="width: 5%;">총수량</th>
			        <th style="width: 5%;">공급단가</th>
			        <th style="width: 5%;">입고단가</th>
			        <th style="width: 5%;">출고단가</th>
			        <th style="width: 5%;">부가세</th>
			        <th style="width: 5%;">총금액</th>
			    </thead>

                <tbody class="itemTbody">
                    <tr>
                        <td>1</td>
                        <td>ITEM000001</td>

                    </tr>
                    <tr>
                        <td>2</td>
                        <td>ITEM000001</td>

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

</html>