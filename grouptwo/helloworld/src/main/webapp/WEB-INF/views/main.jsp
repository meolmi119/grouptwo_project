<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>

<link href="${contextPath}/resources/css/searchGoodsAir.css" rel="stylesheet" type="text/css" media="screen">
<link href="${contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" media="screen">

<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<script>
	/* document.addEventListener(`DOMContentLoaded`, () => {	
	 const bul1 = document.querySelector('#bul1')
	 const bul2 = document.querySelector('#bul2')
	 const bul3 = document.querySelector('#bul3')
	 const bul4 = document.querySelector('#bul4')
	 const bul5 = document.querySelector('#bul5')
	
	 const inner = document.querySelector('.inner')
	
	 bul1.addEventListener(`click`, () => {
	 inner.style.cssText = "margin-left: 0;";
	 })
	 bul2.addEventListener(`click`, () => {
	 inner.style.cssText = "margin-left: -100%;";
	 })
	 bul3.addEventListener(`click`, () => {
	 inner.style.cssText = "margin-left: -200%;";
	 })
	 bul4.addEventListener(`click`, () => {
	 inner.style.cssText = "margin-left: -300%;";
	 })
	 bul5.addEventListener(`click`, () => {
	 inner.style.cssText = "margin-left: -400%;";
	 })
	 }) */
