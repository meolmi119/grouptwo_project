<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="goods"  value="${goodsStayMap.goodsStayVO}"  />
<c:set var="imageList"  value="${goodsStayMap.imageList }"  />
<%
   //치환 변수 선언합니다.
    pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
    pageContext.setAttribute("br", "<br/>"); //br 태그
%> 
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hello World!</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script>
function clip(){
	var url = '';
	var textarea = document.createElement("textarea");
	document.body.appendChild(textarea);
	url = window.document.location.href;
	textarea.value = url;
	textarea.select();
	document.execCommand("copy");
	document.body.removeChild(textarea);
	alert("URL이 복사되었습니다.");
}

function addCartList() {
	var goods_stay_id = $("#goods_stay_id").val();
    var goods_stay_room_number = $("#goods_stay_room_number").val();
    var startD = $("#startD").val();
    var endD = $("#endD").val();
	
	if (goods_stay_id == null || goods_stay_id == undefined || goods_stay_id == "") {
        alert("goods_stay_id is null or undefined");
        return;
    } else if (goods_stay_room_number == null || goods_stay_room_number == undefined || goods_stay_room_number == "") {
        alert("예약할 방의 개수를 선택해주세요.");
        return;
    } else if (startD == null || startD == undefined || startD == "" || startD == "입실 날짜") {
        alert("예약할 입실 날짜를 선택해주세요.");
        return;
    } else if (endD == null || endD == undefined || endD == "" || endD == "퇴실 날짜") {
        alert("예약할 퇴실 날짜를 선택해주세요.");
        return;
    }
	
	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/addGoodsStayInCart.do",
		data : {
			goods_stay_id : goods_stay_id,
			goods_stay_room_number : goods_stay_room_number,
			startD : startD,
			endD : endD,
			//cart_goods_qty:order_goods_qty //////////////장바구니
			//cart_goods_qty:cart_goods_qty
		},
		success : function(data, textStatus) {
			//alert(data);
			$('#message').append(data);
			if(data.trim()=='null_mem_id'){
				alert("로그인이 필요합니다.");	
			}else if(data.trim()=='already_existed'){
				$(".cartInF").fadeIn(300);	
			}else if(data.trim()=='add_success'){
				$(".cartInS").fadeIn(300);
			}
		},
		error : function(data, textStatus) {
			$('#message').append(data);
			if(data.trim()=='null_mem_id'){
				alert("로그인이 필요합니다.");
			} else {
			alert("모루는 에러가 발생했습니다."+data);
			}
		},
		complete : function(data, textStatus) {
			//alert("작업을완료 했습니다");
		}
	}); //end ajax	
}

