<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="goods"  value="${goodsMap.goods}"  />
<c:set var="imageFileList"  value="${goodsMap.imageFileList}"  />
<%
  //치환 변수 선언합니다.
   pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
   pageContext.setAttribute("br", "<br/>"); //br 태그
%> 
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<meta charset="UTF-8">
<title>Hello World!</title>
<link href="${contextPath}/resources/css/modifyGoodsStayForm.css" rel="stylesheet" type="text/css" media="screen">

<script type="text/javascript">
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
         dateFormat: "yymmdd",
         minDate: 30,
         maxDate: 90,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
         onClose: function( selectedDate ) {    
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
         dateFormat: "yymmdd",
         minDate: 1,
         maxDate: 300,                       // 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
         onClose: function( selectedDate ) {    
             // 종료일(endDate) datepicker가 닫힐때
             // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
             $("#startDate").datepicker( "option", "maxDate", selectedDate );
         }    
    });    
});
</script>
<script type="text/javascript">
$(document).ready(function() {
	init();
});

function init() {	/* 숙소분류를 데이터베이스(원래 값)으로 처음 나오게 하기 위한 함수 */
	var frm_mod_goods = document.frm_mod_goodsStay;
	
	var h_goods_stay_sort = frm_mod_goods.h_goods_stay_sort;
	var goods_stay_sort = h_goods_stay_sort.value;
	
	var select_goods_status = frm_mod_goods.select_goods_stay_sort;
	 	select_goods_status.value = goods_stay_sort;
}
</script>
<script type="text/javascript">
function fn_modify_goods(goods_stay_id, attribute){
	var frm_mod_goods=document.frm_mod_goodsStay;
	var value="";
	if(attribute=='goods_stay_name'){
		value=frm_mod_goods.goods_stay_name.value;
		alert("숙박 상품의 숙소명을 수정했습니다.");
	}else if(attribute=='goods_stay_roadAddress'){
		value=frm_mod_goods.goods_stay_roadAddress.value;
		fn_modify_goods('${goods.goods_stay_id }','goods_stay_jibunAddress');
	}else if(attribute=='goods_stay_jibunAddress'){
		value=frm_mod_goods.goods_stay_jibunAddress.value;
		fn_modify_goods('${goods.goods_stay_id }','goods_stay_namujiAddress');
	}else if(attribute=='goods_stay_namujiAddress'){
		value=frm_mod_goods.goods_stay_namujiAddress.value;
		fn_modify_goods('${goods.goods_stay_id }','goods_stay_zipcode');
	}else if(attribute=='goods_stay_zipcode'){
		value=frm_mod_goods.goods_stay_zipcode.value;
		alert("숙박 상품의 주소를 수정했습니다.");
	}
	
	else if(attribute=='goods_stay_num_people'){
		value=frm_mod_goods.goods_stay_num_people.value;
		alert("숙박 상품의 예약 가능 인원/최대 인원을 수정했습니다.");
	}else if(attribute=='goods_stay_price'){
		value=frm_mod_goods.goods_stay_price.value;
		alert("숙박 상품의 숙소 가격(1박 기준)을 수정했습니다.");
	}else if(attribute=='goods_stay_discount'){
		value=frm_mod_goods.goods_stay_discount.value;
		alert("숙박 상품의 할인율을 수정했습니다.");
	}else if(attribute=='goods_stay_discount_title'){
		value=frm_mod_goods.goods_stay_discount_title.value;
		alert("숙박 상품의 할인명을 수정했습니다.");
	}else if(attribute=='goods_stay_sales_price'){
		value=frm_mod_goods.goods_stay_sales_price.value;
		alert("숙박 상품의 할인가격을 수정했습니다.");
	}else if(attribute=='goods_stay_room_number'){
		value=frm_mod_goods.goods_stay_room_number.value;
		alert("숙박 상품의 숙소 방 개수를 수정했습니다.");		
	}else if(attribute=='goods_stay_sort'){
		value=frm_mod_goods.goods_stay_sort.value;
		alert("숙박 상품의 숙소 분류를 수정했습니다.");
	}

	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/modifyGoodsStayInfo.do",
		data : {
			goods_stay_id:goods_stay_id,
			attribute:attribute,
			value:value
		},
		success : function(data, textStatus) {
			if(data.trim()=='mod_success'){
				console.log("숙박 상품 정보를 수정했습니다.");
			}else if(data.trim()=='failed'){
				alert("다시 시도해 주세요.");	
			}
			
		},
		error : function(data, textStatus) {
			alert("에러가 발생했습니다."+data);
		},
		complete : function(data, textStatus) {
			//alert("작업을완료 했습니다");
		}
	}); //end ajax	
}

