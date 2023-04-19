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
<style>
.textbox1 {
	border-radius:20px;
	width:400px;
	text-align:center;
}
.textbox2 {
	border-radius:20px;
	width:400px;
	text-align:center;
}
#address_kakao{
	border-radius:20px;
	width:400px;
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
.edit input[type=submit], .edit input[type=button] {
  background-color: #9FCBF6; /* 배경색 */
  border: 1px solid #0E256D; /* 테두리 */
  box-shadow: 3px 3px 3px #0E256D;
  border-radius: 10px;
  cursor: pointer; /* 마우스 포인터 */
  width: 100%;
  color: black;
}
.edit input[type=submit]:hover, .edit input[type=button]:hover {
  background-color: #0E256D; /* 배경색 */
  border: 1px solid #9FCBF6; /* 테두리 */
  color: #9FCBF6; /* 글자색 */
  box-shadow: 3px 3px 3px #0E256D;
}
</style>
</head>
<body>
<h2 style="text-align:center;">숙박 상품 수정</h2>
<div id="div119">
<form class="edit" action="${contextPath}/goods/goodsEdit.do" method="post">
	<table style="margin-left:auto;margin-right:auto;">
		<tr>
			<td>숙소명</td>
			<input type="hidden" name="goods_stay_id" value="${goodsItems.goods_stay_id}">
			<td><input type="text" name="goods_stay_name" class="textbox1" value="${goodsItems.goods_stay_name}"></td>
		</tr>
		<tr>
			<td>숙소 분류</td>
			<td>
				<select id="select_goods_stay_sort" name="goods_stay_sort">
					<option selected value="${goodsItems.goods_stay_sort}">${goodsItems.goods_stay_sort}</option>
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
	           <td>주소(도로명)</td>
	           <td><input type="text" id="goods_stay_roadAddress" name="goods_stay_roadAddress" value="${goodsItems.goods_stay_roadAddress}" class="textbox2" readonly />
	           <br>
	           <input type="button" id="address_kakao" name="adress_button" value="주소 찾기"></td>
	       </tr>
	       <tr>
	           <td>우편번호</td>
	           <td><input type="text" id="goods_stay_zipcode" name="goods_stay_zipcode" class="textbox1" value="${goodsItems.goods_stay_zipcode}" readonly/></td>
	       </tr>
	       <tr>
	           <td>(구)지번 주소</td>
	           <td><input type="text" id="goods_stay_jibunAddress" name="goods_stay_jibunAddress" value="${goodsItems.goods_stay_jibunAddress}" class="textbox1" readonly/></td>
	       </tr>
	       <tr>
	           <td>상세 주소</td>
	           <td><input type="text" id="goods_stay_namujiAddress" name="goods_stay_namujiAddress" value="${goodsItems.goods_stay_namujiAddress}" class="textbox1"/></td>
	       </tr>
		<tr>
			<td>예약 가능 인원/ 최대 인원</td>
			<td><input type="text" value="" name="goods_stay_num_people" value="${goodsItems.goods_stay_num_people}" class="textbox1"></td>
		</tr>
		<tr>
			<td>숙소 가격(1박 기준)</td>
			<td><input type="text" name="goods_stay_price" value="${goodsItems.goods_stay_price}" class="textbox1"></td>
		</tr>
		<tr>
			<td>이벤트 내용</td>
			<td><input type="text" name="goods_stay_discount_title" value="${goodsItems.goods_stay_discount_title}" class="textbox1"></td>
		</tr>
		<tr>
			<td>할인 가격(1박 기준)</td>
			<td><input type="text" name="goods_stay_sales_price" value="${goodsItems.goods_stay_sales_price}" class="textbox1"></td>
		</tr>
		<tr>
			<td>숙소 방 개수</td>
			<td><input type="text" name="goods_stay_room_number" value="${goodsItems.goods_stay_room_number}" class="textbox1"></td>
		</tr>
	</table>
	<table>
		<tr>
			<td><input type="button" value="등록한 상품 리스트"></td>
			<td><input type="submit" value="수정하기"></td>
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