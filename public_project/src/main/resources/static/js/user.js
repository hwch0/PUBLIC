// 로그아웃
$('#logoutBtn').on('click', function(){
   mqttClient.publish(mqtt_topic, JSON.stringify(
       {type: "LOGOUT",
        receiver: "admin"}
   ));
   location.href = "/logout";
});

// 채팅 모달
$("#chattingBtn").on('click', function(){
   $(".cont-bot-wrap").css('display','block');
   $(".chat-wrap").css('display','block');
   $("#chatList").scrollTop($("#chatList")[0].scrollHeight);
});

//주문버튼
function navBtn(element) {
    const thisNavLi = $(element).parent();

    $(".cont-modal-wrap, .cont-bot-wrap, .wrap_cart, .chat-wrap").css('display', 'none');
    $(".wrap_cart").removeClass('on');
    $('#orderBtn22, #rechargeBtn, #chattingBtn').removeClass('on');

    if (thisNavLi.hasClass('on')) {
        $(".cont-modal-wrap, .cont-bot-wrap, .wrap_cart, .chat-wrap").css('display', 'none');
        thisNavLi.removeClass('on');
    } else {
        if (thisNavLi.attr('id') === 'orderBtn22') {
            $(".cont-modal-wrap, .cont-bot-wrap, .wrap_cart").css('display', 'block');
            $('#orderBtn22').addClass('on');
            getMenuList(); 
        } else if (thisNavLi.attr('id') === 'rechargeBtn') {
			$(".cont-modal-wrap, .cont-bot-wrap, .wrap_recharge").css('display', 'block');
            $('#rechargeBtn').addClass('on');
            $("#chattingBtn").removeClass('on');
            $("#orderBtn22").removeClass('on');
        } else if (thisNavLi.attr('id') === 'chattingBtn') {
            $(".cont-bot-wrap, .chat-wrap").css('display', 'block');
            $(".wrap_cart").removeClass('on');
            $('#chattingBtn').toggleClass('on');
        }

        thisNavLi.addClass('on');
    }
}


// 시간 js
function ajaxResponse(method, url, params) {
    return new Promise(function(resolve, reject) {
        $.ajax({
            url: url,
            method: method,
            data: JSON.stringify(params),
            contentType: 'application/json',
            success: function(response) {
                resolve(response);
            },
            error: function(error) {
                reject(error);
            }
        });
    });
}


var remainingTimeElement = document.getElementById("remainingTime");

function formatTime(seconds) {
    var hours = Math.floor(seconds / 3600);
    var minutes = Math.floor((seconds % 3600) / 60);
    var remainingSeconds = seconds % 60;

    return hours + " : " + minutes + " : " + remainingSeconds ;
}


function updateCountdown(remainingTime) {
    remainingTimeElement.textContent = formatTime(remainingTime);
    if (remainingTime > 0) {
        remainingTime--;
        setTimeout(function () {
            updateCountdown(remainingTime);
        }, 1000);
    } else if (remainingTime <= 300 && remainingTime > 0) {
        remainingTimeElement.style.color = "red";
   }else {
        location.href = "/user/logout/"+localStorage.getItem("userId");
    }
}

function updateRemainingTime(userIdValue) {
   const data = {userId : userIdValue}; //JWT 토큰 구현 이후 userID가져와야함
   ajaxResponse('POST', '/user/getUser', data)
      .then(function(response) {     
         var userInfo = response.result;
		  console.log("userId " + userInfo.userId);    
		  console.log("seatNo " + userInfo.seatNo);    
         localStorage.setItem("userId", userInfo.userId);//테스트용 userId저장
         localStorage.setItem("seatNo", userInfo.seatNo);//테스트용 userId저장
         var remainingTime = userInfo.remainingTime;
         if (remainingTime >= 0) {
              var now = new Date().getTime();
              var loginTime = new Date(userInfo.loginTime).getTime();
              var durationTime = now - loginTime;
              remainingTime = remainingTime - Math.floor(durationTime / 1000);
              updateCountdown(remainingTime);
          } else {
             alert("잔여시간이 없습니다.")
                 location.href = "/user";
          } 
      })
      .catch(function(error) {
         console.error("로그인 정보 가져오는중 에러 발생: " + error);
      });
}