function getDateforOrder() {
	var startD = $("#startD").val();
	var endD = $("#endD").val();
	var room_count = $("#goods_stay_room_number").val();
	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/order/getDataForEachPaymentStay.do",
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
/*슬라이더*/
/* $('.slider').each(function() {
  var $this = $(this);
  var $group = $this.find('.slide_group');
  var $slides = $this.find('.slide');
  var bulletArray = [];
  var currentIndex = 0;
  var timeout;
  
  function move(newIndex) {
    var animateLeft, slideLeft;
    
    advance();
    
    if ($group.is(':animated') || currentIndex === newIndex) {
      return;
    }
    
    bulletArray[currentIndex].removeClass('active');
    bulletArray[newIndex].addClass('active');
    
    if (newIndex > currentIndex) {
      slideLeft = '100%';
      animateLeft = '-100%';
    } else {
      slideLeft = '-100%';
      animateLeft = '100%';
    }
    
    $slides.eq(newIndex).css({
      display: 'block',
      left: slideLeft
    });
    $group.animate({
      left: animateLeft
    }, function() {
      $slides.eq(currentIndex).css({
        display: 'none'
      });
      $slides.eq(newIndex).css({
        left: 0
      });
      $group.css({
        left: 0
      });
      currentIndex = newIndex;
    });
  }
  
  function advance() {
    clearTimeout(timeout);
    timeout = setTimeout(function() {
      if (currentIndex < ($slides.length - 1)) {
        move(currentIndex + 1);
      } else {
        move(0);
      }
    }, 4000);
  }
  
  $('.next_btn').on('click', function() {
    if (currentIndex < ($slides.length - 1)) {
      move(currentIndex + 1);
    } else {
      move(0);
    }
  });
  
  $('.previous_btn').on('click', function() {
    if (currentIndex !== 0) {
      move(currentIndex - 1);
    } else {
      move(3);
    }
  });
  
  $.each($slides, function(index) {
    var $button = $('<a class="slide_btn">&bull;</a>');
    
    if (index === currentIndex) {
      $button.addClass('active');
    }
    $button.on('click', function() {
      move(index);
    }).appendTo('.slide_buttons');
    bulletArray.push($button);
  });
  advance();
}); */
$(document).ready(function () {
	$("#dateCheckConfirm").click(function () {
		$(".pop01").fadeOut(300);
	}); 
});
$(document).ready(function () {
	$("#cartInSClose").click(function () {
		$(".cartInS").fadeOut(300);
	}); 
});
$(document).ready(function () {
	$("#cartInFClose").click(function () {
		$(".cartInF").fadeOut(300);
	}); 
});
</script>
<style>
/* 그냥 css */
@import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=IBM+Plex+Sans+KR:wght@300&family=Montserrat:ital,wght@1,500&display=swap');
* {
	font-family: 'IBM Plex Sans KR', sans-serif;
	line-height: normal;
}
/*0320슬라이더*/
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
#sliderDiv {
  background: #F7F5E6;
  /*width: 100%;
  height: 100%;*/
  width: 1000px;
  height: 500px;
  margin: 0;
  padding: 0;
  border: 1px solid;
}
.slider {
  margin: 0 auto;
  max-width: 940px;
}
.slide_viewer {
  height: 340px;
  overflow: hidden;
  position: relative;
}
.slide_group {
  height: 100%;
  position: relative;
  width: 100%;
}
.slide {
  display: none;
  height: 100%;
  position: absolute;
  width: 100%;
}
.slide:first-child {
  display: block;
}
.slide:nth-of-type(1) {
  background: #D7A151;
}
.slide:nth-of-type(2) {
  background: #F4E4CD;
}
.slide:nth-of-type(3) {
  background: #C75534;
}
.slide:nth-of-type(4) {
  background: #D1D1D4;
}
.slide_buttons {
  left: 0;
  position: absolute;
  right: 0;
  text-align: center;
}
a.slide_btn {
  color: #474544;
  font-size: 42px;
  margin: 0 0.175em;
  -webkit-transition: all 0.4s ease-in-out;
  -moz-transition: all 0.4s ease-in-out;
  -ms-transition: all 0.4s ease-in-out;
  -o-transition: all 0.4s ease-in-out;
  transition: all 0.4s ease-in-out;
}
.slide_btn.active, .slide_btn:hover {
  color: #428CC6;
  cursor: pointer;
}
.directional_nav {
  height: 340px;
  margin: 0 auto;
  max-width: 940px;
  position: relative;
  top: -340px;
}
.previous_btn {
  bottom: 0;
  left: 100px;
  margin: auto;
  position: absolute;
  top: 0;
}
.next_btn {
  bottom: 0;
  margin: auto;
  position: absolute;
  right: 100px;
  top: 0;
}
.previous_btn, .next_btn {
  cursor: pointer;
  height: 65px;
  opacity: 0.5;
  -webkit-transition: opacity 0.4s ease-in-out;
  -moz-transition: opacity 0.4s ease-in-out;
  -ms-transition: opacity 0.4s ease-in-out;
  -o-transition: opacity 0.4s ease-in-out;
  transition: opacity 0.4s ease-in-out;
  width: 65px;
}
.previous_btn:hover, .next_btn:hover {
  opacity: 1;
}
@media only screen and (max-width: 767px) {
  .previous_btn {
    left: 50px;
  }
  .next_btn {
    right: 50px;
  }
}
/* 재선 팝업 창  */
#pop01_section > #pop01_button {
  display: block;
  margin: 0 auto;
  width: 200px;
  -webkit-border-radius: 6px;
  -moz-border-radius: 6px;
  -ms-border-radius: 6px;
  -o-border-radius: 6px;
  border-radius: 6px;
  background-color: #fff; /* 배경색 */
  border: 1px solid #dedede; /* 테두리 */
  padding: 5px 10px 6px 7px; /* 패딩 */
  border-radius: 10px;
  cursor: pointer;
}
#pop01_section > #pop01_button:hover {
  background-color: #C9ECFF; /* 배경색 */
  border: 1px solid #0099FF; /* 테두리 */
  border-color: #0099FF; /* 테두리 */
  color: #0099FF; /* 글자색 */
}
.pop01 {
  display: none;
/*팝업창 위치조정 바꾸기*/
  position: absolute;
  top: 50%-1000px;
  left: 50%;
/*여기까지*/
  z-index: 100;
  width: 500px;
  height: 100px; /* **** 수정 */
  background: #ffffff;
  -webkit-border-radius: 6px;
  -moz-border-radius: 6px;
  -ms-border-radius: 6px;
  -o-border-radius: 6px;
  border-radius: 6px;
  outline: 10px solid rgba(0, 0, 0, 0.1);
}
.pop01 > h1 {
  padding: 30px 30px 10px 30px;
  color: #2a3644;
  font-size: 20px;
  font-weight: bold;
}
.pop01 > p {
  padding-left: 30px;
  font-size: 100%;
  color: #777;
}
.pop01 > span {
  cursor: pointer;
  position: absolute;
  top: 4%;
  right: 4%;
  -webkit-border-radius: 100px;
  -moz-border-radius: 100px;
  border-radius: 100px;
  background: #cccccc;
  color: #ffffff;
  width: 30px;
  height: 30px;
  text-align: center;
  display: flex;
  flex-direction: column;
  justify-content: center;
}
/* 찜하기 버튼 그림 설정 */
.btm_image {
	margin: auto 0px;
	width: 40px;
	height: 40px;
	border: 0px;
	background-color:transparent;
}
/* 재선 팝업 창  */
#cartInS_section > #cartInS_button {
  display: block;
  margin: 0 auto;
  width: 200px;
  -webkit-border-radius: 6px;
  -moz-border-radius: 6px;
  -ms-border-radius: 6px;
  -o-border-radius: 6px;
  border-radius: 6px;
  background-color: #fff; /* 배경색 */
  border: 1px solid #dedede; /* 테두리 */
  padding: 5px 10px 6px 7px; /* 패딩 */
  border-radius: 10px;
  cursor: pointer;
}
#cartInS_section > #cartInS_button:hover {
  background-color: #C9ECFF; /* 배경색 */
  border: 1px solid #0099FF; /* 테두리 */
  border-color: #0099FF; /* 테두리 */
  color: #0099FF; /* 글자색 */
}
.cartInS {
  display: none;
/*팝업창 위치조정 바꾸기*/
  position: absolute;
  top: 50%;
  left: 50%;
/*여기까지*/
  z-index: 100;
  width: 300px;
  height: 50px; /* **** 수정 */
  background: #ffffff;
  -webkit-border-radius: 6px;
  -moz-border-radius: 6px;
  -ms-border-radius: 6px;
  -o-border-radius: 6px;
  border-radius: 6px;
  outline: 10px solid rgba(0, 0, 0, 0.1);
}
.cartInS > h1 {
  padding: 30px 30px 10px 30px;
  color: #2a3644;
  font-size: 20px;
  font-weight: bold;
}
.cartInS > p {
  padding-left: 30px;
  font-size: 100%;
  color: #777;
}
.cartInS > span {
  cursor: pointer;
  position: absolute;
  top: 4%;
  right: 4%;
  -webkit-border-radius: 100px;
  -moz-border-radius: 100px;
  border-radius: 100px;
  background: #cccccc;
  color: #ffffff;
  width: 30px;
  height: 30px;
  text-align: center;
  display: flex;
  flex-direction: column;
  justify-content: center;
}
/* 재선 팝업 창  */
#cartInF_section > #cartInF_button {
  display: block;
  margin: 0 auto;
  width: 200px;
  -webkit-border-radius: 6px;
  -moz-border-radius: 6px;
  -ms-border-radius: 6px;
  -o-border-radius: 6px;
  border-radius: 6px;
  background-color: #fff; /* 배경색 */
  border: 1px solid #dedede; /* 테두리 */
  padding: 5px 10px 6px 7px; /* 패딩 */
  border-radius: 10px;
  cursor: pointer;
}
#cartInF_section > #cartInF_button:hover {
  background-color: #C9ECFF; /* 배경색 */
  border: 1px solid #0099FF; /* 테두리 */
  border-color: #0099FF; /* 테두리 */
  color: #0099FF; /* 글자색 */
}
.cartInF {
  display: none;
/*팝업창 위치조정 바꾸기*/
  position: absolute;
  top: 50%;
  left: 50%;
/*여기까지*/
  z-index: 100;
  width: 300px;
  height: 50px; /* **** 수정 */
  background: #ffffff;
  -webkit-border-radius: 6px;
  -moz-border-radius: 6px;
  -ms-border-radius: 6px;
  -o-border-radius: 6px;
  border-radius: 6px;
  outline: 10px solid rgba(0, 0, 0, 0.1);
}
.cartInF > h1 {
  padding: 30px 30px 10px 30px;
  color: #2a3644;
  font-size: 20px;
  font-weight: bold;
}
.cartInF > p {
  padding-left: 30px;
  font-size: 100%;
  color: #777;
}
.cartInF > span {
  cursor: pointer;
  position: absolute;
  top: 4%;
  right: 4%;
  -webkit-border-radius: 100px;
  -moz-border-radius: 100px;
  border-radius: 100px;
  background: #cccccc;
  color: #ffffff;
  width: 30px;
  height: 30px;
  text-align: center;
  display: flex;
  flex-direction: column;
  justify-content: center;
}


