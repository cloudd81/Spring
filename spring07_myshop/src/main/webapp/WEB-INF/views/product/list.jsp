<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="product page" />
    <meta name="author" content="cloudd81" />
    <title>list.jsp</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="../css/styles.css" rel="stylesheet" />
    <link href="../css/main.css" rel="stylesheet" type="text/css">
   	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
</head>
<body>
    <!-- Responsive navbar-->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container px-lg-5">
            <a class="navbar-brand" href="list">상품 목록</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link active" aria-current="page" href="list">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="write">상품등록</a></li>
                </ul>
            </div>
        </div>
    </nav>
	<br>
	<div class="container-fluid text-center">
		<form method="post" action="search">
			상품명 : <input type="text" name="product_name" value="${product_name}">
				   <input type="submit" value="검색">
				   <button type="button" onclick="location.href='write'">상품등록</button>
		</form>
	</div>
	
	<hr>
	<div class="container-fluid" style="text-align: right;">
	상품 개수 : ${fn:length(list)}
	</div>
	<br>
	
	<section class="pt-4">
	<div class="container px-lg-2 col-md-2"></div>
	<div class="container px-lg-8 col-md-8">
	<table border="1" class="container">
	<tr>
		<c:forEach var="row" items="${list}" varStatus="vs">
			<td>
				<div style="text-align: center;">
				<c:choose>
					<c:when test="${row.filename != '-'}">
						<div style="height: 150px; padding: 10px;">
						<img src="/storage/${row.filename}" width="100px" align="middle">
						</div>
					</c:when>
					<c:otherwise>
						등록된 사진 없음!!<br>
					</c:otherwise>
				</c:choose>
				<br>
				상품명 : <a href="detail/${row.product_code}">${row.product_name}</a>
				<br>
				상품 가격 : <fmt:formatNumber value="${row.price}" pattern="#,###"/>
				</div>
			</td>
			<c:if test="${!vs.last}">
				<td></td>
			</c:if>
			<c:if test="${vs.count mod 5==0}">
				<tr></tr>
			</c:if>
		</c:forEach>
	</tr>
	</table>
	</div>
	<div class="container px-lg-2 col-md-2"></div>
	</section>
</body>
</html>