window.onload = function() {
   //const userInfoData = $('#userInfo').val();

   /*// 쿠키에서 모든 쿠키를 가져옵니다.
   var allCookies = document.cookie;

   // 각 쿠키를 분리합니다.
   var cookiesArray = allCookies.split(';');

   // userId 쿠키를 찾습니다.
   var userIdCookie = cookiesArray.find(function(cookie) {
      return cookie.trim().startsWith('userId=');
   });

   // userId 쿠키에서 값만 추출합니다.
   var userIdValue = userIdCookie ? userIdCookie.split('=')[1] : null;*/
   var userIdValue = $('#userId').text();

   // userId 값을 출력합니다.
   console.log('userId 값:', userIdValue);
   updateRemainingTime(userIdValue);

	var userIdElement = document.getElementById("userId");
	//var loggedInUserId = localStorage.getItem("userId"); 

	var loggedInUserId = userIdValue;
	userIdElement.textContent = loggedInUserId;
	
    //updateRemainingTime(userIdValue);
    
    var userIdElement = document.getElementById("userId");
    //var loggedInUserId = localStorage.getItem("userId"); 
    
    var loggedInUserId = userIdValue; 
    userIdElement.textContent = loggedInUserId;
    
    
    mqttClient.publish(mqtt_topic, JSON.stringify(
		 {type: "LOGIN",
		  receiver: "admin"}
	));
	
	//채팅 가져오기

	const data = {
		receiver: userIdValue,
	}; //JWT 토큰 구현 이후 userID가져와야함
	console.log(data);
	ajaxResponse('POST', '/chat/getListById', data)
		.then(function(response) {
		var chatList = response.result;
		if (chatList != null) {
			console.log(chatList);
			$.each(response.result, function(index, chat) {
				if (chat.sender === 'admin') {
					$("#chatList").append(
						`<li class="you">
					<div class="entete">
						<p>${chat.time}</p>
						<h2>${chat.sender}</h2>
						</div>
						<div class="triangle"></div>
						<div class="message">${chat.message}</div>
				</li>`
					);
				} else {
					$("#chatList").append(
						`<li class="me">
								<div class="entete">
									<p>${chat.time}</p>
									<h2>${chat.sender}</h2>
								</div>
								<div class="triangle"></div>
								<div class="message">${chat.message}</div>
							</li>`
					);
				}
			});
		}
	});
}      

var totalPrice = 0;

// 장바구니 담기
function addCart(element) {
    const thisNavLi = $(element).parent();
    const itemId = $(element).data('menu-id');
    const itemName = $(thisNavLi).find(".food-name").text();
    const sellingPrice = $(thisNavLi).find(".food-price").text();

    // 이미 장바구니에 존재하는지 확인
    const existingCartItem = $('.addCart ul li').filter(function() {
        return $(this).find('.itemId').text() === itemId;
    });

    if (existingCartItem.length > 0) {
        // 이미 존재하면 수량만 증가
        const optionNumElement = existingCartItem.find('.optionNum');
        const optionNum = parseInt(optionNumElement.data('option-num'));
        optionNumElement.data('option-num', optionNum + 1);
        optionNumElement.text(optionNum + 1);
    } else {
        // 존재하지 않으면 새로운 아이템 추가
        var cartItem = '<li>' +
            '<p class="itemId">' + itemId + '</p>' +
            '<p class="food-name">' + itemName + '</p>' +
            '<p class="food-price" style="display:none;">' + sellingPrice + '</p>' +
            '<div class="food-option">' +
                '<span class="btn_option minus" onClick="updateOptionNum(this)">-</span>' +
                '<p><em class="optionNum" data-option-num="1">1</em></p>' +
                '<span class="btn_option plus" onClick="updateOptionNum(this)">+</span>' +
            '</div>' +
            '<a href="javascript:void(0);" class="remove-from-cart" onClick="removeCart(this)">취소</a>' +
            '</li>';

        $('.addCart ul').append(cartItem);
    }
    updateTotalPrice();
    updateOrderButtonState();
}

function updateTotalPrice() {
    totalPrice = 0;

    $('.addCart ul li').each(function () {
        const itemPrice = $(this).find('.food-price').text();
        const quantity = $(this).find('.food-option .optionNum').data('option-num');
        totalPrice += itemPrice * quantity;
    });

    // 업데이트된 총 금액을 표시
    $("#total-price").text(totalPrice);
    updateOrderButtonState();
}

// 주문하기 버튼 활성화
function updateOrderButtonState() {
    const orderButton = $('#orderBtn22');
    const rechargeButton = $('#rechargeBtn');
    
    if ($('.addCart ul li').length > 0) {
        orderButton.prop('disabled', false);
        rechargeButton.prop('disabled', false);
    } else {
        orderButton.prop('disabled', true);
        rechargeButton.prop('disabled', false);
    }
}