function readURL(input,preview) {
//  alert(preview);
   if (input.files && input.files[0]) {
       var reader = new FileReader();
       reader.onload = function (e) {
           $('#'+preview).attr('src', e.target.result);
       }
       reader.readAsDataURL(input.files[0]);
   }
}  

var cnt =1;
function fn_addFile(){
  $("#d_file").append("<br>"+"<input  type='file' name='detail_image"+cnt+"' id='detail_image"+cnt+"'  onchange=readURL(this,'previewImage"+cnt+"') />");
  $("#d_file").append("<input  type='button' value='추가'  onClick=addNewImageFile('detail_image"+cnt+"','${imageFileList[0].goods_id}','detail_image')  />");
  $("#d_file").append("<br>"+"<img  id='previewImage"+cnt+"'   width=150 height=150  />");
  cnt++;
}

// function modifyImageFile(fileId, goods_id, image_id, fileType){
//     // alert(fileId);
//     var imgName = null;
//     imgName = $('#'+fileId)[0].files[0];
//     alert("main이미지 : " + imgName);
    
//   	 var form = $('#FILE_FORM')[0];
//      var formData = new FormData(form);
//      formData.append("fileName", imgName);
//      formData.append("goods_id", goods_id);
//      formData.append("image_id", image_id);
//      formData.append("fileType", fileType);
     
//      $.ajax({
//        url: '${contextPath}/modifyGoodsStayImageInfo.do',
//        processData: false,
//        contentType: false,
//        data: formData,
//        type: 'POST',
//        success: function(result){
//          alert("메인 이미지를 수정했습니다!");
//        }
//      });
// }

function modifyGetImageInfo(goods_id,image_id,fileType,imageFileName){
   $.ajax({
 		type : "post",
 		async : true, // true였음 //false인 경우 동기식으로 처리한다.
 		url : "${contextPath}/modifyGetInfo.do",
 		data: {
 			goods_id:goods_id,
  	        image_id:image_id,
  		    fileType:fileType,
	  	    imageFileName:imageFileName
	  	},
 		success : function(data, textStatus) {
//  			alert("이미지 정보를 Get했습니다!!");
 		},
 		error : function(data, textStatus) {
 			alert("modifyGetInfo 에러가 발생했습니다. "+textStatus);
 		},
 		complete : function(data, textStatus) {
 			//alert("작업을완료 했습니다");
 		}
 	}); //end ajax
}

function modifyImageFile(fileId, goods_id, image_id, fileType){
// 	modifyGetInfo('${item.goods_id}','${item.image_id}','${item.fileType}','${item.fileName}');
	// alert(fileId);
	 var imgName = null;
    imgName = $('#'+fileId)[0].files[0];
//     alert("detail이미지 : " + imgName);
	 
    var form = $('#FILE_FORM')[1];
    var formData = new FormData(form);
    formData.append("fileName", imgName);
    formData.append("goods_id", goods_id);
    formData.append("image_id", image_id);
    formData.append("fileType", fileType);
     
    $.ajax({
        url: '${contextPath}/modifyGoodsStayImageInfo.do',
        processData: false,
        contentType: false,
        data: formData,
        type: 'POST',
        success: function(result){
          alert("상세("+image_id+") 이미지를 수정했습니다!");
        }
      });
}

function addNewImageFile(fileId, goods_id, fileType){
	  //  alert(fileId);
	  var form = $('#FILE_FORM')[0];
	     var formData = new FormData(form);
	     formData.append("uploadFile", $('#'+fileId)[0].files[0]);
	     formData.append("goods_id", goods_id);
	     formData.append("fileType", fileType);
	     
	     $.ajax({
	        url: '${contextPath}/addNewGoodsStayImage.do',
	            processData: false,
	            contentType: false,
	            data: formData,
	            type: 'post',
	            success: function(result){
	                alert("이미지를 추가했습니다!");
	            }
     });
}
 
