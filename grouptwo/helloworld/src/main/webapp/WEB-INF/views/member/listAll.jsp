<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- <link href="${contextPath}/resources/css/admin/listMember.css" rel="stylesheet" type="text/css" media="screen"> --%>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.11.3/datatables.min.css"/>
<title>Hello World!</title>
<!-- jQuery CDN 링크 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- datatables CDN 링크 추가 -->
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.11.3/datatables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<style type="text/css">
.eventRegist input[type=submit] {
  background-color: #9FCBF6; /* 배경색 */
  border: 1px solid #0E256D; /* 테두리 */
  box-shadow: 3px 3px 3px #0E256D;
  border-radius: 10px;
  cursor: pointer; /* 마우스 포인터 */
  width: 15%;
  color: black;
}

.eventRegist input[type=submit]:hover {
  background-color: #0E256D; /* 배경색 */
  border: 1px solid #9FCBF6; /* 테두리 */
  color: #9FCBF6; /* 글자색 */
  box-shadow: 3px 3px 3px #0E256D;
}
.unregi input[type=submit], .edit input[type=submit]{
  background-color: #9FCBF6; /* 배경색 */
  border: 1px solid #0E256D; /* 테두리 */
  box-shadow: 3px 3px 3px #0E256D;
  border-radius: 10px;
  cursor: pointer; /* 마우스 포인터 */
  width: 70%;
  color: black;
}
.unregi input[type=submit]:hover, .edit input[type=submit]:hover {
  background-color: #0E256D; /* 배경색 */
  border: 1px solid #9FCBF6; /* 테두리 */
  color: #9FCBF6; /* 글자색 */
  box-shadow: 3px 3px 3px #0E256D;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	  $('#example').DataTable();
	});
</script>
<style type="text/css">
.sorting{
  background:#9FCBF6;
}
</style>
</head>
<!-- thead 열 -->
<body>
 <table id="example" class="display" style="width:100%">
  <thead>
    <tr>
      <th>상품번호</th>
      <th>이름</th>
      <th>원가격</th>
      <th>할인가</th>
      <th>이벤트 내용</th>
<!--       <th>방번호</th> -->
      <th>이벤트/할인가 관리</th>
      <th>상품관리</th>
      <th>승인</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="stay" items="${stayList}">
      <tr>
        <td class="lalign">${stay.goods_stay_id}</td>
        <td>${stay.goods_stay_name}</td>
        <td>${stay.goods_stay_price}</td>
        <td>${stay.goods_stay_sales_price}</td>
        <td>${stay.goods_stay_discount_title}</td>
<%--         <td>${stay.goods_stay_room_number}</td> --%>
        <td>
	        <form class="eventRegist" method="post" action="${contextPath}/goods/goodsEventRegist.do">
	        	<input type="hidden" name="goods_stay_id" value="${stay.goods_stay_id}"/>
	        	<span>이벤트 내용:</span>
	        	<input type="text" name="goods_stay_discount_title" value="${stay.goods_stay_discount_title}"/>
				<span>할인가:</span>
				<input type="text" name="goods_stay_sales_price" value="${stay.goods_stay_sales_price}"/>
				<input type="submit" value="이벤트등록/수정"/>
			</form>
		</td>
		<td>
			<form class="unregi" method="post" action="${contextPath}/goods/goodsUnregist.do">
	        	<input type="hidden" name="goods_stay_id" value="${stay.goods_stay_id}"/>
	        	<input type="submit" value="상품제거"/>
			</form>
			<form class="edit" method="get" action="${contextPath}/goods/goodsEditForm.do">
	        	<input type="hidden" name="goods_stay_id" value="${stay.goods_stay_id}"/>
	        	<input type="submit" value="상품수정"/>
			</form>
		</td>
		<td>${stay.goods_stay_admin_yn}</td>
      </tr>
      </c:forEach>
  </tbody>
</table>
</body>
</html>