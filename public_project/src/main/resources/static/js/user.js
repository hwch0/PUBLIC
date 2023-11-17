// 로그아웃
$('#logoutBtn').on('click', function(){
   mqttClient.publish(mqtt_topic, JSON.stringify(
       {type: "LOGOUT",
        receiver: "admin"}
   ));
   location.href = "/logout";
});

// 버튼 js
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
   
    updateRemainingTime(userIdValue);
    
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
      userId: loggedInUserId,
   }; //JWT 토큰 구현 이후 userID가져와야함
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
            '<div class="food-option">' +
                '<span class="btn_option minus" onClick="updateOptionNum(this)">-</span>' +
                '<p><em class="optionNum" data-option-num="1">1</em></p>' +
                '<span class="btn_option plus" onClick="updateOptionNum(this)">+</span>' +
            '</div>' +
            '<a href="javascript:void(0);" class="remove-from-cart" onClick="removeCart(this)">취소</a>' +
            '</li>';

        $('.addCart ul').append(cartItem);
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
    
function removeCartAll() {
    $('.addCart ul li').remove();
}    
                 
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
                '<p class="food-price" style="margin-top:15px; text-align: center; line-height:22px; font-size: 18px;">' + menu.SELLINGPRICE + '원</p>' +
                '</div>' +
                '</li>';
            $('.food-list').append(row);
        });
    } else {
        console.error("메뉴가 없습니다.", menuList);
    }
     showCategory(1);
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
