<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <a class="navbar-brand" href="write">상품 등록</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link active" aria-current="page" href="list">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="write">상품등록</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <section class="pt-4">
    <div class="container-fluid px-lg-2"></div>
	<div class="container-fluid px-lg-8">
		<form name="form1" method="post" action="insert" enctype="multipart/form-data">
		<table border="1">
		<tr>
			<td>상품명</td>
			<td><input type="text" name="product_name"></td>
		</tr>
		<tr>
			<td>상품가격</td>
			<td><input type="number" name="price"></td>
		</tr>
		<tr>
			<td>상품설명</td>
			<td>
				<textarea rows="5" cols="60" name="description"></textarea>
			</td>
		</tr>
		<tr>
			<td>상품사진</td>
			<td><input type="file" name="img"></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="상품등록">
			</td>
		</tr>
		</table>
		</form>
	</div>
	<div class="container-fluid px-lg-2"></div>
	</section>
</body>
</html>