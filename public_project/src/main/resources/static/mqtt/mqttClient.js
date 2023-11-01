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
    	  mqttClient.subscribe(mqtt_topic+"#", err => {
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
            	type:'CHAT',
            	sender : "client",
            	receiver :"admin",
            	message:message
            	}));
            $("#chatInputBox").val("");
    };
    //메세지 수신한 데이터를 삽입
    const recvMessage = recv =>  {
  	  console.log(recv);
    //  $("#message_list").prepend('<li class="list-group-item" >[' + recv.sender + '] - ' + recv.message + '</li>'); 
    }
    //설정 및 메서드 끝
    
    mqttClient.on('connect', () => {
    	console.log('Connected')
        //구독 메시지 등록 
        //메시지 수신 이벤트 핸들러 등록
        subscribe();
    });
    
 // 구독 메시지 수신 
    mqttClient.on('message', function (topic, message) {
        // message is Buffer
        //console.log("mqtt message receive :", message.toString())
        	const data = JSON.parse(message.toString())
        	if(data.receiver === "2"){//좌석에따라 수동적으로 바뀌는거 필요함
        		recvMessage(data);
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