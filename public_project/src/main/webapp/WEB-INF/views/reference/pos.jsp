<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>erp</title>
</head>
<link rel="stylesheet" href="css/reference02.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="/mqtt/mqtt.min.js"></script>
<body>
	<div class="wrap">
		<!-- ########## 상단 헤더 영역 끝 ########## -->
		<div class="header">
			<!-- ********** 상단 왼쪽 영역 시작 ********** -->
			<div class="hd hd_lft">
				<!-- 로고 영역 -->
				<div class="logo">
					<img src="/images/logo_p.png" alt="로고">
				</div>
				<!-- 화면 전화 버튼 영역 -->
				<div class="dtn_toggle">
					<ul>
						<li class="btn btn_pos on"><a href="/pos">POS</a></li>
						<li class="btn btn_ERP"><a href="#">ERP</a></li>
					</ul>
				</div>
			</div>
			<!-- ********** 상단 왼쪽 영역 끝 ********** -->

			<!-- ********** 상단 오른쪽 영역 시작 ********** -->
			<div class="hd hd_rgt">
				<div class="btn_grp">
					<ul>
						<li class="on"><a href="javascript:void(0);"
							onClick="showAlert()">알림</a></li>
						<li><a href="javascript:void(0);" onClick="showChat()">채팅</a></li>
						<li><a href="javascript:void(0);">좌석</a></li>
						<li><a href="javascript:void(0);">대시보드</a></li>
						<li><a href="javascript:void(0);">설정</a></li>
					</ul>
				</div>
			</div>
			<!-- ********** 상단 오른쪽 영역 끝 ********** -->
		</div>
		<!-- ########## 상단 헤더 영역 끝 ########## -->

		<div class="wrap_cont">
			<div class="cont_top">
				<ul>
					<li>
						<p>이용중인 좌석</p> <em>22</em>
					</li>

					<li>
						<p>잔여 좌석</p> <em>28</em>
					</li>
				</ul>
			</div>

			<div class="seat_grp">
				<div class="seat">
					<ul>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 1</p>
							<p class="time">01:17:34</p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 121</p>
							<p class="time">01:17:34</p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
					</ul>
				</div>

				<div class="seat seat_end">
					<ul>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 99</p>
							<p class="time">01:17:34</p></li>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 369</p>
							<p class="time">01:17:34</p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 24</p>
							<p class="time">01:17:34</p></li>
					</ul>
				</div>

				<div class="seat">
					<ul>

						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 96</p>
							<p class="time">01:17:31</p></li>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 15</p>
							<p class="time">01:17:34</p></li>
					</ul>
				</div>

				<div class="seat seat_end">
					<ul>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 33</p>
							<p class="time">04:31:44</p></li>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 876</p>
							<p class="time">01:17:34</p></li>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 30</p>
							<p class="time">01:17:34</p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 10</p>
							<p class="time">01:17:34</p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
					</ul>
				</div>

				<div class="seat">
					<ul>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 33</p>
							<p class="time">01:17:34</p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 321</p>
							<p class="time">01:17:34</p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
					</ul>
				</div>

				<div class="seat seat_end">
					<ul>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 678</p>
							<p class="time">01:17:34</p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 55</p>
							<p class="time">01:17:34</p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
					</ul>
				</div>

				<div class="seat">
					<ul>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 44</p>
							<p class="time">01:17:34</p></li>
					</ul>
				</div>

				<div class="seat seat_end">
					<ul>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 7</p>
							<p class="time">01:17:34</p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 111</p>
							<p class="time">01:17:34</p></li>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 123</p>
							<p class="time">01:17:34</p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
					</ul>
				</div>

				<div class="seat">
					<ul>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 88</p>
							<p class="time">01:17:34</p></li>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 100</p>
							<p class="time">01:17:34</p></li>
						<li class="on"><a href="javascript:void(0);"></a>
							<p class="uid">user 777</p>
							<p class="time">01:17:34</p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
						<li><a href="javascript:void(0);"></a>
							<p class="uid"></p>
							<p class="time"></p></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="wrap_alert">
			<button class="accordion">11번 좌석 주문내역 : 콜라 1개, 커피 1개</button>
			<div class="panel">
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed
					do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
					enim ad minim veniam, quis nostrud exercitation ullamco laboris
					nisi ut aliquip ex ea commodo consequat.</p>
					<button>주문 확인</button>
			</div>

			<button class="accordion">22번 좌석 주문내역 : 콜라 1개, 커피 2개</button>
			<div class="panel">
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed
					do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
					enim ad minim veniam, quis nostrud exercitation ullamco laboris
					nisi ut aliquip ex ea commodo consequat.</p>
					<button>주문 확인</button>
			</div>

			<button class="accordion">Section 3</button>
			<div class="panel">
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed
					do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
					enim ad minim veniam, quis nostrud exercitation ullamco laboris
					nisi ut aliquip ex ea commodo consequat.</p>
					<button>주문 확인</button>
			</div>
		</div>

		<div class="wrap_chat">
			<main>
				<ul id="chat">
					<li class="you">
						<div class="entete">
							<span class="status green"></span>
							<h2>Vincent</h2>
							<h3>10:12AM, Today</h3>
						</div>
						<div class="triangle"></div>
						<div class="message">Lorem ipsum dolor sit amet,
							consectetuer adipiscing elit. Aenean commodo ligula eget dolor.</div>
					</li>
					<li class="me">
						<div class="entete">
							<h3>10:12AM, Today</h3>
							<h2>Vincent</h2>
							<span class="status blue"></span>
						</div>
						<div class="triangle"></div>
						<div class="message">Lorem ipsum dolor sit amet,
							consectetuer adipiscing elit. Aenean commodo ligula eget dolor.</div>
					</li>
					<li class="me">
						<div class="entete">
							<h3>10:12AM, Today</h3>
							<h2>Vincent</h2>
							<span class="status blue"></span>
						</div>
						<div class="triangle"></div>
						<div class="message">OK</div>
					</li>
					<li class="you">
						<div class="entete">
							<span class="status green"></span>
							<h2>Vincent</h2>
							<h3>10:12AM, Today</h3>
						</div>
						<div class="triangle"></div>
						<div class="message">Lorem ipsum dolor sit amet,
							consectetuer adipiscing elit. Aenean commodo ligula eget dolor.</div>
					</li>
					<li class="me">
						<div class="entete">
							<h3>10:12AM, Today</h3>
							<h2>Vincent</h2>
							<span class="status blue"></span>
						</div>
						<div class="triangle"></div>
						<div class="message">Lorem ipsum dolor sit amet,
							consectetuer adipiscing elit. Aenean commodo ligula eget dolor.</div>
					</li>
					<li class="me">
						<div class="entete">
							<h3>10:12AM, Today</h3>
							<h2>Vincent</h2>
							<span class="status blue"></span>
						</div>
						<div class="triangle"></div>
						<div class="message">OK</div>
					</li>
				</ul>
				<footer>
					<textarea placeholder="Type your message"  id="chatInputBox"></textarea>
					<a href="#" id="send_chat_button">Send</a>
				</footer>
			</main>


		</div>
	</div>
	<!-- 모달 창 영역 -->
	<div id="modal" class="modal">
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
	</div>
