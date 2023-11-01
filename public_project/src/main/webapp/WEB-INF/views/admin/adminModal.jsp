<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="modal-content">
	<span class="close" id="closeModalBtn">&times;</span>

	<ul class="tab">
		<li class="tab__item active">회원정보</li>
		<li class="tab__item">주문내역</li>
	</ul>
	<div class="tab__content-wrapper">
		<div id="tab1" class="tab__content active">
			<table class="table-fill">
				<thead>
					<tr>
						<th class="text-left">좌석번호</th>
						<th class="text-left">데이터</th>
					</tr>
				</thead>
				<tbody class="table-hover">
					<tr>
						<td class="text-left">회원아이디</td>
						<td class="text-left">데이터</td>
					</tr>
					<tr>
						<td class="text-left">시작시간</td>
						<td class="text-left">데이터</td>
					</tr>
					<tr>
						<td class="text-left">잔여시간</td>
						<td class="text-left">데이터</td>
					</tr>
					<tr>
						<td class="text-left">사용시간</td>
						<td class="text-left">데이터</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div id="tab2" class="tab__content">
		<table class="table-fill">
				<thead>
					<tr>
						<th>판매시간</th>
						<th>품목 이름</th>
						<th>수량</th>
						<th>총금액</th>
					</tr>
				</thead>
				<tbody class="table-hover">
					<tr>
						<td class="text-left">2023-10-10</td>
						<td class="text-left">라면</td>
						<td class="text-left">3</td>
						<td class="text-left">15000</td>
					</tr>
					<tr>
						<td class="text-left">2023-10-10</td>
						<td class="text-left">라면</td>
						<td class="text-left">3</td>
						<td class="text-left">15000</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>