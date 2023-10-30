<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석</title>
</head>
<link rel="stylesheet" href="css/reference.css">
<link rel="stylesheet" href="js/reference.js">
<body>
 <div class="header">
        <!-- ********** 상단 왼쪽 영역 시작 ********** -->
        <div class="hd hd_lft">
            <!-- 로고 영역 -->
            <div class="logo">
                <img src="logo_w.png" alt="로고">
            </div>
            <!-- 화면 전화 버튼 영역 -->
            <div class="dtn_toggle">
                <ul>
                    <li class="btn btn_pos">
                        <a href="admin_main_02.html">POS</a>
                    </li>
                    <li class="btn btn_ERP on">
                        <a href="admin_main.html">ERP</a>
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
                    <em class="arrow"><img src="sub_nav.png" alt="화살표"></em>
                    <a href="#">재고관리</a>
                   
                </li>
                <li>
                    <a href="#">매출관리</a>
                </li>
                <li>
                    <a href="#">회원관리</a>
                </li>
            </ul>
            <ul class="sub_nav">
                <li><a href="#">품목</a></li>
                <li><a href="#">입고현황</a></li>
                <li><a href="#">출고현황</a></li>
            </ul>
        </div>
        <!-- ########## 네비게이션 영역 끝 ########## -->
    </div>


    <div class="content">
        <div class="cont_top" style="height: 100%;">
            <h2>
                <em><img src="icon1.png" alt="아이콘"></em>
                재고관리
            </h2>

            <div class="inquiry">
                <table>
                    <tr>
                        <td class="tr_th">검색조건</td>
                        <td style="padding: 0 30px;">
                            <select>
                                <option value="1">선택 1</option>
                                <option value="2">선택 2</option>
                                <option value="3">선택 3</option>
                            </select>
                        </td>


                        <td class="tr_th">검색조건</td>
                        <td style="padding: 0 30px;">
                            <select>
                                <option value="1">선택 1</option>
                                <option value="2">선택 2</option>
                                <option value="3">선택 3</option>
                            </select>
                        </td>

                    </tr>


                    <tr>
                        <td class="tr_th">검색조건</td>
                        <td style="padding: 0 30px;">
                            <select>
                                <option value="1">선택 1</option>
                                <option value="2">선택 2</option>
                                <option value="3">선택 3</option>
                            </select>
                        </td>


                        <td class="tr_th">검색조건</td>
                        <td style="padding: 0 30px;">
                            <label>선택</label>
                            <input type="radio">

                            <label>선택</label>
                            <input type="radio">
                        </td>
                    </tr>
                </table>
            </div>
        </div>


        <div class="cont_area">
            <h2>
                <em><img src="icon1.png" alt="아이콘"></em>
                재고관리
            </h2>
            <table style="width: 100%;border-color: #a49f9f;">
                <thead>
                    <th style="width: 10%;">컬럼</th>
                    <th style="width: 50%;">컬럼</th>
                    <th style="width: 20%;">컬럼</th>
                    <th style="width: 20%;">컬럼</th>
                </thead>

                <tbody>
                    <tr>
                        <td>내용</td>
                        <td>내용</td>
                        <td>내용</td>
                        <td>내용</td>
                    </tr>
                    <tr>
                        <td>내용</td>
                        <td>내용</td>
                        <td>내용</td>
                        <td>내용</td>
                    </tr>
                    <tr>
                        <td>내용</td>
                        <td>내용</td>
                        <td>내용</td>
                        <td>내용</td>
                    </tr>
                    <tr>
                        <td>내용</td>
                        <td>내용</td>
                        <td>내용</td>
                        <td>내용</td>
                    </tr>
                    <tr>
                        <td>내용</td>
                        <td>내용</td>
                        <td>내용</td>
                        <td>내용</td>
                    </tr>
                    <tr>
                        <td>내용</td>
                        <td>내용</td>
                        <td>내용</td>
                        <td>내용</td>
                    </tr>
                    <tr>
                        <td>내용</td>
                        <td>내용</td>
                        <td>내용</td>
                        <td>내용</td>
                    </tr>
                    <tr>
                        <td>내용</td>
                        <td>내용</td>
                        <td>내용</td>
                        <td>내용</td>
                    </tr>
                 </tbody>
            </table>
        </div>
    </div>
</body>
</html>