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
<link href="${contextPath}/resources/css/member/memberForm.css" rel="stylesheet" type="text/css" media="screen">
<script>
//유효성 검사
function validateForm() {
  var id = document.forms["frm_memForm"]["_mem_id"].value;
  var id_r = document.forms["frm_memForm"]["mem_id"].value;  
  var pw = document.forms["frm_memForm"]["mem_pw"].value;
  var name = document.forms["frm_memForm"]["mem_name"].value;
  var rrn = document.forms["frm_memForm"]["mem_rrn"].value;
  var tel1 = document.forms["frm_memForm"]["mem_tel1"].value;
  var tel2 = document.forms["frm_memForm"]["mem_tel2"].value;
  var tel3 = document.forms["frm_memForm"]["mem_tel3"].value;
  var email1 = document.forms["frm_memForm"]["mem_email1"].value;
  var email2 = document.forms["frm_memForm"]["mem_email2"].value;
  var certi_tf = document.forms["frm_memForm"]["certi_tf"].value;
  var roadAddress = document.forms["frm_memForm"]["mem_roadAddress"].value;
  var jibunAddress = document.forms["frm_memForm"]["mem_jibunAddress"].value;
  var namujiAddress = document.forms["frm_memForm"]["mem_namujiAddress"].value;
  var zipcode = document.forms["frm_memForm"]["mem_zipcode"].value;
   
  if(id == ""){
    alert("아이디를 입력해 주세요")
    return false;
  } else if (id_r == ""){
	alert("아이디 중복검사를 실행해 주세요");
	return false;
  }else if (pw == ""){
    alert("비밀번호를 입력해 주세요");
    return false;
  } else if (name == ""){
    alert("이름을 입력해 주세요");
    return false;
  } else if (rrn == ""){
	alert("생년월일을 입력해 주세요");
	return false;
  }else if (tel1 == "" || tel2 == "" || tel3 == ""){
    alert("휴대전화 번호를 입력해 주세요");
    return false;
  } else if (email1 == "" || email2 == ""){
    alert("이메일을 입력해 주세요");
    return false;
  } else if (certi_tf !== "true_h"){
	alert("이메일을 인증해 주세요");
	return false;
  }else if (roadAddress == "" || jibunAddress == "" || namujiAddress == ""){
    alert("주소를 입력해 주세요");
    return false;
  } else if (zipcode == ""){
    alert("우편번호를 입력해 주세요");
    return false;
  }else
  	return true;
}
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
var pnum = '';

//다음 우편번호 api
function execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

      // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
      var extraRoadAddr = ''; // 도로명 조합형 주소 변수

      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
        extraRoadAddr += data.bname;
      }
      // 건물명이 있고, 공동주택일 경우 추가한다.
      if(data.buildingName !== '' && data.apartment === 'Y'){
        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
      }
      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
      if(extraRoadAddr !== ''){
        extraRoadAddr = ' (' + extraRoadAddr + ')';
      }
      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
      if(fullRoadAddr !== ''){
        fullRoadAddr += extraRoadAddr;
      }

      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
      document.getElementById('roadAddress').value = fullRoadAddr;
      document.getElementById('jibunAddress').value = data.jibunAddress;
      document.querySelector("input[name=mem_namujiAddress]").focus();      
     
    }
  }).open();
}
//아이디 중복 검사
function fn_overlapped(){
    var _id=$("#_mem_id").val();
    if(_id==''){
   	 alert("ID를 입력하세요");
   	 return;
    }
    $.ajax({
       type:"post",
       async:false,  //비동기,동기 여부 지정
       url:"${contextPath}/member/overlapped.do",
       dataType:"text",
       data: {id:_id}, //서버로 보낼 데이터
       success:function (data,textStatus){ //통신 성공시 호출 해야하는 함수 지정
          if(data=='false'){
       	    alert("사용할 수 있는 ID입니다.");
       	    $('#btnOverlapped').prop("disabled", true);
       	    $('#_mem_id').prop("disabled", true);
       	    $('#mem_id').val(_id);
          }else{
        	  alert("사용할 수 없는 ID입니다.");
          }
       },
       error:function(data,textStatus){
    	   alert("요청 도중 에러가 발생했습니다. 페이지를 새로고침 해주세요");
       },
       complete:function(data,textStatus){
          //alert("작업을완료 했습니다");
       }
    });  //end ajax	 
 }
 
