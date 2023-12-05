<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뉴스</title>
</head>
<body>
	<c:set var="subject" value="${param.interId eq 'politics' ? '정치': param.interId eq 'economy' ? '경제' : '연예'}"/>
	<h2 style="text-align:center; margin-bottom:0; ">최근 ${subject } 기사</h2>
	<p style="text-align:right; margin-top:0;">${time} 기준</p>
	<hr/>
	<c:forEach var="list" items="${list}">
		<div style="margin-top:15px"><a href="${list.link}">${list.title}</a></div>
		<div style="margin-bottom:15px">${list.content}</div>
		<hr/>
	</c:forEach>

</body>
</html>