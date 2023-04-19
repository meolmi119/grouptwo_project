<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="myStayCartList"  value="${cartStayMap.myStayCartList}"  />
<c:set var="myGoodsList"  value="${cartStayMap.myGoodsList }"  />

<c:set var="myAirCartList"  value="${cartAirMap.myAirCartList }"  />

<c:set  var="totalDeliveryPrice" value="0" /> <!-- 총 배송비 --> 
<c:set  var="totalStayDiscountedPrice" value="0" /> <!-- 총 할인금액 -->
<c:set  var="totalGoodsStayNum" value="0" />  <!--주문 개수 -->
<c:set  var="finalGoodsStayPrice" value="0" /> <!-- 최종 결제 금액 -->
<c:set  var="totalGoodsStayPrice" value="0" /> <!-- 금액 -->

<c:set  var="totalGoodsAirNum" value="0" />  <!--주문 개수 -->
<c:set  var="finalGoodsAirPrice" value="0" /> <!-- 최종 결제 금액 -->
<c:set  var="totalGoodsAirPrice" value="0" /> <!-- 금액 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>찜한 목록</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script type="text/javascript">

function getDateforOrder(event) {
	var startD = document.getElementsByName("startD")[Number(event)].value;
	var endD = document.getElementsByName("endD")[Number(event)].value;
	var room_count = document.getElementsByName("cart_stay_room_number")[Number(event)].value;
	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/order/getDataForEachPaymentStayCart.do",
		data : {
			startD: startD,
			endD: endD,
			room_count: room_count
		},
		success : function(data, textStatus) {
			console.log("getDataForEachPaymentStay");
		},
		error : function(data, textStatus) {
			console.log("getDataForEachPaymentStay 오류");
		},
		complete : function(data, textStatus) {
			//alert("작업을완료 했습니다");
		}
	}); //end ajax	
}

//결제하기 버튼 클릭 시 실행되는 함수s
function onStayPayButtonClick(event) {
  var _isLogOn = document.getElementsByName("isLogOn")[0];
  var isLogOn = _isLogOn.value;
	console.log(event);
	console.log(Number(event));
  if (isLogOn !== "true") {
    alert("로그인 후 주문이 가능합니다!!!");
  } else {
    var form = document.getElementsByName("getEachStayData")[Number(event)];
    form.submit();
  }
}
</script>
<style>
.list_view {
	 border: 1px solid;
	 color: white;
	 text-align: center;
	 margin: 20px 0px;
	 
	 width:80%;
	 margin-right:auto;
	 margin-left:auto;
	 min-width:700px;
}
.list_view thead td {
	 height: 30px;
}
.list_view tbody td {
	 height: 55px;
}
.list_view2 {
	  background:#313c75;
	  width:80%;
	  margin-right:auto;
	  margin-left:auto;
	  min-width:700px;
	  color:white;
}
.list_view2 td, .list_view2 p {
	 color: white;
	 text-align: center;
	 margin: 20px 0px;
}
.h4Title {
	margin-left: 125px;
}
#cartBtnDiv {
	text-align: center;
}
.subm3 { /* 버튼 스타일 */
	width: 250px;
	height: 40px;
	margin: 0px;
	background-color: #0E256D; /* 배경색 */
	border: 1px solid #9FCBF6; /* 테두리 */
	color: #fff; /* 글자색 */
	cursor: pointer; /* 마우스 포인터 */
	padding: 5px 10px 6px 7px; /* 패딩 */
	border-radius: 10px;
	font-weight: bolder;
	font-size: 20px;
	
	box-shadow: 3px 3px 3px #0E256D;
	transition-duration: 0.3s;
}
</style>
<script src="${contextPath}/resources/script/myCartList.js" type="text/javascript"></script>
</body>
</head>
<body>

<h3 style="text-align:center;">찜한 목록</h3>

