<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hello World!</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=IBM+Plex+Sans+KR:wght@300&family=Montserrat:ital,wght@1,500&display=swap');

.pageName {
	/* font-family: 'Black Han Sans', sans-serif; */
	font-family: 'Montserrat', sans-serif;
	font-size: 20px;
	font-weight: bolder;
	color: #0E256D;
	text-align: center;
	/* color: #C9ECFF; */ /* #9FCBF6; */
	/* text-shadow: -3px 0 #0E256D, 0 3px #0E256D, 3px 0 #0E256D, 0 -3px #0E256D; */
	/* text-shadow: -3px 0 #0099FF, 0 3px #0099FF, 3px 0 #0099FF, 0 -3px #0099FF; */
}
#logo {
	width: 20%;
}
.subm { /* 버튼 스타일 */
	width: 80px;
	background-color: #fff; /* 배경색 */
	border: 1px solid #dedede; /* 테두리 */
	cursor: pointer; /* 마우스 포인터 */
	padding: 5px 10px 6px 7px; /* 패딩 */
	border-radius: 10px;
}
.subm:hover { /* 버튼 위로 마우스 포인터 올렸을 때 스타일 */
	background-color: #C9ECFF; /* 배경색 */
	border: 1px solid #0099FF; /* 테두리 */
	color: #0099FF; /* 글자색 */
}
#btn_d {
	width: 80px;
	height: 50px;
	margin: 0px;
}
#cartImg {
	width: 15px;
	margin: 0px 5px;
}
.headerTd { /* td  class="headerTd" */
    height: 30px;
}

/* 네비게이션 navigation nav bar */
nav ul {
  text-align: center;
  background: linear-gradient(90deg, rgba(255, 255, 255, 0) 0%, rgba(255, 255, 255, 0.2) 20%, rgba(255, 255, 255, 0.2) 70%, rgba(255, 255, 255, 0) 100%);
  box-shadow: 0 0 2px rgba(0, 0, 0, 0.1), inset 0 0 1px rgba(159, 203, 246, 0.6);
  margin-left: -15px;
  margin-right: -15px;
  /* margin-top: -20px; */
}
.headerLi { /* nav ul li     class="headerLi"*/
  display: inline-block;
}
.headerA { /* nav ul li a     class="headerA"*/
  width: 100px;
  padding: 15px;
  /* color: rgba(0, 35, 122, 0.5); */
  color: #9FCBF6;
  font-size: 15px;
  text-decoration: none;
  display: block;
  font-weight: bold;
  cursor: pointer;
  
   --b: 0.1em;   /* the thickness of the line */
  --c: #0E256D; /* the color */
  
  padding-block: var(1em); /* var(--b); */
  background: 
    linear-gradient(var(--c) 50%,#000 0) 0% calc(100% - var(--_p,0%))/100% 200%,
    linear-gradient(var(--c) 0 0) 0% var(--_p,0%)/var(--_p,0%) var(--b) no-repeat;
  -webkit-background-clip: text,padding-box;
          background-clip: text,padding-box;
  transition: .3s var(--_s,0s) linear,background-size .3s calc(.3s - var(--_s,0s));
  
}
.headerA:hover { /* nav ul li a */
  	/* background-color: rgba(255, 255, 255, 0.6); /* 배경색 */
	color: #0E256D; /* 글자색 */ 
	--_p: 100%;
  	--_s: .3s;
    cursor: pointer;
}

/* 드롭다운 */
.dropdown {
	display: none;
	width: 100px;
	margin: 0;
	padding: 5px; 
	list-style: none;
	border-bottom-left-radius: 6px;
	border-bottom-right-radius: 6px;
	box-shadow: 1px 2px 5px -1px rgba(0,0,0,0.15),0px 4px 14px -1px rgba(0,0,0,0.10);
	transform: translate(0,-60px);
	transition: transform 0.2s ease-out, opacity 0.2s, z-index 0s 0.2s;
  	opacity: 0;
	z-index: -1;
}
.headerA:hover ~ .dropdown {
  	display: inline-block;
  	opacity: 1;
} 
#menu1:hover ~ #dropdown1 {
  	display: inline-block;
  	opacity: 1;
}
.ddli {
  display: block;
  color: rgba(14, 37, 109, 0.5);
  font-size: 14px;
  text-decoration: none;
  cursor: pointer;
}

