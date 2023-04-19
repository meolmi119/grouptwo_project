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
<link href="${contextPath}/resources/css/member/unregistForm.css" rel="stylesheet" type="text/css" media="screen">
<title>Hello World!</title>
</head>
<body>

<!--회원탈퇴-->
<c:choose>
  <c:when test="${not empty memberInfo and empty userId}">
  <article class="fifth">
    <form name="frm_memForm" action="${contextPath}/member/unregister.do" method="post">
    <input type="hidden" name="mem_id" value="${memberInfo.mem_id}">
      <h3>회원탈퇴</h3>
      <h3>정말로 탈퇴하시겠습니까?</h3>
      <p>탈퇴 시 이용내역이 삭제되며<br>서비스이용이 제한됩니다.<br>또한 삭제된 계정은 복구되지 않습니다.</p>
      <div>
        <button type="submit">탈퇴하기</button>
      </div>
    </form>
  </article>
  </c:when>
  

  <c:when test="${not empty businessInfo and empty userId}"><!--사업자탈퇴-->
  <article class="fifth">
    <form name="frm_busiForm" action="${contextPath}/business/unregister.do" method="post">
    <input type="hidden" name="busi_id" value="${businessInfo.busi_id}">
      <h3>사업자탈퇴</h3>
      <h3>정말로 탈퇴하시겠습니까?</h3>
      <p>탈퇴 시 이용내역이 삭제되며<br>서비스이용이 제한됩니다.<br>또한 삭제된 계정은 복구되지 않습니다.</p>
      <div>
        <button type="submit">탈퇴하기</button>
      </div>
    </form>
  </article>
  </c:when>
  
  
  <c:when test="${not empty userId and not empty access_Token}"><!--카카오 회원탈퇴-->
  <article class="fifth">
    <form name="frm_memForm" action="${contextPath}/member/unregisterKakao.do" method="post">
    <input type="hidden" name="mem_id" value="${userId}">
      <h3>카카오 회원탈퇴</h3>
      <h3>정말로 탈퇴하시겠습니까?</h3>
      <p>탈퇴 시 이용내역이 삭제되며<br>서비스이용이 제한됩니다.<br>또한 삭제된 계정은 복구되지 않습니다.</p>
      <div>
        <button type="submit">탈퇴하기</button>
      </div>
    </form>
  </article>
  </c:when>
</c:choose>
</body>
</html>