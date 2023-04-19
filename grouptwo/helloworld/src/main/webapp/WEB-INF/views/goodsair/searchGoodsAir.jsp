<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.net.URLEncoder, java.net.URLDecoder" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<c:set var="airMap"  value="${airMap}"  />
<c:set var="depAirportIdGot"  value="${depAirportIdGot}"  />
<c:set var="depAirportNameGot"  value="${depAirportNameGot}"  />
<c:set var="arrAirportIdGot"  value="${arrAirportIdGot}"  />
<c:set var="arrAirportNameGot"  value="${arrAirportNameGot}"  /> 
<c:set var="depDateGot"  value="${depDateGot}"  /> 

<c:set var="airMap2"  value="${airMap2}"  />
<c:set var="depAirportIdGotRnM"  value="${depAirportIdGotRnM}"  />
<c:set var="arrAirportIdGotRnM"  value="${arrAirportIdGotRnM}"  />
<c:set var="depAirportNameGotRnM"  value="${depAirportNameGotRnM}"  />
<c:set var="arrAirportNameGotRnM"  value="${arrAirportNameGotRnM}"  /> 
<c:set var="arrDateGot"  value="${arrDateGot}"  /> 
<c:set var="flagRadio"  value="${flagRadio}"  /> 

<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%> 
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html> 
<html lang="ko">
<head>
<link href="${contextPath}/resources/css/searchGoodsAir.css" rel="stylesheet" type="text/css" media="screen">

<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=262f9fa7a9f6cbb21b2532aabacdb73f"></script> -->
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=262f9fa7a9f6cbb21b2532aabacdb73f&libraries=services"></script> -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<meta charset="UTF-8">
<title>Hello World!</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<!-- 양하희 css -->
<link href="${contextPath}/resources/css/searchGoodsAir.css" rel="stylesheet" type="text/css" media="screen">
<!-- 변재선 date -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>  

