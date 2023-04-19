<%@page import="java.security.SecureRandom"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% request.setCharacterEncoding("utf-8"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<link href="${contextPath}/resources/css/member/registKakaoForm.css" rel="stylesheet" type="text/css" media="screen">
<title>Hello World!</title>
<script>
//유효성 검사
function validateForm() {
  var name = document.forms["frm_memForm"]["mem_name"].value;
   
  if (name == ""){
    alert("이름을 입력해 주세요");
    return false;
  } else{
  	return true;
  }
}
</script>
</head>
<body>

<!--카카오 회원정보 추가 입력-->
  <article class="fifth">
    <form name="frm_memForm" action="${contextPath}/member/kakaoFirstLogin.do" method="post" onsubmit="return validateForm()">
    <input type="hidden" name="mem_id" value="${userId}">
      <h1>카카오 추가 정보 입력</h1>
      <h3>Hello World에 오신 것을<br>환영합니다!</h3><br>
      <p>홈페이지 이용을 위한 추가 정보를 기입해 주세요.</p>
      <div class="misols">
      	<label for="mem_name">닉네임:</label><br>
      	<input id="mem_name" name="mem_name" type="text"/>
      </div>
      <div>
      	<br><br>
        <button type="submit">가입하기</button>
      </div>
    </form>
  </article>
</body>
</html>