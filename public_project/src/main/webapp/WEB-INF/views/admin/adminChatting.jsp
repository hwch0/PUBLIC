<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
		<textarea placeholder="Type your message"></textarea>
		<a href="#">Send</a>
	</footer>
</main>