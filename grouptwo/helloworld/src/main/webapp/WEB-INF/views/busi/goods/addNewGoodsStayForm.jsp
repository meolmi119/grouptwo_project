<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%> 
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<meta charset="EUC-KR">
<title>Hello World!</title>
<script type="text/javascript">
$(document).ready(function () {
    $.datepicker.setDefaults($.datepicker.regional['ko']); 
    $( "#startDate" ).datepicker({
         changeMonth: true, 
         changeYear: true,
         nextText: '다음 달',
         prevText: '이전 달', 
         dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
         monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
         dateFormat: "yymmdd",
         minDate: 30,
         maxDate: 90,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
         onClose: function( selectedDate ) {    
              //시작일(startDate) datepicker가 닫힐때
              //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
             $("#endDate").datepicker( "option", "minDate", selectedDate );
         }    

    });
    $( "#endDate" ).datepicker({
         changeMonth: true, 
         changeYear: true,
         nextText: '다음 달',
         prevText: '이전 달', 
         dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
         monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
         dateFormat: "yymmdd",
         minDate: 1,
         maxDate: 300,                       // 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
         onClose: function( selectedDate ) {    
             // 종료일(endDate) datepicker가 닫힐때
             // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
             $("#startDate").datepicker( "option", "maxDate", selectedDate );
         }    
    });    
});
</script>
<script type="text/javascript">
  var cnt=0;
  function fn_addFile(){
	  if(cnt == 0){
		  $("#d_file").append("<br>"+"<input  type='file' name='main_image' id='f_main_image' />");	  
	  }else{
		  $("#d_file").append("<br>"+"<input  type='file' name='detail_image"+cnt+"' />");
	  }
  	
  	cnt++;
  }
  
  
  function fn_add_new_goodsStay(obj){
		 fileName = $('#f_main_image').val();
		 if(fileName != null && fileName != undefined){
			 obj.submit();
		 }else{
			 alert("메인 이미지는 반드시 첨부해야 합니다.");
			 return;
		 }
		 
	}
</script>  
<style>
.textbox1 {
	border-radius:20px;
	width:400px;
	text-align:center;
}
.textbox2 {
	border-radius:20px;
	width:200px;
	text-align:center;
}
table {
	text-align:center;
	margin-left:auto;
	margin-right:auto;
}
#select_goods_stay_sort {
	width:410px;
	border-radius:20px;
	text-align:center;
}
</style>
</head>
<body>
<h2 style="text-align:center;">숙박 상품 등록</h2>
<div id="div119">
<form action="${contextPath}/addNewGoodsStay.do" method="post" enctype="multipart/form-data">
	<table style="margin-left:auto;margin-right:auto;">
		<tr>
			<td>숙소명</td>
			<td><input type="text" name="goods_stay_name" class="textbox1"></td>
		</tr>
		<tr>
			<td>숙소 분류</td>
			<td>
				<select id="select_goods_stay_sort" name="goods_stay_sort">
					<option>펜션</option>
					<option>리조트</option>
					<option>모텔</option>
					<option>호텔</option>
					<option>호스텔</option>
					<option>풀빌라</option>
					<option>게스트하우스</option>
					<option>여관</option>
					<option>휴양 콘도미니엄</option>
					<option>농어촌민박</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>숙소 분류 등급</td>
			<td><input type="text" name="goods_stay_sort_level" class="textbox1"></td>
		</tr>
	       <tr>
	           <td>주소(도로명)</td>
	           <td style="text-align:left;"><input type="text" id="goods_stay_roadAddress" name="goods_stay_roadAddress" class="textbox2" readonly />
	           <input type="button" id="address_kakao" name="adress_button" value="주소 찾기"></td>
	       </tr>
	       <tr>
	           <td>우편번호</td>
	           <td><input type="text" id="goods_stay_zipcode" name="goods_stay_zipcode" class="textbox1" readonly/></td>
	       </tr>
	       <tr>
	           <td>(구)지번 주소</td>
	           <td><input type="text" id="goods_stay_jibunAddress" name="goods_stay_jibunAddress" class="textbox1" readonly/></td>
	       </tr>
	       <tr>
	           <td>상세 주소</td>
	           <td><input type="text" id="goods_stay_namujiAddress" name="goods_stay_namujiAddress" class="textbox1"/></td>
	       </tr>
		<tr>
			<td>예약 가능 인원/ 최대 인원</td>
			<td><input type="text" value="" name="goods_stay_num_people" class="textbox1"></td>
		</tr>
		<tr>
			<td>숙소 가격(1박 기준)</td>
			<td><input type="text" name="goods_stay_price" class="textbox1"></td>
		</tr>
		<tr>
			<td>숙소 방 개수</td>
			<td><input type="text" name="goods_stay_room_number" class="textbox1"></td>
		</tr>
		<!-- <tr>
			<td>체크인 날짜/시간</td>
			<td><input type="text" name="goods_stay_admission_Date" id="startDate" class="textbox1"></td>
		</tr>
		<tr>
			<td>체크아웃 날짜/시간</td>
			<td><input type="text" name="goods_stay_departure_Date" id="endDate" class="textbox1"></td>
		</tr> -->
		<tr>
			<td>이미지 파일 첨부</td>
			<td><input type="button" value="파일 추가" onClick="fn_addFile()"></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td id="d_file" style="text-align: center;"> </td>
		</tr>
	</table>
	<table>
		<tr>
			<td><form action="#"><input type="button" value="메인 페이지"></form></td>
			<td><input type="button" value="등록한 상품 리스트"></td>
			<td><input type="button" value="등록하기" onClick="fn_add_new_goodsStay(this.form)"></td>
		</tr>
	</table>
</form>
</div>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
    new daum.Postcode({
        oncomplete: function(data) {
        	document.getElementById("goods_stay_zipcode").value = data.zonecode; // 주소 넣기
        	document.getElementById("goods_stay_roadAddress").value = data.roadAddress; //도로주소
        	document.getElementById("goods_stay_jibunAddress").value = data.jibunAddress; //(구)지번주소
            document.querySelector("input[name=goods_stay_namujiAddress]").focus(); //상세입력 포커싱
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
        }
    }).open();
    });
}
</script>
</html>