<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.net.URLEncoder, java.net.URLDecoder" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!-- ///////////////주문 -->
<c:set var="myCartList" 	value="${cartMap.myCartList}"  />
<c:set var="myGoodsList" 	value="${cartMap.myGoodsList}"  />
<c:set var="myGoodsList"	value="${cartMap.myGoodsList}"  />
<c:set var="goodsStayVOEach" value="${goodsStayMap.goodsStayVO}"  />

<c:set var="myStayCartList"  value="${cartStayMap.myStayCartList}"  />
<c:set var="myGoodsList"  value="${cartStayMap.myGoodsList }"  />
<c:set var="myAirCartList"  value="${cartAirMap.myAirCartList }"  />

<%!  public static String flagRnM = "init"; %>
<c:set var="final_total_order_price" value="${final_total_order_price }" />		<!-- 최종 결제 금액 -->
<c:if test="${flagAirStay == 'airRnM'}">
    <c:set var="total_order_priceGo" value="${orderAirRnMMap.prestigeCharge1 }" />	<!-- 왕복다구간 1 금액 -->
	<c:set var="total_order_priceBack" value="${orderAirRnMMap.prestigeCharge2 }" /> <!-- 왕복다구간 2 금액 -->
</c:if>
<c:set var="total_order_price" value="0" />			<!-- 총주문 금액 -->

<c:set var="mem_point" value="1000" /> 				<!-- 회원의 포인트 -->

