<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextPath}/resources/css/member/findPwForm.css" rel="stylesheet" type="text/css" media="screen">
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
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
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
    <form action="${contextPath}/sendMail.do" method="post">
      <input type="text" id="mem_id" class="fadeIn second" name="mem_id" placeholder="아이디">
      <input type="text" id="mem_email1" class="fadeIn third" name="mem_email1" required="" placeholder="이메일">
      <input type="text" id="mem_email2" class="fadeIn third" name="mem_email2" required="" placeholder="ex)naver.com">
      <input type="submit" class="fadeIn fourth" value="비밀번호 찾기">
    </form>
    </div>
    
    <div id="tab2-content">
    <form action="${contextPath}/sendBusiMail.do" method="post">
      <input type="text" id="busi_id" class="fadeIn second" name="busi_id" placeholder="아이디">
      <input type="text" id="busi_email1" class="fadeIn third" name="busi_email1" placeholder="이메일">
      <input type="text" id="busi_email2" class="fadeIn third" name="busi_email2" required="" placeholder="ex)naver.com">
      <input type="text" id="busi_brn" class="fadeIn third" name="busi_brn" required="" placeholder="사업자번호 ex)123-45-67890">
      <input type="submit" class="fadeIn fourth" value="비밀번호찾기">
    </form>
    </div>
    </div>
    
  </div>
</div>
</body>
</html>