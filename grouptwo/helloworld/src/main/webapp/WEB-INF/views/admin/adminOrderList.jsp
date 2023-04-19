<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="adminStayOrderList" value="${totalOrderMap.adminStayOrderList }"/>
<c:set var="adminAirOrderList" value="${totalOrderMap.adminAirOrderList }"/>

<%-- <c:set var="busiOrderList" value="${busiOrderList}"/> --%>
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
<title>busiOrderList</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<script>

</script>
<style>
#busi_order_history_list{

}

#busi_order_history_stay{
	margin-left:auto;
	margin-right:auto;
	min-width:950px;
}
#busi_order_history_stay thead {
	background:#87c1e9;
	
}
#busi_order_history_stay tr{
	text-align:center;
}

.order_state { /* 버튼 스타일 */
	background-color: #0E256D; /* 배경색 */
	border: 1px solid #9FCBF6; /* 테두리 */
	color: #9FCBF6; /* 글자색 */
	padding: 5px 10px 6px 7px; /* 패딩 */
	border-radius: 10px;
	
	box-shadow: 3px 3px 3px #0E256D;
	transition-duration: 0.3s;
	width: auto;
	height: auto;
	margin: 0px;
}


/*상세페이지버튼*/
#stay_detail { /* 버튼 스타일 */
	background-color: #9FCBF6; /* 배경색 */
	border: 1px solid #0E256D; /* 테두리 */
	cursor: pointer; /* 마우스 포인터 */
	padding: 5px 10px 6px 7px; /* 패딩 */
	border-radius: 10px;
	
	box-shadow: 3px 3px 3px #0E256D;
	transition-duration: 0.3s;
	width: 95%;
	height: auto;
	margin: 0px;
}
#stay_detail:active {
	margin-left: 5px;
	margin-top: 5px;
	box-shadow: none;
}
#stay_detail:focus {
	background-color: #0E256D; /* 배경색 */
	border: 1px solid #9FCBF6; /* 테두리 */
	color: #9FCBF6; /* 글자색 */
	box-shadow: 3px 3px 3px #0E256D;
}


