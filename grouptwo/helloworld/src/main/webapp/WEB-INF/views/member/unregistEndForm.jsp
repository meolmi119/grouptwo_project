<%@page import="java.security.SecureRandom"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% request.setCharacterEncoding("utf-8"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="${contextPath}/resources/css/member/unregistEndForm.css" rel="stylesheet" type="text/css" media="screen">
<title>Hello World!</title>
</head>
<script type="text/javascript">
function home() {
	window.location.href="${contextPath}/main.do";
}
</script>
<body>
<!--탈퇴완료-->
  <article class="seventh">
    <div>
      <h3>탈퇴 완료</h3>
      <img src="https://i.imgur.com/3NhJ9d0.png" width="50">
      <h3>정상적으로 탈퇴 처리 되었습니다.</h3>
      <p>그 동안 이용해주셔서 감사합니다.</p>
      <div>
        <button type="button" onclick="home()">홈으로</button>
      </div>
    </div>
  </article>
</body>
</html>