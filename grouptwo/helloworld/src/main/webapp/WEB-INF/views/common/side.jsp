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
#checkImg {
	width: 13px;
	margin: 0px 5px;
}
.sideList {
	padding: 5px;
	line-height: 2.5;
}
#sideH {
	font-family: 'Black Han Sans', sans-serif;
	margin: 20px;
	text-align: center;
	color: #0099FF;
	font-size: 20px;
}
.sideList {
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-decoration: none;
	color: black;
}
</style>
<meta charset="UTF-8">
<title>사이드 메뉴</title>
</head>
<body>
	<%-- <h1 id="sideH">M E N U</h1>
	<h2 style="text-align: left; margin-left: 20px;"">
		항공<br>
		숙박<br>
		상품추천<br>
		커뮤니티<br>
		공지사항<br>
		마이페이지<br>
	</h2> --%>
</body>
</html>