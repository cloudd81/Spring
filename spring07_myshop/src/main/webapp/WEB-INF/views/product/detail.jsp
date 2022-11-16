<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    <link href="/css/styles.css" rel="stylesheet" />
    <link href="/css/main.css" rel="stylesheet" type="text/css">
   	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="/js/scripts.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body style="text-align: center;">
	<h3>상품 상세보기 / 상품 수정 / 상품 삭제</h3>
	<p>
		<button type="button" onclick="location.href='../list'">상품전체목록</button>
	</p>
	<form name="form1" method="post" enctype="multipart/form-data">
	<div class="container-fluid">
		<table border="1" style="margin: auto;">
		<tr>
			<td>상품명</td>
			<td><input type="text" name="product_name" value="${product.product_name}"></td>
		</tr>
		<tr>
			<td>상품가격</td>
			<td><input type="number" name="price" value="${product.price}"></td>
		</tr>
		<tr>
			<td>상품설명</td>
			<td>
				<textarea rows="5" cols="60" name="description">${product.description}</textarea>
			</td>
		</tr>
		<tr>
			<td>상품사진</td>
			<td>
				<c:if test="${product.filename != '-'}">
					<img src="/storage/${product.filename}" width="100px">
				</c:if>
				<br>
				<input type="file" name="img">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="hidden" name="product_code" value="${product.product_code}">
				<input type="button" value="상품수정" onclick="product_update()">
				<input type="button" value="상품삭제" onclick="product_delete()">
			</td>
		</tr>
		</table>
	</div>
	</form>
	
	<hr>
	<!-- 댓글 -->
	<div class="container">
		<label for="content">댓글</label>
		<form name="commentInsertForm" id="commentInsertForm">
		<div>
			<input type="hidden" name="pno" id="pno" value="${product.product_code}">
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
		let pno='${product.product_code}';
		
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
						a += "		댓글번호 : " + value.cno + " / 작성자 : " + value.wname + " " + value.regdate;
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
		
		// 댓글 수정 - 댓글 내용 출력을 input 폼으로 바꾸기
		function commentUpdate(cno, content) {
			let a = "";
			a += "<div class='input-group'>";
			// a += "	<input type='text' name='content_" + cno + "' value='" + content + "'>";
			a += "	<input type='text' id='content_" + cno + "' value='" + content + "'>";
			a += "	<button type='button' onclick='commentUpdateProc(" + cno + ")'>수정</button>";
			a += "</div>";
			
			$(".commentContent" + cno).html(a);
		} // commentUpdate() end 
		
		// 댓글 수정
		function commentUpdateProc(cno) {
			// let updateContent = $('[name=content_' + cno + ']').val();
			let updateContent = $('#content_' + cno).val();
			
			$.ajax({
				url:"/comment/update"
				,type:"post"
				,data:{'content':updateContent, 'cno':cno}
				,success:function(data){
					if(data==1) commentList();
				}
			}); // ajax() end
		} // commentUpdateProc() end
		
		// 댓글 삭제
		function commentDelete(cno){
			$.ajax({
				url:"/comment/delete/"+cno
				,type:"post"
				,success:function(data){
					if(data==1) {commentList()};
				}
			}); // ajax() end
		} // commentDelete() end
		
	</script>
	
</body>
</html>