//이메일 인증번호 전송
//alert("인증번호를 전송하였습니다."); 컨트롤러에서 통신 상태를 확인하는 코드를 보내지 않음
function certi_s() {
  let certi_num = Math.floor(Math.random() * 900000) + 100000; // 랜덤 인증번호 생성
  pnum = certi_num
  let email1 = document.forms["frm_memForm"]["mem_email1"].value;
  let email2 = document.forms["frm_memForm"]["mem_email2"].value;

  if(email1 !== "" && email2 !== "" && certi_num !== ""){
    axios({
      method: 'post',
      url: '${contextPath}/sendMemberMail.do',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      data: { mem_email1: email1, mem_email2: email2, certi_num: certi_num }
    })
    .then(function (response) {
      alert("인증번호를 전송하였습니다.");
    })
    .catch(function (error) {
    	alert("예상치 못한 문제가 발생하였습니다.");
    });
  } else {
    alert("이메일을 입력하지 않았습니다. 이메일을 입력해주세요.");
  }
}
//이메일 인증
function certi_r() {
	var _certi_num = document.forms["frm_memForm"]["_certi_num"].value;
	var certi_num = pnum;
	if(_certi_num == certi_num){
		alert("인증번호가 일치합니다. 인증되었습니다.");
		document.getElementById("mem_email1").readOnly = true;
		document.getElementById("mem_email2").readOnly = true;
		document.getElementById("mem_email3").disabled = true;
		document.getElementById("certi_send").disabled = true;
		document.getElementById("_certi_num").disabled = true;
		document.getElementById("certi_tf").value = "true_h";
		
	} else {
	    alert("인증번호가 일치하지 않습니다. 다시 입력해주세요.");
	}
}
</script>
</head>
<body>