function deleteImageFile(goods_id,image_id,imageFileName){
   	$.ajax({
  		type : "post",
  		async : true, //false인 경우 동기식으로 처리한다.
  		url : "${contextPath}/removeGoodsStayImage.do",
  		data: {goods_id:goods_id,
   	         image_id:image_id,
   	         imageFileName:imageFileName},
  		success : function(data, textStatus) {
  			alert("이미지를 삭제했습니다!!");
  			$('#tab7').load(location.href+' #tab7');
  		},
  		error : function(data, textStatus) {
  			alert("에러가 발생했습니다."+textStatus);
  		},
  		complete : function(data, textStatus) {
  			//alert("작업을완료 했습니다");
  		}
  	}); //end ajax	
}

</script>
</head>
<body>
<h2 style="text-align:center;"><a href="${contextPath}/modifyGoodsStayForm.do?goods_id=${goods.goods_stay_id}">숙박 상품 수정</a></h2>
<div id="div119">
<form name="frm_mod_goodsStay" method=post enctype="multipart/form-data"> <%-- action="${contextPath}/modifyGoodsStayForm.do" --%>
	<div class="clear"></div>
	<div id="container">
		<div class="tab_container">
			<div class="tab_content" id="tab1">
				<table style="margin-left:auto;margin-right:auto;">
					<tr>
						<td>숙소명</td>
						<td><input type="text" name="goods_stay_name" value="${goods.goods_stay_name }" class="textbox1"></td>
						<td><input  type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_stay_id }','goods_stay_name')" class="subm"/></td>
					</tr>
					<tr>
						<td>숙소 분류</td>
						<td>
							<select id="select_goods_stay_sort" name="goods_stay_sort">
								<option value="1종류">1종류우</option>
								<option value="2종류">2</option>
								<option value="3종류">3</option>
								<option value="4종류">4</option>
								<option value="5종류">5</option>
								<option value="6종류">6</option>
								<option value="7종류">7</option>
							</select>
							<input type="hidden" name="h_goods_stay_sort" value="${goods.goods_stay_sort }"/>
						</td>
						<td><input  type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_stay_id }','goods_stay_sort')" class="subm"/></td>
					</tr>
			        <tr>
			            <td>주소(도로명)</td>
			            <td style="text-align:left;"><input type="text" id="goods_stay_roadAddress" name="goods_stay_roadAddress" value="${goods.goods_stay_roadAddress }" class="textbox2" readonly />
			            <input type="button" id="address_kakao" name="adress_button" value="주소 찾기" class="subm4"></td>
			            <td rowspan="4"><input  type="button" value="주소 수정" onClick="fn_modify_goods('${goods.goods_stay_id }','goods_stay_roadAddress')" class="subm"/></td>
			        </tr>
			        <tr>
			            <td>우편번호</td>
			            <td><input type="text" id="goods_stay_zipcode" name="goods_stay_zipcode" value="${goods.goods_stay_zipcode }" class="textbox1" readonly/></td>
			        </tr>
			        <tr>
			            <td>(구)지번 주소</td>
			            <td><input type="text" id="goods_stay_jibunAddress" name="goods_stay_jibunAddress" value="${goods.goods_stay_jibunAddress }" class="textbox1" readonly/></td>
			        </tr>
			        <tr>
			            <td>상세 주소</td>
			            <td><input type="text" id="goods_stay_namujiAddress" name="goods_stay_namujiAddress" value="${goods.goods_stay_namujiAddress }" class="textbox1"/></td>
			        </tr>
					<tr>
						<td>예약 가능 인원/ 최대 인원</td>
						<td><input type="text" name="goods_stay_num_people" value="${goods.goods_stay_num_people }" class="textbox1"></td>
						<td><input  type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_stay_id }','goods_stay_num_people')" class="subm"/></td>
					</tr>
					<tr>
						<td>숙소 가격(1박 기준)</td>
						<td><input type="text" name="goods_stay_price" value="${goods.goods_stay_price }" class="textbox1"></td>
						<td><input  type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_stay_id }','goods_stay_price')" class="subm"/></td>
					</tr>
					<tr>
						<td>숙소 방 개수</td>
						<td><input type="text" name="goods_stay_room_number" value="${goods.goods_stay_room_number }" class="textbox1"></td>
						<td><input  type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_stay_id }','goods_stay_room_number')" class="subm"/></td>
					</tr>
					
					<%-- <tr>
						<td>체크인 날짜/시간</td>
						<td><input type="text" name="goods_stay_admission_Date" value="${goods.goods_stay_admission_Date }" id="startDate" class="textbox1"></td>
						<td><input  type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_stay_id }','goods_stay_admission_Date')" class="subm"/></td>
					</tr>
					<tr>
						<td>체크아웃 날짜/시간</td>
						<td><input type="text" name="goods_stay_departure_Date" value="${goods.goods_stay_departure_Date }" id="endDate" class="textbox1"></td>
						<td><input  type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_stay_id }','goods_stay_departure_Date')" class="subm"/></td>
					</tr> --%>
					
					<tr>
						<td valign="top">이미지 파일 첨부</td>
						<td>
							<div class="tab_content" id="tab7">
								   <form id="FILE_FORM" method="post" enctype="multipart/form-data"  >
									 <table>
									 	 <tr align="center">
								      		<td colspan="3">
									      		<div id="d_file">
											  	<%-- <img  id="preview${itemNum.count }"   width=200 height=200 src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}" /> --%>
									      		</div>
								       		</td>
								    	 </tr>
										 <tr>
											<c:forEach var="item" items="${imageFileList }"  varStatus="itemNum">
									        <c:choose>
									            <c:when test="${item.fileType=='main_image' }">
									              <tr>
												    <td>메인 이미지</td>
												    <td style="width: 260px;">
													    <input type="file"  id="main_image"  name="main_image"  onchange="readURL(this,'preview${itemNum.count}');" />
												        <%-- <input type="text" id="image_id${itemNum.count }"  value="${item.fileName }" disabled  /> --%>
													    <input type="hidden"  name="image_id" value="${item.image_id}"  />
													    <br>
												    </td>
												    <td>
												    	<input  type="button" value="수정"  onClick="modifyGetImageInfo('${item.goods_id}','${item.image_id}','${item.fileType}','${item.fileName}');
												 												    modifyImageFile('main_image','${item.goods_id}','${item.image_id}','${item.fileType}')"/>
												 	</td>
												  <tr>
												  	<td></td>
												    <td>
												        <img id="preview${itemNum.count }"   width=150 height=150 src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}&image_id=${item.image_id}" />
												    </td>
												  </tr>
									            </c:when>
								         	  <c:otherwise>
								           		  <tr  id="${itemNum.count-1}">
													<td>상세 이미지${itemNum.count-1 }</td>
													<td style="width: 260px;">
														<input type="file" name="detail_image${itemNum.count-1 }"  id="detail_image${itemNum.count-1 }"   onchange="readURL(this,'preview${itemNum.count}');" />
														<%-- <input type="text" id="image_id${itemNum.count }"  value="${item.fileName }" disabled  /> --%>
														<input type="hidden" name="image_id" value="${item.image_id }" />
														<br>
													</td>
													<td>
					 						 			<%--<input  type="button" value="수정"  onClick="modifyImageFile('detail_image','${item.goods_id}','${item.image_id}','${item.fileType}')" />${item.image_id} --%>
														<input  type="button" value="수정"  onClick="modifyGetImageInfo('${item.goods_id}','${item.image_id}','${item.fileType}','${item.fileName}');
																								    modifyImageFile('detail_image${itemNum.count-1 }','${item.goods_id}','${item.image_id}','${item.fileType}')" />
													</td>
												  <tr>
												  	<td></td>
													<td>
											  			<img id="preview${itemNum.count }"   width=150 height=150 src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}&image_id=${item.image_id}">
													</td>
													<td valign="top">
														<input  type="button" value="삭제"  onClick="deleteImageFile('${item.goods_id}','${item.image_id}','${item.fileName}')"/>
													</td>
												  </tr>
								               </c:otherwise>
								       		</c:choose>		
								    		</c:forEach>
								    	</tr>
								    	
									</table>
								</form>
							</div>
							<DIV class="clear"></DIV>
						</td>
						<td align=center colspan=3 valign="top">
		     				<input type="button" value="이미지파일&#10;추가하기"  onClick="fn_addFile()" class="subm" />
		   				</td>
					</tr>
					<tr>
						<!-- <td></td>
						<td id="d_file" style="text-align: center;"> </td> -->
					</tr>
				</table>
				<table>
					<tr><td><p>&nbsp;</p></td></tr>
					<tr>
						<td><input type="button" value="메인 페이지" onclick="location.href='${contextPath}/main.do'" class="subm3" /></td>
						<td><input type="button" value="상품 삭제하기" class="subm3" /></td>
						<td><input type="button" value="전체 수정하기" onClick="fn_add_new_goodsStay(this.form)" class="subm3" ></td>
					</tr>
					<tr><td><p>&nbsp;</p></td></tr>
					<tr><td><p>&nbsp;</p></td></tr>
				</table>
			</div>
		</div>
	</div>