</body>
<script src="js/reference.js"></script>
<script>

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
	console.log('Connecting mqtt client ');
	console.log('mqtt_topic -> ', mqtt_topic);

	const mqttClient = mqtt.connect(options);//mqtt 연결
	console.log('mqttClient -> ', mqttClient);
	const disconnect = () => {
        console.log('mqtt 연결 끊음');
        mqttClient.end();//mqtt연결 해제
   }  
	mqttClient.on('error', (err) => {
        console.log('Connection error: ', err)
        mqttClient.end()
    });
      
    mqttClient.on('reconnect', () => {
        console.log('Reconnecting...')
    });//mqtt 디버깅
    
  //구독을 등록
    const subscribe = () => {
    	  mqttClient.subscribe(mqtt_topic, err => {
    		  console.log("Subscribe to a topic=>" +mqtt_topic);
    		  if (!err) {
    			  console.log("error", err);
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
    	const message = $("#chatInputBox").val();
        mqttClient.publish(mqtt_topic, JSON.stringify({
        	type:'TALK',
        	sender : "관리자",
        	receiver :"reciever",
        	message:message
        	}));
        $("#chatInputBox").val("");
    };
    //메세지 수신한 데이터를 삽입
    const recvMessage = recv =>  {
  	  console.log(recv);
    //  $("#message_list").prepend('<li class="list-group-item" >[' + recv.sender + '] - ' + recv.message + '</li>'); 
  }
  //입장메시지를 전송한다
    const enterSendMessage = () => {
    	  console.log("enterSendMessage ")
        
    	  //채팅방에 입장을 서버에 전송한다
    	  //mqttClient.publish(mqtt_topic, JSON.stringify({type:'ENTER', roomId : roomId, sender : '[알림]', message : sender + "님 입장하셨습니다"}));
    }
        
    //퇴장메시지를 전송한다
    const leaveSendMessage = () => {
    	  //채팅방에 입장을 서버에 전송한다
        //mqttClient.publish(mqtt_topic, JSON.stringify({type:'LEAVE', roomId : roomId, sender : '[알림]', message : sender + "님 퇴장하셨습니다"}));
    }
    //설정 및 메서드 끝
    
    mqttClient.on('connect', () => {
    	  console.log('Connected')
        //구독 메시지 등록 
        //메시지 수신 이벤트 핸들러 등록
        subscribe();
        //채팅방에 입장 메시지를 서버에 전송한다(디버깅용)
        //enterSendMessage();
    });
    
 // 구독 메시지 수신 
    mqttClient.on('message', function (topic, message) {
        // message is Buffer
        console.log("mqtt message receive :", message.toString())
        recvMessage(JSON.parse(message.toString()))
    })
      
    $("#chatInputBox").on("keydown", e => {
    	  if (e.keyCode == 13) {
    		  sendMessage();
        }
    });
        
    $("#send_chat_button").on("click", e => {
        sendMessage();
    });
    
</script>
</html>