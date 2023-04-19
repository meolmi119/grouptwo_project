<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%> 
<% request.setCharacterEncoding("utf-8"); %>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<head>
<title>숙박 상품 리스트</title>
<style>
.seventh input {
  background-color: #9FCBF6; /* 배경색 */
  border: 1px solid #0E256D; /* 테두리 */
  box-shadow: 3px 3px 3px #0E256D;
  border-radius: 10px;
  cursor: pointer; /* 마우스 포인터 */
  width: 100%;
  color: black;
}

.seventh input:hover {
  background-color: #0E256D; /* 배경색 */
  border: 1px solid #9FCBF6; /* 테두리 */
  color: #9FCBF6; /* 글자색 */
  box-shadow: 3px 3px 3px #0E256D;
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
#test001 {
	border:1px solid black;
	min-width:800px;
}
hr {
	background-color:blue;
	height:1px;
}
#goodsStayList > td,
#goodsStayList > tr,
#goodsStayList > p {
	color:white;
}
#goodsStayList {
	margin: 0px auto;
	width: 98%;
}
#goodsStayList thead {
	font-weight: bold;
}
#goodsStayList, #goodsStayList tr {
	border: 1px solid #000000;
	border-collapse: collapse;
}
#goodsStayList td {
	height: 50px;
}
.staySearch input{
  background-color: #9FCBF6; /* 배경색 */
  border: 1px solid #0E256D; /* 테두리 */
  box-shadow: 3px 3px 3px #0E256D;
  border-radius: 10px;
  cursor: pointer; /* 마우스 포인터 */
  width: 7%;
  color: black;
  font-weight: bold;
}
#searchHeader input {
  background-color: #9FCBF6; /* 배경색 */
  border: 1px solid #0E256D; /* 테두리 */
  box-shadow: 3px 3px 3px #0E256D;
  border-radius: 10px;
  cursor: pointer; /* 마우스 포인터 */
  color: black;
  display:inline-block;
  width: 100%;
  max-width: 300px; /* 최대 가로 크기 */
  height: 60px; /* 세로 크기 */
  padding: 5px; /* 내부 여백 */
  font-size: 16px; /* 폰트 크기 */
  font-weight: bold;
}
.staySearch input:hover{
  background-color: #0E256D; /* 배경색 */
  border: 1px solid #9FCBF6; /* 테두리 */
  color: #9FCBF6; /* 글자색 */
  box-shadow: 3px 3px 3px #0E256D;
}
.staySearch_in{
  width: 50%;
/*border: 3px solid #9FCBF6; */
  border: none;
  padding: 5px;
  height: 20px;
  border-radius: 5px;
  outline: none;
  color: #black;
}
/*숙박 검색하기 글자*/
.stayTop{
  background-color: #9FCBF6; /* 배경색 */
  margin-top:0px;
  margin-bottom:0px;
  border: 0px solid #000000;
  border-bottom: none;
  color: white;
}
/*searchTd 다 들어가 있는 form*/
#searchForm{
  background-color: #9FCBF6; /* 배경색 */
  display: flex;
  justify-content: center;
  align-items: left;
}
/*지역,분류,숙소명 td*/
.searchTd1 {
  background-color: white; /* 배경색 */
  border-radius: 10px 0 0 10px;
  border: 1px solid #ccc;
  text-align: center;
  vertical-align: middle;
  height: 20px; /* 요소의 세로 크기 */
  width: 40%;
}
.searchTd2 {
  background-color: white; /* 배경색 */
  border: 1px solid #ccc;
  text-align: center;
  vertical-align: middle;
}
.searchTd3 {
  background-color: white; /* 배경색 */
  border-radius: 0 10px 10px 0;
  border: 1px solid #ccc;
  text-align: center;
  vertical-align: middle;
}
.searchTd4 {
 
}
.staySelect{
  border: none;
}
.searchH4{
  margin-top:0px;
  margin-bottom:5px;
}
.goodsStayListTop{
  font-weight: bold;
}
.advertiseImg {
	width: 100%;
}
</style>
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
</script>
</head>
<body>
<div  style="max-width: 1100px; margin: 0 auto;">
<a href="${contextPath}/main.do" class="category_top">홈</a> <span class="category_top">&nbsp;>&nbsp;</span>
<a href="${contextPath }/searchGoodsStay.do" class="category_top">국내숙박</a><br>
<a href="${contextPath }/searchGoodsStay.do" class="title1">국내숙박</a><br>
<div id="test001">
<h4 class="stayTop">[숙박 검색하기]</h4>
<form id="searchForm" action="${contextPath}/searchGoodsStay.do" method="get">
	<table>
		<tr>
			<td class="searchTd1">
				<h4 class="searchH4">지역</h4>
				<input class="staySearch_in" type="text" name="keywordAddress" value="${totalKeyword.keywordAddress }">
			</td>
			<td class="searchTd2">
				<h4 class="searchH4">분류</h4>
				<select class="staySelect" style="width:120px;" name="keywordSort">
					<option></option>
					<option>일반호텔</option>
					<option>여관업</option>
					<option>숙박업(생활)</option>
					<option>여인숙업</option>
					<option>숙박업 기타</option>
					<option>관광호텔</option>
					<option>휴양콘도미니엄업</option>
				</select>
			</td>
			<td class="searchTd3">
				<h4 class="searchH4">숙소명</h4>
				<input class="staySearch_in" type="text" name="keywordName" value="${totalKeyword.keywordName }">
			</td>
			<td class="searchTd4">
				<div id="searchHeader" style="text-align:right;">
					<input type="submit" value="검색하기" style="display:inline-block">
				</div>
			</td>
		</tr>
	</table>
