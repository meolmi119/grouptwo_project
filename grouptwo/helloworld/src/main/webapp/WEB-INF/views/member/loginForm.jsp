<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextPath}/resources/css/member/loginForm.css" rel="stylesheet" type="text/css" media="screen">
<c:if test='${not empty message }'>
<script>
alert("${message}");
</script>
</c:if>
<script type="text/javascript">
function changeTab(tabId) {
	// 모든 탭의 actvice를 삭재
	const tabs = document.querySelectorAll('.tabs h2');
	tabs.forEach(tab => {
	  tab.classList.remove('active');
	});
	
	// 클린된 탭을 active로 변경
	const clickedTab = document.getElementById(tabId);
	clickedTab.classList.add('active');
	
	// 클릭된 탭 표시 다른 탭은 숨김
	// tab-content 클래스를 가진 모든 요소의 하위 div 요소에 대해 active 클래스를 제거하기 위해
	const tabContent = document.querySelectorAll('.tab-content div');
	tabContent.forEach(content => {
	  content.classList.remove('active');
	});
	
	const clickedTabContent = document.getElementById(tabId + '-content');
	clickedTabContent.classList.add('active');
}

document.addEventListener(`DOMContentLoaded`, () => {
	const tab1 = document.querySelector('#tab1');
	const tab2 = document.querySelector('#tab2');
	
	tab1.style.color = "#000";
	tab1.style.borderBottom = "2px solid #5fbae9";

	
	tab2.addEventListener(`click`, () => {
		document.getElementById("tab2").style.cssText = "color: #000;  border-bottom: 2px solid #5fbae9;"
		document.getElementById("tab1").style.cssText = "color: #cccccc; "
		
	})
	tab1.addEventListener(`click`, () => {
		document.getElementById("tab1").style.cssText = "color: #000;  border-bottom: 2px solid #5fbae9;"
		document.getElementById("tab2").style.cssText = "color: #cccccc; "
	})
	
})
</script>
<title>Hello World!</title>
</head>
<body>
 
 <div class="wrapper fadeInDown">
  <div id="formContent">
    <!-- Tabs Titles -->
    <div>
	    <h2 id="tab1" class="active underlineHover" onclick="changeTab('tab1')"> 일반회원 </h2>
	    <h2 id="tab2" class="underlineHover" onclick="changeTab('tab2')"> 사업자 </h2>
	</div>
    <!-- Login Form -->
    <div class="tab-content">
	    <div id="tab1-content" class="active">
		    <form action="${contextPath}/member/login.do" method="post">
		      <input type="text" id="login" class="fadeIn second" name="mem_id" placeholder="아이디">
		      <input type="password" id="password" class="fadeIn third" name="mem_pw" placeholder="비밀번호">
		      <input type="submit" class="fadeIn fourth" value="로그인">
		    </form>
	    </div>
	    
	    <div id="tab2-content">
		    <form action="${contextPath}/business/login.do" method="post">
		      <input type="text" id="login" class="fadeIn second" name="busi_id" placeholder="사업자 아이디"> 
		      <input type="password" id="password" class="fadeIn third" name="busi_pw" placeholder="비밀번호">
		      <input type="submit" class="fadeIn fourth" value="로그인">
		    </form>
	    </div>
    </div>

    <!-- Remind Passowrd -->
    <div id="formFooter">
      <a class="underlineHover" href="${contextPath}/member/findIDForm.do">아이디찾기</a> &nbsp &nbsp
      <a class="underlineHover" href="${contextPath}/member/findPwForm.do">비밀번호찾기</a>
      <br><br>
      
      <c:if test="${userId eq null}">
        <a href="https://kauth.kakao.com/oauth/authorize?client_id=e68c9069996ed8ece88f23c25ea43167&redirect_uri=http://localhost:8080/helloworld/member/kakaoLogin.do&response_type=code">
            <img src="${contextPath}/resources/image/kakao_login_medium_narrow.png" style="width:100px;">
        </a>
     </c:if>
    </div>
  </div>
</div>

<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
</body>
</html>