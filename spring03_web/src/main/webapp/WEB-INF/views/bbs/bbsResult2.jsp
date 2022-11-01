<%@page import="kr.co.itwill.bbs.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>bbsResult.jsp</title>
</head>
<body>
	<h3>* 글쓰기 결과 *</h3>
	
	1) JSP<br>
<%
	BbsDTO dto = (BbsDTO)request.getAttribute("dto");
	out.println("작성자 : " + dto.getWname() + "<br>"); 
	out.println("제목 : " + dto.getSubject() + "<br>");
	out.println("내용 : " + dto.getContent() + "<br>");
	out.println("비밀번호 :" + dto.getPasswd() + "<br>");
%>
	<hr>
	2) EL<br>
	<!-- BbsDTO 클래스에 반드시 getter와 setter 함수가 있어야 함 -->
	작성자 : ${dto.wname}<br>
	제목 : ${dto.subject}<br>
	내용 : ${dto.content}<br>
	비밀번호 : ${dto.passwd}
	<hr>
	작성자 : ${wname}<br>
	제목 : ${subject}<br>
	내용 : ${content}<br>
	비밀번호 : ${passwd}<br>


</body>
</html>