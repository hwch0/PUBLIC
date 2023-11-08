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
  return new Promise(function (resolve, reject) {
    $.ajax({
      url: url,
      method: method,
      data: JSON.stringify(params),
      contentType: "application/json",
      success: function (response) {
        resolve(response);
      },
      error: function (error) {
        reject(error);
      },
    });
  });
}
const countSeat = () => {
	$('.cont_top').find('em').first().text($("[data-seatNo].on").length);
	$('.cont_top').find('em').last().text(50 - $("[data-seatNo].on").length);
}

const showInfoModal = (loggedInUserList) => {
    $("li[data-seatNo].on").each(function(index, seat) {
        $(seat).on('click', function(e) {
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
    });
}


const closeInfoModal = () => {
	$.each($(".close"), function(index, close) {
		$(close).on('click' , e=>infoModal.css('display', 'none'));
	});
}


$(document).ready(function() {
	var loggedInUserList = [];
	ajaxResponse("GET", "/loggedInUserList")
		.then(function(response) {
			loggedInUserList = response.result;
			if(loggedInUserList != null){
				$.each(loggedInUserList, function(index, user) {
				var remainingTime = user.remainingTime;
				var seat = $(`li[data-seatNo=${user.seatNo}]`);
				if (remainingTime >= 0) {
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
	  	showInfoModal(loggedInUserList);
	  	closeInfoModal();
	  	/*$("li[data-seatNo].on").on('click', function(e){
			  const userInfo = loggedInUserList.find(user => user.id ===  $(e.currentTarget).find('.uid').text());
			  alert(userInfo)
			  //$(e.currentTarget).find('em').text();
		  });*/
		});
});

