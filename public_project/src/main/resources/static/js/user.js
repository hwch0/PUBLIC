// 로그아웃
$('#logoutBtn').on('click', function(){
	location.href = "/logout";
});

// 채팅 모달
$("#chattingBtn").on('click', function(){
	$(".cont-bot-wrap").css('display','block');
});

function navBtn(element) {
	const thisNavLi = $(element).parent();
	
	if (thisNavLi.hasClass('on')) {
		$(".cont-modal-wrap").css('display', 'none');
		$(".cont-bot-wrap").css('display', 'none');
		$(".wrap_cart").removeClass('on');
		thisNavLi.removeClass('on');
	} else {
		$(".cont-modal-wrap").css('display', 'block');
		$(".cont-bot-wrap").css('display', 'block');
		$(".wrap_cart").addClass('on');
		thisNavLi.addClass('on');
		getMenuList();
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
   ajaxResponse('POST', '/getUserById', data)
      .then(function(response) {         
         var userInfo = response.result;
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

window.onload = function () {
	const userInfoData = $('#userInfo').val();
	
	// 쿠키에서 모든 쿠키를 가져옵니다.
	var allCookies = document.cookie;

	// 각 쿠키를 분리합니다.
	var cookiesArray = allCookies.split(';');

	// userId 쿠키를 찾습니다.
	var userIdCookie = cookiesArray.find(function(cookie) {
	    return cookie.trim().startsWith('userId=');
	});

	// userId 쿠키에서 값만 추출합니다.
	var userIdValue = userIdCookie ? userIdCookie.split('=')[1] : null;

	// userId 값을 출력합니다.
	console.log('userId 값:', userIdValue);

	
    updateRemainingTime(userIdValue);
    
    var userIdElement = document.getElementById("userId");
    //var loggedInUserId = localStorage.getItem("userId"); 
    
    var loggedInUserId = userIdValue; 
    userIdElement.textContent = loggedInUserId;
    
}


//주문창 
function navBtn(element) {
	const thisNavLi = $(element).parent();
	
	if (thisNavLi.hasClass('on')) {
		$(".cont-modal-wrap").css('display', 'none');
		$(".cont-bot-wrap").css('display', 'none');
		$(".wrap_cart").removeClass('on');
		thisNavLi.removeClass('on');
	} else {
		$(".cont-modal-wrap").css('display', 'block');
		$(".cont-bot-wrap").css('display', 'block');
		$(".wrap_cart").addClass('on');
		thisNavLi.addClass('on');
		getMenuList();
	}
}

// 장바구니 담기
function addCart(element) {
	const thisNavLi = $(element).parent();
	const itemId = $(element).data('menu-id');
	const itemName = $(thisNavLi).find(".food-name").text();
	const sellingPrice = $(thisNavLi).find(".food-price").text();
	
    
    
	 var cartItem = '<li>' +
	     '<p class="itemId">' + itemId + '</p>' +
	     '<p class="food-name">' + itemName + '</p>' +
	     '<p class="food-price">' + sellingPrice + '</p>' +
	     '<div class="food-option">' +
	         '<span class="btn_option minus" onClick="updateOptionNum(this)">-</span>' +
	         '<p><em class="optionNum" data-option-num="1">1</em></p>' +
	         '<span class="btn_option plus" onClick="updateOptionNum(this)">+</span>' +
	     '</div>' +
	     '<a href="javascript:void(0);" class="remove-from-cart" onClick="removeCart(this)">Remove</a>' +
	     '</li>';
	
	 $('.addCart ul').append(cartItem);
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

//주문하기
function order() {
   const userId = $("#userId").text();
   const cartItems = [];

    $('.addCart ul li').each(function () {
        const itemId = $(this).find('.itemId').text(); 
        const quantity = $(this).find('.food-option .optionNum').data('option-num');
        const itemPrice = $(this).find('.food-price').text();
        const itemTotalPrice = itemPrice * quantity;

        cartItems.push({ itemId: itemId, quantity: quantity, price: itemTotalPrice });
    });
    
    console.log(cartItems);
    
	const param = { userId: userId, items: cartItems };
	fetch('/user/order', {
	   method: 'POST',
	   headers: {
	      'Content-Type': 'application/json; charset=UTF-8',
	   },
	   body: JSON.stringify(param),
	})
	.then((rs) => rs.json())
	.then((json) => {
	   if (json.rs == 'true') {
	      alert('주문이 정상적으로 이루어졌습니다.');
	      $('.addCart ul').empty();
	   } else {
	      alert('주문이 정상적으로 이루어지지 않았습니다. ');
	   }
	})
	.catch((error) => {
	   console.error('주문 에러:', error);
	});
}


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
function displayMenuList(menuList) {

    var foodList = document.querySelector(".food-list");
    
	$('.food-list').empty();

    if (menuList != null) {
    	 menuList.forEach(function(menu) {
            var row = '<li>' +
            	'<a href="javascript:void(0);" class="add-to-cart" onClick="addCart(this);" data-menu-id="' + menu.ITEMID +'">' +
                '<div class="img-wrap">' +
                '<img alt="상품이미지" src="/image/download/' + menu.IMGID + '"/>' +
                '</div>' +
                '<div class="food-info-wrap">' +
                '<p class="food-name">' + menu.ITEMNAME + '</p>' +
                '<p class="food-price">' + menu.SELLINGPRICE + '</p>' +
                '</div>' +
                '</li>';
            $('.food-list').append(row);
        });
    } else {
        console.error("메뉴가 없습니다.", menuList);
    }
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