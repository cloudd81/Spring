<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>media.jsp</title>
	<link href="../css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="title">미디어 그룹 목록</div>
	<div class="content">
		<input type="button" value="음원 등록"
			   onclick="location.href='create.do?mediagroupno=${mediagroupno}'">
		<input type="button" value="HOME" onclick="location.href='/home.do'">
	</div>
	
	<table>
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>등록일</th>
		<th>음원파일명</th>
		<th>수정/삭제</th>
	</tr>
	
	<c:forEach var="dto" items="${list}">
		<tr>
			<td>${dto.mediano}</td>
			<td><a href="read.do?mediano=${dto.mediano}">${dto.title}</a></td>
			<td>${dto.rdate}</td>
			<td>
				${dto.filename}<br>
				${dto.filesize}<br>
				<c:set var="filesize" value="${fn:substringBefore(dto.filesize/1024, '.')}"/>
				${filesize}KB
			</td>
			<td>
				<input type="button" value="수정" onclick="location.href='update.do?mediano=${dto.mediano}'">
				<input type="button" value="삭제" onclick="location.href='delete.do?mediano=${dto.mediano}'">
			</td>
		</tr>
	</c:forEach>

	</table>
	
</body>
</html>