<h4 class="h4Title">1.숙박 찜목록</h4>
<table class="list_view" border=1>
	<thead align=center >
		<tr style="background:#87c1e9" >
			<td class="fixed">구분</td>
			<td class="fixed">숙소이름</td> <!-- colspan=2 -->
			<td>분류</td>
			<td>체크인</td>
			<td>체크아웃</td>
			<td>방 개수</td>
			<td>예상요금</td>
			<td>삭제/결제</td>
		</tr>
	</thead>
	<tbody align=center >
		<c:choose>
			<c:when test="${ empty myStayCartList }">
				<tr>
					<td colspan=8 class="fixed"><strong>장바구니에 상품이 없습니다.</strong></td>
				</tr>
			</c:when>
			<c:otherwise>       
				<div name="frm_order_all_cartStay">
					<c:forEach var="item" items="${myGoodsList}" varStatus="cnt">
						<tr>
							<c:set var="cart_stay_room_number" value="${myStayCartList[cnt.count-1].cart_stay_room_number}" />
							<c:set var="cart_stay_id" value="${myStayCartList[cnt.count-1].cart_stay_id}" />
							<!-- 체크박스 -->
							<td>
								<input type="checkbox" id="checked_goods_stay" name="checked_goods_stay" checked value="${myStayCartList[cnt.count-1].cart_stay_id }" onClick="calcGoodsPrice(${item.goods_stay_sales_price },this,${item.goods_stay_id },${item.goods_stay_sales_price*0.9 },${cnt.count-1 })">
							</td>
							<%-- <td class="goods_image">
								<a href="${contextPath}/goodsStayDetail.do?goods_stay_id=${item.goods_stay_id }">
									<img width="75" alt="" src="${contextPath}/thumbnails.do?goods_stay_id=${item.goods_stay_id}&fileName=${item.goods_stay_fileName}"  />
								</a>
							</td> --%>
							<td>
								<a href="${contextPath}/goodsStayDetail.do?goods_stay_id=${item.goods_stay_id }">${item.goods_stay_name }</a>
							</td>
							<td class="price">
								<span id="goods_stay_sort">${item.goods_stay_sort }</span>
							</td>
							<td>
								<span id="startD">${startDate }</span>
							</td>
							<td>
								<span id="endD">${endDate }</span>
							</td>
							<td>
								<span id="cart_stay_room_number">${cart_stay_room_number}</span>
								<%-- <input type="text" id="cart_stay_room_number" name="cart_stay_room_number" size=3 value="${cart_stay_room_number}"><br>
									<a href="javascript:modify_cart_qty(${item.goods_stay_id },${item.goods_stay_sales_price*0.9 },${cnt.count-1 });" >
									<img width=25 alt=""  src="${contextPath}/resources/image/btn_modify_qty.jpg">
								</a> --%>
							</td>
							<td>
								<strong>
									<fmt:formatNumber  value="${item.goods_stay_price*cart_stay_room_number*diffDays}" type="number" var="total_sales_price" />
									${total_sales_price}원
								</strong> 
							</td>
							<td>
								<a href="javascript:delete_cart_goodsStay('${cart_stay_id}');">삭제하기</a>
								<form method="post" name="getEachStayData" action="${contextPath }/order/orderEachGoodsStay.do">
								  	<input type="hidden" name="goods_stay_id" value="${item.goods_stay_id }">
								  	<input type="hidden" name="isLogOn" value="${isLogOn}" />
								  	<input type="hidden" name="startD" value="${startDate}">
				  					<input type="hidden" name="endD" value="${endDate }">
				  					<input type="hidden" name="cart_stay_room_number" value="${cart_stay_room_number }">
								  	<input type="button" name="stayPay_button" value="결제하기" class="subm4" onclick="getDateforOrder('${cnt.count-1}'); onStayPayButtonClick('${cnt.count-1}')">
								</form>
							</td>
							<c:set  var="totalGoodsStayPrice" value="${totalGoodsStayPrice+item.goods_stay_price*cart_stay_room_number*diffDays }" />
							<c:set  var="finalGoodsStayPrice" value="${totalGoodsStayPrice-totalStayDiscountedPrice}" />
							<c:set  var="totalStayDiscountedPrice" value="${totalStayDiscountedPrice}" /><!-- +((item.goods_stay_price-(item.goods_stay_price*0.9))*cart_stay_room_number) -->
							<c:set  var="totalGoodsStayNum" value="${totalGoodsStayNum+1 }" />
						</tr>
					</c:forEach>
				</div>
		    </c:otherwise>
		</c:choose> 
	</tbody>