<head>
<link href="${contextPath}/resources/css/orderGoodsForm.css" rel="stylesheet" type="text/css" media="screen">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jquery쓰기위해 필요 -->
<script>
window.onload=function() {
  init();
  console.log("flagRnM ->" + flagRnM);
  console.log("flagAirStay ->" + flagAirStay);
}
// 편도인지 왕복/다구간인지 확인하는 flag 상태
let flagAirStay = '<%= request.getAttribute("flagAirStay") %>';
let flagRnM = '<%= flagRnM %>';
//일반석 선택시
function select_economy() {
	const economyBtn = document.querySelector('#economyBtn');	// 일반석 선택 버튼
	const businessBtn = document.querySelector('#businessBtn');	// 비즈니스 선택 버튼
	const economyDiv = document.querySelector('#economyDiv');	// 일반석 가격
	const businessDiv = document.querySelector('#businessDiv');	// 비즈니스 가격
	const br = document.querySelector('#brDiv');	// 비즈니스 위치조정 br태그
	const p_totalPrice = document.querySelector('#p_totalPrice');	// 총 상품 금액
	const h_totalPrice = document.querySelector('#h_totalPrice');	// 총 상품 금액
	const p_final_totalPrice = document.querySelector('#p_final_totalPrice');	// 최종 결제 금액
	const h_final_total_Price = document.querySelector('#h_final_total_Price');	// p_final_totalPrice
	const p_totalSalesPrice = document.querySelector('#p_totalSalesPrice');	// 총 할인금액
	const h_total_sales_price = document.querySelector('#h_total_sales_price');	// 총 할인금액	
	const h_point = document.querySelector('#h_point');	// 포인트 저장
	const h_coupon = document.querySelector('#h_coupon');	// 쿠폰 저장
	const chargeAnnounce = document.querySelector('#chargeAnnounce');	// 총 상품 금액
	//chargeAnnounce.style.display ='none';
	const GOValueRealTime = document.querySelector('#GOValueRealTime');	
	const BACKValueRealTime = document.querySelector('#BACKValueRealTime');	
	const TOTALValueRealTime = document.querySelector('#TOTALValueRealTime');	

	//할인리셋
	p_totalSalesPrice.textContent = "0원";
	h_total_sales_price.value = "0";
	h_point.textContent = "0";
	h_coupon.textContent = "0";

	//console.log("economy flagRnM : " + flagRnM);
	//console.log("select_economy airRnM 초기값 : " + ${total_order_priceGo} + ", "+ ${total_order_priceBack} );
	
	if (flagAirStay === 'air') {
		  br.style.display = 'none';
		  economyBtn.style.display ='none';
		  businessBtn.style.display ='block';
		  businessBtn.style.cssText ='text-align: center; width: 130px;';
		  businessBtn.value ='비즈니스석으로 변경';
		  economyDiv.style.display ='block';
		  businessDiv.style.display ='none';
		  
		  final_total_order_price = ${airEachDataMap.economyCharge* airEachDataMap.qty};	//<c:set var="final_total_order_price" 	value="${airEachDataMap.economyCharge* airEachDataMap.qty}" />
		  total_order_price = ${airEachDataMap.economyCharge* airEachDataMap.qty};			//<c:set var="total_order_price" 		value="${airEachDataMap.economyCharge* airEachDataMap.qty}" />
		  
		  console.log("total_order_price : " + ${total_order_price }+ ", final_total_order_price : " + ${final_total_order_price });
		  p_totalPrice.textContent = ${total_order_price };
		  h_totalPrice.value = ${total_order_price };
		  p_final_totalPrice.textContent = ${total_order_price};
		  h_final_total_Price.value = ${total_order_price};

	  } else if (flagAirStay === 'airRnM' && (flagRnM !== "init")) {
		  console.log("들어옴 airRnM");
			const economyBtn2 = document.querySelector('#economyBtn2');	// 일반석 선택 버튼
			const businessBtn2 = document.querySelector('#businessBtn2');	// 비즈니스 선택 버튼
			const economyDiv2 = document.querySelector('#economyDiv2');	// 일반석 가격
			const businessDiv2 = document.querySelector('#businessDiv2');	// 비즈니스 가격
			const br2 = document.querySelector('#brDiv2');	// 비즈니스 위치조정 br태그
			console.log("    airRnM 처음");
			console.log("flagRnM : " + flagRnM);
			if (flagRnM === "first") {
				br.style.display = 'none';
				economyBtn.style.display ='none';
				businessBtn.style.display ='block';
				businessBtn.style.cssText ='text-align: center; width: 130px;';
				businessBtn.value ='비즈니스석으로 변경';
				economyDiv.style.display ='block';
				businessDiv.style.display ='none';
// 				if(${total_order_priceBack} === 0 && ${orderAirRnMMap.prestigeCharge2 ne '0' }) {
// 					<c:set var="total_order_priceBack" 		value="${orderAirRnMMap.economyCharge2 }" />
// 				}
				<c:set var="total_order_priceGo" 		value="0" />
			    <c:set var="total_order_priceGo" 		value="${orderAirRnMMap.economyCharge1 }" />

		    	GOValueRealTime.value =  ${total_order_priceGo};
		    	var temp = BACKValueRealTime.textContent;
		    	if(${total_order_priceBack} != temp) {
		    		<c:set var="total_order_priceBack" 		value="${orderAirRnMMap.prestigeCharge2}" />
		    	}
			    <c:set var="total_order_price" 			value="${(total_order_priceGo + total_order_priceBack)*orderAirRnMMap.qty }" />
			    <c:set var="final_total_order_price" 	value="${(total_order_priceGo + total_order_priceBack)*orderAirRnMMap.qty }" />
				console.log(" economy first Go and Back : " + ${total_order_priceGo} + ", "+ ${total_order_priceBack} );
		    	console.log("total_order_price : " + ${total_order_price }+ ", final_total_order_price : " + ${final_total_order_price });

				TOTALValueRealTime.value = (Number(GOValueRealTime.value) + Number(BACKValueRealTime.value)) * ${orderAirRnMMap.qty};
				p_totalPrice.textContent = TOTALValueRealTime.value;
				h_totalPrice.value = TOTALValueRealTime.value;
				p_final_totalPrice.textContent = TOTALValueRealTime.value;
				h_final_total_Price.value = TOTALValueRealTime.value;
			   	 	
			} else if (flagRnM === "second") { 
				br2.style.display = 'none';
				economyBtn2.style.display ='none';
				businessBtn2.style.display ='block';
				businessBtn2.style.cssText ='text-align: center; width: 130px;';
				businessBtn2.value ='비즈니스석으로 변경';
				economyDiv2.style.display ='block';
				businessDiv2.style.display ='none';

				<c:set var="total_order_priceBack" 		value="0" />
				<c:set var="total_order_priceBack" 		value="${orderAirRnMMap.economyCharge2 }" />
					BACKValueRealTime.value = ${total_order_priceBack};
			    	if(${total_order_priceGo} != temp) {
			    		<c:set var="total_order_priceGo" 		value="${orderAirRnMMap.prestigeCharge1}" />
			    	}
			    <c:set var="total_order_price" 			value="${(total_order_priceGo + total_order_priceBack)*orderAirRnMMap.qty }" />
			    <c:set var="final_total_order_price" 	value="${(total_order_priceGo + total_order_priceBack)*orderAirRnMMap.qty }" />
					console.log(" economy second Go and Back : " + ${total_order_priceGo} + ", "+ ${total_order_priceBack} );
					console.log("total_order_price : " + ${total_order_price }+ ", final_total_order_price : " + ${final_total_order_price });

					TOTALValueRealTime.value = (Number(GOValueRealTime.value) + Number(BACKValueRealTime.value)) * ${orderAirRnMMap.qty};
					p_totalPrice.textContent = TOTALValueRealTime.value;
					h_totalPrice.value = TOTALValueRealTime.value;
					p_final_totalPrice.textContent = TOTALValueRealTime.value;
					h_final_total_Price.value = TOTALValueRealTime.value;
			}
			console.log("    airRnM 마지막");
	  }
	  p_final_totalPrice.style.cssText ='font-size: 48px';
}
// 비즈니스석 선택시
function select_business() {
	const economyBtn = document.querySelector('#economyBtn');	// 일반석 선택 버튼
	const businessBtn = document.querySelector('#businessBtn');	// 비즈니스 선택 버튼
	const economyDiv = document.querySelector('#economyDiv');	// 일반석 가격
	const businessDiv = document.querySelector('#businessDiv');	// 비즈니스 가격
	const br = document.querySelector('#brDiv');	// 비즈니스 위치조정 br태그
	const p_totalPrice = document.querySelector('#p_totalPrice');	// 총 상품 금액
	const h_totalPrice = document.querySelector('#h_totalPrice');	// 총 상품 금액
	const p_final_totalPrice = document.querySelector('#p_final_totalPrice');	// 최종 결제 금액
	const h_final_total_Price = document.querySelector('#h_final_total_Price');	// p_final_totalPrice
	const p_totalSalesPrice = document.querySelector('#p_totalSalesPrice');	// 총 할인금액
	const h_total_sales_price = document.querySelector('#h_total_sales_price');	// 총 할인금액
	const h_point = document.querySelector('#h_point');	// 포인트 저장
	const h_coupon = document.querySelector('#h_coupon');	// 쿠폰 저장
	const chargeAnnounce = document.querySelector('#chargeAnnounce');	// 총 상품 금액
	//chargeAnnounce.style.display ='none';
	const GOValueRealTime = document.querySelector('#GOValueRealTime');	
	const BACKValueRealTime = document.querySelector('#BACKValueRealTime');	
	const TOTALValueRealTime = document.querySelector('#TOTALValueRealTime');	
	
	//할인리셋
	p_totalSalesPrice.textContent = "0원";
	h_total_sales_price.value = "0";
	h_point.textContent = "0";
	h_coupon.textContent = "0";
	
	console.log("business flagRnM : " + flagRnM);
	console.log("select_business airRnM 초기값 : " + ${total_order_priceGo} + ", "+ ${total_order_priceBack} );
		
	if (flagAirStay === 'air') {
		//br.style.display = 'none';
		  economyBtn.style.display ='block';
		  businessBtn.style.display ='none';
		  economyBtn.style.cssText ='text-align: center; width: 130px;';
		  economyBtn.value ='일반석으로 변경';
			
		  economyDiv.style.display ='none';
		  businessDiv.style.display ='block';
		  
		  <c:set var="final_total_order_price" 	value="${airEachDataMap.prestigeCharge* airEachDataMap.qty}" />
		  <c:set var="total_order_price" 		value="${airEachDataMap.prestigeCharge* airEachDataMap.qty}" />
		  
		  //console.log("airEachDataMap.prestigeCharge : " + ${airEachDataMap.prestigeCharge});
		  console.log("total_order_price : " + ${total_order_price }+ ", final_total_order_price : " + ${final_total_order_price });
		  p_totalPrice.textContent = ${total_order_price };
		  h_totalPrice.value = ${total_order_price };
		  p_final_totalPrice.textContent = ${total_order_price};
		  h_final_total_Price.value = ${total_order_price};
			
	  } else if (flagAirStay === 'airRnM') {
		  console.log("들어옴 airRnM");
			const economyBtn2 = document.querySelector('#economyBtn2');	// 일반석 선택 버튼
			const businessBtn2 = document.querySelector('#businessBtn2');	// 비즈니스 선택 버튼
			const economyDiv2 = document.querySelector('#economyDiv2');	// 일반석 가격
			const businessDiv2 = document.querySelector('#businessDiv2');	// 비즈니스 가격
			const br2 = document.querySelector('#brDiv2');	// 비즈니스 위치조정 br태그
			console.log("    airRnM 처음");
			console.log("    airRnM 초기값 : " + ${total_order_priceGo} + ", "+ ${total_order_priceBack} );
			
			if (flagRnM === "first") { 
				//br.style.display ='block'; 
				economyBtn.style.display ='block';
				businessBtn.style.display ='none';
				economyBtn.style.cssText ='text-align: center; width: 130px;';
				economyBtn.value ='일반석으로 변경';
				
				economyDiv.style.display ='none';
				businessDiv.style.display ='block';
				
				<c:set var="total_order_priceGo" 		value="0" />
			    <c:set var="total_order_priceGo" 		value="${orderAirRnMMap.prestigeCharge1}" />
			    	GOValueRealTime.value =  ${total_order_priceGo};
			    	var temp = BACKValueRealTime.textContent;
			    	if(${total_order_priceBack} != temp) {
			    		<c:set var="total_order_priceBack" 		value="${orderAirRnMMap.prestigeCharge2}" />
			    	}
			    <c:set var="total_order_price" 			value="${(total_order_priceGo + total_order_priceBack)*orderAirRnMMap.qty }" />
			    <c:set var="final_total_order_price" 	value="${(total_order_priceGo + total_order_priceBack)*orderAirRnMMap.qty }" />
					console.log(" business first Go and Back : " + ${total_order_priceGo} + ", "+ ${total_order_priceBack} );
			    	console.log("total_order_price first : " + ${total_order_price }+ ", final_total_order_price : " + ${final_total_order_price });

					TOTALValueRealTime.value = (Number(GOValueRealTime.value) + Number(BACKValueRealTime.value)) * ${orderAirRnMMap.qty};
					p_totalPrice.textContent = TOTALValueRealTime.value;
					h_totalPrice.value = TOTALValueRealTime.value;
					p_final_totalPrice.textContent = TOTALValueRealTime.value;
					h_final_total_Price.value = TOTALValueRealTime.value;
	  		} else if (flagRnM === "second") {  
				//br2.style.display ='block';
				economyBtn2.style.display ='block';
				businessBtn2.style.display ='none';
				economyBtn2.style.cssText ='text-align: center; width: 130px;';
				economyBtn2.value ='일반석으로 변경';
				
				economyDiv2.style.display ='none';
				businessDiv2.style.display ='block';
// 				if(${total_order_priceGo} === 0 && ${orderAirRnMMap.prestigeCharge1 ne '0' }) {
// 					<c:set var="total_order_priceGo" 		value="${orderAirRnMMap.economyCharge1}" />
// 				}
				<c:set var="total_order_priceBack" 		value="0" />
				<c:set var="total_order_priceBack" 		value="${orderAirRnMMap.prestigeCharge2}" />
					BACKValueRealTime.value = ${total_order_priceBack};
			    	var temp = GOValueRealTime.textContent;
			    	if(${total_order_priceGo} != temp) {
			    		<c:set var="total_order_priceGo" 		value="${orderAirRnMMap.prestigeCharge1}" />
			    	}
			    <c:set var="total_order_price" 			value="${(total_order_priceGo + total_order_priceBack)*orderAirRnMMap.qty }" />
			    <c:set var="final_total_order_price" 	value="${(total_order_priceGo + total_order_priceBack)*orderAirRnMMap.qty }" />
					console.log(" business first Go and Back : " + ${total_order_priceGo} + ", "+ ${total_order_priceBack} );
					console.log("total_order_price second : " + ${total_order_price }+ ", final_total_order_price : " + ${final_total_order_price });

					TOTALValueRealTime.value = (Number(GOValueRealTime.value) + Number(BACKValueRealTime.value)) * ${orderAirRnMMap.qty};
					p_totalPrice.textContent = TOTALValueRealTime.value;
					h_totalPrice.value = TOTALValueRealTime.value;
					p_final_totalPrice.textContent = TOTALValueRealTime.value;
					h_final_total_Price.value = TOTALValueRealTime.value;
// 				p_totalPrice.textContent = ${total_order_price };
// 				h_totalPrice.value = ${total_order_price };
// 				p_final_totalPrice.textContent = ${total_order_price};
// 				h_final_total_Price.value = ${total_order_price};
	  		}
			console.log("     airRnM 마지막");
	  }
	  p_final_totalPrice.style.cssText ='font-size: 48px';
}
// 포인트 값 입력되면 모두사용하기 체크박스 풀기
document.addEventListener(`DOMContentLoaded`, () => {
	const pointInput = document.querySelector("#pointInput");
	const pointUseAll = document.querySelector('#pointUseAll');	// 포인트 모두 사용하기
	
	pointInput.addEventListener("input", function(e) {
	    console.log("포인트 입력중...", e.target.value); // 값이 바뀔때마다 찍힘
	    pointUseAll.checked=false;
	})
	
	flagAirStay = '<%= request.getAttribute("flagAirStay") %>';
	// 편도인지 왕복/다구간인지 확인하는 flag 상태
	console.log("flagAirStay 플래그 : " + flagAirStay);
})
// 할인 : 포인트 적용하기
function pointApply() {
	const p_totalSalesPrice = document.querySelector('#p_totalSalesPrice');	// 총 할인금액
	const h_total_sales_price = document.querySelector('#h_total_sales_price');	// 총 할인금액
	const pointInput = document.querySelector('#pointInput');	// 포인트 입력 input 태그
	const pointUseAll = document.querySelector('#pointUseAll');	// 포인트 모두 사용하기
	const h_point = document.querySelector('#h_point');	// 포인트 저장
	const h_coupon = document.querySelector('#h_coupon');	// 쿠폰 저장
	const h_totalPrice = document.querySelector('#h_totalPrice');	// h_totalPrice
	const p_final_totalPrice = document.querySelector('#p_final_totalPrice');	// 최종 결제 금액
	const h_final_total_Price = document.querySelector('#h_final_total_Price');	// p_final_totalPrice
	
	var totalPoint = 0;
	var pointAll = 0;
	var pointIn = 0;
	
	if (pointUseAll.checked) {	// 포인트 모두사용하기
  		pointAll = ${mem_point};
  		console.log("pointAll : " + pointAll);
    } else {	// 포인트 직접 입력
    	pointAll = 0;
  		console.log("pointAll : " + pointAll);
  		
  		console.log("포인트 입력값 : " + pointInput.value);
  	  	if (pointInput.value > ${mem_point}) {	// 포인트 입력이 보유 금액보다 많을 때 -> 다시 입력
  	  		alert("보유한 포인트는 " + ${mem_point} + "원 입니다. 포인트를 다시 입력해주세요. ");
  	  		pointInput.value = 0;
  	  	} else {	// 적정 금액 입력이거나 비어있을 때
	  	  	if( pointInput.value == "" ){	// 모두사용하기x, 포인트 입력 칸이 비어있으면 사용 포인트 : 0
	  	  	  	console.log("포인트 사용 안함");
	  	  	} else {	// 포인트 입력 칸이 비어있지 않으면
	  	  		pointIn = pointInput.value; 
	  	  		console.log("사용할 포인트 : " + pointIn);
	  	  	}
  	  	}
    } 
	totalPoint = Number(pointAll) + Number(pointIn);
  	
	h_point.textContent = totalPoint;
	console.log("총 할인금액 : " + totalPoint);
			
	p_totalSalesPrice.textContent = Number(totalPoint) + Number(h_coupon.textContent);
	p_totalSalesPrice.textContent += "원";
	h_total_sales_price.value = Number(totalPoint) + Number(h_coupon.textContent);
	console.log("h_total_sales_price.value" + h_total_sales_price.value);
	console.log("total_order_price " + ${total_order_price });
	
	p_final_totalPrice.textContent = Number(h_totalPrice.value) - Number(h_total_sales_price.value);
	h_final_total_Price.value = Number(h_totalPrice.value) - Number(h_total_sales_price.value);
	p_final_totalPrice.style.cssText ='font-size: 48px';
}
// 할인 : 쿠폰 적용하기
function couponApply() {
	const p_totalSalesPrice = document.querySelector('#p_totalSalesPrice');	// 총 할인금액
	const h_total_sales_price = document.querySelector('#h_total_sales_price');	// 총 할인금액
	var couponSelect  = document.getElementById("couponSelect");
	var value = (couponSelect.options[couponSelect.selectedIndex].value);
	const h_point = document.querySelector('#h_point');	// 포인트 저장
	const h_coupon = document.querySelector('#h_coupon');	// 쿠폰 저장
	const h_totalPrice = document.querySelector('#h_totalPrice');	// h_totalPrice
	const p_final_totalPrice = document.querySelector('#p_final_totalPrice');	// 최종 결제 금액
	const h_final_total_Price = document.querySelector('#h_final_total_Price');	// p_final_totalPrice
	
	var totalCoupon = 0;
	if (Number(h_coupon.value) >= 0) {
		
	}
	console.log("value : " + value);
	totalCoupon = Number(h_totalPrice.value) * Number(value);
  	console.log("+++총 쿠폰 사용 금액 : " + totalCoupon);
  	
  	h_coupon.textContent = totalCoupon;
	console.log("총 할인금액 : " + totalCoupon);
	
	p_totalSalesPrice.textContent = Number(totalCoupon) + Number(h_point.textContent);
	p_totalSalesPrice.textContent += "원";
	h_total_sales_price.value = Number(totalCoupon) + Number(h_point.textContent);
	console.log("h_total_sales_price.value" + h_total_sales_price.value);
	
	p_final_totalPrice.textContent = Number(h_totalPrice.value) - Number(h_total_sales_price.value);
	h_final_total_Price.value = Number(h_totalPrice.value) - Number(h_total_sales_price.value);
	p_final_totalPrice.style.cssText ='font-size: 48px';
}
// 결제수단~
function init() {
	var form_order=document.form_order;
}    
function fn_pay_phone(){
	var e_card=document.getElementById("tr_pay_card");
	var e_phone=document.getElementById("tr_pay_phone");
	e_card.style.visibility="hidden";
	e_phone.style.visibility="visible";
}
function fn_pay_card(){
	var e_card=document.getElementById("tr_pay_card");
	var e_phone=document.getElementById("tr_pay_phone");
	e_card.style.visibility="visible";
	e_phone.style.visibility="hidden";
}
function imagePopup(type) {
	if (type == 'open') {
		// 팝업창을 연다.
		jQuery('#layer').attr('style', 'visibility:visible');
		// 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
		jQuery('#layer').height(jQuery(document).height());
	} else if (type == 'close') {
		// 팝업창을 닫는다.
		jQuery('#layer').attr('style', 'visibility:hidden');
	}
}
	var orderer_name;
	var hp1;
	var hp2;
	var hp3;
	
	var tel1;
	var tel2;
	var tel3;
	
	var pay_method;
	var card_com_name;
	var card_pay_month;
	var pay_orderer_hp_num;
	var air_order_ChargeS;
	var stay_order_ChargeS;
	