</form>
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
			
	</div><hr>
<div style="text-align:center;">
		<a href="https://hhahee.tistory.com/"><img class="advertiseImg" src="${contextPath}/resources/image/adv01.png" alt="광고"></a>
</div><hr>
<div style="overflow:scroll; width:auto; height:350px;" >
	<div>
		<table id="goodsStayList" border="0" align="center" width="80%" style="min-width:1000px;">
			<tr class="goodsStayListTop" align="center" style="height:40px;">
				<td></td>
				<td>숙소명</td>
				<td>분류</td>
				<td>주소</td>
				<td>숙박 가능 인원</td>
				<td>가격</td>
			</tr>
			<c:choose>
				<c:when test="${ empty goodsStayList }">
					<tr>
						<td colspan=6 class="fixed" style="text-align:center;padding-top:40px;"><strong>검색하신 정보에 해당하는 상품이 없습니다.</strong></td>
					</tr>
				</c:when>
				<c:otherwise>
					<!-- begin 숫자는 인덱스인가? -->
					<c:forEach var="goodsStay" items="${goodsStayList }" begin="0" end="100">
						<tr align="center" style=";height:100px;">
							<td>
								<a href="${contextPath}/goodsStayDetail.do?goods_stay_id=${goodsStay.goods_stay_id}">
									<img alt="외부사진" src="${contextPath }/resources/image/${goodsStay.goods_stay_sort }.jpg" style="width:50px;height:50px;">
								</a>
							</td>
							<td>
								<a href="${contextPath}/goodsStayDetail.do?goods_stay_id=${goodsStay.goods_stay_id}">
									${goodsStay.goods_stay_name }
								</a>
							</td>
							<td>
								<a href="${contextPath}/goodsStayDetail.do?goods_stay_id=${goodsStay.goods_stay_id}">
									${goodsStay.goods_stay_sort }
								</a>
							</td>
							<td>
								<a href="${contextPath}/goodsStayDetail.do?goods_stay_id=${goodsStay.goods_stay_id}">
									${goodsStay.goods_stay_roadAddress }
								</a>
							</td>
							<td>
								<a href="${contextPath}/goodsStayDetail.do?goods_stay_id=${goodsStay.goods_stay_id}">
									${goodsStay.goods_stay_num_people }
								</a>
							</td>
							<td>
								<a href="${contextPath}/goodsStayDetail.do?goods_stay_id=${goodsStay.goods_stay_id}">
									${goodsStay.goods_stay_price }원, 할인 : ${goodsStay.goods_stay_sales_price }원
								</a>
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
</div>
</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.31.3/js/jquery.tablesorter.min.js"></script>
<script type="text/javascript">
$(function(){
	  $('#keywords').tablesorter(); 
	});
</script>