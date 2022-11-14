<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>detail.jsp</title>
	<script src="/js/jquery-3.6.1.min.js"></script>
	<link href="/css/main.css" rel="stylesheet" type="text/css">
	<script>
	function product_update(){
		document.form1.action="/product/update";
		document.form1.submit();
	} // product_update() end
	
	function product_delete(){
		if(confirm("영구히 삭제됩니다\n진행할까요?")){
			document.form1.action="/product/delete";
			document.form1.submit();
		}// if end
	} // product_delete() end

	</script>
</head>
<body>
	<h3>상품 상세보기 / 상품 수정 / 상품 삭제</h3>
	<p>
		<button type="button" onclick="location.href='../list'">상품전체목록</button>
	</p>
	
	<form name="form1" method="post" enctype="multipart/form-data">
	<table border="1">
	<tr>
		<td>상품명</td>
		<td><input type="text" name="product_name" value="${product.PRODUCT_NAME}"></td>
	</tr>
	<tr>
		<td>상품가격</td>
		<td><input type="number" name="price" value="${product.PRICE}"></td>
	</tr>
	<tr>
		<td>상품설명</td>
		<td>
			<textarea rows="5" cols="60" name="description">${product.DESCRIPTION}</textarea>
		</td>
	</tr>
	<tr>
		<td>상품사진</td>
		<td>
			<c:if test="${product.FILENAME != '-'}">
				<img src="/storage/${product.FILENAME}" width="100px">
			</c:if>
			<br>
			<input type="file" name="img">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="hidden" name="product_code" value="${product.PRODUCT_CODE}">
			<input type="button" value="상품수정" onclick="product_update()">
			<input type="button" value="상품삭제" onclick="product_delete()">
		</td>
	</tr>
	</table>
	</form>
	
	<hr>
	<!-- 댓글 -->
	<div class="container">
		<label for="content">댓글</label>
		<form name="commentInsertForm" id="commentInsertForm">
		<div>
			<input type="hidden" name="pno" id="pno" value="${product.PRODUCT_CODE}">
			<input type="text" name="content" id="content" placeholder="내용을 입력하세요">
			<button type="button" name="commentInsertBtn" id="commentInsertBtn">등록</button>
		</div>
		</form>
	</div>
	<hr>
	<div class="container">
		<div class="commentList"></div>
	</div>
	
	<!-- 댓글 관련 자바스크립트 -->
	<script>
		let pno='${product.PRODUCT_CODE}';
		
		$('#commentInsertBtn').click(function(){
			let insertData = $('#commentInsertForm').serialize();
			//alert(insertData);
			commentInsert(insertData);
		}); // click() end
		
		// 댓글 등록
		function commentInsert(insertData){
			//alert(insertData);
			$.ajax({
				 url:'/comment/insert'
				,type:'post'
				,data:insertData
				,success:function(data){
					// alert(data);
					if(data==1){
						commentList(); // 댓글 작성 후 댓글 목록 함수 호출
						$('#content').val('');
					} // if end
				} // success end
			}); // ajax() end
		} // commentInsert() end
		
		// 댓글 목록
		function commentList(){
			$.ajax({
				 url:"/comment/list"
				,type:"get"
				,data:{'pno':pno}
				,success:function(data){
					// alert(data);
					let a = "";
					$.each(data, function(key, value){
						a += "<div class='commentArea' style='border-bottm:1px solid darkgray; margin-bottom:15px;'>";
						a += "	<div class='commentInfo" + value.cno + "'>";
						a += "		댓글번호 : " + value.cno + " / 작성자 : " + value.wname + " " + value.pno;
						a += "		<a href='javascript:commentUpdate(" + value.cno + ", \"" + value.content + "\");'>수정</a>";
						a += "		<a href='javascript:commentDelete(" + value.cno + ");'>삭제</a>";
						a += "	</div>";
						a += "	<div class='commentContent" + value.cno + "'>";
						a += "		<p>내용 : " + value.content + "</p>";
						a += "	</div>";
						a += "</div>";
						// alert(a);
					}); // each end
					
					$(".commentList").html(a);
				} // success end
			}); // ajax() end
		} // commentList() end
		
		// 페이지 로딩 시 댓글 목록 출력시키기
		$(document).ready(function(){
			commentList();
		}); // ready() end
		
	</script>
	
</body>
</html>