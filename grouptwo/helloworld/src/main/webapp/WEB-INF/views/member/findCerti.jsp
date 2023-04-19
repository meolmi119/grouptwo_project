<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextPath}/resources/css/member/findCerti.css" rel="stylesheet" type="text/css" media="screen">
<c:if test='${not empty message }'>
<script>
window.onload=function()
{
  result();
}
</script>
</c:if>
<script type="text/javascript">
function certifi() {
	var certifi_num = document.querySelector('#certifi_num');
	var num = document.querySelector('#num');
	var memberPwFind;
	if('${sessionScope.memberPwFind}' != '') {
	    memberPwFind = '${sessionScope.memberPwFind.mem_pw}';
	} else if('${sessionScope.businessPwFind}' != '') {
	    memberPwFind = '${sessionScope.businessPwFind.busi_pw}';
	}
	
	if(certifi_num.value == num.value){
		alert("인증번호가 일치합니다. 회원님의 비밀 번호는 "+memberPwFind+"입니다.")
		window.location.href="${contextPath}/member/loginForm.do";
	}
	else if(cont == false){
	    alert("인증번호가 일치하지 않습니다. 다시 입력해주세요");
	}
}
</script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<title>Hello World!</title>
</head>
<body>
 
 <div class="wrapper fadeInDown">
  <div id="formContent">
    <!-- Tabs Titles -->
    <div>
    <h2 id="tab1" class="active underlineHover" onclick="changeTab('tab1')"> 비밀번호찾기 </h2>
	</div>
    <!-- Login Form -->
    <div class="tab-content">
    <div id="tab1-content" class="active">
	    <input type="text" id="certifi_num" class="fadeIn second" name="certifi_num" placeholder="인증번호">
	    <input type="submit" class="fadeIn fourth" value="확인" onclick=certifi()>
	    <input type="hidden" id="num" name="num" value="${num}">
    </div>
    </div>
    
  </div>
</div>
</body>
</html>