function fn_show_order_detail(){
	var frm=document.form_order;
	
	// 이미지 관련 (이미지가 없는 상태이므로 주석)
	/* if(h_goods_fileName.length <2 ||h_goods_fileName.length==null){
		goods_fileName+=h_goods_fileName.value;
	}else{
		for(var i=0; i<h_goods_fileName.length;i++){
			goods_fileName+=h_goods_fileName[i].value+"<br>";
		}	
	} */
		
	var r_pay_method = frm.pay_method;
	
	for(var i=0; i<r_pay_method.length;i++){
	  if(r_pay_method[i].checked==true){
		  pay_method=r_pay_method[i].value;
		  if(pay_method=="신용카드"){
			var i_card_com_name=document.getElementById("card_com_name");
			var i_card_pay_month=document.getElementById("card_pay_month");
			card_com_name=i_card_com_name.value;
			card_pay_month=i_card_pay_month.value;
			pay_method+="<Br>"+
				 		"카드사:"+card_com_name+"<br>"+
				 		"할부개월수:"+card_pay_month;
			pay_orderer_hp_num="해당없음";
			
		  }else if(pay_method=="휴대폰결제"){
			var i_pay_order_tel1=document.getElementById("pay_order_tel1");
			var i_pay_order_tel2=document.getElementById("pay_order_tel2");
			var i_pay_order_tel3=document.getElementById("pay_order_tel3");
			pay_orderer_hp_num=i_pay_order_tel1.value+"-"+
						   	    i_pay_order_tel2.value+"-"+
							    i_pay_order_tel3.value;
			pay_method+="<Br>"+"결제휴대폰번호:"+pay_orderer_hp_num;
			card_com_name="해당없음";
			card_pay_month="해당없음";
		  } //end if
		 break;
	  }// end for
	}
	
	var i_hp1=document.getElementById("hp1");
	var i_hp2=document.getElementById("hp2");
	var i_hp3=document.getElementById("hp3");
	
	var i_tel1=document.getElementById("tel1");
	var i_tel2=document.getElementById("tel2");
	var i_tel3=document.getElementById("tel3");
	
	var i_pay_method=document.getElementById("pay_method");
	
	//RnM 합쳐야합니다!!!!
	order_goods_qty="${orderAirRnMMap.qty }";
// 	order_goods_qty="${airEachDataMap.qty }";
	
	orderer_name="${orderer.mem_name}";
	hp1="${orderer.mem_tel1}";
	hp2="${orderer.mem_tel2}";
	hp3="${orderer.mem_tel3}";
	
	tel1="${orderer.mem_tel1}";
	tel2="${orderer.mem_tel2}";
	tel3="${orderer.mem_tel3}";
	
	var p_flightName=document.getElementById("p_flightName");
	var p_airlineName=document.getElementById("p_airlineName");
	var p_departureAirport=document.getElementById("p_departureAirport");
	var p_departureTime=document.getElementById("p_departureTime");
	var p_arrivalAirport=document.getElementById("p_arrivalAirport");
	var p_arrivalTime=document.getElementById("p_arrivalTime");
	var p_total_order_goods_price=document.getElementById("p_total_order_goods_price");
	var p_orderer_name=document.getElementById("p_orderer_name");
	var p_pay_method=document.getElementById("p_pay_method");
	//RnM 합쳐야합니다!!!!
	var p_flightName2=document.getElementById("p_flightName2");
	var p_airlineName2=document.getElementById("p_airlineName2");
	var p_departureAirport2=document.getElementById("p_departureAirport2");
	var p_departureTime2=document.getElementById("p_departureTime2");
	var p_arrivalAirport2=document.getElementById("p_arrivalAirport2");
	var p_arrivalTime2=document.getElementById("p_arrivalTime2");
	//여기까지RnM 합쳐야합니다!!!!
	
	p_flightName.textContent="${orderAirRnMMap.flightName1 }";
	p_airlineName.innerHTML="${orderAirRnMMap.airlineName1 }";
	p_departureAirport.innerHTML="${orderAirRnMMap.departureAirport1 }";
	p_departureTime.innerHTML="${orderAirRnMMap.departureTime1 }";
	p_arrivalAirport.innerHTML="${orderAirRnMMap.arrivalAirport1 }";
	p_arrivalTime.innerHTML="${orderAirRnMMap.arrivalTime1 }";
	p_total_order_goods_price.innerHTML=document.getElementById("h_final_total_Price").value;
	p_orderer_name.innerHTML="${orderer.mem_name}";
	p_pay_method.innerHTML=pay_method;
	//RnM 합쳐야합니다!!!!
	p_flightName2.textContent="${orderAirRnMMap.flightName2 }";
	p_airlineName2.innerHTML="${orderAirRnMMap.airlineName2 }";
	p_departureAirport2.innerHTML="${orderAirRnMMap.departureAirport2 }";
	p_departureTime2.innerHTML="${orderAirRnMMap.departureTime2 }";
	p_arrivalAirport2.innerHTML="${orderAirRnMMap.arrivalAirport2 }";
	p_arrivalTime2.innerHTML="${orderAirRnMMap.arrivalTime2 }";
	//여기까지RnM 합쳐야합니다!!!!
	
	imagePopup('open');
}