.subm4 { /* 버튼 스타일 */
	background-color: #9FCBF6; /* 배경색 */
	border: 1px solid #0E256D; /* 테두리 */
	cursor: pointer; /* 마우스 포인터 */
	padding: 5px 10px 6px 7px; /* 패딩 */
	border-radius: 10px;
	
	box-shadow: 3px 3px 3px #0E256D;
	transition-duration: 0.3s;
	width: 80px;
	height: 50px;
	margin: 0px;
}
.subm4:active {
	margin-left: 5px;
	margin-top: 5px;
	box-shadow: none;
}
.subm4:focus {
	background-color: #0E256D; /* 배경색 */
	border: 1px solid #9FCBF6; /* 테두리 */
	color: #9FCBF6; /* 글자색 */
	box-shadow: 3px 3px 3px #0E256D;
}
/* 결제하기 관련 */
#stayPay {
	height: 30px;
}
/* 찜하기 버튼 그림 설정 */
.btm_image {
	margin: auto 0px;
	width: 40px;
	height: 40px;
	border: 0px;
	background-color:transparent;
}


/* 맵 팝업 창  */
.mapPopup {
  display: none;
/*팝업창 위치조정 바꾸기*/
  position: absolute;
  top: 55%;
  left: 47.5%;
/*여기까지*/
  z-index: 100;
  width: 500px;
  height: 100px; /* **** 수정 */
  background: #ffffff;
  -webkit-border-radius: 6px;
  -moz-border-radius: 6px;
  -ms-border-radius: 6px;
  -o-border-radius: 6px;
  border-radius: 6px;
  outline: 10px solid rgba(0, 0, 0, 0.1);
}

