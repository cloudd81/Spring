<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>ajaxTest02.jsp</title>
	<script src="../js/jquery-3.6.1.min.js"></script>
	<script src="../js/jquery.cookie.js"></script>
</head>
<body>

	<h3> * $.ajax() 테스트 * </h3>
	
	<button id="btn">* 서버에서 응답받기 *</button>
	<div id="panel"></div>

	<script>
	// 1) $.ajax() 함수
	//	-> 형식 : $.ajax({name:value, name:value, "name",value})
	//	-> value의 값은 자료형 표현 방식에 맞춰서 작성
	/*
	$("#btn").click(function() {
		$.ajax({
				 url 		: "message.do"	// 요청 명령어
				,type		: "get"			// get 방식
				,dataType	: "text"		// 응답 메세지의 타입, 기본값은 text
				,error		: function(error){
								alert("에러 : " + error);
							}	// error callback 함수 
				,success 	: function(result){ // result는 서버가 응답해준 메세지
								// alert("성공 : " + result);
								// 1. 결과물이 쌓아지면서 출력
								$("#panel").append(result);
								
								// 2. 결과물을 없애가며 새롭게 출력
								// $("#panel").empty();
								// $("#panel").text(result);	// 단순 문자열로
								//$("#panel").html(result);	// html 구조로
							}	// success callback 함수
		}); // ajax() end
	}); // click() end
	*/
	
	// 2) $.get() 방식
	//	AJAX를 GET 방식으로 요청하는 방식
	//	형식 : $.get("요청 명령어", callback 함수)
	
	$("#btn").click(function(){
		$.get("message.do", responseProc);
	}); // click() end
	
	function responseProc(result){
		$("#panel").empty();
		$("#panel").text(result);
	} // responseProc() end
	
	</script>
	
</body>
</html>