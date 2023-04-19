<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="OCC Extranet App cards demo">
<meta name="author" content="Samaritan's Purse International Relief">
<title>Hello World!</title>
<link href="https://fonts.googleapis.com/css?family=Lato:100,300,400" rel="stylesheet">
<link href="${contextPath}/resources/css/admin/managementForm.css" rel="stylesheet" type="text/css" media="screen">
</head>

<body>
<div class="managebody">
    <div class="flexbox-container">

        <!-- 메인페이지 -->
        <a href="${contextPath}/main.do" class="app-card-color">
            <div class="app-card" id="home-card-color" style="background-color:#9FCBF6;">
                <div class="image-container" id="home-icon"></div>
                <div class="text-container">
                    <div class="flip-container" ontouchstart="this.classList.toggle('hover');">
                        <div class="flipper">
                            <div class="front">
                                <p class="title">메인화면</p>
                            </div>
                            <div class="back">
                                <p class="description">메인화면으로<br>돌아갑니다.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </a>
		
		<!-- 회원관리 -->
        <form method="get" action="${contextPath}/admin/listMember.do" id="app-form-color">
		    <button type="submit" class="app-card-color" style="background-color: #ffffff ;">
		        <div class="app-card" id="my-profile-settings-card-color" style="background-color:#9FCBF6;">
		            <div class="image-container" id="my-profile-settings-icon"></div>
		            <div class="text-container">
		                <div class="flip-container" ontouchstart="this.classList.toggle('hover');">
		                    <div class="flipper">
		                        <div class="front">
		                            <p class="title">회원관리</p>
		                        </div>
		                        <div class="back">
		                            <p class="description" style="font-size: 13px;">회원관리 페이지로<br>이동합니다.</p>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </button>
		</form>
		
		<!-- 사업자관리 -->
        <form method="get" action="${contextPath}/admin/listBusiness.do" id="app-form-color">
		    <button type="submit" class="app-card-color" style="background-color: #ffffff ;">
		        <div class="app-card" id="my-profile-settings-card-color" style="background-color:#9FCBF6;">
		            <div class="image-container" id="volunteer-selection-ampersand-onboarding-icon"></div>
		            <div class="text-container">
		                <div class="flip-container" ontouchstart="this.classList.toggle('hover');">
		                    <div class="flipper">
		                        <div class="front">
		                            <p class="title">사업자관리</p>
		                        </div>
		                        <div class="back">
		                            <p class="description" style="font-size: 13px;">사업자관리 페이지로<br>이동합니다.</p>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </button>
		</form>
        
        <!-- 상품관리 -->
        <form method="get" action="${contextPath}/admin/adminOrderList.do" id="app-form-color">
		    <button type="submit" class="app-card-color" style="background-color: #ffffff ;">
		        <div class="app-card" id="drop-off-location-management-card-color" style="background-color:#9FCBF6;">
		            <div class="image-container" id="drop-off-location-management-icon"></div>
		            <div class="text-container">
		                <div class="flip-container" ontouchstart="this.classList.toggle('hover');">
		                    <div class="flipper">
		                        <div class="front">
		                            <p class="title">결제관리</p>
		                        </div>
		                        <div class="back">
		                            <p class="description">결제관리 페이지로<br>이동합니다.</p>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </button>
		</form>
		
		<!-- 문의사항 -->
        <a href="" class="app-card-color">
            <div class="app-card" id="leader-inbox-card-color" style="background-color:#9FCBF6;">
                <div class="image-container" id="leader-inbox-icon"></div>
                <div class="text-container">
                    <div class="flip-container" ontouchstart="this.classList.toggle('hover');">
                        <div class="flipper">
                            <div class="front">
                                <p class="title">문의사항</p>
                            </div>
                            <div class="back">
                                <p class="description">문의사항 페이지로<br>이동합니다.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </a>
	
<!--         이벤트관리 -->
<!--         <a href="" class="app-card-color"> -->
<!--             <div class="app-card" id="reporting-center-card-color" style="background-color:#9FCBF6;"> -->
<!--                 <div class="image-container" id="reporting-center-icon"></div> -->
<!--                 <div class="text-container"> -->
<!--                     <div class="flip-container" ontouchstart="this.classList.toggle('hover');"> -->
<!--                         <div class="flipper"> -->
<!--                             <div class="front"> -->
<!--                                 <p class="title">이벤트관리</p> -->
<!--                             </div> -->
<!--                             <div class="back"> -->
<!--                                 <p class="description">이벤트관리 페이지로<br>이동합니다.</p> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </a> -->
        <!-- 이벤트관리 -->
        <form method="get" action="${contextPath}/admin/eventListAll.do" id="app-form-color">
		    <button type="submit" class="app-card-color" style="background-color: #ffffff ;">
		        <div class="app-card" id="reporting-center-card-color" style="background-color:#9FCBF6;">
		            <div class="image-container" id="reporting-center-icon"></div>
		            <div class="text-container">
		                <div class="flip-container" ontouchstart="this.classList.toggle('hover');">
		                    <div class="flipper">
		                        <div class="front">
		                            <p class="title">이벤트관리</p>
		                        </div>
		                        <div class="back">
		                            <p class="description" style="font-size: 13px;">이벤트관리 페이지로<br>이동합니다.</p>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </button>
		</form>
        
</div>

</body>

</html>