#mapPopup_button {
	height: 30px;
}

#close_map {
	height: 30px;
	position: absolute;
    top: 0.5%;
 	left: 83.5%;
 	z-index: 101;
}

</style>
<script>
/* 팝업 창 재선 pop01 */
$(document).ready(function () {
  $("#pop01_button").click(function () {
    $(".pop01").fadeIn(300);

  });

$(".pop01 > span").click(function () {
    $(".pop01").fadeOut(300);
  });  
});

/* 맵 팝업 만들기*/
$(document).ready(function () {
	  $("#mapPopup_button").click(function () {
	    $(".mapPopup").fadeIn(300);
	    
	  });

	$("#close_map").click(function () {
	    $(".mapPopup").fadeOut(300);
	  });  
	});
	
document.addEventListener(`DOMContentLoaded`, () => {
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption);
	const mapPopup_button = document.querySelector('#mapPopup_button')
	const mapPopup = document.querySelector('#mapPopup');
	
	mapPopup_button.addEventListener(`click`, () => {
		mapPopup.style.height = '500px';
		document.getElementById("mapPopup").style.display ='inline-block';
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		var adress = document.getElementById('stay_address').innerHTML;

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(adress, function(result, status) {

		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {

		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });

		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});
		map.relayout();
	})
})	


