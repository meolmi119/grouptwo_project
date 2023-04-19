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
<link href="${contextPath}/resources/css/member/memberEdit.css" rel="stylesheet" type="text/css" media="screen">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<script>
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

            document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('roadAddress').value = fullRoadAddr;
            document.getElementById('jibunAddress').value = data.jibunAddress;
            document.querySelector("input[name=mem_namujiAddress]").focus();

        }
    }).open();
}


window.onload=function()
{
  selectBoxInit();
}
//옵션을 선택해야하는 값들 옵션값과 선택값이 같은지 확인
function selectBoxInit(){

 var mem_tel1='${memberInfoAd.mem_tel1 }';
 var selTel1 = document.getElementById('mem_tel1');
 var optionTel1 = selTel1.options;
 var val;
 for(var i=0; i<optionTel1.length;i++){
   val = optionTel1[i].value;
   if(mem_tel1 == val){
	   optionTel1[i].selected= true;
    break;
   }
 }  
}


//유효성 검사
function isValidPassword(password) {
  // 영문 대/소문자, 숫자, 특수문자를 조합한 8자리 이상의 문자열
  const pwRegex = /^[a-zA-Z0-9!@#$%^&*()?_~]{8,20}$/;
  return pwRegex.test(password);
}

//회원 수정
function fn_modify_member_info(attribute){
var value;

	var frm_mod_member=document.frm_memForm;
	if(attribute=='mem_pw'){
		value=frm_mod_member.mem_pw.value;
		if (!isValidPassword(value)) {
	      alert("비밀번호는 영문 대/소문자, 숫자, 특수문자를 조합한 8자리 이상의 문자열이어야 합니다.");
	      return; // 유효하지 않은 경우 서버로 데이터를 전송하지 않음
	    }
	}else if(attribute=='mem_tel'){
		var mem_tel1=frm_mod_member.mem_tel1;
		var mem_tel2=frm_mod_member.mem_tel2;
		var mem_tel3=frm_mod_member.mem_tel3;
		
		for(var i=0; mem_tel1.length;i++){
		 	if(mem_tel1[i].selected){
				value_tel1=mem_tel1[i].value;
				break;
			} 
		}
		value_tel2=mem_tel2.value;
		value_tel3=mem_tel3.value;
		value=value_tel1+","+value_tel2+", "+value_tel3;
	}else if(attribute=='mem_email'){
		var mem_email1=frm_mod_member.mem_email1;
		var mem_email2=frm_mod_member.mem_email2;
		
		value_email1=mem_email1.value;
		value_email2=mem_email2.value;
		value=value_email1+","+value_email2;
		//alert(value);
	}else if(attribute=='mem_address'){
		var mem_zipcode=frm_mod_member.mem_zipcode;
		var mem_roadAddress=frm_mod_member.mem_roadAddress;
		var mem_jibunAddress=frm_mod_member.mem_jibunAddress;
		var mem_namujiAddress=frm_mod_member.mem_namujiAddress;
		
		value_zipcode=mem_zipcode.value;
		value_roadAddress=mem_roadAddress.value;
		value_jibunAddress=mem_jibunAddress.value;
		value_namujiAddress=mem_namujiAddress.value;
		value=value_zipcode+","+value_roadAddress+","+value_jibunAddress+","+value_namujiAddress;
	}
	console.log(attribute);
	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/mypage/modifyMyInfoAdmin.do",
		data : {
			attribute:attribute,
			value:value,
		},
		success : function(data, textStatus) {
			if(data.trim()=='mod_success'){
				alert("회원 정보를 수정했습니다.");
			}else if(data.trim()=='failed'){
				alert("다시 시도해 주세요.");	
			}
			
		},
		error : function(data, textStatus) {
			alert("에러가 발생했습니다."+data);
		},
		complete : function(data, textStatus) {
			//alert("작업을완료 했습니다");
			
		}
	});
}
function main_E() {
	window.location.href="${contextPath}/admin/listMember.do";
}
//attribute = name, valu = 그 값
</script>
</head>
<body>
<!-- 로그인 -->
<form class="memForm" name="frm_memForm">
  <h1>상세정보</h1>
  <fieldset>
    <h2>회원정보</h2>
    <label for="_mem_id">아이디:</label><br>
    <input type="text" id="_mem_id" name="_mem_id" size="20" value="${memberInfoAd.mem_id}" disabled />
    <br>
    <label for="mem_pw">비밀번호:</label><br>
    <input id="mem_pw" name="mem_pw" type="password" minlength="8" maxlength="20" value="${memberInfoAd.mem_pw}"/>
    <input id="pw_edit" type="button" value="수정하기" onClick="fn_modify_member_info('mem_pw')" />
    <div id="pw-message"></div>	
    <label for="mem_name">이름:</label>
    <input id="mem_name" name="mem_name" type="text" value="${memberInfoAd.mem_name}" disabled />
    <br>
    <label for="mem_rrn">생년월일:</label>
    <input id="mem_rrn" name="mem_rrn" type="text" size="20" value="${memberInfoAd.mem_rrn}" disabled/>
    <br>
    <label for="mem_tel1">휴대폰번호:</label><br>
   		<select name="mem_tel1" id="mem_tel1">
			<option>없음</option>
			<option selected value="${memberInfoAd.mem_tel1}">${memberInfoAd.mem_tel1}</option>
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="018">018</option>
			<option value="019">019</option>
			</select>
			<input size="10px" type="text" name="mem_tel2" id="mem_tel2" minlength="4" maxlength="4" pattern="[0-9]{4}" value="${memberInfoAd.mem_tel2}">
			<input size="10px" type="text" name="mem_tel3" id="mem_tel3" minlength="4" maxlength="4" pattern="[0-9]{4}" value="${memberInfoAd.mem_tel3}"> 
			<input id="tel_edit" type="button" value="수정하기" onClick="fn_modify_member_info('mem_tel')" />		
    <br>
    <label for="mem_email1">이메일:</label><br>
    <input id="mem_email1" type="text" name="mem_email1" value="${memberInfoAd.mem_email1}" disabled/>
	@ 
	<input id="mem_email2" type="text" name="mem_email2"  value="${memberInfoAd.mem_email2}" disabled/>
    <br>
    <label for="zipcode">주소:</label><br>
	<input type="text" id="zipcode" name="mem_zipcode" value="${memberInfoAd.mem_zipcode}">
	<a id="zipcode2" href="javascript:execDaumPostcode()">우편번호검색</a> <br>
	<label for="roadAddress">도로명 주소:</label><br>
	<input type="text" id="roadAddress" name="mem_roadAddress" value="${memberInfoAd.mem_roadAddress}"><br>
	<label for="jibunAddress">지번 주소:</label><br>
	<input type="text" id="jibunAddress" name="mem_jibunAddress" value="${memberInfoAd.mem_jibunAddress}"><br>
	<label for="namujiAddress">나머지 주소:</label><br>
	<input type="text" name="mem_namujiAddress" id="namujiAddress" value="${memberInfoAd.mem_namujiAddress}"/>								
	<input id="addre_edit" type="button" value="수정하기" onClick="fn_modify_member_info('mem_address')" />
  </fieldset>
  <input type="hidden" name="command"  value="modify_my_info" />
  <input id="memberConfirm" name="btn_cancel_member" type="button"  value="수정 취소" onclick=main_E()>
</form>
  <input  type="hidden" name="h_tel1" value="${memberInfoAd.mem_tel1}" />
</body>
<script>
const pwInput = document.getElementById('mem_pw');
const pwMessage = document.getElementById('pw-message');
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
</script>
</html>