<!-- 로그인 -->
<form class="memForm" name="frm_memForm" action="${contextPath}/member/addMember.do" method="post" onsubmit="return validateForm()" >
  <h1>일반회원 가입</h1>
  <fieldset>
    <h2>회원정보</h2>
    <label for="_mem_id">아이디:</label><br>
    <input type="text" id="_mem_id" name="_mem_id" placeholder="아이디" minlength="6" maxlength="20">
    <input type="hidden" name="mem_id" id="mem_id" />
	<input type=button id="btnOverlapped" value="중복체크" onClick="fn_overlapped()" />
	<div id="id-message"></div>
    <label for="mem_pw">비밀번호:</label>
    <input type="password" id="mem_pw" name="mem_pw" placeholder="비밀번호" minlength="8" maxlength="20">
    <div id="pw-message"></div>
    <label for="mem_name">이름:</label>
    <input type="text" id="mem_name" name="mem_name" placeholder="이름" pattern="^[a-zA-Z가-힣]+$">
    <br>
    <label for="mem_rrn">생년월일:</label>
    <input type="text" id="mem_rrn" name="mem_rrn" placeholder="ex)20010402" minlength="8" maxlength="8" pattern="^\d{8}$">
    <div id="rrn-message"></div>
    <label for="mem_tel1">휴대폰번호:</label><br>
   		<select name="mem_tel1" id="mem_tel1">
			<option>없음</option>
			<option selected value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="018">018</option>
			<option value="019">019</option>
			</select>
			<input size="10px" type="text" name="mem_tel2" id="mem_tel2" minlength="4" maxlength="4" pattern="[0-9]{4}">
			<input size="10px" type="text" name="mem_tel3" id="mem_tel3" minlength="4" maxlength="4" pattern="[0-9]{4}"> 
					
    <br>
    <label for="mem_email1">이메일:</label><br>
    <input id="mem_email1" type="text" name="mem_email1" placeholder="example" pattern="[a-zA-Z0-9]+"/><!-- 영문 대소문자, 숫자 -->
	@ 
	<input id="mem_email2" type="text" name="mem_email2"  placeholder="mydomain.com" pattern="[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}"/><!-- 영문 대소문자, 숫자, 하이픈, 점 -->
    <select id=mem_email3 name="domain" onChange="document.getElementById('mem_email2').value=this.value">
							<option value="">직접입력</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="naver.com">naver.com</option>
							<option value="yahoo.co.kr">yahoo.co.kr</option>
							<option value="hotmail.com">hotmail.com</option>
							<option value="paran.com">paran.com</option>
							<option value="nate.com">nate.com</option>
							<option value="google.com">google.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="empal.com">empal.com</option>
							<option value="korea.com">korea.com</option>
							<option value="freechal.com">freechal.com</option>
	</select>
    <br>
    <input type="button" id="certi_send" name="certi_send" value="인증번호 받기" onClick="certi_s()">
    <input type="text" id="_certi_num" name="_certi_num" placeholder="인증번호" value="">
    <input type="hidden" id="certi_tf" name="certi_tf" value="">
  	<input type="button" id="certiBtn" value="확인" onClick="certi_r()">
  	
    <br>
    <label for="zipcode">주소:</label><br>
	<input type="text" id="zipcode" name="mem_zipcode">
	<a id="zipcode2" href="javascript:execDaumPostcode()">우편번호검색</a> <br>
	<label for="roadAddress">도로명 주소:</label><br>
	<input type="text" id="roadAddress" name="mem_roadAddress"><br>
	<label for="jibunAddress">지번 주소:</label><br>
	<input type="text" id="jibunAddress" name="mem_jibunAddress"><br>
	<label for="namujiAddress">나머지 주소:</label><br>
	<input type="text" name="mem_namujiAddress" id="namujiAddress"/>								
  </fieldset>
  <input id="memberConfirm" type="submit" value="회원 가입">
</form>
</body>
<script>
//정규식 확인
const idInput = document.getElementById('_mem_id');
const pwInput = document.getElementById('mem_pw');
const rrnInput = document.getElementById('mem_rrn');
const idMessage = document.getElementById('id-message');
const pwMessage = document.getElementById('pw-message');
const rrnMessage = document.getElementById('rrn-message');

idInput.addEventListener('input', () => {
  const idRegex = /^[a-zA-Z0-9]{6,20}(?!\s)$/;
  const idIsValid = idRegex.test(idInput.value);
  

  if (idIsValid) {
    idMessage.textContent = '';
  } else {
	idMessage.style.color = 'red';
    idMessage.textContent = '영문자, 숫자로 6~20자리로 공백 없이 입력하세요.';
  }
});

pwInput.addEventListener('input', () => {
  const pwRegex = /^[a-zA-Z0-9!@#$%^&*()?_~]{8,20}$/;
  const pwIsValid = pwRegex.test(pwInput.value);

  if (pwIsValid) {
    pwMessage.textContent = '';
  } else {
    pwMessage.style.color = 'red';
    pwMessage.textContent = '영문자, 숫자, 특수문자 중 8~20자리로 입력하세요.';
  }
});
rrnInput.addEventListener('input', () => {
  const rrnRegex = /^[a-zA-Z0-9!@#$%^&*()?_~]{8,20}$/;
  const rrnIsValid = rrnRegex.test(rrnInput.value);

  if (rrnIsValid) {
    rrnMessage.textContent = '';
  } else {
    rrnMessage.style.color = 'red';
    rrnMessage.textContent = '숫자로만 이루어진 8자리로 입력하세요';
  }
});
</script>
</html>