</head>
<body>
	<div  style="max-width: 1100px; margin: 0 auto;">
	<a href="${contextPath}/main.do" class="category_top">홈</a> <span class="category_top">&nbsp;>&nbsp;</span>
	<a href="#" class="category_top">항공</a>
	<br>
	<a href="${contextPath }/searchGoodsAir.do" class="title1">국내항공</a>
	<!-- <p id="radiocheck">라디오체크하기</p> -->
	<div id="backg1">
		<table class="tblGA">
			<tr style="display: none">
				<td><input type="radio" name="airda" value="왕복" id="airda1" /></td>
				<td><input type="radio" name="airda" value="다구간" id="airda2"/></td>
				<td><input type="radio" name="airda" value="편도" id="airda3"/></td>
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
					<input id="in_search" type="button" value="검색하기" class="subm3">
					<!-- </a> -->
				</td>
			</tr>
		</table>
		<hr>
		<table id="searchAirTable2" class="tblGA">
			<tr>
				<td>출발지역<br><p id="p_departAirport">${depAirportNameGot }</p><%-- <p id="p_departAirport">${getDepAirportId }</p> --%></td> 
				<td style="width: 45%;" rowspan="2"><img src="${contextPath}/resources/image/airplaingogo.png" id="airgo" /></td>
				<td>도착지역<br><p id="p_arriveAirport">${arrAirportNameGot }</p><%-- <p id="p_arriveAirport">${getArrAirportId }</p> --%></td>
			</tr>
			<tr>
				<td>
					<section id="pop2_section">
					  <button id="pop2_button" onclick="relayout()" >출발지역 검색하기</button><!-- class="reg" -->
					</section>
					<div class="pop2" id="pop2">
						<span id="fadeout">✖</span>
						<h1>출발지역 검색</h1><!-- <button onclick="relayout()" id="map_hiddenButton1">지도로 검색하기</button>  -->
						<div id="pop2div" style="display: hidden">
							<div id="menu_wrap" class="bg_white" style="display: hidden">
						        <div class="option">
						            <div><!-- <form onsubmit="searchPlaces(); return false;">
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
					  <button id="pop3_button" onclick="relayout3()" >도착지역 검색하기</button>
					</section>
					<div class="pop3" id="pop3">
						<span id="fadeout">✖</span>
						<h1>도착지역 검색</h1>
						<div id="pop3div" style="display: hidden">
							<div id="menu_wrap3" class="bg_white" style="display: hidden">
						        <div class="option"><div></div></div><hr>
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
				<td>출발날짜<p id="p_startDate">${depDateGot }</p></td>
				<td>
					<p id="p_count">성인 1명</p><br>
					<p id="p_level">좌석전체</p>
				</td>
				<td>
					<div style="margin: auto auto;"><p id="p_endDate" style="display: none;" >도착날짜<p id="p_endDate2">${arrDateGot }</p></p></div>
					<p id="p_reStartDate" style="display: none;" >출발날짜(2)</p>
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" name="goods_stay_departure_Date" id="startDate" class="date_input" value="연도-월-일">
				</td>
				<td>
					<section id="pop_section">
					  <button id="pop_button">인원 / 좌석등급</button><!-- class="reg" -->
					</section>
					<div class="pop">
					  <span id="fadeout">✖</span>
					  <h1>인원</h1>
					  <div id="popdiv">
						  <table border="0" class="tblGA" style="text-align: center">
						  	<tr>
						  		<td style="text-align: left">&nbsp;&nbsp;성인 (만 13세 이상)</td>
						  		<td><input id="popBigMinus" type="button" class="subm" style="width: 30px" value="-"></td>
						  		<td><p id="popBigNum">1</p></td>
						  		<td><input id="popBigPlus" type="button" class="subm" style="width: 30px" value="+"></td>
						  	</tr>
						  	<tr>
						  		<td style="text-align: left">&nbsp;&nbsp;소아 (만 2세~만 13세 미만)</td>
						  		<td><input id="popMidMinus" type="button" class="subm" style="width: 30px" value="-"></td>
						  		<td><p id="popMidNum">0</p></td>
						  		<td><input id="popMidPlus" type="button" class="subm" style="width: 30px" value="+"></td>
						  	</tr>
						  	<tr>
						  		<td style="text-align: left">&nbsp;&nbsp;유아 (24개월 미만)</td>
						  		<td><input id="popSmallMinus" type="button" class="subm" style="width: 30px" value="-"></td>
						  		<td><p id="popSmallNum">0</p></td>
						  		<td><input id="popSmallPlus" type="button" class="subm" style="width: 30px" value="+"></td>
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
									    <!-- <option value="프리미엄 일반석">프리미엄 일반석</option> -->
									    <!-- <option value="비즈니스석">비즈니스석</option> -->
									    <!-- <option value="일등석">일등석</option> -->
									  </select>
									  <svg>
									    <use xlink:href="#select-arrow-down"></use>
									  </svg>
									</label>
									<!-- SVG Sprites-->
									<svg class="sprites">
									  <symbol id="select-arrow-down" viewbox="0 0 10 6">
									    <polyline points="1 1 5 5 9 1"></polyline>
									  </symbol>
									</svg>
							  	</td>
							</tr>
						  </table>
						</div>
						<br><br><input id="popConfirm" type="button" class="subm" value="선택완료"><br><br>
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
	<div>
		<table class="tblGB">
			<tr>
				<td>
					<table border="0">
						<tr>
							<td>
								<p>여행지 추천 상품 보기</p>
							</td>
							<td class="seventh">
								<form action="${contextPath}/goodsRecommand.do" method="get">
								<input type="submit" value="클릭" style="display: inline-block" >
								</form>
							</td>
						</tr>
					</table>
				</td>
				<td>
					<a href="#" style="display: inline-block; vertical-align: middle; margin-left: 10px;">
						<img alt="링크복사 이미지" src="${contextPath}/resources/image/link.png" width="40px" height="auto" OnClick="clip()">
					</a>
				</td>
			</tr>
		</table>
			
	</div>

	<hr>
		<a href="https://hhahee.tistory.com/"><img class="advertiseImg" src="${contextPath}/resources/image/adv01.png" alt="광고"></a>
	<hr>
	
	<div id="selectAirTable" style="display: none">
		<table class="apiTable">
			<thead>
				<tr>
					<td colspan="10"><h3>선택한 항공편 &nbsp;&nbsp;&nbsp;</h3></td>
				</tr>
				<tr>
					<td></td>
					<td>항공편명</td>
					<td>항공사명</td>
					<td>출발시간</td>
					<td>도착시간</td>
					<td>출발공항</td>
					<td>도착공항</td>
					<td>일반석운임<br>(비즈니스석)</td>
					<td>찜하기</td>
					<td>삭제하기</td>
				</tr>
			</thead>
			<tbody>
				<tr id="selectAirTableGo">
					<td>가는편</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>					
					<td>
						<a href="#" id="jjimBtn"><img class="btm_image" src="${contextPath}/resources/image/jjim.png" alt="찜하기"></a>						
					</td>
					<td>
						<a href="javascript:onAirPayRoundDelete();" id="deleteBtnGo"><img class="btm_image" src="${contextPath}/resources/image/delete.png" alt="삭제하기"></a>
					</td>
				</tr>
				<tr id="selectAirTableBack">
					<td>오는편</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>					
					<td>
						<a href="#" id="jjimBtn"><img class="btm_image" src="${contextPath}/resources/image/jjim.png" alt="찜하기"></a>						
					</td>
					<td>
						<a href="javascript:onAirPayRoundDelete();" id="deleteBtnBack"><img class="btm_image" src="${contextPath}/resources/image/delete.png" alt="삭제하기"></a>
					</td>
				</tr>
			</tbody>
		</table>
		<div id="selectAirPayDiv">
			<input type="button" id="selectAirPayBtn" name="" value="선택한 항공권 결제하기" class="subm4" onclick="onAirPayButtonRnMClick()">
		</div>
		<hr>
	</div>
	
	
	<!-- 양하희 변재선 공항 API ----------------------------------------------------------------------------------------------------------->
	<%-- <a href="${contextPath }/airapi.do">한국공항공공API TEST</a> --%>
	<%-- <a href="${contextPath }/airapiTago.do" style="background-color: #EFEFEF;">국토교통부_(TAGO)_국내항공운항정보 API TEST</a> --%>
	<p></p>
	
	<h3 style="display: inline">가는 항공편 &nbsp;&nbsp;&nbsp;</h3>
	<c:if test="${getDepAirportId != null}">
		<p style="display: inline">${depAirportNameGot } -> ${arrAirportNameGot }</p>
	</c:if>
	<br><br>

	<div class="apiDiv1">
		<div class="apiDiv2">
			<p class="first_announ"><br><br><br><br><br><br><br>
				검색조건(왕복/다구간/편도, 출발지역, 도착지역, 날짜 등)을 선택하신 후,<br><br>
			<span class="bold">검색하기 버튼을 클릭해주세요.</span> </p>
			<c:if test="${(totalCount ne null) && (totalCount != '')}">
				<c:set var="totalCountNumber1" value="${Integer.parseInt(totalCount)}"/>
				<c:if test="${totalCountNumber1 <= 0}">
					<p id="no_airdata"><br><br><br><br><br>
					죄송합니다. 예약 가능한 항공편이 없습니다.<br><br>
					다른 조건으로 다시 검색해보세요.</p>
				</c:if>
				<c:if test="${totalCountNumber1 > 0}">
					<table class="apiTable">
						<thead>
							<tr>
								<td>항공편명</td>
								<td>항공사명</td>
								<td>출발시간</td>
								<td>도착시간</td>
								<td>출발공항</td>
								<td>도착공항</td>
								<td>일반석운임<br>(비즈니스석)</td>
								<td>찜하기</td>
								<td>결제하기</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="i" begin="0" end="${totalCount - 1}">
								<tr>
									<td>${airMap.vihicleId[i]}</td>
									<td>${airMap.airlineNm[i]}</td>
									<td>${airMap.depPlandTime[i]}</td>
									<td>${airMap.arrPlandTime[i]}</td>
									<td>${airMap.depAirportNm[i]}</td>
									<td>${airMap.arrAirportNm[i]}</td>
									<td>${airMap.economyCharge[i]}원 
										<c:if test="${airMap.prestigeCharge[i] eq '해당없음'}"><br>(${airMap.prestigeCharge[i]})</c:if>
										<c:if test="${airMap.prestigeCharge[i] != '해당없음'}"><br>(${airMap.prestigeCharge[i]}원)</c:if>
									</td>
									<td>
										<form action="${contextPath }/addGoodsAirInCart.do" method="post" enctype="multipart/form-data">
											<input type="text" id="cart_vihicleId" name="cart_vihicleId" value="${airMap.vihicleId[i]}" style="display:none;">
											<input type="text" id="cart_airlineNm" name="cart_airlineNm" value="${airMap.airlineNm[i]}" style="display:none;">
											<input type="text" id="cart_depPlandTime" name="cart_depPlandTime" value="${airMap.depPlandTime[i]}" style="display:none;">
											<input type="text" id="cart_arrPlandTime" name="cart_arrPlandTime" value="${airMap.arrPlandTime[i]}" style="display:none;">
											<input type="text" id="cart_depAirportNm" name="cart_depAirportNm" value="${airMap.depAirportNm[i]}" style="display:none;">
											
											<input type="text" id="cart_arrAirportNm" name="cart_arrAirportNm" value="${airMap.arrAirportNm[i]}" style="display:none;">
											<input type="text" id="cart_economyCharge" name="cart_economyCharge" value="${airMap.economyCharge[i]}" style="display:none;">
											<c:if test="${airMap.prestigeCharge[i] eq '해당없음'}">
												
											</c:if>
											<c:if test="${airMap.prestigeCharge[i] != '해당없음'}">
												<input type="text" id="cart_prestigeCharge" name="cart_prestigeCharge" value="${airMap.prestigeCharge[i]}" style="display:none;">
											</c:if>
											<input type="text" id="cart_air_qty_people" name="cart_air_qty_people" value="1" style="display:none;">
											
											<button type="submit" style="border:none;outline:none;background:#ffffff;">
												<img class="btm_image" src="${contextPath}/resources/image/jjim.png" alt="찜하기">
											</button>
										</form>
										
									</td>
									<td>
										<!-- 편도 -->
										<c:if test="${flagRadio eq 'o'}">
											<input type="button" id="airPay" name="airPay_button" value="결제하기" class="subm4" onclick="onAirPayButtonClick(event)">
										</c:if>
										<!-- 왕복 -->
										<c:if test="${flagRadio eq 'r'}">
											<input type="button" id="airPayRound" name="airPay_buttonR" value="선택하기" class="subm4" onclick="onAirPayRound(event)">
										</c:if>
										<!-- 다구간 -->
										<!-- <input type="button" id="airPayMulti" name="airPay_buttonM" value="다구간임~" class="subm4" onclick="onAirPayMulti(event)"> -->
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
			</c:if>
		</div>
	</div>
	<!-- 양하희 변재선 공항 API ----------------------------------------------------------------------------------------------------------->
	<br><br>
	<h3 style="display: inline">오는 항공편 &nbsp;&nbsp;&nbsp;</h3>
	<c:if test="${getDepAirportIdRnM != null}">
		<p style="display: inline">${depAirportNameGotRnM } -> ${arrAirportNameGotRnM }</p>
	</c:if>
	<br><br>
		<!-- 왕복 -->
		<div id="radiodiv21" style="display: none;  width:100%; text-align: center;" >
			<div class="apiDiv1">
				<div class="apiDiv2">
					<c:if test="${(totalCount2 ne null) && (totalCount2 != '')}">
						<c:set var="totalCountNumber" value="${Integer.parseInt(totalCount2)}"/>
					    <c:if test="${totalCountNumber <= 0}">
							<p id="no_airdata"><br><br><br><br><br>
							죄송합니다. 예약 가능한 항공편이 없습니다.<br><br>
							다른 조건으로 다시 검색해보세요.</p>
						</c:if>
						<c:if test="${totalCountNumber > 0}">
							<table class="apiTable">
								<thead>
									<tr>
										<td>항공편명</td>
										<td>항공사명</td>
										<td>출발시간</td>
										<td>도착시간</td>
										<td>출발공항</td>
										<td>도착공항</td>
										<td>일반석운임<br>(비즈니스석)</td>
										<td>찜하기</td>
										<td>결제하기</td>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="i" begin="0" end="${totalCount2 - 1}">
										<tr>
											<td>${airMap2.vihicleId[i]}</td>
											<td>${airMap2.airlineNm[i]}</td>
											<td>${airMap2.depPlandTime[i]}</td>
											<td>${airMap2.arrPlandTime[i]}</td>
											<td>${airMap2.depAirportNm[i]}</td>
											<td>${airMap2.arrAirportNm[i]}</td>
											<td>${airMap2.economyCharge[i]}원 
												<c:if test="${airMap2.prestigeCharge[i] eq '해당없음'}">
													<br>(${airMap2.prestigeCharge[i]})
												</c:if>
												<c:if test="${airMap2.prestigeCharge[i] != '해당없음'}">
													<br>(${airMap2.prestigeCharge[i]}원)
												</c:if>
											</td>
											<td>
												<a href="#" id="jjimBtn"><img class="btm_image" src="${contextPath}/resources/image/jjim.png" alt="찜하기"></a>
											</td>
											<td>
												<input type="button" id="airPay" name="airPay_button" value="선택하기" class="subm4" onclick="onAirPayRound2(event)">
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:if>
					</c:if>
				</div>
			</div>
		</div>
		
		<!-- 다구간 -->
		<div id="radiodiv22" style="display: none; overflow:scroll; width:98%; height:300px; text-align: center;" >
			<div align=center>
			<table border="1" style="width:95%; text-align: center;">
				<tr>
					<td></td>
					<td><input type="button" class="airsubtitle" value="항공사"></td>
					<td><input type="button" class="airsubtitle" value="좌석등급"></td>
					<td><input type="button" class="airsubtitle" value="출발시간"></td>
					<td><input type="button" class="airsubtitle" value="도착시간"></td>
					<td><input type="button" class="airsubtitle" value="소요시간"></td>
					<td><input type="button" class="airsubtitle" value="예상요금(성인1명 기준)"></td>
				</tr>
				<c:forEach var="goodsAir" items="${goodsAirList}">
					<tr style="text-align: center;">
						<td><img src="" alt="로고"></td>
						<td>${goodsAir.goods_air_name}</td>
						<td>${goodsAir.goods_air_class}</td>
						<td>${goodsAir.goods_air_depart_Date}</td>
						<td>${goodsAir.goods_air_arrive_Date}</td>
						<td>${goodsAir.goods_air_arrive_Date} - ${goodsAir.goods_air_depart_Date }</td>
						<td>${goodsAir.goods_air_price }원, ${goodsAir.goods_air_sales_price }원</td>
					</tr>
				</c:forEach>
			</table>
			</div>
		</div>
		<!-- 편도 -->
		<div id="radiodiv23" style="display: none;"><br><br>   <!-- style="display: none; width: 95%; height:200px;" -->
			<p style="text-align: center; margin:0px;"><span class="bold">편도항공권을 검색하셨습니다.</span><br>
				<br>왕복 항공권 혹은 다구간 항공권 검색을 원하시면 검색조건 변경 후 다시 검색해 주세요.</p>
		</div>
		<!-- 검색하기 전 -->
		<div id="firstNotice"><br><br> 
			<p class="first_announ"><br><br><br><br><br>
				검색조건(왕복/다구간/편도, 출발지역, 도착지역, 날짜 등)을 선택하신 후,<br><br>
				<span class="bold">검색하기 버튼을 클릭해주세요.</span><br><br><br><br><br> </p>
		</div>
		
		<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/>
		
		
		<!-- 개별 결제하기 버튼 클릭시 데이터 가지고오기 -->
		<!-- <div id="getInfoForPaymentData">
			<table class="apiTable">
				<thead id="resultTable tbody">
					<tr>
						<td>항공편명</td>
						<td>항공사명</td>
						<td>출발시간</td>
						<td>도착시간</td>
						<td>출발공항</td>
						<td>도착공항</td>
						<td>일반석운임<br>(비즈니스석)</td>
					</tr>
				</thead>
				<tbody id="selectedData"></tbody>
			</table>
		</div>	 -->
	<script src="${contextPath}/resources/script/searchGoodsAir.js" type="text/javascript"></script>
	</div>
</body>
</html>