<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>list.jsp</title>
	<link href="../css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="title">미디어 그룹 목록</div>
	<div class="content">
		<input type="button" value="그룹 등록" onclick="location.href='create.do'">
	</div>
	
	<c:if test="${requestScope.count==0}"> <!-- 전체 글 개수가 0일 때 : 글이 없을 때 -->
		<table><tr><td>게시판에 글 없음!!</td></tr></table>
	</c:if>
	
	<c:if test="${requestScope.count>0}"> <!-- 전체 글 개수가 0 이상일 때 : 글이 있을 때 -->
		<table>
		<tr>
			<th>그룹 번호</th>
			<th>그룹 제목</th>
			<th>수정/삭제</th>
		</tr>
		
		<!-- rowMapper를 이용해 list에 담은 각각의 행을 dto에 담아 한줄씩 출력 -->
		<c:forEach var="dto" items="${list}"> <!-- for(dto : ${list}) -->
			<tr>
				<td>${dto.mediagroupno}</td>
				<td><a href="../media/list.do?mediagroupno=${dto.mediagroupno}">${dto.title}</a></td>
				<td>
					<input type="button" value="수정" onclick="location.href='update.do?mediagroupno=${dto.mediagroupno}'">
					<input type="button" value="삭제" onclick="location.href='delete.do?mediagroupno=${dto.mediagroupno}'">
				</td>
			</tr>		
		</c:forEach>
		</table>
	</c:if>
	
	<!-- 페이지 리스트 -->
	<!-- 1-10 / 2-11 / 이런 식으로 출력하게 하고 싶어서 구현 -->
	<c:if test="${count>0}"> <!-- 글이 1개 이상 있다면 페이징 출력 -->
		<!-- 변수 지정 -->
		<!-- 내 글이 45개가 있다고 생각하고 변수값 예시를 들었다 -->
		<c:set var="pageCount" value="${totalPage}"/> <!-- 9, 글이 들어있는 총 페이지(글은 45개, 9페이지까지 글이 있음) -->
		<c:set var="startPage" value="${startPage}"/> <!-- 0, 페이지의 시작 지점 -->
		<c:set var="endPage" value="${endPage}"/> <!-- 11, 페이지의 끝 지점 -->
		
		<div class="content">
			<!-- 글이 있는 페이지의 끝지점보다 글이 들어있는 총 페이지가 작다면, 즉 10개의 페이지 안에 글이 다 들어갔다면 -->
			<c:if test="${endPage>pageCount}">
				<!-- 끝페이지 변수에 담긴 값을 글이 들어있는 총 페이지에서 1을 더해준 값으로 바꿔줌 -->
				<!-- 글이 있는 페이지까지만 출력을 시켜준다. 예를 들어 글이 9페이지 까지 있다면, endPage 변수는 10이 담기고 아래 반복문에서 출력에 쓰인다. -->
				<!-- 글이 들어있는 페이지가 10페이지 이상이라면 10페이지까지만 출력됨 -->
				<c:set var="endPage" value="${pageCount+1}"/>
			</c:if>
			
			<!-- 이전 버튼 띄우기 -->
			<!-- 내가 현재 1페이지라면 startPage는 0이다, 이전 버튼이 출력되지 않는다 -->
			<!-- 내가 현재 2페이지라면 startPage는 1이다, 이전 버튼이 출력된다 -->
			<c:if test="${startPage>0}">
				<a href = "./list.do?pageNum=${startPage}">[이전]</a>
			</c:if>
			
			<!-- 반복문 -->
			<!-- i라는 변수에 값을 담음 -->
			<!-- 페이지의 시작 지점부터 끝지점까지, 내가 1페이지라면 1부터 10까지 -->
			<c:forEach var="i" begin="${startPage+1}" end="${endPage-1}">
				<c:choose>
					<%-- i가 현재 페이지와 일치한다면 현재 페이지를 굵게 출력 --%>
					<c:when test="${pageNum==i}"><span style="font-weight: bold;">${i}</span></c:when>
					<%-- i가 현재 페이지와 일치하지 않는다면 해당 번호의 페이지로 이동하는 버튼을 출력 --%>
					<c:when test="${pageNum!=i}"><a href="./list.do?pageNum=${i}">${i}</a></c:when>
				</c:choose>
			</c:forEach>
			
			<!-- 다음 버튼 띄우기 -->
			<!-- 내가 있는 곳이 마지막 페이지라면 다음 페이지를 띄우지 말아야 한다 -->
			<!-- 글이 있는 마지막 페이지보다 현재 페이지가 작아야지 다음을 띄움 -->
			<c:if test="${endPage>pageNum}">
				<a href = "./list.do?pageNum=${pageNum+1}">[다음]</a>
			</c:if>
			
		</div>
	</c:if>
</body>
</html>