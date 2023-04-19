<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<style>
@import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=IBM+Plex+Sans+KR:wght@300&display=swap');
* {
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-decoration: none;
	color: black;
}
p {
	font-size: 13px;
	text-align: left;
	margin-left: 20px;
	marin-top: 30px;
	line-height: 0.9;
}
#logo {
	width: 250px;
	margin-left: 20px;
}
</style>
<meta charset="UTF-8">
<title>푸터</title>
</head>
<body>
<table>
	<tr>
		<td><a href="#"><img src="${contextPath}/resources/image/logo.png" id="logo" /></a></td>
		<td><p>항공 및 숙박 예약 서비스 주식회사</p>
			<p>대표이사 : 양 하 희</p>
			<p>주소 : 대전광역시 서구 대덕로 182 오라클빌딩 1005호</p>
			<p>사업자 등록번호 : 123-456-78910</p>
			<p>Tel : 042-789-4561</p>
			<p>COPYRIGHT(C) 1석2조 HELLO WORLD ALL RIGHTS RESERVED.</p>
		</td>
	</tr>
	<tr>
		
	</tr>
</table> 
</body>