/*날짜 : 변재선*/
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
         dateFormat: "yy-mm-dd",
         minDate: 0,
         maxDate: 90,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
         onClose: function( selectedDate ) {
        	 console.log("startDate가 변경됨 : " + selectedDate);
			 $('#_startD').text(selectedDate);
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
         dateFormat: "yy-mm-dd",
         minDate: 1,
         maxDate: 91,                       // 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
         onClose: function( selectedDate ) {    
        	 console.log("endDate가 변경됨 : " + selectedDate);
			 $('#_endD').text(selectedDate);
             // 종료일(endDate) datepicker가 닫힐때
             // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
             $("#startDate").datepicker( "option", "maxDate", selectedDate );
         }    
    });    
});

document.addEventListener(`DOMContentLoaded`, () => {
	var dateCheckConfirm = document.getElementById("dateCheckConfirm");
	var _startD = document.querySelector("#_startD");
    var _endD = document.querySelector("#_endD");
	var startD = document.querySelector("#startD");
    var endD = document.querySelector("#endD");
    
    dateCheckConfirm.addEventListener(`click`, () => {
		console.log("_startD" + _startD.value);
		console.log("_endD" + _endD.value);
		console.log("startD" + startD.value);
		console.log("endD" + endD.value);
    });
});

//결제하기 버튼 클릭 시 실행되는 함수s
function onStayPayButtonClick(event) {
	var _isLogOn=document.getElementById("isLogOn");
	var isLogOn=_isLogOn.value;
	var _startD = $("#_startD").val();
    var _endD = $("#_endD").val();
	var startD = document.querySelector("#startD");
    var endD = document.querySelector("#endD");
    var goods_stay_room_number = document.querySelector("#goods_stay_room_number");
    
	if(isLogOn !="true"){
		alert("로그인 후 주문이 가능합니다!!!");
		
	} else if (startD.value == null || startD.value == undefined || startD.value == "" || startD.value == "입실 날짜") {
        alert("입실 날짜를 선택해주세요");
        return;
    } else if (endD.value == null || endD.value == undefined || endD.value == "" || endD.value == "퇴실 날짜") {
        alert("퇴실 날짜를 선택해주세요");
        return;
    } else if (goods_stay_room_number.value == null || goods_stay_room_number.value == undefined || goods_stay_room_number.value == ""){
    	alert("방 수량을 선택해주세요");
        return;
    } else {
		var form = document.getElementById("getEachStayData");
		form.submit();
	}
}
</script>
</head>
<body>
<div  style="max-width: 1100px; margin: 0 auto;">
<a href="${contextPath}/main.do" class="category_top">홈</a> <span class="category_top">&nbsp;>&nbsp;</span>
<a href="${contextPath }/searchGoodsStay.do" class="category_top">국내숙박</a><br>
<a class="title1">${goods.goods_stay_name}</a><br><br>
<div id="" align="center">
	<table style="min-width:1000px;">
		<tr>
			<td rowspan="11" width="50%">
				<div id="사진">
					<img src="${contextPath }/resources/image/${goods.goods_stay_sort }_내부.jpg" alt="사진" style="width:450px;height:450px;">
				</div>
			</td>
		<tr>
			<td>숙박업소명</td>
			<td>
				<strong>[<span name="goods_stay_name">${goods.goods_stay_name}</span>]</strong>
			</td>
		</tr>
		<tr>
			<td>가격(1박기준)</td>
			<td>
				<c:choose>	
				<c:when test="${not empty goods.goods_stay_sales_price and goods.goods_stay_sales_price != 0}">	
					<fmt:formatNumber value="${goods.goods_stay_price}" type="number" var="goods_price"/>	
					<span style="text-decoration: line-through">${goods_price}원</span>&nbsp;	
					<span style="display: inline-block; max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; vertical-align: top;">	
				    	${goods.goods_stay_discount_title}	
				  	</span>	
					<br>	
					<fmt:formatNumber value="${goods.goods_stay_sales_price}" type="number" var="goods_stay_sales_price"/>	
					${goods_stay_sales_price }원	
				</c:when>	
				<c:otherwise>	
					<fmt:formatNumber value="${goods.goods_stay_price}" type="number" var="goods_price"/>	
					<span>${goods_price}원</span>&nbsp;	
				</c:otherwise>	
				</c:choose>
			</td>
			<td>
				<!-- <img alt="링크 복사" src="" OnClick="clip()" style="height:50px;width:50px;"> -->
				<a style="float: right;" href="#" id="linkBtn">
					<img class="btm_image" src="${contextPath}/resources/image/link.png" alt="링크 복사" OnClick="clip()">
				</a>
				<a href="javascript:" onClick="javascript:addCartList();">
					<img alt="찜하기" src="${contextPath}/resources/image/jjim.png" style="margin: auto 0px; width: 40px; height: 40px; border: 0px; background-color:transparent;">
				</a>&nbsp;&nbsp;
			</td>
		</tr>
		<tr>
			<td>분류</td>
			<td>${goods.goods_stay_sort }</td>
		</tr>
		<!--<tr>
			 <td>상품평</td> -->
			<!--<td>${goods }</td>-->
		<!-- </tr> -->
		<tr>
			<td>주소</td>
			<td>
			<span id="stay_address">${goods.goods_stay_roadAddress }</span>
			</td>
			<td><input type="button" value="지도보기" id="mapPopup_button" class="subm4"/></td>
		</tr>
		<tr>
			<td>방 수량</td>
			<td>
				<!-- <input type="text" name="stay_order_qty_people" id="stay_order_qty_people" > -->
				<!-- <select name="peopleNum1" id="peopleNum1" OnChange="document.getElementById('stay_order_qty_people').value=this.value"> -->
				<select name="goods_stay_room_number" id="goods_stay_room_number" style="width:70px;text-align:center;">
						<option></option>
					<c:forEach var="cnt" begin="1" end="${goods.goods_stay_room_number }">
						<option value="${cnt}">${cnt}</option>
					</c:forEach>
				</select>
				<!-- id가 필요해서 만들었는데 자리는 바꿔줘야함. -->
				<input type="text" id="goods_stay_id" name="goods_stay_id" value="${goods.goods_stay_id }" style="visibility:hidden;display:none;">
			</td>
		</tr>
		<tr>
			<td>인실</td>
			<td>${goods.goods_stay_num_people} 인실</td>
		</tr>
		<tr>
			<td>적립 포인트</td>
			<td>${goods.goods_stay_price*0.01}</td>
		</tr>
		<tr>
			<td>숙박 날짜</td>
				<!-- <td><input type="text" name="startD" id="startD" style="border:none;width:75px;text-align:center;" value="입실 날짜" readOnly>
				- <input type="text" name="endD" id="endD" style="border:none;width:75px;text-align:center;" value="퇴실 날짜" readOnly></td> -->
			<td>
				<section id="pop01_section">
				  <button id="pop01_button">날짜 선택</button> <!-- class="reg" -->
				  <div style="text-align: center">
				  	<input type="text" name="startD" id="startD" style="border:none;width:75px;text-align:center;" value="입실 날짜" readOnly disabled />
					- <input type="text" name="endD" id="endD" style="border:none;width:75px;text-align:center;" value="퇴실 날짜" readOnly disabled />
				  </div>
				</section>
				<div class="pop01" id="pop01" style="height: 400px;">
					<span id="fadeout">✖</span>
					<div style="margin-top: 50px;">
						<input type="text" name="a" id="startDate" onChange="document.getElementById('startD').value=this.value" style="width:180px;text-align:center;" readOnly />
						- <input type="text" name="b" id="endDate" onChange="document.getElementById('endD').value=this.value" style="width:180px;text-align:center;" readOnly />
						<input id="dateCheckConfirm" type="button" value="확인" />
					</div>	
				</div>
			</td>
		</tr>
		<tr>
			<td style="text-align: right" colspan="2">
				<form id="getEachStayData" method="post" action="${contextPath }/order/orderEachGoodsStay.do">
				  	<input type="hidden" name="goods_stay_id" value="${goods.goods_stay_id }">
				  	<input type="hidden" id="_startD" name="startD" >
				  	<input type="hidden" id="_endD" name="endD" >
				  	<input type="button" id="stayPay" name="stayPay_button" value="결제하기" class="subm4" onClick="getDateforOrder(); onStayPayButtonClick(event);" >
				</form>
			</td>
		</tr>
	</table>