</table><br>

<table class="list_view2" style="display: none;">
	<tbody>
		<tr align=center  class="fixed" style="color:white;">
			<td class="fixed">총 상품수</td>
			<td>총 상품금액</td>
			<td>  </td>
			<!-- <td>총 배송비</td> -->
			<td>  </td>
			<td>총 할인 금액 </td>
			<td>  </td>
			<td>최종 결제금액</td>
		</tr>
		<tr cellpadding=40  align=center class="fixed">
			<td class="fixed" id="">
				<p id="p_totalGoodsStayNum">${totalGoodsStayNum}개 </p>
				<input id="h_totalGoodsStayNum"type="hidden" value="${totalGoodsStayNum}"  />
			</td>
			<td>
				<p id="p_totalGoodsStayPrice">
					<fmt:formatNumber  value="${totalGoodsStayPrice}" type="number" var="total_goods_price" />
					${total_goods_price}원
				</p>
				<input id="h_totalGoodsStayPrice"type="hidden" value="${totalGoodsStayPrice}" />
			</td>
			<%-- <td> 
				<img width="25" alt="" src="${contextPath}/resources/image/plus.jpg">  
			</td> --%>
			<td></td>
			<%-- <td>
				<p id="p_totalDeliveryPrice">${totalDeliveryPrice }원 </p>
				<input id="h_totalDeliveryPrice"type="hidden" value="${totalDeliveryPrice}" />
			</td> --%>
			<%-- <td> 
				<img width="25" alt="" src="${contextPath}/resources/image/minus.jpg"> 
			</td> --%>
			<td></td>
			<td>  
				<p id="p_totalSalesPrice">
					<fmt:formatNumber value="${totalStayDiscountedPrice}" type="number" var="total_sales_Price" />
					${totalStayDiscountedPrice}원 
				</p>
				<input id="h_totalSalesPrice"type="hidden" value="${totalStayDiscountedPrice}" />
			</td>
			<%-- <td>  
				<img width="25" alt="" src="${contextPath}/resources/image/equal.jpg">
			</td> --%>
			<td></td>
			<td>
				<p id="p_final_totalPrice">
					<fmt:formatNumber value="${totalGoodsStayPrice-totalStayDiscountedPrice}" type="number" var="total_price" />
					${totalGoodsStayPrice-totalStayDiscountedPrice}원 
				</p>
				<input id="h_final_totalPrice" type="hidden" value="${totalGoodsStayPrice-totalStayDiscountedPrice}" />
			</td>
		</tr>
	</tbody>
</table><br>

<div>
	<h4 class="h4Title">2. 항공 찜목록</h4>
	<table class="list_view"  border=1>
		<thead align=center>
		<tr style="background:#87c1e9">
			<td class="fixed">구분</td>
			<td class="fixed">항공사명</td> <!-- colspan=2 -->
			<td>항공편명</td>
			<td>출발시간</td>
			<td>도착시간</td>
			<td>출발공항</td>
			<td>도착공항</td>
			<td>일반석운임</td>
			<td>인원</td>
			<td>결제/삭제</td>
		</tr>
		</thead>
		<tbody align=center >
			<c:choose>
				<c:when test="${ empty myAirCartList }">
					<tr>
						<td colspan=10 class="fixed"><strong>장바구니에 상품이 없습니다.</strong></td>
					</tr>
				</c:when>
				<c:otherwise>
					<form name="frm_order_all_cartAir">
						<c:forEach var="item" items="${myAirCartList }" varStatus="cnt">
					       <c:set var="cart_goods_qtyAir" value="${myAirCartList[cnt.count-1].cart_air_qty_people}" />
					       <c:set var="cart_idAir" value="${myAirCartList[cnt.count-1].cart_air_id}" />
							<tr>
								<!-- 체크박스 -->
								<td>
									<input type="checkbox" id="checked_goods_air" name="checked_goods_air" value="${item.cart_air_id}" checked>
								</td>
								<td><span>${item.cart_airlineNm }</span></td>
								<td><span>${item.cart_vihicleId }</span></td>
								<td><span>${item.cart_depPlandTime }</span></td>
								<td><span>${item.cart_arrPlandTime }</span></td>
								<td><span>${item.cart_depAirportNm }</span></td>
								<td><span>${item.cart_arrAirportNm }</span></td>
								<td><span>${item.cart_economyCharge }원</span></td>
								<td>
									<span>${item.cart_air_qty_people }명</span>
									<input type="text" id="cart_goods_qtyAir" name="cart_goods_qtyAir" style="display:none" value="${item.cart_air_qty_people}"><br>
								</td>
								<td>
									<a href="javascript:delete_cart_goodsAir('${item.cart_air_id}');">삭제하기</a>
									<input type="button" value="결제하기">
								</td>
							</tr>
						</c:forEach>
					</form>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div><br>

