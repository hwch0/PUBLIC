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


$(document).ready(function() {
	var loggedInUserList = [];
	ajaxResponse("POST", "/loggedInUserList", null)
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
  		countSeat()		
		});
});