// 메뉴옵션 수정
function updateOptionNum(element) {
    const optionNumElement = $(element).closest('.food-option').find('.optionNum');
    let optionNum = parseInt(optionNumElement.data('option-num'));

    if ($(element).hasClass('minus')) {
        if (optionNum > 1) {
            optionNum--;
        }
    } else if ($(element).hasClass('plus')) {
        optionNum++;
    }

    optionNumElement.data('option-num', optionNum);
    optionNumElement.text(optionNum);
}

//해당 메뉴 삭제
function removeCart(element) {
    $(element).closest('li').remove();
}    
    
// 장바구니 비우기
function removeCartAll() {
    $('.addCart ul li').remove();
    totalPrice = 0;
    updateTotalPrice();
}    

// 키테고리별 메뉴 출력       
function showCategory(no) {
  $(".menu-category li").removeClass('on');
  $("#menu0" + no).addClass('on');

  if (no == 1) {
    $(".food-list li").not('#MC001').hide();
     $(".food-list li[id='MC001']").show();
  } else if(no == 2){ 
   $(".food-list li").not('#MC002').hide();
    $(".food-list li[id='MC002']").show();
  } else if(no == 3){ 
   $(".food-list li").not('#MC003').hide();
    $(".food-list li[id='MC003']").show();
  } else {
    $(".food-list li").not('#MC004').hide();
    $(".food-list li[id='MC004']").show();
  }
}

function orderBtn(){
	$('.order-btn-list .recharge-order').hide();
	if ($('.addCart ul li').length > 0) {
        updateTotalPrice(); 
        $(".modal-payment").show();
        $(".modal-paymentList").show();
    } else {
        alert("장바구니가 비어있습니다.");
    }
}

function rechargeBtn(){
	$('.order-btn-list .menu-order').hide();
	$('.modal-food').hide();
    $(".modal-payment").show();
    $(".modal-paymentList").show();
    updateTotalPrice();
    updateOrderButtonState();
}

var paymentMethodCode;

function payment(no){
	paymentMethodCode = "PM00" + no;
	$(".modal-paymentList").hide();
	$(".modal-order").show();
}

// 결제하기
function order() {
   const userId = $("#userId").text();
   const cartItems = [];
   const paymentMethodCodeValue = paymentMethodCode;

    $('.addCart ul li').each(function () {
        const itemId = $(this).find('.itemId').text(); 
        const quantity = $(this).find('.food-option .optionNum').data('option-num');
        const itemPrice = $(this).find('.food-price').text();
        const itemTotalPrice = itemPrice * quantity;

        cartItems.push({ itemId: itemId, quantity: quantity, price: itemTotalPrice });
    	
    });
    
  
    const param = { userId: userId, items: cartItems , paymentMethodCode : paymentMethodCodeValue};
  	
    console.log(param);
  
    $.ajax({
        url: '/user/order',
        type: 'POST',
        contentType: 'application/json; charset=UTF-8',
        data: JSON.stringify(param),
        success: function(response) {
            if (response.rs == 'true') {
                alert('주문이 정상적으로 이루어졌습니다.');
                $('.addCart ul').empty();
                $(".modal-payment").hide();
				$(".modal-order").hide();
				$(".modal-paymentList").hide();
				$(".modal-order #total-price").empty();
                mqttClient.publish(mqtt_topic + "order", JSON.stringify({
                    type: "ORDER",
                    receiver: "admin"
                }));
            } else {
                alert('주문이 정상적으로 이루어지지 않았습니다. ');
            }
        },
        error: function(error) {
            console.error('주문 에러:', error);
        }
    });
	 updateTotalPrice();
	 $('.order-btn-list .menu-order').show();
	 $('.order-btn-list .recharge-order').show();
}

function cancle(){
	$(".modal-payment").hide();
	$(".modal-order").hide(); 
	$('.order-btn-list .menu-order').show();
	$('.order-btn-list .recharge-order').show();
	$(".modal-order #total-price").empty();
}

// 메뉴리스트 호출
function getMenuList() {
    $.ajax({
        url: "/user/getMenuList",
        type: "GET",
        success: function (menuList) {
            console.log("서버에서 받은 메뉴 리스트:", menuList);
            displayMenuList(menuList.menuList);
        },
        error: function (error) {
            console.error("오류: " + error);
        }
    });
}