function fn_show_order_detail_stay(){
	var frm=document.form_order;
		
	var r_pay_method = frm.pay_method;
	
	for(var i=0; i<r_pay_method.length;i++){
	  if(r_pay_method[i].checked==true){
		  pay_method=r_pay_method[i].value;
		  if(pay_method=="신용카드"){
			var i_card_com_name=document.getElementById("card_com_name");
			var i_card_pay_month=document.getElementById("card_pay_month");
			card_com_name=i_card_com_name.value;
			card_pay_month=i_card_pay_month.value;
			pay_method+="<Br>"+
				 		"카드사:"+card_com_name+"<br>"+
				 		"할부개월수:"+card_pay_month;
			pay_orderer_hp_num="해당없음";
			
		  }else if(pay_method=="휴대폰결제"){
			var i_pay_order_tel1=document.getElementById("pay_order_tel1");
			var i_pay_order_tel2=document.getElementById("pay_order_tel2");
			var i_pay_order_tel3=document.getElementById("pay_order_tel3");
			pay_orderer_hp_num=i_pay_order_tel1.value+"-"+
						   	    i_pay_order_tel2.value+"-"+
							    i_pay_order_tel3.value;
			pay_method+="<Br>"+"결제휴대폰번호:"+pay_orderer_hp_num;
			card_com_name="해당없음";
			card_pay_month="해당없음";
		  } //end if
		 break;
	  }// end for
	}
	
	var i_hp1=document.getElementById("hp1");
	var i_hp2=document.getElementById("hp2");
	var i_hp3=document.getElementById("hp3");
	
	var i_tel1=document.getElementById("tel1");
	var i_tel2=document.getElementById("tel2");
	var i_tel3=document.getElementById("tel3");
	
	var i_pay_method=document.getElementById("pay_method");
	
	order_goods_qty="${stayDays }";
	
	orderer_name="${orderer.mem_name}";
	hp1="${orderer.mem_tel1}";
	hp2="${orderer.mem_tel2}";
	hp3="${orderer.mem_tel3}";
	
	tel1="${orderer.mem_tel1}";
	tel2="${orderer.mem_tel2}";
	tel3="${orderer.mem_tel3}";
	
	var p_stay_name=document.getElementById("p_stay_name");
	var p_stay_sort=document.getElementById("p_stay_sort");
	var p_stay_address=document.getElementById("p_stay_address");
	var p_stay_admissionDate=document.getElementById("p_stay_admissionDate");
	var p_stay_departureDate=document.getElementById("p_stay_departureDate");
	var p_stay_num_people=document.getElementById("p_stay_num_people");
	var p_total_order_goods_price=document.getElementById("p_total_order_goods_price");
	var p_orderer_name=document.getElementById("p_orderer_name");
	var p_pay_method=document.getElementById("p_pay_method");
	
	p_stay_name.textContent="${goodsStayVOEach.goods_stay_name }";
	p_stay_sort.innerHTML="${goodsStayVOEach.goods_stay_sort }";
	p_stay_address.innerHTML="${goodsStayVOEach.goods_stay_roadAddress }";
	p_stay_admissionDate.innerHTML="${checkInDate }";
	p_stay_departureDate.innerHTML="${checkOutDate }";
	p_stay_num_people.innerHTML="${goodsStayVOEach.goods_stay_num_people }";
	p_total_order_goods_price.innerHTML=document.getElementById("h_final_total_Price").value;
	p_orderer_name.innerHTML="${orderer.mem_name}";
	p_pay_method.innerHTML=pay_method;
	
	imagePopup('open');
}

