function formatDatenTime(dateTimeString) {
	const dateTime = new Date(dateTimeString);
	const year = dateTime.getFullYear();
	const month = String(dateTime.getMonth() + 1).padStart(2, '0');
	const day = String(dateTime.getDate()).padStart(2, '0');
	const hours = String(dateTime.getHours()).padStart(2, '0');
	const minutes = String(dateTime.getMinutes()).padStart(2, '0');
	const seconds = String(dateTime.getSeconds()).padStart(2, '0');
	return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

function ajaxResponse(method, url, params) {
	return new Promise(function(resolve, reject) {
		$.ajax({
			url: url,
			method: method,
			data: JSON.stringify(params),
			contentType: "application/json",
			success: function(response) {
				resolve(response);
			},
			error: function(error) {
				reject(error);
			},
		});
	});
}
const countSeat = () => {
	$('.cont_top').find('em').first().text($("[data-seatNo].on").length);
	$('.cont_top').find('em').last().text(50 - $("[data-seatNo].on").length);
}
$('.wrap_cont').on('click', 'li[data-seatNo].on', function(e) {
	const clickedUserId = $(e.currentTarget).find('.uid').text();
	const params = {
		userId: clickedUserId,
	}
	console.log(params);
	ajaxResponse("POST", "/user/getUser", params)
		.then(function(response) {
			const userInfo = response.result;
			console.log(userInfo);
			$('#userSeatNo').text(userInfo.seatNo);
			$('#userId').text(userInfo.userId);
			$('#loginTime').text(formatDatenTime(userInfo.loginTime));
			$('#remainingTime').text(formatTime(userInfo.remainingTime));
			$('#regDate').text(formatDatenTime(userInfo.regDate));
		});
	infoModal.css('display', 'block');
});//좌석 클릭시 사용자정보 띄우기

const closeInfoModal = () => {
	$.each($(".close"), function(index, close) {
		$(close).on('click', () => infoModal.css('display', 'none'));
	});
}


$(document).ready(function() {
	//var loggedInUserList = [];
	ajaxResponse("GET", "/admin/loggedInUserList")
		.then(function(response) {
			loggedInUserList = response.result;
			if (loggedInUserList != null) {
				$.each(loggedInUserList, function(index, user) {
					var remainingTime = user.remainingTime;
					var seat = $(`li[data-seatNo=${user.seatNo}]`);
					if (remainingTime > 0) {
						var now = new Date().getTime();
						var loginTime = new Date(user.loginTime).getTime();
						var durationTime = now - loginTime;
						remainingTime = remainingTime - Math.floor(durationTime / 1000);
						if (!seat.hasClass('on')) {
							seat.addClass("on");
							seat.find("p").first().text(user.userId);
							updateCountdown(seat.find("p").last(), remainingTime, user.seatNo);
						}
					}
				});
			}
			addOption();
			countSeat();
			closeInfoModal();
		});//로그인 유저 가져와서 좌석 띄우기, 모달창


	ajaxResponse("GET", "/chat/list")
		.then(function(response) {
			console.log(response.result)
			$.each(response.result, function(index, chat) {
				if (chat.receiver === 'admin') {
					$("#chatList").append(
						`<li class="you">
						<div class="entete">
							<p>${getNow()}</p>
							<h2>${chat.seatNo}번 좌석(${chat.sender})</h2>
							</div>
							<div class="triangle"></div>
							<div class="message">${chat.message}</div>
					</li>`
					);
				} else {
					$("#chatList").append(
						`<li class="me">
									<div class="entete">
										<p>${getNow()}</p>
										<h2>좌석 ${chat.receiver}님에게 보냄</h2>
									</div>
									<div class="triangle"></div>
									<div class="message">${chat.message}</div>
								</li>`
					);
				}
			});
		});//채팅 데이터 불러오기		
	ajaxResponse("GET", "/admin/getOrderList")
		.then(function(response) {
			$.each(response.result, function(key, order) {
				var priceList = [];
				var sum = 0;
				var seatNo = order[0].seatNo;
				//$(`li.on .uid:contains('${order[0].userId}')`).parent().find('em').text();
				console.log(seatNo)
				$("#orderList").prepend(
					`<button class="accordion" data-orderId='${key}'>${seatNo}번 좌석 주문</button>
		 				<div class="panel"></div>`);
				$.each(order, function(index, detailOrder) {
					$("#orderList").children().next().first()
						.append(
							`<p>상품 이름 : ${detailOrder.itemName}</p>
									<p>상품 가격 : ${detailOrder.sellingPrice}</p>
							     	<p>수량 : ${detailOrder.quantity}</p>`
						);
					priceList.push(detailOrder.sellingPrice * detailOrder.quantity);
				});
				$.each(priceList, function(index, price) {
					sum = sum + price
				})
				$("#orderList").children().next().first()
					.append(`
						<p>주문 일시 : ${getNow()}</p>
						<p>총 금액 : ${sum}</p>
						<button class="served">주문 확인</button>
						`);
			});
		});
	//주문데이터 불러오기
});

$('#orderList').on('click', '.served', function(e) {
	console.log($(e.currentTarget).parent().prev().data('orderid'));
	//$(e.currentTarget).parent().prev().remove();
	//$(e.currentTarget).parent().remove();
	//DB에 Orders 테이블 served를 Y로 바꾸는 로직 들어가야함
});