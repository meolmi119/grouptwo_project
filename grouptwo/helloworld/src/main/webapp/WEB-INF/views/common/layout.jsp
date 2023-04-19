<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<style>
@import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=IBM+Plex+Sans+KR:wght@300&display=swap');
* {
	font-family: 'IBM Plex Sans KR', sans-serif;
	text-decoration: none;
	color: black;
}

#container {
	width: 100%;
	margin: 0px auto;
	/* text-align: center; */
	border: 0px solid rgb();
}
#header {
	padding: 5px;
	margin-bottom: 5px;
	border: 0px solid #E6F7FF;
}
#sidebar-left {
	/* width: 15%; */
	width: 1dp;
	height: 100vh;
	padding: 5px;
	margin-right: 5px;
	margin-bottom: 5px;
	float: left;
	/* border: 1px solid #bcbcbc; */
/* 	border-right: 2px solid #A4DEFF; */
	font-size: 10px;
}
#content {
	width: 95%;
	padding: 5px;
	margin-right: 5px;
	float: left;
	border: 0px solid #A4DEFF;
}
#footer {
	clear: both;
	padding: 5px;
	margin-top: -5px;
/* 	border: 0px solid #bcbcbc; */
/* 	background-color: #E6F7FF; */
	border-top: 2px solid #A4DEFF;
}
</style>
<meta charset="UTF-8">
</head>
<body>
	<div id="container">
		<div id="header">
			<tiles:insertAttribute name="header" />
		</div>
		<div id="sidebar-left">
			<tiles:insertAttribute name="side" />
		</div>
		<div id="content">
			<tiles:insertAttribute name="body" />
		</div>
		<div id="footer">
			<tiles:insertAttribute name="footer" />
		</div>
	</div>
</body>
</html>