function fn_process_pay_order(){
	alert("최종 결제하기");
	
	var formObj=document.createElement("form");
	var i_pay_method=document.createElement("input");
	var i_card_com_name=document.createElement("input");
	var i_card_pay_month=document.createElement("input");
	var i_air_order_ChargeSS=document.createElement("input");
	var i_pay_orderer_hp_num=document.createElement("input");
	
	i_pay_method.name="pay_method";
	i_card_com_name.name="card_com_name";
	i_card_pay_month.name="card_pay_month";
	i_air_order_ChargeSS.name="air_order_ChargeSS";
	i_pay_orderer_hp_num.name="pay_orderer_hp_num";
	
	air_order_ChargeS = document.getElementById("p_total_order_goods_price").textContent;

	i_pay_method.value=pay_method;
	i_card_com_name.value=card_com_name;
	i_card_pay_month.value=card_pay_month;
	i_air_order_ChargeSS.value=air_order_ChargeS;
	i_pay_orderer_hp_num.value=pay_orderer_hp_num;
	//여기부터~
	var p_flightName=document.createElement("input");
	var p_airlineName=document.createElement("input");
	var p_departureAirport=document.createElement("input");
	var p_departureTime=document.createElement("input");
	var p_arrivalAirport=document.createElement("input");
	var p_arrivalTime=document.createElement("input");
	var p_flightName2=document.createElement("input");
	var p_airlineName2=document.createElement("input");
	var p_departureAirport2=document.createElement("input");
	var p_departureTime2=document.createElement("input");
	var p_arrivalAirport2=document.createElement("input");
	var p_arrivalTime2=document.createElement("input");
	var qtyqty=document.createElement("input");
	
	p_flightName.name="p_flightName";
	p_airlineName.name="p_airlineName";
	p_departureAirport.name="p_departureAirport";
	p_departureTime.name="p_departureTime";
	p_arrivalAirport.name="p_arrivalAirport";
	p_arrivalTime.name="p_arrivalTime";
	p_flightName2.name="p_flightName2";
	p_airlineName2.name="p_airlineName2";
	p_departureAirport2.name="p_departureAirport2";
	p_departureTime2.name="p_departureTime2";
	p_arrivalAirport2.name="p_arrivalAirport2";
	p_arrivalTime2.name="p_arrivalTime2";
	qtyqty.name="qtyqty";
	
	p_flightName.value="${orderAirRnMMap.flightName1 }";
	p_airlineName.value="${orderAirRnMMap.airlineName1 }";
	p_departureAirport.value="${orderAirRnMMap.departureAirport1 }";
	p_departureTime.value="${orderAirRnMMap.departureTime1 }";
	p_arrivalAirport.value="${orderAirRnMMap.arrivalAirport1 }";
	p_arrivalTime.value="${orderAirRnMMap.arrivalTime1 }";
	p_flightName2.value="${orderAirRnMMap.flightName2 }";
	p_airlineName2.value="${orderAirRnMMap.airlineName2 }";
	p_departureAirport2.value="${orderAirRnMMap.departureAirport2 }";
	p_departureTime2.value="${orderAirRnMMap.departureTime2 }";
	p_arrivalAirport2.value="${orderAirRnMMap.arrivalAirport2 }";
	p_arrivalTime2.value="${orderAirRnMMap.arrivalTime2 }";
	qtyqty.value="${orderAirRnMMap.qty }";
	
	formObj.appendChild(p_flightName);
	formObj.appendChild(p_airlineName);
	formObj.appendChild(p_departureAirport);
	formObj.appendChild(p_departureTime);
	formObj.appendChild(p_arrivalAirport);
	formObj.appendChild(p_arrivalTime);
	formObj.appendChild(p_flightName2);
	formObj.appendChild(p_airlineName2);
	formObj.appendChild(p_departureAirport2);
	formObj.appendChild(p_arrivalAirport2);
	formObj.appendChild(p_arrivalTime2);
	formObj.appendChild(qtyqty);
	//~~~여기부터
	
	
	formObj.appendChild(i_pay_method);
	formObj.appendChild(i_card_com_name);
	formObj.appendChild(i_card_pay_month);
	formObj.appendChild(i_air_order_ChargeSS);
	formObj.appendChild(i_pay_orderer_hp_num);
	
	document.body.appendChild(formObj); 
	formObj.method="post";
	formObj.action="${contextPath}/order/payToOrderGoodsAirRnM.do";
	formObj.submit();
	imagePopup('close');
}

