<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginResult.jsp</title>
</head>
<body>
	
	1) JSP<br>
	<%=request.getAttribute("message")%>
	아이디(세션) : <%=session.getAttribute("s_id")%><br>
	비밀번호(세션) : <%=session.getAttribute("s_pw")%>
	<hr>
	2) EL<br>
	${requestScope.message}
	아이디(세션) : ${sessionScope.s_id}<br>
	비밀번호(세션) : ${sessionScope.s_pw}
	<hr>
	${message}
	아이디 : ${s_id}<br>
	비밀번호 : ${s_pw}
</body>
</html>