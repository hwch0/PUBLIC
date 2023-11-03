<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>erp</title>

</head>
<%-- <jsp:include page="/WEB-INF/views/common/commonCSS.jsp"></jsp:include> --%>

<!-- erp 영역 CSS -->
<link rel="stylesheet" href="css/reference.css"> 

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
                <li>
                    <em class="arrow"><img src="/images/sub_nav.png" alt="화살표"></em>
                    <a href="/stock" onclick="navOn(this);">재고관리</a>                  
                </li>
                <li class="on">
                	<em class="arrow"><img src="/images/sub_nav.png" alt="화살표"></em>
                    <a href="/sales" onclick="navOn(this);">매출관리</a>
                   	<ul class="sub_nav">
		                <li><a href="javascript:void(0);" onclick="changesalesPage();">매출 내역</a></li>
		                <li><a href="javascript:void(0);" onclick="changeOrderPage();">주문 내역</a></li>
		            </ul>
                </li>
                <li>
                	<em class="arrow"><img src="/images/sub_nav.png" alt="화살표"></em>
                    <a href="javascript:void(0);" onclick="navOn(this);">회원관리</a>
                </li>
            </ul>
        </div>
        <!-- ########## 네비게이션 영역 끝 ########## -->
    </div>

			<!-- 매출 관리 영역 -->			
			<jsp:include page="sales.jsp"></jsp:include>
			<jsp:include page="order.jsp"></jsp:include>
			

    <!-- 모달 창 영역 -->

</body>

<jsp:include page="/WEB-INF/views/common/commonJS.jsp"></jsp:include>

</html>