/* 드롭다운 dropdown */
ul.nav {
  /* flex-direction: row; align-items: center; margin: 0 auto; list-style: none; */
  text-align: center;
  padding: -10px;
  background: linear-gradient(90deg, rgba(255, 255, 255, 0) 0%, rgba(255, 255, 255, 0.2) 20%, rgba(255, 255, 255, 0.2) 70%, rgba(255, 255, 255, 0) 100%);
  box-shadow: 0 0 2px rgba(0, 0, 0, 0.1), inset 0 0 1px rgba(159, 203, 246, 0.6);
  margin-left: -15px;
  margin-right: -15px;
  /* margin-top: -20px; */ 
  height: 50px;
}
ul.nav > li {
  position: relative;
  flex-grow: 1;
  flex-shrink: 0;
  font-size: 14px;
  text-align: center;
  text-transform: uppercase;
  /* line-height: 60px; */
  letter-spacing: 1px;
  cursor: pointer;
}
ul.nav > li:hover {
  /* background: rgba(0, 0, 0, 0.1); */
}
ul.nav > li:hover ul.dropdown {
  visibility: visible;
  transform: translate(0, 0);
  line-height: 30px;
  opacity: 1;
  z-index: 200;
  background: #fff;
}
ul.nav > li:hover ul.dropdown > li {
  -webkit-animation-name: slideInLeft;
          animation-name: slideInLeft;
  -webkit-animation-duration: 0.3s;
          animation-duration: 0.3s;
  -webkit-animation-timing-function: ease-in-out;
          animation-timing-function: ease-in-out;
  -webkit-animation-fill-mode: backwards;
          animation-fill-mode: backwards; 
}

.dropdown {
  visibility: hidden;
  display: flex;
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  flex-direction: column;
  width: 120px;
 /* margin: 0; padding: 5px 0 30px; list-style: none; color: #333; background: #e5e4ea; */
  border-bottom-left-radius: 6px;
  border-bottom-right-radius: 6px;
  box-shadow: 1px 2px 5px -1px rgba(0, 0, 0, 0.15), 0px 4px 14px -1px rgba(0, 0, 0, 0.1);
  transform: translate(0, -60px);
  transition: transform 0.2s ease-out, opacity 0.2s, z-index 0s 0.2s;
  opacity: 0;
  z-index: -1;
}
ul.dropdown > li {
  font-size: 14px;
  cursor: pointer;
}
ul.dropdown > li:hover { }

@-webkit-keyframes slideInLeft {
  from {
    transform: translate(-25%, 0);
    opacity: 0;
  }
  to {
    transform: translate(0, 0);
    opacity: 1;
  }
}

@keyframes slideInLeft {
  from {
    transform: translate(-25%, 0);
    opacity: 0;
  }
  to {
    transform: translate(0, 0);
    opacity: 1;
  }
}

/* 검색바 searchbar */
/* body {
    padding: 0;
    margin: 0;
    height: 100vh;
    width: 100%;
    background: #07051a;
} */

