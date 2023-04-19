<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<title>Hello World!</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Poppins');

body {
  font-family: "Poppins", sans-serif;
  height: 100vh;
}
</style>
</head>
<body>

 

<!--  <a href="javascript:void(0)" class="underlineHover" onclick="kakaoLogin();">
    카카오 로그인</a>
<a href="javascript:void(0)" class="underlineHover" onclick="kakaoLogout();">
    카카오 로그아웃</a> -->
    
    <c:if test="${userId eq null}">
        <a href="https://kauth.kakao.com/oauth/authorize?client_id=e68c9069996ed8ece88f23c25ea43167&redirect_uri=http://localhost:8080/helloworld/member/kakaoLogin.do&response_type=code">
            <img src="${contextPath}/resources/image/kakao_login_medium_narrow.png">
        </a>
    </c:if>
    <c:if test="${userId ne null}">
        <h1>로그인 성공입니다</h1>
        <input type="button" value="로그아웃" onclick="location.href='/helloworld/member/kakaoLogout.do'">
    </c:if>


<!-- 카카오 스크립트 -->
 <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- <script>
Kakao.init('262f9fa7a9f6cbb21b2532aabacdb73f'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  console.log(response)
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }
//카카오로그아웃  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  
</script> -->

</body>
</html>