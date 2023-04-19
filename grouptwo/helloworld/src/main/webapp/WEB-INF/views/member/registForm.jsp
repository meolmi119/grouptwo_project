<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextPath}/resources/css/member/registForm.css" rel="stylesheet" type="text/css" media="screen">
<title>회원가입</title>
</head>
<body>
<h1 style="text-align: center;">회원가입</h1>
<div id="allbox">
	<a class="box" href="${contextPath}/member/memberForm.do">
		<h2>일반회원</h2>
		<img src="${contextPath}/resources/image/memberRegi.png" alt="일반회원" id="memRegiImg">
		<p class="p1">HelloWorld 웹사이트로 <br>여행을 준비하는<br> 일반 회원을 위한 회원가입입니다.</p>
		<div class="btn">가입하기</div>
	</a>
	<a class="box" href="${contextPath}/member/businessForm.do">
		<h2>사업자</h2>
		<img src="${contextPath}/resources/image/businessRegi.png" alt="사업자" id="busiRegiImg">
		<p class="p1">HelloWorld 웹사이트에 <br>여행상품 등록을 원하는<br> 사업자를 위한 회원가입입니다.</p>
		<div class="btn">가입하기</div>
	</a>  
</div>
</body>
</html>




