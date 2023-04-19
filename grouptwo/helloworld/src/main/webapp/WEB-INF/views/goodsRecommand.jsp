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
<title>상품추천 페이지</title>

<link href="${contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" media="screen">

<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<style>
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
</style>
</head>
<body>
<div  style="max-width: 1100px; margin: 0 auto;">
<a href="${contextPath}/main.do" class="category_top">홈</a> <span class="category_top">&nbsp;>&nbsp;</span>
<a href="#" class="category_top">상품추천</a><br>
<a href="${contextPath }/goodsRecommand.do" class="title1">상품추천</a><br>
	
	<div id="recoDivBig1">
		<h3 style="display: inline">체험활동 추천&nbsp;&nbsp;&nbsp;</h3>
		<div id="recoDiv2">
			<div class="recoBox" id="recoBox1">
				<img alt="체험활동1" src="${contextPath}/resources/image/reco_11.jpg" />
				<div class="caption">
					<a href="https://www.klook.com/ko/activity/7955-hanbok-rental-voucher-at-kyeonbokgung-store-in-hanboknam-seoul/?spm=Experience_Vertical.ThemeActivity_LIST&clickId=ef1fccfd1a">
						<div class="recoText">
							<h1>경복궁 한국체험</h1>
							<p><br>#한복체험 #경복궁</p>
							<p>#HanboknamKyeongbokgungStore</p>
						</div>
					</a>
				</div>
				<div class="belowCaption">
					<h4>서울 경복궁</h4>
					<p><br>화려한 색감과 수려한 선이<br><br>아름다운 한복을 체험해보세요~</p>
					<input type="button" class="subm5" value="경복궁 한복체험" onClick="location.href='https://www.klook.com/ko/activity/7955-hanbok-rental-voucher-at-kyeonbokgung-store-in-hanboknam-seoul/?spm=Experience_Vertical.ThemeActivity_LIST&clickId=ef1fccfd1a'" >
				</div>
			</div>
			<div class="recoBox">
				<img alt="체험활동2" src="${contextPath}/resources/image/reco_12.jpg" />
				<div class="caption">
					<a href="https://www.klook.com/ko/activity/44416-nami-island-summer-package-10-coupons/?spm=Experience_Vertical.ThemeActivity_LIST&clickId=adfeda35a5">
						<div class="recoText">
							<h1>남이섬</h1>
							<p><br>#짚라인 #동물체험</p>
							<p>#자연힐링타임</p>
						</div>
					</a>
				</div>
				<div class="belowCaption">
					<h4>강원도 남이섬</h4>
					<p><br>여유로운 힐링타임을 즐기고 싶다면!<br><br>동물과 다양한 액티비티 즐기고 싶다면!</p>
					<input type="button" class="subm5" value="남이섬 입장권" onClick="location.href='https://www.klook.com/ko/activity/44416-nami-island-summer-package-10-coupons/?spm=Experience_Vertical.ThemeActivity_LIST&clickId=adfeda35a5'" >
				</div>
			</div>
			<div class="recoBox">
				<img alt="체험활동3" src="${contextPath}/resources/image/reco3.jpg" />
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
				<img alt="체험활동4" src="${contextPath}/resources/image/reco4.jpg" />
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
	
	<div id="recoDivBig2">
		<h3 style="display: inline">숙박 추천지 &nbsp;&nbsp;&nbsp;</h3>
		<div id="recoDiv2">
			<div class="recoBox" id="recoBox1">
				<img alt="숙박1" src="${contextPath}/resources/image/reco1.jpg" />
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
				<img alt="숙박2" src="${contextPath}/resources/image/reco2.jpg" />
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
				<img alt="숙박3" src="${contextPath}/resources/image/reco_23.jpg" />
				<div class="caption">
					<a href="http://localhost:8080/helloworld/goodsStayDetail.do?goods_stay_id=239872">
						<div class="recoText">
							<h1>충남 보령</h1>
							<p><br>#머드축제 #보령바다</p>
							<p>#보령둘레길먹거리</p>
						</div>
					</a>
				</div>
				<div class="belowCaption">
					<h4>충남 보령</h4>
					<p><br>충남 대표 여름 바다 <br><br>할인받고 보령으로 놀러가자~</p>
					<input type="button" class="subm5" value="상화원 한국문학사 숙박예약" onClick="location.href='http://localhost:8080/helloworld/goodsStayDetail.do?goods_stay_id=239872'" >
				</div>
			</div>
			<div class="recoBox" id="recoBox4">
				<img alt="숙박4" src="${contextPath}/resources/image/reco_24.jpg" />
				<div class="caption">
					<a href="http://localhost:8080/helloworld/goodsStayDetail.do?goods_stay_id=238618">
						<div class="recoText">
							<h1>경북 경주</h1>
							<p><br>#첨성대 #불국사</p>
							<p>#추억의수학여행코스</p>
						</div>
					</a>
				</div>
				<div class="belowCaption">
					<h4>경북 경주</h4>
					<p><br>경주에서 볼거리 즐기고, <br><br>먹거리도 즐기고, 숙박까지~</p>
					<input type="button" class="subm5" value="경주 숙박호텔 보러가기" onClick="location.href='http://localhost:8080/helloworld/goodsStayDetail.do?goods_stay_id=238618'" >
				</div>
			</div>
		</div>
	</div><br><br>
	
	<div id="recoDivBig3">
		<h3 style="display: inline">봄맞이 꽃축제 추천 &nbsp;&nbsp;&nbsp;</h3>
		<div id="recoDiv2">
			<div class="recoBox" id="recoBox1">
				<img alt="봄맞이1" src="${contextPath}/resources/image/reco_31.jpg" />
				<div class="caption">
					<a href="https://travel.naver.com/domestic/03330/summary">
						<div class="recoText">
							<h1>경남 양산시</h1>
							<p><br>#매화축제 #통도사</p>
							<p>#등산코스</p>
						</div>
					</a>
				</div>
				<div class="belowCaption">
					<h4>경남 양산</h4>
					<p><br>매화축제로 유명한 양산시에서 봄도,<br><br>무더위 날리기엔 양산에서 여름도!</p>
					<input type="button" class="subm5" value="경상남도 양산시 링크" onClick="location.href='https://travel.naver.com/domestic/03330/summary'" >
				</div>
			</div>
			<div class="recoBox">
				<img alt="봄맞이2" src="${contextPath}/resources/image/reco_32.jpg" />
				<div class="caption">
					<a href="https://travel.naver.com/domestic/02460/summary">
						<div class="recoText">
							<h1>경기도 용인시</h1>
							<p><br>#에버랜드 #4계절행사</p>
							<p>#주말나들이코스</p>
						</div>
					</a>
				</div>
				<div class="belowCaption">
					<h4>경기도 용인</h4>
					<p><br>주말 나들이 코스로 좋은 용인, <br><br>즐거움이 끊이지 않는 곳</p>
					<input type="button" class="subm5" value="경기도 용인시 링크" onClick="location.href='https://travel.naver.com/domestic/02460/summary'" >
				</div>
			</div>
			<div class="recoBox">
				<img alt="봄맞이3" src="${contextPath}/resources/image/reco_33.jpg" />
				<div class="caption">
					<a href="https://travel.naver.com/domestic/04720/summary">
						<div class="recoText">
							<h1>경상북도 군위군</h1>
							<p><br>#드라이브코스 #화본역</p>
							<p>#가장아름다운간이역</p>
						</div>
					</a>
				</div>
				<div class="belowCaption">
					<h4>경상북도 군위</h4>
					<p><br>팔공산으로 드라이브 코스가자~ <br><br>주말 당일치기 기차 여행지</p>
					<input type="button" class="subm5" value="경상북도 군위 링크" onClick="location.href='https://travel.naver.com/domestic/04720/summary'" >
				</div>
			</div>
			<div class="recoBox" id="recoBox4">
				<img alt="봄맞이4" src="${contextPath}/resources/image/reco_34.jpg" />
				<div class="caption">
					<a href="https://travel.naver.com/domestic/01750/summary">
						<div class="recoText">
							<h1>강원도 영월</h1>
							<p><br>#인기관광코스 #평창강</p>
							<p>#작은한반도</p>
						</div>
					</a>
				</div>
				<div class="belowCaption">
					<h4>강원도 영월군</h4>
					<p><br>여름에는 래프팅, 겨울이면 얼음낚시<br><br>작은 한반도가 숨어있는 영월군</p>
					<input type="button" class="subm5" value="강원도 영월 링크" onClick="location.href='https://travel.naver.com/domestic/01750/summary'" >
				</div>
			</div>
		</div>
	</div><br><br>
</div>
</body>
</html>