#search_form {	/* form */
    position: relative;
    top: 20%;
    left: 50%;
    transform: translate(-50%,-50%);
    transition: all 1s;
    width: 50px;
    background: white;
    box-sizing: border-box;
    border-radius: 25px;
    border: 4px solid white;
    padding: 5px;
    margin-top: -20px;
}
#search_input {	/* input */
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;;
    height: 42.5px;
    line-height: 30px;
    outline: 0;
    border: 0;
    display: none;
    font-size: 1em;
    border-radius: 20px;
    padding: 0 20px;
}
.fa {
    box-sizing: border-box;
    padding: 10px;
    width: 42.5px;
    height: 42.5px;
    position: absolute;
    top: 0;
    right: 0;
    border-radius: 50%;
    color: #07051a;
    text-align: center;
    font-size: 1.2em;
    transition: all 1s;
    
    cursor: pointer;
    border: 1px solid #dedede;
}
#search_form:hover,
#search_form:valid {
    width: 200px;
    cursor: pointer;
}
#search_form:hover #search_input,
#search_form:valid #search_input {
    display: block;
    border: 1px solid #0099FF;
}
#search_form:hover .fa,
#search_form:valid .fa {
    /* background: #07051a; color: white; */
    background-color: #C9ECFF;
    border: 1px solid #0099FF;
    color: #0099FF;
}
#search_a {	/* a */
  display: none;
  position: absolute;
  top: 70px;
  bottom:0;
  left: 0;
  right: 0;
  font-size: 20px;
  color: white;
  text-align: center; 
  width: 100%;
}
#search_form:valid #search_a {
  display: block;
}
.welcome_td {
	width: 80px; 
	text-align: center;
}
</style>
<script  type="text/javascript">
function logout_h() {
	var cont = confirm('로그아웃 하시겠습니까?');
	if(cont == true){
		window.location.href="${contextPath}/member/logout.do";
	}
	else if(cont == false){
	    alert("로그아웃을 취소합니다.");
	}
}
function logout_a() {
	var cont = confirm('로그아웃 하시겠습니까?');
	if(cont == true){
		window.location.href="${contextPath}/admin/logout.do";
	}
	else if(cont == false){
	    alert("로그아웃을 취소합니다.");
	}
}
function logout_k() {
	var cont = confirm('로그아웃 하시겠습니까?');
	if(cont == true){
		window.location.href="${contextPath}/member/kakaoLogout.do";
	}
	else if(cont == false){
	    alert("로그아웃을 취소합니다.");
	}
}
function login_h() {
	alert("로그인 창으로 이동합니다.");
	window.location.href="${contextPath}/member/loginForm.do";
}
function goToCart() {
	window.location.href = "${contextPath}/myCartList.do";
}
function memadd_h() {
	alert("회원가입 창으로 이동합니다.");
	window.location.href="${contextPath}/member/registForm.do";
}
function listAll() {
	window.location.href="${contextPath}/business/listAll.do";
}
function cart_h() {
	alert("찜한목록 창으로 이동합니다.");
	window.location.href="#";
}
function gd_a() {
	alert("상품관리 창으로 이동합니다.");
	window.location.href="#";
}
//관리자페이지
function admin_d() {
	window.location.href="${contextPath}/admin/managementForm.do";
}
//전체 검색
function stay_a() {
	window.location.href="${contextPath}/member/listStay.do";
}

/* 검색바 searchbar */
const clearInput = () => {
  const input = document.getElementsByTagName("input")[0];
  input.value = "";
};

const clearBtn = document.getElementById("clear-btn");
/* clearBtn.addEventListener("click", clearInput); */
</script>