// 호출된 메뉴 리스트 출력
function displayMenuList(menuList) {

    var foodList = document.querySelector(".food-list");
    
   $('.food-list').empty();


    if (menuList != null) {
        menuList.forEach(function(menu) {
            var row = '<li id="' + menu.MENUCATEGORYCODE + '">'+
               '<a href="javascript:void(0);" class="add-to-cart" onClick="addCart(this);" data-menu-id="' + menu.ITEMID +'">' +
                '</a>' +
                '<div class="img-wrap">' +
                '<img alt="상품이미지" src="/image/download/' + menu.IMGID + '"/>' +
                '</div>' +
                '<div class="food-info-wrap">' +
                '<p class="food-name" style="margin-top: 15px; text-align:center; font-size: 22px; font-weight: bold; line-height: 30px;">' + menu.ITEMNAME + '</p>' +
                '<p class="food-price-wrap" style="margin-top:15px; text-align: center; line-height:22px; font-size: 18px;">' + '<span class="food-price">' + menu.SELLINGPRICE + '</span>' + '원 </p>' +
                '</div>' +
                '</li>';
            $('.food-list').append(row);
        });
    } else {
        console.error("메뉴가 없습니다.", menuList);
    }
     showCategory(1);
}

/*// 시간 충전
function recharge() {
    const userId = $('#userId').text(); 
    const chargeTime = parseInt($('#chargeTime').text());
    
    const paymentMethodCodeValue = paymentMethodCode;

    const param = {
        userId: userId,
        remainingTime: chargeTime * 3600,
        paymentMethodCode: paymentMethodCodeValue
    };

    $.ajax({
        url: '/user/recharge', 
        type: 'POST',
        contentType: 'application/json; charset=UTF-8',
        data: JSON.stringify(param),
        success: function(response) {
            if (response.rs == 'true') {
                alert('충전이 정상적으로 이루어졌습니다.');
            } else {
                alert('충전이 정상적으로 이루어지지 않았습니다.');
            }
        },
        error: function(error) {
            console.error('충전 에러:', error);
        }
    });
}*/

// 시간 충전
function recharge() {
   const userId = $("#userId").text();
   const chargeItems = [];
   const chargeTime = parseInt($('#chargeTime').text());
   const paymentMethodCodeValue = paymentMethodCode;

    const quantity = chargeTime;
    const itemTotalPrice = chargeTime * 1000;

    chargeItems.push({ itemId: 'ITEM000001', quantity: quantity, price: itemTotalPrice });

	console.log(chargeItems);
    const param = { userId: userId, remainingTime: chargeTime * 3600, items: chargeItems , paymentMethodCode : paymentMethodCodeValue};
  	
    
    console.log(param);
  
    $.ajax({
        url: '/user/recharge',
        type: 'POST',
        contentType: 'application/json; charset=UTF-8',
        data: JSON.stringify(param),
        success: function(response) {
            if (response.rs == 'true') {
                alert('주문이 정상적으로 이루어졌습니다.');
                updateRemainingTime(userId);
                $(".modal-payment").hide();
				$(".modal-order").hide();
				$(".modal-paymentList").hide();
				$(".modal-order #total-price").empty();
                mqttClient.publish(mqtt_topic + "charge", JSON.stringify({
                    type: "CHARGE",
                    receiver: "admin"
                }));
            } else {
                alert('주문이 정상적으로 이루어지지 않았습니다. ');
            }
        },
        error: function(error) {
            console.error('주문 에러:', error);
        }
    });
	 updateTotalPrice();
	 $('.order-btn-list .menu-order').show();
	 $('.order-btn-list .recharge-order').show();
}

// 충전시간 조절
let chargeTime = 1;

$('.minus').on('click', function(e) {
    if (chargeTime > 1) {
        chargeTime--; 
        updateChargeTime();
    }
});

$('.plus').on('click', function(e) {
    chargeTime++; 
    updateChargeTime();
});


function updateChargeTime() {
    $('.charge_time em').text(chargeTime);
}




/*function fetchMenuList() {
    $.ajax({
        url: "/user/getMenuList",
        type: "GET",
        success: function (menuList) {
            displayMenuList(menuList);
        },
        error: function (error) {
            console.error("Error fetching menu list: " + error);
        }
    });
}

function displayMenuList(menuList) {
    var menuContainer = $(".cont-food .food ul");

    menuContainer.empty();

    for (var i = 0; i < menuList.length; i++) {
        var menu = menuList[i];

        var menuItem = '<li>' +
            '<a href="javascript:void(0);">장바구니에 담기</a>' +
            '<div class="img-wrap">' +
            `<img alt="상품이미지" src="/image/download/${menu.imgId}">` +
            '</div>' +
            '<div class="food-info-wrap">' +
            '<p class="food-name">' + menu.itemName + '</p>' +
            '<p class="food-price">' + menu.sellingPrice + '</p>' +
            '</div>' +
            '</li>';

        menuContainer.append(menuItem);
    }
}

$(document).ready(function () {
    fetchMenuList();
});*/