<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/chat.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="/mqtt/mqtt.min.js"></script>
</head>
<body>
	<div class="wrap_chat">
		<div class="wrap_chat_main">
			<ul id="chatList">	</ul>
			<footer>
				<textarea placeholder="Type your message" id="chatInputBox"></textarea>
				<a href="javascript:void(0);" id="send_chat_button">Send</a>
			</footer>
		</div>
	</div>
	
	<button id="orderBtn">주문 버튼</button>
</body>
<script type="text/javascript" src="/mqtt/mqttClient.js"></script>
</html>