</form>
</div>


			<%-- <div class="tab_content" id="tab7">
			   <form id="FILE_FORM" method="post" enctype="multipart/form-data"  >
				 <table>
					 <tr>
						<c:forEach var="item" items="${imageFileList }"  varStatus="itemNum">
				        <c:choose>
				            <c:when test="${item.fileType=='main_image' }">
				              <tr>
							    <td>메인 이미지</td>
							    <td>
								    <input type="file"  id="main_image"  name="main_image"  onchange="readURL(this,'preview${itemNum.count}');" />
							        <input type="text" id="image_id${itemNum.count }"  value="${item.fileName }" disabled  />
								    <input type="hidden"  name="image_id" value="${item.image_id}"  />
								    <br>
							    </td>
							    <td>
							        <img id="preview${itemNum.count }"   width=150 height=150 src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}&image_id=${item.image_id}" />
							    </td>
							    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
							 	<td>
							 		<input  type="button" value="수정"  onClick="modifyGetImageInfo('${item.goods_id}','${item.image_id}','${item.fileType}','${item.fileName}');
							 												    modifyImageFile('main_image','${item.goods_id}','${item.image_id}','${item.fileType}')"/>${item.image_id}
								</td> 
							  </tr>
						      <tr>
						 		<td><br></td>
							  </tr>
				            </c:when>
			         	  <c:otherwise>
			           		  <tr  id="${itemNum.count-1}">
								<td>상세 이미지${itemNum.count-1 }</td>
								<td>
									<input type="file" name="detail_image${itemNum.count-1 }"  id="detail_image${itemNum.count-1 }"   onchange="readURL(this,'preview${itemNum.count}');" />
									<input type="text" id="image_id${itemNum.count }"  value="${item.fileName }" disabled  />
									<input type="hidden" name="image_id" value="${item.image_id }" />
									<br>
								</td>
								<td>
						  			<img id="preview${itemNum.count }"   width=150 height=150 src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}&image_id=${item.image_id}">
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
						 		<td>
 						 			<input  type="button" value="수정"  onClick="modifyImageFile('detail_image','${item.goods_id}','${item.image_id}','${item.fileType}')" />${item.image_id}
									<input  type="button" value="수정"  onClick="modifyGetImageInfo('${item.goods_id}','${item.image_id}','${item.fileType}','${item.fileName}');
																			    modifyImageFile('detail_image${itemNum.count-1 }','${item.goods_id}','${item.image_id}','${item.fileType}')" />${item.image_id}
						  			<input  type="button" value="삭제"  onClick="deleteImageFile('${item.goods_id}','${item.image_id}','${item.fileName}','${itemNum.count-1}')"/>
								</td> 
							  </tr>
							  <tr>
					 			<td><br></td>
							  </tr> 
			               </c:otherwise>
			       		</c:choose>		
			    		</c:forEach>
			    	</tr>
		   			<tr>
		     			<td align=center colspan=3>
		     				<input type="button" class="subm3" value="이미지파일추가하기" onClick="fn_addFile()" />
		   				</td>
					</tr>
				</table>
			</form>
		</div>
		<DIV class="clear"></DIV> --%>



</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
    new daum.Postcode({
        oncomplete: function(data) {
        	document.getElementById("goods_stay_zipcode").value = data.zonecode; // 주소 넣기
        	document.getElementById("goods_stay_roadAddress").value = data.roadAddress; //도로주소
        	document.getElementById("goods_stay_jibunAddress").value = data.jibunAddress; //(구)지번주소
            document.querySelector("input[name=goods_stay_namujiAddress]").focus(); //상세입력 포커싱
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
        }
    }).open();
    });
}
</script>
</html>