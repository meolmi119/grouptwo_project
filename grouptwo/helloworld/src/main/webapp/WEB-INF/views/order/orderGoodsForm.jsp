<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.net.URLEncoder, java.net.URLDecoder" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!-- ///////////////주문 -->
<c:set var="myCartList" value="${cartMap.myCartList}"  />
<c:set var="myGoodsList" value="${cartMap.myGoodsList}"  />
<c:set var="myGoodsList" value="${cartMap.myGoodsList}"  />
<c:set var="goodsStayVOEach" value="${goodsStayMap.goodsStayVO}"  />

<c:set var="final_total_order_price" value="${final_total_order_price }" />	<!-- 최종 결제 금액 -->
<c:set var="total_order_price" value="0" />			<!-- 총주문 금액 -->

<c:set var="mem_point" value="1000" /> 				<!-- 회원의 포인트 -->

<head>
<style>
#layer {
	z-index: 2;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
	/* background-color:rgba(0,0,0,0.8); */
}
#popup_order_detail {
	z-index: 3;
	position: fixed;
	text-align: center;
	left: 10%;
	top: 0%;
	width: 60%;
	height: 800px;
	background-color: white;
	border: 5px solid  #0E256D;
}
#close {
	z-index: 4;
	float: right;
	margin: 5px;
}
.title1 {
	font-size: 40px;
	text-decoration: none;
	color: black;
	font-weight: bold;
	text-align: left;
}
.category_top {
	text-decoration: none;
	color: #A8A8A8;
}
.detail_table {
	margin-left: 100px;
	width: 830px;
}
.smallFont {
	font-size: 11px;
}
#memInfoTable td {
	height: 45px;
}
.list_view {
	margin: 0px;
}
.list_view p {
	text-align: center;
	margin: 20px 10px;
}
#discountDiv, #payChooseDiv {
	border: 1px solid #BCBCBC;
	width: 95%;
}
#payChooseTable {
	width: 100%;
	margin: 20px;
	margin-right: 0px;
}
#payChooseDiv td {
	width: 300px;
}
#pointInput:invalid {
  border: 2px solid red;
}
#chargeAnnounce {
	width: 95%;
	text-align: right;
	margin: 0;
	font-size: 12px;
}
#card_pay_month, #card_com_name {
	width: 170px;
}
#finalOrderTable, .finalOrderP  {
	font-size: 18px;
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
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jquery쓰기위해 필요 -->
<script>
window.onload=function() {
  init();
}
// 일반석 선택시
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
	chargeAnnounce.style.display ='none';
	
	//할인리셋
	p_totalSalesPrice.textContent = "0원";
	h_total_sales_price.value = "0";
	h_point.textContent = "0";
	h_coupon.textContent = "0";
	
	br.style.display = 'none';
	economyBtn.style.display ='none';
	businessBtn.style.display ='block';
	businessBtn.style.cssText ='text-align: center; width: 130px;';
	businessBtn.value ='비즈니스석으로 변경';
	
	economyDiv.style.display ='block';
	businessDiv.style.display ='none';
	
	<c:set var="final_total_order_price" value="${airEachDataMap.economyCharge* airEachDataMap.qty}" />
	<c:set var="total_order_price" value="${airEachDataMap.economyCharge* airEachDataMap.qty}" />
	console.log("total_order_price : " + ${total_order_price }+ ", final_total_order_price : " + ${final_total_order_price });
	p_totalPrice.textContent = ${total_order_price };
	h_totalPrice.value = ${total_order_price };
	
	p_final_totalPrice.textContent = ${total_order_price};
	h_final_total_Price.value = ${total_order_price};
	p_final_totalPrice.style.cssText ='font-size: 48px';
}
// 비즈니스석 선택시
function select_business() {
	const economyBtn = document.querySelector('#economyBtn');	// 일반석 선택 버튼
	const businessBtn = document.querySelector('#businessBtn');	// 비즈니스 선택 버튼
	const economyDiv = document.querySelector('#economyDiv');	// 일반석 가격
	const businessDiv = document.querySelector('#businessDiv');	// 비즈니스 가격
	const p_totalPrice = document.querySelector('#p_totalPrice');	// 총 상품 금액
	const h_totalPrice = document.querySelector('#h_totalPrice');	// 총 상품 금액
	const p_final_totalPrice = document.querySelector('#p_final_totalPrice');	// 최종 결제 금액
	const h_final_total_Price = document.querySelector('#h_final_total_Price');	// p_final_totalPrice
	const p_totalSalesPrice = document.querySelector('#p_totalSalesPrice');	// 총 할인금액
	const h_total_sales_price = document.querySelector('#h_total_sales_price');	// 총 할인금액
	const h_point = document.querySelector('#h_point');	// 포인트 저장
	const h_coupon = document.querySelector('#h_coupon');	// 쿠폰 저장
	const chargeAnnounce = document.querySelector('#chargeAnnounce');	// 총 상품 금액
	chargeAnnounce.style.display ='none';
	
	//할인리셋
	p_totalSalesPrice.textContent = "0원";
	h_total_sales_price.value = "0";
	h_point.textContent = "0";
	h_coupon.textContent = "0";
	
	if (${airEachDataMap.prestigeCharge eq "-" } ) {
		alert("해당 항공편의 비즈니스석이 존재하지 않습니다.");
		select_economy();
	} else {
		economyBtn.style.display ='block';
		economyBtn.style.cssText ='text-align: center; width: 130px;';
		economyBtn.value ='일반석으로 변경';
		businessBtn.style.display ='none';
		
		economyDiv.style.display ='none';
		businessDiv.style.display ='block';
		
		<c:set var="final_total_order_price" value="${airEachDataMap.prestigeCharge* airEachDataMap.qty}" />
		<c:set var="total_order_price" value="${airEachDataMap.prestigeCharge* airEachDataMap.qty}" />
		console.log("total_order_price : " + ${total_order_price }+ ", final_total_order_price : " + ${final_total_order_price });
		p_totalPrice.textContent = ${total_order_price };
		h_totalPrice.value = ${total_order_price };
		

		p_final_totalPrice.textContent = ${total_order_price};
		h_final_total_Price.value = ${total_order_price};
		p_final_totalPrice.style.cssText ='font-size: 48px';
	}
}
// 포인트 값 입력되면 모두사용하기 체크박스 풀기
document.addEventListener(`DOMContentLoaded`, () => {
	const pointInput = document.querySelector("#pointInput");
	const pointUseAll = document.querySelector('#pointUseAll');	// 포인트 모두 사용하기
	
	pointInput.addEventListener("input", function(e) {
	    console.log("포인트 입력중...", e.target.value); // 값이 바뀔때마다 찍힘
	    pointUseAll.checked=false;
	})
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
	
	order_goods_qty="${airEachDataMap.qty }";
	
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
	
	p_flightName.textContent="${airEachDataMap.flightName }";
	p_airlineName.innerHTML="${airEachDataMap.airlineName }";
	p_departureAirport.innerHTML="${airEachDataMap.departureAirport }";
	p_departureTime.innerHTML="${airEachDataMap.departureTime }";
	p_arrivalAirport.innerHTML="${airEachDataMap.arrivalAirport }";
	p_arrivalTime.innerHTML="${airEachDataMap.arrivalTime }";
	p_total_order_goods_price.innerHTML=document.getElementById("h_final_total_Price").value;
	p_orderer_name.innerHTML="${orderer.mem_name}";
	p_pay_method.innerHTML=pay_method;
	
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
	
	formObj.appendChild(i_pay_method);
	formObj.appendChild(i_card_com_name);
	formObj.appendChild(i_card_pay_month);
	formObj.appendChild(i_air_order_ChargeSS);
	formObj.appendChild(i_pay_orderer_hp_num);
	
	document.body.appendChild(formObj); 
	formObj.method="post";
	formObj.action="${contextPath}/order/payToOrderGoodsAir.do";
	formObj.submit();
	imagePopup('close');
}

function fn_process_pay_order_stay(){
	alert("최종 결제하기");
	var formObj=document.createElement("form");
	var i_pay_method=document.createElement("input");
	var i_card_com_name=document.createElement("input");
	var i_card_pay_month=document.createElement("input");
	var i_stay_order_ChargeSS=document.createElement("input");
	var i_pay_orderer_hp_num=document.createElement("input");

	i_pay_method.name="pay_method";
	i_card_com_name.name="card_com_name";
	i_card_pay_month.name="card_pay_month";
	i_stay_order_ChargeSS.name="stay_order_ChargeSS";
	i_pay_orderer_hp_num.name="pay_orderer_hp_num";
	
	stay_order_ChargeS = document.getElementById("p_total_order_goods_price").textContent;
	
	i_pay_method.value=pay_method;
	i_card_com_name.value=card_com_name;
	i_card_pay_month.value=card_pay_month;
	i_stay_order_ChargeSS.value=stay_order_ChargeS;
	i_pay_orderer_hp_num.value=pay_orderer_hp_num;
	
	formObj.appendChild(i_pay_method);
	formObj.appendChild(i_card_com_name);
	formObj.appendChild(i_card_pay_month);
	formObj.appendChild(i_stay_order_ChargeSS);
	formObj.appendChild(i_pay_orderer_hp_num);
	
	document.body.appendChild(formObj); 
	formObj.method="post";
	formObj.action="${contextPath}/order/payToOrderGoodsStay.do";
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
<c:if test="${airEachDataMap.prestigeCharge ne '0' && flagAirStay eq 'air' }">
	<p id="chargeAnnounce">**좌석(일반석/비즈니스석)미선택시, 비즈니스석 가격으로 책정됩니다.</p>
</c:if>
<form  name="form_order">	
	<!-- =======================================항공========================================================== -->
	<c:if test="${flagAirStay eq 'air' }">
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
					<td rowspan="2">${airEachDataMap.flightName }</td>
					<td rowspan="2">${airEachDataMap.airlineName }</td>
					<td>${airEachDataMap.departureAirport } 공항</td>
					<td>${airEachDataMap.arrivalAirport } 공항</td>
					<td rowspan="2">
						<c:if test="${airEachDataMap.prestigeCharge eq '0' }">
							${airEachDataMap.economyCharge }원<br><span class="smallFont">(일반석)</span>
							<c:set var="final_total_order_price" value="${airEachDataMap.economyCharge* airEachDataMap.qty}" />
							<c:set var="total_order_price" value="${airEachDataMap.economyCharge* airEachDataMap.qty}" />
						</c:if>
						<c:if test="${airEachDataMap.prestigeCharge ne '0' }">
							<div id="economyDiv" style="display: none;">${airEachDataMap.economyCharge }원 <span class="smallFont">(일반석)</span><br></div>
							<div id="businessDiv" style="display: none;">${airEachDataMap.prestigeCharge }원 <span class="smallFont">(비즈니스석)</span><br></div>
							<input id="economyBtn" type="button" value="일반석 선택" onclick=select_economy()  class="subm" style="width: 120px;"/>
							<div id="brDiv"></div>
							<input id="businessBtn" type="button" value="비즈니스석 선택" onclick=select_business()  class="subm" style="width: 120px;"/>
						</c:if>
					</td>
					<td rowspan="2">${airEachDataMap.qty }명<br><span class="smallFont">(유아 제외)</span></td>
				</tr>
				<tr>
					<td>${airEachDataMap.departureTime }</td>
					<td>${airEachDataMap.arrivalTime }</td>
				</tr>
			</tbody>
		</table>
		<div class="clear"></div><br>
	</c:if>
	<!-- =======================================항공========================================================== -->

	<!-- =======================================숙박========================================================== -->
	<c:if test="${flagAirStay eq 'stay' }">
		<table border="1" class="list_view" style="text-align: center; width: 95%;">
			<tbody>
				<tr style="background: #9FCBF6">
					<td>숙박업소명</td>
					<td>사업자명</td>
					<td>분류</td>
					<td>인실</td>
					<td>수량</td>
					<td>주소</td>
					<td>입실날짜<br>퇴실날짜</td>
					<td>가격(1박 기준)</td>
				</tr>
				<tr>
					<td>${goodsStayVOEach.goods_stay_name }</td>
					<td>${goodsStayVOEach.busi_id }</td>
					<td>${goodsStayVOEach.goods_stay_sort }</td>
					<td>${goodsStayVOEach.goods_stay_num_people }</td>
					<td>${roomCount }</td>
					<td>${goodsStayVOEach.goods_stay_roadAddress }</td>
					<td>
						${checkInDate }<br>
						${checkOutDate }
					</td>
					<c:choose>
						<c:when test="${not empty goodsStayVOEach.goods_stay_sales_price and goodsStayVOEach.goods_stay_sales_price != 0}">
							<td>${goodsStayVOEach.goods_stay_sales_price }원</td>
						</c:when>
						<c:otherwise>
							<td>${goodsStayVOEach.goods_stay_price }원</td>
						</c:otherwise>
					</c:choose>
				</tr>
			</tbody>
		</table>
		<c:choose>
			<c:when test="${not empty goodsStayVOEach.goods_stay_sales_price and goodsStayVOEach.goods_stay_sales_price != 0}">
				<c:set var="total_order_price" value="${goodsStayVOEach.goods_stay_sales_price* stayDays* roomCount}" />
			</c:when>
			<c:otherwise>
				<c:set var="total_order_price" value="${goodsStayVOEach.goods_stay_price* stayDays* roomCount}" />
			</c:otherwise>
		</c:choose>
		<div class="clear"></div><br>
	</c:if>
	<!-- =======================================숙박========================================================== -->

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
		<c:if test="${flagAirStay eq 'air' }">
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
							<p id="p_totalNum">${airEachDataMap.qty }명</p> 
							<input id="h_total_order_goods_qty" type="hidden" value="${airEachDataMap.qty }" />
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

		<!-- =======================================숙박========================================================== -->
		<c:if test="${flagAirStay eq 'stay' }">
			<table class="list_view" style="background: #9FCBF6; width: 100%;">
				<tbody>
					<tr align=center class="fixed">
						<td>총 숙박일</td>
						<td>총 상품금액</td>
						<td></td>
						<td>총 할인 금액</td>
						<td></td>
						<td>최종 결제금액</td>
					</tr>
					<tr>
						<td id="">
							<p id="p_totalNum">${stayDays }일</p> 
							<input id="h_total_order_goods_qty" type="hidden" value="${stayDays }" />
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
		<!-- =======================================숙박========================================================== -->
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
	
	<h3 style="display: inline">4.결제정보 &nbsp;&nbsp;&nbsp;</h3>
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
		<c:if test="${flagAirStay eq 'air' }">
			<a href="javascript:fn_show_order_detail();"> 
				<input type="button" value="결제하기" class="subm3" />
			</a> 
		</c:if>
		<!-- =======================================항공========================================================== -->
		<!-- =======================================숙박========================================================== -->
		<c:if test="${flagAirStay eq 'stay' }">
			<a href="javascript:fn_show_order_detail_stay();"> 
				<input type="button" value="결제하기" class="subm3" />
			</a> 
		</c:if>
		<!-- =======================================숙박========================================================== -->
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
			<!-- =======================================숙박========================================================== -->
			<c:if test="${flagAirStay eq 'stay' }">
				<h1>최종 주문 사항</h1>
				  <div class="detail_table">
					  <table id="finalOrderTable">
					 	<tr>
						  <td width=200px>숙박업소명 : </td>
						  <td><p id="p_stay_name" class="finalOrderP"> 숙박업소명 </p></td>
					    </tr>
					    <tr>
						  <td width=200px>분류 : </td>
						  <td><p id="p_stay_sort" class="finalOrderP"> 분류 </p></td>
					    </tr>
					    <tr>
						  <td width=200px>주소 : </td>
						  <td><p id="p_stay_address" class="finalOrderP"> 주소 </p></td>
					    </tr>
					    <tr>
						  <td width=200px>입실 날짜 : </td>
						  <td><p id="p_stay_admissionDate" class="finalOrderP"> 입실 날짜 </p></td>
					    </tr>
					    <tr>
						  <td width=200px>퇴실 날짜 : </td>
						  <td><p id="p_stay_departureDate" class="finalOrderP"> 퇴실 날짜 </p></td>
					    </tr>
					    <tr>
						  <td width=200px>숙박인원 : </td>
						  <td><p id="p_stay_num_people" class="finalOrderP"> 숙박인원 </p></td>
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
			
			<div class="clear"></div><br>
			<!-- =======================================항공========================================================== -->
			<c:if test="${flagAirStay eq 'air' }">
				<input name="btn_process_pay_order" type="button" onClick="fn_process_pay_order()" value="최종결제하기" class="subm3">
			</c:if>
			<!-- =======================================숙박========================================================== -->
			<c:if test="${flagAirStay eq 'stay' }">
				<input name="btn_process_pay_order" type="button" onClick="fn_process_pay_order_stay()" value="최종결제하기" class="subm3">
			</c:if>
		</div>
	</div> 
	</form>
</body>