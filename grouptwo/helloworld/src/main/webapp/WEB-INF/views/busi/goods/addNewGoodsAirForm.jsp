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
<meta charset="utf-8">
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
<h2 style="text-align:center;">항공 상품 등록</h2>
<div id="div119">
<form action="${contextPath}/addNewGoodsAir.do" method="post" enctype="multipart/form-data">
	<table style="margin-left:auto;margin-right:auto;">
		<tr>
			<td>항공기명</td>
			<td><input type="text" name="goods_air_name" class="textbox1"></td>
		</tr>
	       <tr>
	           <td>출발 지역</td>
	           <td style="text-align:left;"><input type="text" id="goods_air_depart1" name="goods_air_depart1" class="textbox2" readonly />
	           <input type="button" id="address_kakao1" name="adress_button" value="주소 찾기"></td>
	       </tr>
	       <tr>
	           <td>도착 지역</td>
	           <td style="text-align:left;"><input type="text" id="goods_air_arrive1" name="goods_air_arrive1" class="textbox2" readonly />
	           <input type="button" id="address_kakao" name="adress_button" value="주소 찾기"></td>
	       </tr>
		<tr>
			<td>출발 날짜/시간</td>
			<td><input type="text" name="goods_air_depart_Date" id="startDate" class="textbox1"></td>
		</tr>
		<tr>
			<td>도착 날짜/시간</td>
			<td><input type="text" name="goods_air_arrive_Date" id="endDate" class="textbox1"></td>
		</tr>
		<tr>
			<td>좌석 등급</td>
			<td>
				<select id="select_goods_air_class" name="goods_air_class">
					<option>1종류우</option>
					<option>2</option>
					<option>3</option>
					<option>4</option>
					<option>5</option>
					<option>6</option>
					<option>7</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>좌석 수</td>
			<td><input type="text" name="goods_air_num_people" class="textbox1"></td>
		</tr>
		<tr>
			<td>좌석 가격</td>
			<td><input type="text" name="goods_air_price" class="textbox1"></td>
		</tr>
		<tr>
			<td>비행기 고유 번호</td>
			<td><input type="text" name="air_airplane_id" id="1" class="textbox1"></td>
		</tr>
		<tr>
			<td>이미지 파일 첨부</td>
			<td><input type="button" value="파일 추가" onClick="fn_addFile()"></td>
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
    document.getElementById("address_kakao1").addEventListener("click", function(){ //주소입력칸을 클릭하면
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
window.onload = function(){
    document.getElementById("address_kakao2").addEventListener("click", function(){ //주소입력칸을 클릭하면
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