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

const closeInfoModal = () => {
	$.each($(".close"), function(index, close) {
		$(close).on('click', e => infoModal.css('display', 'none'));
	});
}


$(document).ready(function() {
	var loggedInUserList = [];
	ajaxResponse("GET", "/loggedInUserList")
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
			$('.wrap_cont').on('click', 'li[data-seatNo].on', function(e) {
				infoModal.css('display', 'block');
				const clickedUserId = $(e.currentTarget).find('.uid').text();
				const userInfo = loggedInUserList.find(user => user.userId == clickedUserId);
				console.log(userInfo);
				$('#userSeatNo').text(userInfo.seatNo);
				$('#userId').text(userInfo.userId);
				$('#loginTime').text(formatDatenTime(userInfo.loginTime));
				$('#remainingTime').text(formatTime(userInfo.remainingTime));
				$('#regDate').text(formatDatenTime(userInfo.regDate));
			});
			closeInfoModal();
		});//로그인 유저 가져와서 좌석 띄우기, 모달창


	ajaxResponse("GET", "/getChatList")
		.then(function(response) {
			console.log(response.result)
			$.each(response.result, function(index, chat) {
				if (chat.receiver === 'admin') {
					$("#chatList").append(
						`<li class="you">
						<div class="entete">
							<p>${getNow()}</p>
							<h2>${chat.sender}번 좌석(${chat.userId})</h2>
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

		});
	//채팅 데이터 불러오기		

	//주문데이터 불러오기
});

