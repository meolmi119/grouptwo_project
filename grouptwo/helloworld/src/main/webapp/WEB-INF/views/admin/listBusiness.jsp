<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextPath}/resources/css/admin/listMember.css" rel="stylesheet" type="text/css" media="screen">
<title>Hello World!</title>
<!-- jQuery CDN 링크 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- tablesorter CDN 링크 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.31.3/js/jquery.tablesorter.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript">
$(function(){
	  $('#keywords').tablesorter(); 
	});
</script>
<script>
function deleteMember(form) {
	if(confirm("정말로 회원을 탈퇴시키겠습니까?")){
	axios.post(form.action, new FormData(form))
        .then(response => {
            
        })
        .catch(error => {
        	alert("회원 탈퇴에 실패했습니다.")
        });
	}else{
		return false;
	}
}
function editMember(form) {
    axios.post(form.action, new FormData(form))
        .then(response => {
            // 수정 성공 시 처리할 로직 작성
        })
        .catch(error => {
            // 수정 실패 시 처리할 로직 작성
        });
}

</script>
</head>
<body>
 <div id="wrapperMem">
  <h1>사업자관리</h1>
  <table id="keywords" cellspacing="0" cellpadding="0">
    <thead>
      <tr>
        <th><span>ID</span></th>
        <th><span>Pw</span></th>
        <th><span>Name</span></th>
        <th><span>BusiNum</span></th>
        <th><span>Tel</span></th>
        <th><span>hp</span></th>
        <th><span>Email</span></th>
        <th><span>Address</span></th>
        <th><span>JoinDate</span></th>
        <th><span>Del_YN</span></th>
        <th><span>Unregi/Edit</span></th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="business" items="${BusiList}">
      <tr>
        <td class="lalign">${business.busi_id}</td>
        <td>${business.busi_pw}</td>
        <td>${business.busi_name}</td>
        <td>${business.busi_brn}</td>
        <td>${business.busi_tel1}-${business.busi_tel2}-${business.busi_tel3}</td>
        <td>${business.busi_hp1}-${business.busi_hp2}-${business.busi_hp3}</td>
        <td>${business.busi_email1}@${business.busi_email2}</td>
        <td>${business.busi_zipcode}-${business.busi_jibunAddress}-${business.busi_roadAddress}-${business.busi_namujiAddress}</td>
        <td>${business.joinDate}</td>
        <td>${business.del_yn} </td>
        <td>
        	<form class="deleteForm" method="post" action="${contextPath}/admin/unregisterBusi.do">
			    <input type="hidden" id="busi_id2" name="busi_id" value="${business.busi_id}" />
			    <button type="submit" onclick="return deleteMember(this.form)" class="buttonAll">삭제</button>
			</form>
            <form class="editForm" method="post" action="${contextPath}/admin/businessEditAdmin.do">
			    <input type="hidden" id="busi_id" name="busi_id" value="${business.busi_id}" />
			    <button type="submit" onclick="editMember(this.form)" class="buttonAll">수정</button>
			</form>
        </td>
      </tr>
      </c:forEach>
    </tbody>
  </table>
 </div> 
</body>
</html>