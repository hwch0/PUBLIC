<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>erp</title>

    <!-- Google Font: Source Sans Pro -->
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback"
    />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="/plugins/fontawesome-free/css/all.min.css" />
    <!-- Ionicons -->
    <link
      rel="stylesheet"
      href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"
    />
    <!-- Tempusdominus Bootstrap 4 -->
    <link
      rel="stylesheet"
      href="/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css"
    />
    <!-- iCheck -->
    <link
      rel="stylesheet"
      href="/plugins/icheck-bootstrap/icheck-bootstrap.min.css"
    />
    <!-- JQVMap -->
    <link rel="stylesheet" href="/plugins/jqvmap/jqvmap.min.css" />
    <!-- Theme style -->
    <link rel="stylesheet" href="/dist/css/adminlte.min.css" />
    <!-- overlayScrollbars -->
    <link
      rel="stylesheet"
      href="/plugins/overlayScrollbars/css/OverlayScrollbars.min.css"
    />
    <!-- Daterange picker -->
    <link rel="stylesheet" href="/plugins/daterangepicker/daterangepicker.css" />
    <!-- summernote -->
    <link rel="stylesheet" href="/plugins/summernote/summernote-bs4.min.css" />

</head>
<link rel="stylesheet" href="css/reference02.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
	<div class="wrap">
        <!-- ########## 상단 헤더 영역 끝 ########## -->
        <div class="header">
            <!-- ********** 상단 왼쪽 영역 시작 ********** -->
            <div class="hd hd_lft">
                <!-- 로고 영역 -->
                <div class="logo">
                    <img src="/images/logo_p.png" alt="로고">
                </div>
                <!-- 화면 전화 버튼 영역 -->
                <div class="btn_toggle">
                    <ul>
                        <li class="btn btn_pos on">
                            <a href="/pos">POS</a>
                        </li>
                        <li class="btn btn_ERP">
                            <a href="#">ERP</a>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- ********** 상단 왼쪽 영역 끝 ********** -->

            <!-- ********** 상단 오른쪽 영역 시작 ********** -->
            <div class="hd hd_rgt">
                <div class="btn_grp">
                    <ul>
                        <li class="on"><a href="javascript:void(0);" onClick="alert();">알림</a></li>
                        <li><a href="javascript:void(0);" onClick="chat();">채팅</a></li>
                        <li><a href="javascript:void(0);">좌석</a></li>
                        <li><a href="javascript:void(0);" onclick="changeAdminPage();">대시보드</a></li>
                        <li><a href="javascript:void(0);">설정</a></li>
                    </ul>
                </div>
            </div>
            <!-- ********** 상단 오른쪽 영역 끝 ********** -->
        </div>
        <!-- ########## 상단 헤더 영역 끝 ########## -->

		<div class="wrap_cont">
		
		<!-- 좌석현황, 대시보드 출력되는 영역 -->
		<jsp:include page="adminMain.jsp"></jsp:include>
		<jsp:include page="adminDashboard.jsp"></jsp:include>
		
		</div>


        <div class="wrap_alert">
            알림 영역임 ㅋ ㅋ ㅋ
        </div>
        
        <div class="wrap_chat">
        	채팅 영역임 ㅋ
        </div>
    </div>

    

    <!-- 모달 창 영역 -->
    <div id="modal" class="modal">
        <div class="modal-content">
            <span class="close" id="closeModalBtn">&times;</span>
            <h2>모달 제목</h2>
            <p>모달 내용</p>
        </div>
    </div>
</body>
<script src="js/reference.js"></script>
<script src="js/admin.js"></script>
<script>
let admimPageChange = true;

	function changeAdminPage() {
		if(admimPageChange) {
			$('.cont_top').css("display", "none");
			$('.seat_grp').css("display", "none");
			$('.wrap_dash').css("display", "block");
			admimPageChange = false;
		} else {
			$('.cont_top').css("display", "block");
			$('.seat_grp').css("display", "block");
			$('.wrap_dash').css("display", "none");
			admimPageChange = true;
		}
	}

	function alert(){
		$('.wrap_cont').addClass("lft");
		$(".wrap_alert").addClass("on");
	}
	
	function chat(){
		$('.wrap_cont').addClass("lft");
		$(".wrap_chat").addClass("on");
	}
</script>
</html>