<table class="list_view2" style="display: none;">
	<tbody>
		<tr align=center  class="fixed" style="color:white;">
			<td class="fixed">총 상품수</td>
			<td>총 상품금액</td>
			<td>  </td>
			<!-- <td>총 배송비</td> -->
			<td>  </td>
			<td>총 할인 금액 </td>
			<td>  </td>
			<td>최종 결제금액</td>
		</tr>
		<tr cellpadding=40  align=center class="fixed">
			<td class="fixed" id="">
				<p id="p_totalGoodsStayNum">${totalGoodsStayNum}개 </p>
				<input id="h_totalGoodsStayNum"type="hidden" value="${totalGoodsStayNum}"  />
			</td>
			<td>
				<p id="p_totalGoodsStayPrice">
					<fmt:formatNumber  value="${totalGoodsStayPrice}" type="number" var="total_goods_price" />
					${total_goods_price}원
				</p>
				<input id="h_totalGoodsStayPrice"type="hidden" value="${totalGoodsStayPrice}" />
			</td>
			<%-- <td> 
				<img width="25" alt="" src="${contextPath}/resources/image/plus.jpg">  
			</td> --%>
			<td></td>
			<%-- <td>
				<p id="p_totalDeliveryPrice">${totalDeliveryPrice }원 </p>
				<input id="h_totalDeliveryPrice"type="hidden" value="${totalDeliveryPrice}" />
			</td> --%>
			<%-- <td> 
				<img width="25" alt="" src="${contextPath}/resources/image/minus.jpg"> 
			</td> --%>
			<td></td>
			<td>  
				<p id="p_totalSalesPrice">
					<fmt:formatNumber value="${totalStayDiscountedPrice}" type="number" var="total_sales_Price" />
					${totalStayDiscountedPrice}원 </p>
				<input id="h_totalSalesPrice"type="hidden" value="${totalStayDiscountedPrice}" />
			</td>
			<%-- <td>  
				<img width="25" alt="" src="${contextPath}/resources/image/equal.jpg">
			</td> --%>
			<td></td>
			<td>
				<p id="p_final_totalPrice">
					<fmt:formatNumber value="${totalGoodsStayPrice-totalStayDiscountedPrice}" type="number" var="total_price" />
					${totalGoodsStayPrice-totalStayDiscountedPrice}원 
				</p>
				<input id="h_final_totalPrice" type="hidden" value="${totalGoodsStayPrice-totalStayDiscountedPrice}" />
			</td>
		</tr>
	</tbody>
</table><br><br>

<div id="cartBtnDiv">
	<input name="btn_order_all_cart_goods" type="button" onClick="fn_order_all_cart_goodsAir()" value="모든 항공편 결제하기" class="subm3">
</div>




<br>
<%-- <a href="${contextPath }/main.do">메인으로</a>
<table style="display: none">
	<tr>
		<td>
			<form action="${contextPath }/main.do">
				<input type="submit" value="메인화면으로">
			</form>
		</td>
		<td>
			<a href="javascript:check_box_all_buy();">테스트</a>
			<form action="">
				<input type="submit" value="선택한 상품 삭제">
			</form>
		</td>
		<td>
			<form action="">
				<input type="submit" value="선택한 상품 결제">
			</form>
		</td>
	</tr>
</table> --%>

<form id="myForm" method="post" action="${contextPath }/test0404.do">
  <input type="hidden" name="stay_values" value="">
  <input type="hidden" name="air_values" value="">
</form>

</body>
</html>