</script>
</head>
<body>
<a href="${contextPath}/main.do" class="category_top">홈</a> <span class="category_top">&nbsp;>&nbsp;</span>
<a href="#" class="category_top">결제 페이지</a><br>
<a href="${contextPath }/order/orderEachGoodsAir.do" class="title1">결제 페이지</a><br>

<h3 style="display: inline-block">1.주문확인 &nbsp;&nbsp;&nbsp;</h3>
<c:if test="${(airEachDataMap.prestigeCharge ne '0' && flagAirStay eq 'air') || ((orderAirRnMMap.prestigeCharge1 ne '0' || orderAirRnMMap.prestigeCharge2 ne '0') && flagAirStay eq 'airRnM') }">
	<p id="chargeAnnounce">**좌석(일반석/비즈니스석)미선택시, 비즈니스석 가격으로 책정됩니다.</p>
</c:if>
<form  name="form_order">	
	<!-- =======================================항공 왕복/다구간================================================= -->
	<c:if test="${flagAirStay eq 'airRnM' }">
		<c:set var="total_order_priceGo" 		value="0" />		<!-- 왕복다구간 1 금액 -->
		<c:set var="total_order_priceBack" 		value="0" />		<!-- 왕복다구간 2 금액 -->
		<table border="1" class="list_view" style="text-align: center; width: 95%;">
			<tbody>
				<tr style="background: #9FCBF6">
					<td>항공편명</td>
					<td>항공사명</td>
					<td>출발</td>
					<td>도착</td>
					<td>결제가격</td>
					<td>총 결제인원</td>
				</tr>
				<tr>
					<td rowspan="2">${orderAirRnMMap.flightName1 }</td>
					<td rowspan="2">${orderAirRnMMap.airlineName1 }</td>
					<td>${orderAirRnMMap.departureAirport1 } 공항</td>
					<td>${orderAirRnMMap.arrivalAirport1 } 공항</td>
					<td rowspan="2">
						<c:if test="${orderAirRnMMap.prestigeCharge1 eq '0' }">
							${orderAirRnMMap.economyCharge1 }원<br><span class="smallFont">(일반석)</span>
							<c:set var="total_order_priceGo" 	value="${orderAirRnMMap.economyCharge1 }" />	
						</c:if>
						<c:if test="${orderAirRnMMap.prestigeCharge1 ne '0' }">
							<div id="economyDiv" style="display: none;">${orderAirRnMMap.economyCharge1 }원 <span class="smallFont">(일반석)</span><br></div>
							<div id="businessDiv" style="display: none;">${orderAirRnMMap.prestigeCharge1 }원 <span class="smallFont">(비즈니스석)</span><br></div>
							<input id="economyBtn" type="button" value="일반석 선택" onclick="flagRnM = 'first'; select_economy()"  class="subm" style="width: 120px;"/>
							<div id="brDiv"></div>
							<input id="businessBtn" type="button" value="비즈니스석 선택" onclick="flagRnM = 'first'; select_business()"  class="subm" style="width: 120px;"/>
								<c:set var="total_order_priceGo" 		value="${orderAirRnMMap.prestigeCharge1 }" />		<!-- 왕복다구간 1 금액 -->
						</c:if>
					    <c:set var="total_order_price" 			value="${(total_order_priceGo + total_order_priceBack)*orderAirRnMMap.qty }" />
					    <c:set var="final_total_order_price" 	value="${(total_order_priceGo + total_order_priceBack)*orderAirRnMMap.qty }" />
					</td>
					<td rowspan="4">${orderAirRnMMap.qty }명<br><span class="smallFont">(유아 제외)</span></td>
				</tr>
				<tr>
					<td>${orderAirRnMMap.departureTime1 }</td>
					<td>${orderAirRnMMap.arrivalTime1 }</td>
				</tr>
				<tr>
					<td rowspan="2">${orderAirRnMMap.flightName2 }</td>
					<td rowspan="2">${orderAirRnMMap.airlineName2 }</td>
					<td>${orderAirRnMMap.departureAirport2 } 공항</td>
					<td>${orderAirRnMMap.arrivalAirport2 } 공항</td>
					<td rowspan="2">
						<c:if test="${orderAirRnMMap.prestigeCharge2 eq '0' }">
							${orderAirRnMMap.economyCharge2 }원<br><span class="smallFont">(일반석)</span>							
							<c:set var="total_order_priceBack"	value="${orderAirRnMMap.economyCharge2 }" />	
						</c:if>
						<c:if test="${orderAirRnMMap.prestigeCharge2 ne '0' }">
							<div id="economyDiv2" style="display: none;">${orderAirRnMMap.economyCharge2 }원 <span class="smallFont">(일반석)</span><br></div>
							<div id="businessDiv2" style="display: none;">${orderAirRnMMap.prestigeCharge2 }원 <span class="smallFont">(비즈니스석)</span><br></div>
							<input id="economyBtn2" type="button" value="일반석 선택" onclick="flagRnM = 'second'; select_economy()"  class="subm" style="width: 120px;"/>
							<div id="brDiv2"></div>
							<input id="businessBtn2" type="button" value="비즈니스석 선택" onclick="flagRnM = 'second'; select_business()"  class="subm" style="width: 120px;"/>
								<c:set var="total_order_priceBack" 		value="${orderAirRnMMap.prestigeCharge2 }" />		<!-- 왕복다구간 2 금액 -->
						</c:if>
					    <c:set var="total_order_price" 			value="${(total_order_priceGo + total_order_priceBack)*orderAirRnMMap.qty }" />
					    <c:set var="final_total_order_price" 	value="${(total_order_priceGo + total_order_priceBack)*orderAirRnMMap.qty }" />
					</td>
				</tr>
				<tr>
					<td>${orderAirRnMMap.departureTime2 }</td>
					<td>${orderAirRnMMap.arrivalTime2 }</td>
				</tr>
			</tbody>
		</table>
		<input id="GOValueRealTime" type="hidden" value="${total_order_priceGo}" /><!--  type="hidden" -->
		<input id="BACKValueRealTime" type="hidden" value="${total_order_priceBack}" />
		<input id="TOTALValueRealTime" type="hidden" value="${total_order_price}" />
		<div class="clear"></div><br>
	</c:if>
	<!-- =======================================항공 왕복/다구간================================================= -->

	<h3 style="display: inline-block">2.할인 정보 &nbsp;&nbsp;&nbsp;</h3>
	<div id="discountDiv">
		<div class="detail_table"><br>
			<table>
				<tbody>
					<tr class="dot_line">
						<td width=100>포인트</td><%-- <c:set var="mem_point" value="1000" /> --%>
						<td>
							<input id="pointInput" name="discount_juklip" type="text" pattern="[0-9]+" max="${mem_point }" style="width: 80px" /> 원<span class="smallFont">/1000원</span>
							<input id="pointUseAll" type="checkbox" /><span class="smallFont">모두 사용하기</span>
							<p id="h_point" style="display: none;">0</p>
						</td>
						<td><input type="button" value="포인트 적용하기" class="subm" onClick="pointApply()" style="width: 90px; height:28px; font-size: 11px;"/></td>
					</tr>
					<tr class="dot_line">
						<td>쿠폰할인</td>
						<td>
							<select id="couponSelect" name="couponSelect" style="width: 220px;">
								<option value="0.1" selected>봄맞이 10% 할인 쿠폰</option>
								<option value="0.05">코로나 안녕~ 5% 할인 쿠폰</option>
								<option value="0.15">첫구매 파격 15% 할인 쿠폰</option>
							</select>
							<p id="h_coupon" style="display: none;">0</p>
						</td>
						<td><input type="button" value="쿠폰 적용하기" class="subm" onClick="couponApply()" style="width: 90px; height:28px; font-size: 11px;"/></td>
					</tr>
				</tbody>
			</table>
			<br>
		</div>
		<!-- =======================================항공========================================================== -->
		<c:if test="${flagAirStay eq 'air' || flagAirStay eq 'airRnM'}">
			<table class="list_view" style="background: #9FCBF6; width: 100%;">
				<tbody>
					<tr align=center class="fixed">
						<td>총 결제인원</td>
						<td>총 상품금액</td>
						<td></td>
						<td>총 할인 금액</td>
						<td></td>
						<td>최종 결제금액</td>
					</tr>
					<tr>
						<td id="">
							<p id="p_totalNum">${airEachDataMap.qty }${orderAirRnMMap.qty }명</p> 
							<input id="h_total_order_goods_qty" type="hidden" value="${airEachDataMap.qty }${orderAirRnMMap.qty }" />
						</td>
						<td>
							<p id="p_totalPrice">${total_order_price }원</p> 
							<input id="h_totalPrice" type="hidden" value="${total_order_price }" />
						</td>
						<td>
						<img width="25" alt="" 	src="${pageContext.request.contextPath}/resources/image/minus.jpg"></td>
						<td>
							<p id="p_totalSalesPrice">0원</p>
							<input id="h_total_sales_price" type="hidden" value="0" />
						</td>
						<td><img width="25" alt="" src="${pageContext.request.contextPath}/resources/image/equal.jpg"></td>
						<td>
							<p id="p_final_totalPrice">
								<font size="15">${total_order_price}원 </font></p>
							<input id="h_final_total_Price" type="hidden" value="${total_order_price}" />
						</td>
					</tr>
				</tbody>
			</table>
		</c:if>
		<!-- =======================================항공========================================================== -->

	</div>
	<div class="clear"></div>

	<div >
	  <br><br>
	   <h3 style="display: inline">3.주문고객 &nbsp;&nbsp;&nbsp;</h3>
	     <div class="detail_table">
			 <table id="memInfoTable">
			   <tbody>
				 <tr class="dot_line">
					<td >이름</td>
					<td><input  type="text" value="${orderer.mem_name}" size="20" /></td>
				  </tr>
				  <tr class="dot_line">
					<td >핸드폰</td>
					<td><input  type="text" value="${orderer.mem_tel1}-${orderer.mem_tel2}-${orderer.mem_tel3}" size="20" /></td>
				  </tr>
				  <tr class="dot_line">
					<td >이메일</td>
					<td><input  type="text" value="${orderer.mem_email1}@${orderer.mem_email2}" size="20" /></td>
				  </tr>
			   </tbody>
			</table>
		</div>
	</div>
	<div class="clear"></div>
	
	<br><br><br>
	
	<h3 style="display: inline">4.결제정보 &nbsp;&nbsp;&nbsp;</h3><br><br>
	<div id="payChooseDiv">
		<div class="detail_table">
			<table id="payChooseTable">
				<tbody>
					<tr >
						<td><input type="radio" id="pay_method" name="pay_method" value="신용카드"   onClick="fn_pay_card()" checked>신용카드</td>
					    <td><input type="radio" id="pay_method" name="pay_method" value="제휴 신용카드"  >제휴 신용카드</td>
					    <td><input type="radio" id="pay_method" name="pay_method" value="실시간 계좌이체">실시간 계좌이체</td>
					    <td><input type="radio" id="pay_method" name="pay_method" value="무통장 입금">무통장 입금</td>
						
					</tr>
					<tr >
						<td><input type="radio" id="pay_method" name="pay_method" value="휴대폰결제" onClick="fn_pay_phone()">휴대폰 결제</td>
						<td><input type="radio" id="pay_method" name="pay_method" value="카카오페이(간편결제)">카카오페이(간편결제)</td>
						<td><input type="radio" id="pay_method" name="pay_method" value="페이나우(간편결제)">페이나우(간편결제)</td>
						<td><input type="radio" id="pay_method" name="pay_method" value="페이코(간편결제)">페이코(간편결제)</td>
					</tr>
					<tr >
						<td>
						   <input type="radio"  id="pay_method" name="pay_method" value="직접입금">직접입금&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					<tr id="tr_pay_card">
						<td colspan="4"><br><br>
							<strong>카드 선택 :</strong>&nbsp;&nbsp;&nbsp;
							<select id="card_com_name" name="card_com_name">
								<option value="삼성" selected>삼성</option>
								<option value="하나SK">하나SK</option>
								<option value="현대">현대</option>
								<option value="KB">KB</option>
								<option value="신한">신한</option>
								<option value="롯데">롯데</option>
								<option value="BC">BC</option>
								<option value="시티">시티</option>
								<option value="NH농협">NH농협</option>
							</select><br><Br>
							<strong>할부 기간 :</strong>&nbsp;&nbsp;&nbsp;
							<select id="card_pay_month" name="card_pay_month">
								<option value="일시불" selected>일시불</option>
								<option value="2개월">2개월</option>
								<option value="3개월">3개월</option>
								<option value="4개월">4개월</option>
								<option value="5개월">5개월</option>
								<option value="6개월">6개월</option>
						    </select>
						</td>
					</tr>
					<tr id="tr_pay_phone" style="visibility:hidden">
					  <td colspan="4">
					  		<strong>휴대폰 번호 입력: </strong>
					  	    <input  type="text" size="5" value=""  id="pay_order_tel1" name="pay_order_tel1" />-
					        <input  type="text" size="5" value="" id="pay_order_tel2" name="pay_order_tel2" />-
					        <input  type="text" size="5" value="" id="pay_order_tel3" name="pay_order_tel3" />
					  </td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

    <div class="clear"></div>
	<div style="text-align: center">
		<br><br><br>
		<br><br>
		<a href="${contextPath}/main.do"> 
		   <%-- <img width="75" alt="" src="${contextPath}/resources/image/btn_shoping_continue.jpg"> --%>
		   <input type="button" value="쇼핑 계속하기" onclick="location.href='${contextPath}/main.do'" class="subm7" />
		</a>
		
		<!-- =======================================항공========================================================== -->
		<c:if test="${flagAirStay eq 'air' || flagAirStay eq 'airRnM'}">
			<a href="javascript:fn_show_order_detail();"> 
				<input type="button" value="결제하기" class="subm3" />
			</a> 
		</c:if>
		<!-- =======================================항공========================================================== -->
		<br><br><br>
	</div>
	<div class="clear"></div>		
	<div id="layer" style="visibility:hidden">
		<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
		<div id="popup_order_detail">
			<!-- 팝업창 닫기 버튼 -->
			<a href="javascript:" onClick="javascript:imagePopup('close', '.layer01');">
				<img  src="${contextPath}/resources/image/close.png" id="close" />
			</a><br> 
			 <!-- =======================================항공========================================================== -->
	  		 <c:if test="${flagAirStay eq 'air' }">
				  <h1>최종 주문 사항</h1>
				  <div class="detail_table">
					  <table id="finalOrderTable">
					 	<tr>
						  <td width=200px>항공편명 : </td>
						  <td><p id="p_flightName" class="finalOrderP"> 항공편명 </p></td>
					    </tr>
					    <tr>
						  <td width=200px>항공사명 : </td>
						  <td><p id="p_airlineName" class="finalOrderP"> 항공사명 </p></td>
					    </tr>
					    <tr>
						  <td width=200px>출발 공항 : </td>
						  <td><p id="p_departureAirport" class="finalOrderP"> 출발 공항 </p></td>
					    </tr>
					    <tr>
						  <td width=200px>출발 시간 : </td>
						  <td><p id="p_departureTime" class="finalOrderP"> 출발 시간 </p></td>
					    </tr>
					    <tr>
						  <td width=200px>도착 공항 : </td>
						  <td><p id="p_arrivalAirport" class="finalOrderP"> 도착 공항 </p></td>
					    </tr>
					    <tr>
						  <td width=200px>도착 시간 : </td>
						  <td><p id="p_arrivalTime" class="finalOrderP"> 도착 시간 </p></td>
					    </tr>
					    <tr>
						  <td width=200px>결제금액합계: </td>
						  <td><p id="p_total_order_goods_price" class="finalOrderP">결제금액합계</p></td>
					    </tr>
						<tr>
						  <td width=200px>주문자: </td>
						  <td><p id="p_orderer_name" class="finalOrderP"> 주문자 이름 </p></td>
					    </tr>
					   <tr>
						  <td width=200px>결제방법: </td>
						  <td align=left><p id="p_pay_method" class="finalOrderP">결제방법</p></td>
					   </tr>
					</table>
				</div>
			</c:if>
			<!-- =======================================항공========================================================== -->
			<!-- =======================================항공 왕복/다구간========================================================== -->
	  		 <c:if test="${flagAirStay eq 'airRnM' }">
				  <h1>최종 주문 사항</h1>
				  <div class="detail_table2">
					  <table id="finalOrderTable2">
					 	<tr>
						  <td width=200px>항공편명 : </td>
						  <td width=200px><p id="p_flightName" class="finalOrderP2"> 항공편명 </p></td>
						  <td width=200px><p id="p_flightName2" class="finalOrderP2"> 항공편명 </p></td>
					    </tr>
					    <tr>
						  <td width=200px>항공사명 : </td>
						  <td><p id="p_airlineName" class="finalOrderP2"> 항공사명 </p></td>
						  <td><p id="p_airlineName2" class="finalOrderP2"> 항공사명 </p></td>
					    </tr>
					    <tr>
						  <td width=200px>출발 공항 : </td>
						  <td><p id="p_departureAirport" class="finalOrderP2"> 출발 공항 </p></td>
						  <td><p id="p_departureAirport2" class="finalOrderP2"> 출발 공항 </p></td>
					    </tr>
					    <tr>
						  <td width=200px>출발 시간 : </td>
						  <td><p id="p_departureTime" class="finalOrderP2"> 출발 시간 </p></td>
						  <td><p id="p_departureTime2" class="finalOrderP2"> 출발 시간 </p></td>
					    </tr>
					    <tr>
						  <td width=200px>도착 공항 : </td>
						  <td><p id="p_arrivalAirport" class="finalOrderP2"> 도착 공항 </p></td>
						  <td><p id="p_arrivalAirport2" class="finalOrderP2"> 도착 공항 </p></td>
					    </tr>
					    <tr>
						  <td width=200px>도착 시간 : </td>
						  <td><p id="p_arrivalTime" class="finalOrderP2"> 도착 시간 </p></td>
						  <td><p id="p_arrivalTime2" class="finalOrderP2"> 도착 시간 </p></td>
					    </tr>
					    <tr>
						  <td width=200px>결제금액합계: </td>
						  <td><p id="p_total_order_goods_price" class="finalOrderP2">결제금액합계</p></td>
					    </tr>
						<tr>
						  <td width=200px>주문자: </td>
						  <td><p id="p_orderer_name" class="finalOrderP2"> 주문자 이름 </p></td>
					    </tr>
					   <tr>
						  <td width=200px>결제방법: </td>
						  <td align=left><p id="p_pay_method" class="finalOrderP2">결제방법</p></td>
					   </tr>
					</table>
				</div>
			</c:if>
			<!-- =======================================항공 왕복/다구간========================================================== -->
			<div class="clear"></div><br>
			<!-- =======================================항공========================================================== -->
			<c:if test="${flagAirStay eq 'airRnM' }">
				<input name="btn_process_pay_order" type="button" onClick="fn_process_pay_order()" value="최종결제하기" class="subm3">
			</c:if>
			
		</div>
	</div> 
	</form>
</body>