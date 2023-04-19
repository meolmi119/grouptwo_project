<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.net.URLEncoder, java.net.URLDecoder" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<head>
<style>
.title1 {
	font-size: 40px;
	text-decoration: none;
	color: black;
	font-weight: bold;
	text-align: left;
}
.detail_table {
	margin-left: 100px;
	width: 830px;
}
.list_view {
	margin: 0px;
}
.list_view p {
	text-align: center;
	margin: 20px 10px;
}
#memInfoTable td {
	height: 45px;
}
.subm7 { /* 버튼 스타일 */
	width: 250px;
	height: 40px;
	margin: 0px;
	background-color: #9FCBF6; /* 배경색 */
	border: 1px solid #0E256D; /* 테두리 */
	color: #0E256D; /* 글자색 */
	cursor: pointer; /* 마우스 포인터 */
	padding: 5px 10px 6px 7px; /* 패딩 */
	border-radius: 10px;
	font-weight: bolder;
	font-size: 20px;
	
	box-shadow: 3px 3px 3px #0E256D;
	transition-duration: 0.3s;
}
#paymentInfoDiv {
	border: 1px solid #BCBCBC;
	width: 95%;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jquery쓰기위해 필요 -->

</head>
<BODY>
<a href="${contextPath}/main.do" class="category_top">홈</a> <span class="category_top">&nbsp;>&nbsp;</span>
<a href="${contextPath }/order/orderEachGoodsAir.do" class="category_top">결제 페이지</a><br>
<a href="#" class="title1">최종 주문 확인서</a><br>
<!-- =======================================항공========================================================== -->
<c:if test="${flagAirStay eq 'air' }">
	<h3 style="display: inline-block">1.최종 주문 내역서 &nbsp;&nbsp;&nbsp;</h3>
	<TABLE border="1" class="list_view" style="text-align: center; width: 95%;">
		<TBODY align=center>
			<tr style="background: #9FCBF6">
			    <td>주문번호 </td>
				<td class="fixed">주문상품명</td> <!-- colspan=2 --> 
				<td>인원</td>
				<td>예상적립금</td>
				<td>결제금액</td>
			</tr>
			<c:forEach var="item" items="${myOrderList }">
				<tr>
				    <td>${item.air_order_id }</td>
						<%-- <TD class="goods_image"><a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }"><IMG width="75" alt=""  src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"></a></TD> --%>
					<td>${item.air_order_vihicleId } 항공편</td>
					     <%-- <A href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }</A> --%>
					<td>${item.air_order_qty_people }명</td>
					<td>${item.air_order_Charge* 0.01}원 (1%적립)</td>
					<td><h2>${item.air_order_Charge }원</h2></td>
				</tr>
			</c:forEach>
		</TBODY>
	</TABLE>
</c:if>
<!-- =======================================숙박========================================================== -->
<c:if test="${flagAirStay eq 'stay' }">
	<h3 style="display: inline-block">1.최종 주문 내역서 &nbsp;&nbsp;&nbsp;</h3>
	<TABLE border="1" class="list_view" style="text-align: center; width: 95%;">
		<TBODY align=center>
			<tr style="background: #9FCBF6">
			    <td>주문번호 </td>
				<td class="fixed">주문상품명</td> <!-- colspan=2 --> 
				<td>숙박날짜</td>
				<td>수량</td>
				<td>예상적립금</td>
				<td>결제금액</td>
			</tr>
			<c:forEach var="item" items="${myOrderList }">
				<tr>
				    <td>${item.stay_order_id }</td>
						<%-- <TD class="goods_image"><a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }"><IMG width="75" alt=""  src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"></a></TD> --%>
					<td>${item.stay_name } </td>
					     <%-- <A href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }</A> --%>
					<td>${item.stay_admissionDate } <br>~ ${item.stay_departureDate }</td>
					<td>${item.stay_order_qty_people }</td>
					<td>${item.stay_price* 0.01}원 (1%적립)</td>
					<td><h2>${item.stay_price }원</h2></td>
				</tr>
			</c:forEach>
		</TBODY>
	</TABLE>
</c:if>
<DIV class="clear"></DIV>
<form  name="form_order"><br><br>
	<div>
	  <br><br>
	  <h3 style="display: inline">2.주문고객 &nbsp;&nbsp;&nbsp;</h3>
	     <div class="detail_table">
			 <table id="memInfoTable">
			   <tbody>
				 <tr class="dot_line">
					<td >이름</td>
					<td><input  type="text" value="${orderer.mem_name}" size="20" disabled /></td>
				  </tr>
				  <tr class="dot_line">
					<td >핸드폰</td>
					<td><input  type="text" value="${orderer.mem_tel1}-${orderer.mem_tel2}-${orderer.mem_tel3}" size="20" disabled /></td>
				  </tr>
				  <tr class="dot_line">
					<td >이메일</td>
					<td><input  type="text" value="${orderer.mem_email1}@${orderer.mem_email2}" size="20" disabled /></td>
				  </tr>
			   </tbody>
			</table>
		</div>
	</div>
	<div class="clear"></div>
	<br><br><br>
	<h3 style="display: inline">3.결제정보 &nbsp;&nbsp;&nbsp;</h3><br><br>
	<table border="1" id="paymentInfoTable" style="text-align: center; width: 95%;">
	  <tbody>
	    <tr style="background-color: #9FCBF6;">
	      <td class="fixed_join">결제방법</td>
	      <c:if test="${myOrderInfo.card_pay_month != 'undefined'}">
	        <td class="fixed_join">결제카드</td>
	        <td class="fixed_join">할부기간</td>
	      </c:if>
	    </tr>
	    <tr>
	      <c:choose>
	        <c:when test="${myOrderInfo.pay_method != '무통장 입금'}">
	          <td>${myOrderInfo.pay_method }</td>
	        </c:when>
	        <c:otherwise>
	          <td>
	            ${myOrderInfo.pay_method }<br>
	            하나은행: 642-910840-37007 (주)1석2조<br>
	            <span style="font-size: 9px;">**입금 후 입금반영 완료까지 최대 10분정도 소요될 수 있습니다.</span>
	          </td>					
	        </c:otherwise>
	      </c:choose>
	      <c:if test="${myOrderInfo.card_pay_month != 'undefined'}">
	        <td>${myOrderInfo.card_com_name }</td>
	        <td>${myOrderInfo.card_pay_month }</td>
	      </c:if>
	    </tr>
	  </tbody>
	</table>
</form>
<DIV class="clear"></DIV><br><br><br>
<div style="text-align: center;">
	<a href="${contextPath}/main.do"> 
	   <%-- <img width="75" alt="" src="${contextPath}/resources/image/btn_shoping_continue.jpg"> --%>
	   <input type="button" value="쇼핑 계속하기" onclick="location.href='${contextPath}/main.do'" class="subm7" />
	</a>
</div>
<DIV class="clear"></DIV>
</BODY>		