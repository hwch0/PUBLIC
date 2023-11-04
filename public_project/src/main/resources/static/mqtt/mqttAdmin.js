function formatTime(seconds) {
    var hours = Math.floor(seconds / 3600);
    var minutes = Math.floor((seconds % 3600) / 60);
    var remainingSeconds = seconds % 60;
	//+ remainingSeconds + " 초"
    return hours + " 시간 " + minutes + " 분 ";
}
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



	const mqtt_host = "www.chocomungco.store";
	const mqtt_port = 9001; //websocket port : mosquitt.conf 파일에 설정됨  
	const mqtt_topic = "/public/";

	const options = {
		hostname : 'www.chocomungco.store',
		port : 9001,
		username : 'chocomungco',
		password : 'choco11',
		clean : true,
	}//mqtt 연결 설정
	//console.log('Connecting mqtt client ');
	//console.log('mqtt_topic -> ', mqtt_topic);

	const mqttClient = mqtt.connect(options);//mqtt 연결
	//console.log('mqttClient -> ', mqttClient);
	const disconnect = () => {
        //console.log('mqtt 연결 끊음');
        mqttClient.end();//mqtt연결 해제
   }  
	mqttClient.on('error', (err) => {
        //console.log('Connection error: ', err)
        mqttClient.end()
    });
      
    mqttClient.on('reconnect', () => {
        //console.log('Reconnecting...')
    });//mqtt 디버깅
    
  //구독을 등록
    const subscribe = () => {
    	  mqttClient.subscribe(mqtt_topic+"#", err => {
    		  //console.log("Subscribe to a topic=>" +mqtt_topic);
    		  if (!err) {
    			  //console.log("error", err);
          } else {
          }
        })
    }
  //구독을 해제한다
    const unsubscribe = () => {
    	  mqttClient.unsubscribe(mqtt_topic);
    }
  //서버에 메시지를 전송한다
    const sendMessage = () => {
    	if(!isNaN($('#seatSelector option:selected').val())){
			const seatNo = $('#seatSelector option:selected').val();
    		const message = $("#chatInputBox").val();
            mqttClient.publish(mqtt_topic+"chat", JSON.stringify({
            	type:'CHAT',
            	sender : "admin",
            	receiver :$('#seatSelector option:selected').val(),
            	message:message
            	}));
            $("#chatInputBox").val("");
            $("#chatList").append(
					 `<li class="me">
					<div class="entete">
						<h3>10:12AM, Today</h3>
						<h2>좌석 ${seatNo}님에게 보냄</h2>
						<span class="status blue"></span>
					</div>
					<div class="triangle"></div>
					<div class="message">${message}</div>
				</li>`
				 );
			$("#chatList").scrollTop($("#chatList")[0].scrollHeight);
    	}else{alert('좌석을 선택해주세요')};
    };
    //메세지 수신한 데이터를 삽입
    const recvMessage = recv =>  {
  	  //console.log(recv);
    $("#chatList").append(
		`<li class="you">
						<div class="entete">
							<span class="status green"></span>
							<h2>${recv.sender}</h2>
							<h3>10:12AM, Today</h3>
						</div>
						<div class="triangle"></div>
						<div class="message">${recv.message}</div>
					</li>`
		);
	$("#chatList").scrollTop($("#chatList")[0].scrollHeight);//채팅이오면 스크롤 내려오게
    }
    const recvOrder = recv =>  {
		//console.log(recv);
		$('#orderList').append(
			`<button class="accordion">${recv.sender}번 좌석 주문내역 : ${recv.orderList}</button>
				<div class="panel">
					<p>${recv.orderList}</p>
					<button>주문 확인</button>
				</div>`
		)
	}//주문리스트 받기
	
	const recvLogin = recv => {
		//const data = { userId: recv.userId };
		const data = {};
		ajaxResponse('POST', '/loggedInUserList', data)
			.then(function(response) {
				console.log(response.result);
				$.each(response.result, function(index, user){
					console.dir(user.seatNo);
					var seat = $(`li[data-seatNo=${user.seatNo}]`);
					seat.addClass('on');
					seat.find('p').first().text(user.userId);
					seat.find('p').last().text(formatTime(user.remainingTime));
				});
				/*var userInfo = $.parseJSON(response);
				var seat = $(`li[data-seatNo=${recv.seatNo}]`);
				seat.addClass('on');
				seat.find('p').first().text(userInfo.userId);
				seat.find('p').last().text(formatTime(userInfo.remainingTime));*/
			})
			.catch(function(error) {
				console.error("로그인 정보 가져오는중 에러 발생: " + error);
			});
	}//사용자 로그인시 관리자 좌석 동적으로 변경
	
	
    //설정 및 메서드 끝
    
    mqttClient.on('connect', () => {
    	//console.log('Connected')
        //구독 메시지 등록 
        //메시지 수신 이벤트 핸들러 등록
        subscribe();
    });
    
 // 구독 메시지 수신 
    mqttClient.on('message', function (topic, message) {
        // message is Buffer
        ////console.log("mqtt message receive :", message.toString())
        	const data = JSON.parse(message.toString())
        	console.log(data);
        	//if(data.receiver)
        	if(data.receiver === "admin" && data.type ==="CHAT"){
        		recvMessage(data);
        	}else if(data.receiver === "admin" && data.type ==="LOGIN"){
			recvLogin(data);
			}
        	else{
			recvOrder(data);
		}
    })
      
    $("#chatInputBox").on("keydown", e => {
    	  if (e.keyCode == 13) {
    		  e.preventDefault();
    		  sendMessage();
        }
    });
    $("#send_chat_button").on("click", e => {
        sendMessage();
    });
    