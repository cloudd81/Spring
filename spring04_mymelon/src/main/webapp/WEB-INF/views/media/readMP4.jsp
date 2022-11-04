<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>readMP4.jsp</title>
	<link href="../css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="title">MP4 보기</div>
	<div class="content">
		${dto.title}<br><br>
		<video src="../storage/${dto.filename}" poster="../storage/${dto.poster}" width="500px" controls></video>
	</div>
	<div class="bottom">
		<input type="button" value="음원 목록" onclick="location.href='list.do?mediagroupno=${dto.mediagroupno}'">
		<input type="button" value="HOME" onclick="location.href='/home.do'">
	</div>
	
</body>
</html>