</head>
<body>
<table border=0 width="100%">
	<tr>
		<td rowspan="2" style="width:20%" class="headerTd"><a href="${contextPath}/main.do"><img src="${contextPath}/resources/image/logo.png" id="logo" /></a></td>
		<td rowspan="2" class="headerTd"><h1 class="pageName"><a href="${contextPath}/main.do" class="pageName">Hello World!</a></h1>
		</td>
		<c:choose>
			<c:when test="${isLogOn==true and not empty memberInfo and memberInfo.mem_id == 'hwAdmin'}">
				<td class="welcome_td"><h5 style="margin: 0px;">환영합니다!<br>${memberInfo.mem_name}님</h5></td>
				</c:when>
			<c:when test="${isLogOn==true and not empty userId and not empty access_Token}">
				<td class="welcome_td"><h5 style="margin: 0px;">환영합니다!<br>${memberInfo.mem_name}님</h5></td>
				</c:when>
			<c:when test="${isLogOn==true and not empty memberInfo}">
				<td class="welcome_td"><h5 style="margin: 0px;">환영합니다!<br>${memberInfo.mem_name}님</h5></td>
				</c:when>
			<c:when test="${isLogOn==true and not empty businessInfo}">
				<td class="welcome_td"><h5 style="margin: 0px;">환영합니다!<br>${businessInfo.busi_name}님</h5></td>
				</c:when>
			<c:otherwise>
				
			</c:otherwise>
		</c:choose>
		<td colspan="2" style="height: 20px" class="headerTd">
			<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

			<form id="search_form" action="">
			  <input type="search" required id="search_input">
			  <i class="fa fa-search" id="search_i"></i>
			  <a href="javascript:void(0)" id="clear-btn" id="search_a"> </a>
			</form>
		</td>
	</tr>
	<tr>
		<c:choose>
				<c:when test="${isLogOn==true and not empty memberInfo and memberInfo.mem_id == 'hwAdmin'}">
					<td id="btn_d" style="height: 30px; text-align: right;"><input type="button" value="로그아웃" onclick=logout_h()  class="subm"></td>
					<td id="btn_d" style="height: 30px"><button type="button" class="subm" style="width: 120px;" onclick=admin_d()>관리자페이지</button></td>
				</c:when>
				<c:when test="${isLogOn==true and not empty userId and not empty access_Token}">
					<td id="btn_d" style="height: 30px; text-align: right;"><input type="button" value="로그아웃" onclick=logout_k()  class="subm"></td>
					<td id="btn_d" style="height: 30px">
						<nav class="navbar" style="width: 120px;">
	  						<ul class="nav" style="margin:0; padding: 0; height: 33px;">
							  <li class="headerLi" style="border: none;">
							      <button type="button" class="subm" style="width: 120px;">마이페이지</button>
							      <!-- <a href="#" class="headerA">마이페이지</a> -->
							      <ul class="dropdown" style="width: 110px;">
							      	<li class="ddli">결제확인</li>
							      	<li class="ddli">쿠폰/포인트</li>
							      	<li class="ddli">문의내역</li>
							      	<li class="ddli"><a href="${contextPath}/member/unregistForm.do" class="ddli">회원 탈퇴</a></li>
							      </ul>
							    </li>
							  </ul>
						</nav>
				    </td>
				    <td id="btn_d" style="height: 30px">
						<button type="button" class="subm" onclick="goToCart()" style="width: 120px;">찜한목록<img src="${contextPath}/resources/image/cart1.png" id="cartImg" /></button>
					</td>
				</c:when>
				<c:when test="${isLogOn==true and not empty memberInfo}">
					<td id="btn_d" style="height: 30px; text-align: right;"><input type="button" value="로그아웃" onclick=logout_h()  class="subm"></td>
					<td id="btn_d" style="height: 30px">
						<nav class="navbar" style="width: 120px;">
	  						<ul class="nav" style="margin:0; padding: 0; height: 33px;">
							  <li class="headerLi" style="border: none;">
							      <button type="button" class="subm" style="width: 120px;">마이페이지</button>
							      <!-- <a href="#" class="headerA">마이페이지</a> -->
							      <ul class="dropdown" style="width: 110px;">
							      	<li class="ddli"><a href="${contextPath}/mypage/memberEdit.do" class="ddli">회원 정보 수정</a></li>
							      	<li class="ddli"><a href="${contextPath}/myCartList.do" class="ddli">찜한목록</a></li>
							      	<li class="ddli"><a href="${contextPath}/order/myOrderHistory.do" class="ddli">결제확인</a></li>
							      	<li class="ddli">쿠폰/포인트</li>
							      	<li class="ddli">문의내역</li>
							      	<li class="ddli"><a href="${contextPath}/member/unregistForm.do" class="ddli">회원 탈퇴</a></li>
							      </ul>
							    </li>
							  </ul>
						</nav>
				    </td>
					<%-- <td id="btn_d" style="height: 30px"><button type="button" class="subm" style="width: 120px;">찜한목록<img src="${contextPath}/resources/image/cart1.png" id="cartImg" /></button></td> --%>
					<td id="btn_d" style="height: 30px">
						<button type="button" class="subm" onclick="goToCart()" style="width: 120px;">찜한목록<img src="${contextPath}/resources/image/cart1.png" id="cartImg" /></button>
					</td>
				</c:when>
				<c:when test="${isLogOn==true and not empty businessInfo}">
					<td id="btn_d" style="height: 30px; text-align: right;"><input type="button" value="로그아웃" onclick=logout_h()  class="subm"></td>
					<td id="btn_d" style="height: 30px">
						<nav class="navbar" style="width: 120px;">
	  						<ul class="nav" style="margin:0; padding: 0; height: 33px;">
							  <li class="headerLi" style="border: none;">
							      <button type="button" class="subm" style="width: 120px;" onclick=my_h()>마이페이지</button>
							      <!-- <a href="#" class="headerA">마이페이지</a> -->
							      <ul class="dropdown" style="width: 110px;">
							      	<li class="ddli"><a href="${contextPath}/mypage/businessEdit.do" class="ddli">회원 정보 수정</a></li>
							      	<li class="ddli"><a href="${contextPath}/addNewGoodsStayForm.do" class="ddli" style="font-size: 12px;">숙박 상품 등록하기</a></li>
							      	<li class="ddli"><a href="${contextPath}/order/busiOrderList.do" class="ddli">결제확인</a></li>
							      	<li class="ddli">쿠폰/포인트</li>
							      	<li class="ddli">문의내역</li>
							      	<li class="ddli"><a href="${contextPath}/member/unregistForm.do" class="ddli">회원 탈퇴</a></li>
							      </ul>
							    </li>
							  </ul>
						</nav>
					</td>
					<td id="btn_d" style="height: 30px">
						<button type="button" class="subm" onclick="listAll()" style="width: 120px;">상품관리<img src="${contextPath}/resources/image/cart1.png" id="cartImg" /></button>
					</td>
				</c:when>
				<c:otherwise>
					<td id="btn_d" style="height: 30px"><input type="button" value="로그인" onclick=login_h()  class="subm" style="width: 100px;"></td>
					<td id="btn_d" style="height: 30px"><input type="button" value="회원가입" onclick=memadd_h()  class="subm" style="width: 100px;"></td>
				</c:otherwise>
			</c:choose>
	</tr>