</div><br><br><hr>
<%-- 
<c:choose>
	<c:when test="${ empty imageList }">
		<img alt="사진이 없다도르" src="${contextPath}/thumbnails.do?goods_id=${goods.goods_stay_id}&fileName=${goods.goods_stay_fileName}" style="margin:auto;display:block;">
		<c:forEach var="item" items="${imageList }"  varStatus="itemNum">
			<img alt="관련 사진" src="${contextPath}/thumbnails.do?goods_id=${goods.goods_stay_id}&fileName=${item.fileName}" style="margin:auto;display:block;">
		</c:forEach>
	</c:when>
	<c:otherwise>
		<c:forEach var="item" items="${imageList }"  varStatus="itemNum">
			<img alt="관련 사진" src="${contextPath}/thumbnails.do?goods_id=${goods.goods_stay_id}&fileName=${item.fileName}" style="margin:auto;display:block;">
		</c:forEach>
	</c:otherwise>
</c:choose> --%>
<div style="display: none; overflow:scroll; width:auto; height:150px;" >
	<div>
		<h4>홈 > 커뮤니티 > 리뷰</h4>
		<table border="0" align="center" width="80%">
			<c:forEach var="reviews" items="${goodsStayList }">
				<tr align="center">
					<td>${reviews.title}</td>
					<td>${reviews.content}</td>
					<td>${reviews.mem_id}</td>
					<td>${reviews.writeDate}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
<div class="cartInS" id="cartInS" style="height: 300px;">
	<div id="popup">
<!-- 		<span id="fadeout">✖</span> -->
		<font size="7" id="contents">장바구니에 담았습니다.</font><br>
		<form action='${contextPath}/myCartList.do'  >				
			<input type="submit" value="장바구니 보기">
			<input id="cartInSClose" type="button" value="닫기">
		</form>
	</div>
</div>
<div class="cartInF" id="cartInF" style="height: 300px;">
	<div id="popup">
<!-- 	<span id="fadeout">✖</span> -->
	<font size="7" id="contents">같은 상품이 이미 장바구니에 있습니다.</font><br>
	<form action='${contextPath}/myCartList.do'  >				
		<input type="submit" value="장바구니 보기">
		<input id="cartInFClose" type="button" value="닫기">
	</form>
	</div>
</div>
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn }" />


<div class="mapPopup" id="mapPopup" style="height:400px;">
	<button id="close_map" class="subm4">닫기</button>
		<div id="popup">
			<!-- 지도영역 -->
			<div id="map" style="width:500px;height:500px;"></div>
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2ebf944c0806c988ad2d58743abaa15f&libraries=services"></script>
		</div>
</div>
</div>
</body>
</html>