/*승인버튼*/
#busi_permit { /* 버튼 스타일 */
	background-color: #9FCBF6; /* 배경색 */
	border: 1px solid #0E256D; /* 테두리 */
	cursor: pointer; /* 마우스 포인터 */
	padding: 5px 10px 6px 7px; /* 패딩 */
	border-radius: 10px;
	
	box-shadow: 3px 3px 3px #0E256D;
	transition-duration: 0.3s;
	width: auto;
	height: auto;
	margin: 0px;
}
#busi_permit:active {
	margin-left: 5px;
	margin-top: 5px;
	box-shadow: none;
}
#busi_permit:focus {
	background-color: #0E256D; /* 배경색 */
	border: 1px solid #9FCBF6; /* 테두리 */
	color: #9FCBF6; /* 글자색 */
	box-shadow: 3px 3px 3px #0E256D;
}
</style>
</head>
<body>
<div id="busi_order_history_list">
	
	<table id="busi_order_history_stay">
		<thead>
			<tr>
				<td colspan="8" style="background:white; font-size: 20px;"><strong>숙박 상품 결제 현황</strong><br><br></td>
			</tr><br>
			<tr>
				<td>숙소 이름</td>
				<td>결제ID</td>
				<td>입실날짜</td>
				<td>퇴실날짜</td>
				<td>수량</td>
				<td>인실</td>
				<td>가격</td>
			</tr>
		</thead>
		
		<tbody>
		<c:choose>
			<c:when test="${isLogOn == false || isLogOn == null }">
			<tr>
			<td id="isLogin_f_n" colspan="8" style="text-align:center;">로그인 상태에서 확인이 가능합니다.</td>
			</tr>
			</c:when>
		
			<c:when test="${ empty adminStayOrderList }">
			<tr>
			<td colspan="7">결제된 기록이 없습니다.</td>
			</tr>
			</c:when>
		
			<c:otherwise>
				<c:forEach var="item" items="${adminStayOrderList }">
				<tr>
					<td><a href="${contextPath }/goodsStayDetail.do?goods_stay_id=${item.goods_stay_id}"><button id="stay_detail">${item.stay_name }</button></a></td>
					<td>${item.mem_id }</td>
					<td>${item.stay_admissionDate }</td>
					<td>${item.stay_departureDate }</td>
					<td>${item.stay_order_qty_people }</td>
					<td>${item.stay_num_people }</td>
					<td>
						<div>
						${item.stay_price }원
						</div>
						<section>
						<c:choose>
							<c:when test="${ empty item.stay_order_state || item.stay_order_state == null}">
								<button class="order_state" value="결제 상태" disabled>결제 완료</button>
							</c:when>
							<c:when test="${ item.stay_order_state == '취소처리중' }">
								<a href="${contextPath }/admin/adminPermitState.do?stay_seq_num=${item.stay_seq_num}&air_seq_num=0">
								<button id="busi_permit">취소승인</button>
								</a>
								<button class="order_state" value="취소처리중" disabled>취소승인대기중</button>
							</c:when>
							<c:otherwise>
								<button class="order_state" value="취소완료" disabled>${item.stay_order_state}</button>
							</c:otherwise>
						</c:choose>
						</section>
					</td>
				</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		</tbody>
	</table>
	
	<table id="busi_order_history_stay">
		<thead>
			<tr><br><br>
				<td colspan="9" style="background:white; font-size: 20px;"><strong>항공 상품 결제 현황</strong><br><br></td>
			</tr>
			<tr>
				<td>항공기ID</td>
				<td>항공사</td>
				<td>결제ID</td>
				<td>출발날짜(시간)</td>
				<td>도착날짜(시간)</td>
				<td>출발지역</td>
				<td>도착지역</td>
				<td>인원</td>
				<td>가격</td>
			</tr>
		</thead>
		
		<tbody>
		<c:choose>
			<c:when test="${isLogOn == false || isLogOn == null }">
			<tr>
			<td id="isLogin_f_n" colspan="8" style="text-align:center;">로그인 상태에서 확인이 가능합니다.</td>
			</tr>
			</c:when>
		
			<c:when test="${ empty adminAirOrderList }">
			<tr>
			<td colspan="9">결제된 기록이 없습니다.</td>
			</tr>
			</c:when>
		
			<c:otherwise>
				<c:forEach var="item" items="${adminAirOrderList }">
				<tr>
					<td>${item.air_order_vihicleId }</td>
					<td>${item.air_order_airlineNm }</td>
					<td>${item.mem_id }</td>
					<td>${item.air_order_depPlandTime }</td>
					<td>${item.air_order_arrPlandTime }</td>
					<td>${item.air_order_depAirportNm }</td>
					<td>${item.air_order_arrAirportNm }</td>
					<td>${item.air_order_qty_people }</td>
					<td>
						<div>
						${item.air_order_Charge }원
						</div>
						<section>
						<c:choose>
							<c:when test="${ empty item.air_order_state || item.air_order_state == null}">
								<button class="order_state" value="결제 상태" disabled>결제 완료</button>
							</c:when>
							<c:when test="${ item.air_order_state == '취소처리중' }">
								<a href="${contextPath }/admin/adminPermitState.do?air_seq_num=${item.air_seq_num}&stay_seq_num=0">
								<button id="busi_permit">취소승인</button>
								</a>
								<button class="order_state" value="취소처리중" disabled>취소승인대기중</button>
							</c:when>
							<c:otherwise>
								<button class="order_state" value="취소완료" disabled>${item.air_order_state}</button>
							</c:otherwise>
						</c:choose>
						</section>
					</td>
				</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		</tbody>
	</table>
</div>


</body>
</html>