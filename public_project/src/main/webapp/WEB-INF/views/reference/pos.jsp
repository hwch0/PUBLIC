<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>erp</title>
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
                <div class="dtn_toggle">
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
                        <li><a href="javascript:void(0);">대시보드</a></li>
                        <li><a href="javascript:void(0);">설정</a></li>
                    </ul>
                </div>
            </div>
            <!-- ********** 상단 오른쪽 영역 끝 ********** -->
        </div>
        <!-- ########## 상단 헤더 영역 끝 ########## -->

        <div class="wrap_cont">
            <div class="cont_top">
                <ul>
                    <li>
                        <p>이용중인 좌석</p>
                        <em>22</em>
                    </li>

                    <li>
                        <p>잔여 좌석</p>
                        <em>28</em>
                    </li>
                </ul>
            </div>

            <div class="seat_grp">
                <div class="seat">
                    <ul>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 1</p>
                            <p class="time">01:17:34</p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 121</p>
                            <p class="time">01:17:34</p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                    </ul>
                </div>

                <div class="seat seat_end">
                    <ul>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 99</p>
                            <p class="time">01:17:34</p>
                        </li>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 369</p>
                            <p class="time">01:17:34</p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 24</p>
                            <p class="time">01:17:34</p>
                        </li>
                    </ul>
                </div>

                <div class="seat">
                    <ul>
                        
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 96</p>
                            <p class="time">01:17:31</p>
                        </li>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 15</p>
                            <p class="time">01:17:34</p>
                        </li>
                    </ul>
                </div>

                <div class="seat seat_end">
                    <ul>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 33</p>
                            <p class="time">04:31:44</p>
                        </li>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 876</p>
                            <p class="time">01:17:34</p>
                        </li>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 30</p>
                            <p class="time">01:17:34</p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 10</p>
                            <p class="time">01:17:34</p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                    </ul>
                </div>

                <div class="seat">
                    <ul>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 33</p>
                            <p class="time">01:17:34</p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 321</p>
                            <p class="time">01:17:34</p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                    </ul>
                </div>

                <div class="seat seat_end">
                    <ul>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 678</p>
                            <p class="time">01:17:34</p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 55</p>
                            <p class="time">01:17:34</p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                    </ul>
                </div>

                <div class="seat">
                    <ul>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 44</p>
                            <p class="time">01:17:34</p>
                        </li>
                    </ul>
                </div>

                <div class="seat seat_end">
                    <ul>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 7</p>
                            <p class="time">01:17:34</p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 111</p>
                            <p class="time">01:17:34</p>
                        </li>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 123</p>
                            <p class="time">01:17:34</p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                    </ul>
                </div>

                <div class="seat">
                    <ul>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 88</p>
                            <p class="time">01:17:34</p>
                        </li>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 100</p>
                            <p class="time">01:17:34</p>
                        </li>
                        <li class="on">
                            <a href="javascript:void(0);"></a>
                            <p class="uid">user 777</p>
                            <p class="time">01:17:34</p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                        <li>
                            <a href="javascript:void(0);"></a>
                            <p class="uid"></p>
                            <p class="time"></p>
                        </li>
                    </ul>
                </div>
            </div>
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
<script>
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