document.addEventListener(`DOMContentLoaded`, () => {
	const in_search = document.querySelector('#in_search');	// 검색하기 버튼
	const radioButtons = document.getElementsByName("airda");	// 라디오 버튼
	const recoBox = document.querySelector('.recoBox');
	const caption = recoBox.querySelector('.caption');
	
	// 검색하기 버튼 클릭
    in_search.addEventListener('click', () => {
    	// 라디오 버튼이 선택되었는지 확인
	    let isSelected = false;
	    for (const radioButton of radioButtons) {
	      if (radioButton.checked) {
	        isSelected = true;
	        break;
	      }
    }
	if (isSelected) {
		if(radioCurrentStatus == "다구간") {
			recoBox.addEventListener('mouseover', function() {
			  caption.style.opacity = 1;
			  caption.style.transform = 'translateY(80px)';
			});
		}
	}
	
		 
});
</script>
</head>
<body>
	<!-- <h3 class="text_page" id="login_h">메인페이지입니다.</h3> -->

	<div id="slider">
		<input type="radio" name="slider" id="slide1" checked> 
		<input type="radio" name="slider" id="slide2"> 
		<input type="radio" name="slider" id="slide3"> 
		<input type="radio" name="slider" id="slide4"> 
		<input type="radio" name="slider" id="slide5">

		<div id="slides">
			<div id="overflow">
				<div class="inner">
					<div class="slide slide_1">
						<div class="slide-content">
							<a href="http://localhost:8080/helloworld/searchGoodsAir.do">
								<img class="slider2_img" id="img1" src="${contextPath}/resources/image/main1.jpg" alt="Image_1" />
							</a>
						</div>
					</div>
					<div class="slide slide_2">
						<div class="slide-content">
							<a href="http://localhost:8080/helloworld/goodsStayDetail.do?goods_stay_id=238592">
								<img class="slider2_img" id="img2" src="${contextPath}/resources/image/main2.jpg" alt="Image_2" />
							</a>
						</div>
					</div>
					<div class="slide slide_3">
						<div class="slide-content">
							<a href="#"> 
								<img class="slider2_img" id="img3" src="${contextPath}/resources/image/main3.jpg" alt="Image_3" />
							</a>
						</div>
					</div>
					<div class="slide slide_4">
						<div class="slide-content">
							<a href="http://localhost:8080/helloworld/searchGoodsAir.do">
								<img class="slider2_img" id="img4" src="${contextPath}/resources/image/main4.jpg" alt="Image_4" />
							</a>
						</div>
					</div>
					<div class="slide slide_5">
						<div class="slide-content">
							<a href="http://localhost:8080/helloworld/goodsStayDetail.do?goods_stay_id=247808">
								<img class="slider2_img" id="img5" src="${contextPath}/resources/image/main5.jpg" alt="Image_5" />
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="controls">
			<label for="slide1" class="controlsLabel"></label> 
			<label for="slide2" class="controlsLabel"></label> 
			<label for="slide3" class="controlsLabel"></label> 
			<label for="slide4" class="controlsLabel"></label> 
			<label for="slide5" class="controlsLabel"></label>
		</div>
		<div id="bullets">
			<label for="label1" id="bul1" class="bulLabel"></label> 
			<label for="label2" id="bul2" class="bulLabel"></label> 
			<label for="label3" id="bul3" class="bulLabel"></label> 
			<label for="label4" id="bul4" class="bulLabel"></label> 
			<label for="label5" id="bul5" class="bulLabel"></label>
		</div>
	</div>

	<div id="backg1" style="max-width: 960px; margin: 30px auto; background-color: #FCFCFF; background-image: none; border: 1px solid #ccc;"><!-- #E2EEFB; -->
		<table class="tblGA">
			<tr style="display: none">
				<td><input type="radio" name="airda" value="왕복" id="airda1" /></td>
				<td><input type="radio" name="airda" value="다구간" id="airda2"/></td>
				<td><input type="radio" name="airda" value="편도" id="airda3" /></td>
				<td></td>
			</tr>
			<tr>
				<td colspan="3" style="text-align: left;">
					<label for="airda1" class="subm4" id="airda01">왕복</label> 
					<label for="airda2" class="subm4" id="airda02" style="display: none">다구간</label> 
					<label for="airda3" class="subm4" id="airda03">편도</label>
				</td>
				<td>
					<%-- <a href="${contextPath }/airapiTago.do"> --%> 
					<input id="in_search" type="button" value="검색하기" class="subm3"> <!-- </a> -->
				</td>
			</tr>
		</table>
		<hr>
		<table id="searchAirTable2" class="tblGA">
			<tr>
				<td>출발지역<br>
					<p id="p_departAirport">${depAirportNameGot }</p>
					<%-- <p id="p_departAirport">${getDepAirportId }</p> --%>
				</td>
				<td style="width: 45%;" rowspan="2">
					<img src="${contextPath}/resources/image/airplaingogo.png" id="airgo" />
				</td>
				<td>도착지역<br>
					<p id="p_arriveAirport">${arrAirportNameGot }</p>
					<%-- <p id="p_arriveAirport">${getArrAirportId }</p> --%>
				</td>
			</tr>
			<tr>
				<td>
					<section id="pop2_section">
						<button id="pop2_button" onclick="relayout()">출발지역 검색하기</button>
						<!-- class="reg" -->
					</section>
					<div class="pop2" id="pop2">
						<span id="fadeout">✖</span>
						<h1>출발지역 검색</h1>
						<!-- <button onclick="relayout()" id="map_hiddenButton1">지도로 검색하기</button>  -->
						<div id="pop2div" style="display: hidden">
							<div id="menu_wrap" class="bg_white" style="display: hidden">
								<div class="option">
									<div>
										<!-- <form onsubmit="searchPlaces(); return false;">
					                    공항검색 : <input type="text" value="공항" id="keyword" size="13"> 
					                    <button type="submit">검색하기</button></form> -->
									</div>
								</div><hr>
								<ul id="placesList"></ul><hr>
								<div id="pagination"></div>
							</div>
							<div class="map_wrap" id="map_hidden1" style="display: hidden">
								<!-- <div id="map" style="width:100%;height:100%;position:absolute;overflow:auto;"></div> -->
								<div id="map"></div>
								<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=262f9fa7a9f6cbb21b2532aabacdb73f"></script>
							</div>
						</div>
					</div>
				</td>
				<td>
					<section id="pop3_section">
						<button id="pop3_button" onclick="relayout3()">도착지역 검색하기</button>
					</section>
					<div class="pop3" id="pop3">
						<span id="fadeout">✖</span>
						<h1>도착지역 검색</h1>
						<div id="pop3div" style="display: hidden">
							<div id="menu_wrap3" class="bg_white" style="display: hidden">
								<div class="option">
									<div></div>
								</div><hr>
								<ul id="placesList3"></ul><hr>
								<div id="pagination"></div>
							</div>
							<div class="map_wrap" id="map_hidden3" style="display: hidden">
								<div id="map3"></div>
								<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=262f9fa7a9f6cbb21b2532aabacdb73f"></script>
							</div>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>출발날짜
					<p id="p_startDate">${depDateGot }</p>
				</td>
				<td>
					<p id="p_count">성인 1명</p><br>
					<p id="p_level">좌석전체</p>
				</td>
				<td>
					<div style="margin: auto auto;">
						<p id="p_endDate" style="display: none;">도착날짜<p id="p_endDate2">${arrDateGot }</p></p>
					</div>
					<p id="p_reStartDate" style="display: none;">출발날짜(2)</p>
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" name="goods_stay_departure_Date" id="startDate" class="date_input" value="연도-월-일">
				</td>
				<td>
					<section id="pop_section">
						<button id="pop_button">인원 / 좌석등급</button>
						<!-- class="reg" -->
					</section>
					<div class="pop">
						<span id="fadeout">✖</span>
						<h1>인원</h1>
						<div id="popdiv">
							<table border="0" class="tblGA" style="text-align: center">
								<tr>
									<td style="text-align: left">&nbsp;&nbsp;
										성인 (만 13세 이상)
									</td>
									<td>
										<input id="popBigMinus" type="button" class="subm" style="width: 30px" value="-">
									</td>
									<td>
										<p id="popBigNum">1</p>
									</td>
									<td>
										<input id="popBigPlus" type="button" class="subm" style="width: 30px" value="+">
									</td>
								</tr>
								<tr>
									<td style="text-align: left">&nbsp;&nbsp;
										소아 (만 2세~만 13세 미만)
									</td>
									<td>
										<input id="popMidMinus" type="button" class="subm" style="width: 30px" value="-">
									</td>
									<td>
										<p id="popMidNum">0</p>
									</td>
									<td>
										<input id="popMidPlus" type="button" class="subm" style="width: 30px" value="+">
									</td>
								</tr>
								<tr>
									<td style="text-align: left">&nbsp;&nbsp;
										유아 (24개월 미만)
									</td>
									<td>
										<input id="popSmallMinus" type="button" class="subm" style="width: 30px" value="-">
									</td>
									<td>
										<p id="popSmallNum">0</p>
									</td>
									<td>
										<input id="popSmallPlus" type="button" class="subm" style="width: 30px" value="+">
									</td>
								</tr>
								<tr>
									<td colspan="4" style="text-align: left;"><br> 
										<span>&nbsp;&nbsp;아동 및 유아 예약 안내</span> 
										<input id="checkBtn" type="button" value="보기" style="font-size: 10px;" /> 
										<input id="unCheckBtn" type="button" value="닫기" style="font-size: 10px;" />
									</td>
								</tr>
								<tr>
									<td colspan="4" style="margin: 0 auto; text-align: left;">
										<div id="menubar01">
											<p class="pMenubar01">** 유/소아 동반 여행 시 나이 제한과 정책은 항공사별로 다를 수 있으니 예약하기 전에 해당 항공사와 확인하시기 바랍니다.</p>
											<p class="pMenubar01">** 유아는 좌석을 점유하지 않습니다. 좌석 점유를 원하시는 경우 소아로 예매를 진행해 주시기 바랍니다.</p>
											<p class="pMenubar01">** 귀국/도착일 기준으로 나이 조건이 변경될 경우 추가요금이 부과될 수 있습니다.(생년월일 확인 가능한 증빙서류 지참)</p>
										</div>
									</td>
								</tr>
							</table>
						</div>
						<h1>좌석 등급</h1>
						<div id="popdiv">
							<table border="0" class="tblGA">
								<tr>
									<td>
										<label class="select" for="slct"> 
											<select id="slct" required="required">
												<option value="좌석 전체" selected="selected">좌석 전체</option>
												<!-- <option value="일반석">일반석</option> -->
												<!-- <option value="비즈니스석">비즈니스석</option> -->
												<!-- <option value="프리미엄 일반석">프리미엄 일반석</option> -->
												<!-- <option value="일등석">일등석</option> -->
											</select> 
											<svg>
									    		<use xlink:href="#select-arrow-down"></use>
									  		</svg>
										</label> <!-- SVG Sprites--> 
										<svg class="sprites">
									  		<symbol id="select-arrow-down" viewbox="0 0 10 6">
									   			<polyline points="1 1 5 5 9 1"></polyline>
									 		</symbol>
										</svg>
									</td>
								</tr>
							</table>
						</div><br><br>
						<input id="popConfirm" type="button" class="subm" value="선택완료"><br><br>
					</div>
				</td>
				<td>
					<input type="text" name="goods_stay_departure_Date" id="endDate" class="date_input" value="연도-월-일" style="display: none;" /> 
					<input type="text" name="goods_stay_departure_Date" id="reStartDate" class="date_input" value="연도-월-일" style="display: none;" />
				</td>
				<td>
					<!-- <input type="button" class="subm" value="좌석등급"/> -->
				</td>
			</tr>
			<tr id="roundTrip" style="display: none;">
				<td>다구간일때</td>
			</tr>
		</table>
	</div>
	
	<div id="recoDiv1">
		<h3 style="display: inline">여행 추천지 &nbsp;&nbsp;&nbsp;</h3>
		<div id="recoDiv2">
			<div class="recoBox" id="recoBox1">
				<img alt="여행추천지1" src="${contextPath}/resources/image/reco1.jpg" />
				<div class="caption">
					<a href="http://tour.interpark.com/freeya/Discovery/View.aspx?seq=12480">
						<div class="recoText">
							<h1>강원 양양</h1>
							<p><br>#한국의발리 #서핑</p>
							<p>#여름액티비티</p>
						</div>
					</a>
				</div>
				<div class="belowCaption">
					<h4>강원도 양양</h4>
					<p><br>여름 액티비티도 즐기고~<br><br>친구도 만들고! 게스트하우스 체험</p>
					<input type="button" class="subm5" value="양리단길 게스트하우스" onClick="location.href='http://localhost:8080/helloworld/goodsStayDetail.do?goods_stay_id=252163'" >
				</div>
			</div>
			<div class="recoBox">
				<img alt="여행추천지2" src="${contextPath}/resources/image/reco2.jpg" />
				<div class="caption">
					<a href="https://brunch.co.kr/@dailynews/603">
						<div class="recoText">
							<h1>부산 해운대</h1>
							<p><br>#바다뷰 #더베이101</p>
							<p>#독보적인야경뷰</p>
						</div>
					</a>
				</div>
				<div class="belowCaption">
					<h4>부산 해운대</h4>
					<p><br>낮에는 야외수영장, <br><br>밤에는 도보 10분! 더베이101 야경</p>
					<input type="button" class="subm5" value="하운드 해운대 가든&테라스 호텔" onClick="location.href='http://localhost:8080/helloworld/goodsStayDetail.do?goods_stay_id=264902'" >
				</div>
			</div>
			<div class="recoBox">
				<img alt="여행추천지3" src="${contextPath}/resources/image/reco3.jpg" />
				<div class="caption">
					<a href="https://korean.visitseoul.net/entertainment/%ED%95%9C%EC%8B%9D%EB%AC%B8%ED%99%94%EA%B4%80_/28748">
						<div class="recoText">
							<h1>한식문화관</h1>
							<p><br>#계절한식 #한식체험마당</p>
							<p>#한식의명품화</p>
						</div>
					</a>
				</div>
				<div class="belowCaption">
					<h4>한식문화관</h4>
					<p><br>한식배움터, 한식체험마당, 한식사랑방 <br><br>tel) 02-6053-7177</p>
					<input type="button" class="subm5" value="리뷰 보러가기" onClick="location.href='#'" >
				</div>
			</div>
			<div class="recoBox" id="recoBox4">
				<img alt="여행추천지4" src="${contextPath}/resources/image/reco4.jpg" />
				<div class="caption">
					<a href="https://www.donggu.go.kr/dg/tour/contents/989">
						<div class="recoText">
							<h1>대전 대청호</h1>
							<p><br>#뮤직페스티벌 #벚꽃길</p>
							<p>#대청호벚꽃축제</p>
						</div>
					</a>
				</div>
				<div class="belowCaption">
					<h4>대전 대청호</h4>
					<p><br>제5회 대청호 벚꽃축제<br><br>너와 나, 가치 더하는 생태 한 스푼!</p>
					<input type="button" class="subm5" value="맛집공유 보러가기" onClick="location.href='#'" >
				</div>
			</div>
		</div>
	</div><br><br>

	<!-- 이중 Map 형 데이터를 저장한 변수 -->
	<c:set var="doubleMap" value="${stayMap}" />

	<!-- 외부 Map의 key 값을 가져옴 -->
	<c:forEach items="${doubleMap.keySet()}" var="outerKey">
		<!-- 내부 Map의 key와 value 값을 가져옴 -->
		<c:set var="myGoodsList" value="${doubleMap[outerKey].myGoodsList}" />
		<c:set var="myStayCartList" value="${doubleMap[outerKey].myStayCartList}" />
		<c:forEach var="item" items="${myGoodsList}">
        	${item.goods_stay_id }${item.goods_stay_name }${item.goods_stay_sort }${item.goods_stay_id }
        </c:forEach>
		<%-- <c:forEach items="${doubleMap[outerKey]}" var="innerEntry">
	        <!-- 내부 Map의 key와 value 출력 -->
	        <p>Outer Key: ${outerKey}, Inner Key: ${innerEntry.key}, Value: ${innerEntry.value}</p>
    	</c:forEach> --%>
	</c:forEach>

	<script src="${contextPath}/resources/script/searchGoodsAir.js" type="text/javascript"></script>
</body>
</html>