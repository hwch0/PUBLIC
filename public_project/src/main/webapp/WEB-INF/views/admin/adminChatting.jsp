<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="wrap_chat_main">
	<ul id="chatList">
	</ul>
	<footer>
		<textarea placeholder="Type your message"  id="chatInputBox"></textarea>
		<select id="seatSelector">
		  <option selected>좌석번호</option>
		</select>
		<a href="javascript:void(0);" id="send_chat_button">Send</a>
	</footer>
</div>