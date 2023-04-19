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
<script type="text/javascript">
$(document).ready(function() {
	  $('#example').DataTable();
	});
	
//서버에서 데이터를 가져오는 경우
// $(document).ready(function() {
// 	  $('#example').DataTable( {
// 	    "ajax": {
// 	        "url": "/member/listAll.do",
// 	        "dataSrc": ""
// 	    },
// 	    "columns": [
// 	        { "data": "goods_stay_id", "name":"ID" },
// 	        { "data": "goods_stay_name","name":"Name" },
// 	        { "data": "goods_stay_price","name":"price" },
// 	        { "data": "goods_stay_num_people","name":"people" },
// 	        { "data": "goods_stay_room_number","name":"roomNumber" },
// 	        { "data": "goods_stay_roadAddress","name":"Address" }
// 	    ]
// 	  } );
// 	} );
	
	
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
      <th>할인률%</th>
      <th>할인가</th>
      <th>이벤트 내용</th>
      <th>방번호</th>
      <th>이벤트기간</th>
      <th>관리자 승인</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="stay" items="${stayList}">
      <tr>
        <td class="lalign">${stay.goods_stay_id}</td>
        <td>${stay.goods_stay_name}</td>
        <td>${stay.goods_stay_price}</td>
        <td>${stay.goods_stay_discount}%</td>
        <td>${stay.goods_stay_sales_price}</td>
        <td>${stay.goods_stay_discount_title}</td>
        <td>${stay.goods_stay_room_number}</td>
        <td>${stay.goods_stay_admission_Date}/${stay.goods_stay_departure_Date}</td>
        <td>${stay.goods_stay_admin_yn}</td>
      </tr>
      </c:forEach>
  </tbody>
</table>
</body>
</html>