</table>
		
<nav class="navbar">
  <ul class="nav">
    <li class="headerLi">
      <a href="${contextPath}/searchGoodsAir.do" class="headerA">항&nbsp;&nbsp;&nbsp;공</a>
      <ul class="dropdown">
      	<li class="ddli"><a href="${contextPath}/searchGoodsAir.do" class="ddli">국내항공</a></li>
      	<!-- <li class="ddli">국외항공</li> -->
      </ul>
    </li>
    <li class="headerLi">
      <a href="${contextPath}/searchGoodsStay.do" class="headerA">숙&nbsp;&nbsp;&nbsp;박</a>
      <ul class="dropdown">
      	<li class="ddli"><a href="${contextPath}/searchGoodsStay.do" class="ddli">국내숙박</a></li>
      	<!-- <li class="ddli">종류별</li>
      	<li class="ddli">금액별</li> -->
      </ul>
    </li>
    <li class="headerLi">
      <a href="${contextPath}/goodsRecommand.do" class="headerA">상품추천</a>
      <ul class="dropdown">
        <li class="ddli"><a href="${contextPath}/goodsRecommand.do" class="ddli">상품추천</a></li>
      	<!-- <li class="ddli">여행지</li>
      	<li class="ddli">최저가항공</li>
      	<li class="ddli">이벤트숙박</li> -->
      </ul>
    </li>
    <li class="headerLi">
      <a href="#" class="headerA">커뮤니티</a>
      <ul class="dropdown">
      	<li class="ddli">리뷰</li>
      	<li class="ddli">꿀팁공유</li>
      	<li class="ddli">맛집공유</li>
      </ul>
    </li>
    <li class="headerLi">
      <a href="#" class="headerA">공지사항</a>
      <ul class="dropdown">
      	<li class="ddli">공지사항</li>
      	<li class="ddli">예약/환불안내</li>
      	<li class="ddli">Q&A</li>
      	<li class="ddli">1:1문의내역</li>
      </ul>
    </li>
  </ul>
</nav>
		
</body>
</html>