<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>idCheck_cookie.jsp</title>
	<script src="../js/jquery-3.6.1.min.js"></script>
	<script src="../js/jquery.cookie.js"></script>
</head>
<body>
	<!-- 쿠키를 활용하여 아이디 중복확인을 해야만 회원가입이 가능하다 -->	
	<h3>회원 등록 폼(cookie)</h3>
	
	<form name="memfrm" method="post" action="./insert.do" onsubmit="return send()">
		<table border="1" width="400px">
		<tr>
			<th>아이디</th>
			<td>
				<input type="text" name="userid" id="userid">
				<input type="button" value="아이디중복확인" id="btn_userid">
				<br>
				<span id="panel"></span><!-- 아이디 중복 관련 메세지 -->
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="passwd" id="passwd"></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><input type="text" name="name" id="name"></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" name="email" id="email"></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="회원가입">
			</td>
		</tr>
		</table>
	</form>

	<script>
	
	// 6) 해당 페이지가 로딩되었을 때 아이디 중복확인과 관련된 쿠키를 삭제해주기
	$(function (){
		$.removeCookie("checkID");		
	}); // end
	
	
	
	// 1) id="btn_userid" 아이디 중복확인 버튼이 클릭 되었을 때
	$("#btn_userid").click(function(){
		// 2) 입력한 id="btn_userid" 값을 변수에 대입하기
		let params = "userid=" + $("#userid").val().trim();
		
		// 3) post 방식으로 서버에 요청해서 응답받기
		//  -> 형식 : $.post("요청 명렁어", 전달값, 콜백함수, 응답 받는 형식)
	    // ① text 방식
	    // $.post("idcheckcookieproc.do", params, checkID, "text");
		
		// ② JSON 응답
		$.post("idcheckcookieproc.do", params, checkID, "json");
		
	}); // click() end

	// 4) 콜백 함수
	function checkID(result){
// 		① text 응답
// 	    alert(result); // 0 또는 1

// 		② json 응답
// 		alert(result); // [object Object] 또는 {"count":1} 
// 		alert(result.count); // 0 또는 1

		// 5) 서버에서 응답받는 메세지(result)를 본문의 id=panel에 출력하고, 쿠키변수를 저장
		// 	형식 : $.cookie("쿠키변수명", 값)
		let count = eval(result.count); // 형변환
		if(count==0){
			$("#panel").css("color", "blue");
			$("#panel").text("사용 가능한 아이디 입니다");
			$.cookie("checkID", "PASS"); // 아이디 중복확인을 했다는 증거
		} else {
			$("#panel").css("color", "red");
			$("#panel").text("중복된 아이디 입니다");
			${"userid"}.focus(); // 커서 생성
		} // if end

	} // checkID() end
	
	// 7) 아이디 중복확인을 해야만 회원가입폼이 서버로 전송
	function send() {
		// 아이디 입력했는지?
		if($("#userid").val()==""){
			alert("아이디를 입력해주세요")
			$("#userid").focus();
			return false;
		} // if end
		
		// 비밀번호 입력했는지?
		if($("#passwd").val()==""){
			alert("비밀번호를 입력해주세요")
			$("#passwd").focus();
			return false;
		} // if end
		
		// 이름 입력했는지?
		if($("#name").val()==""){
			alert("이름을 입력해주세요")
			$("#name").focus();
			return false;
		} // if end
		
		// 이메일 입력했는지?
		if($("#email").val()==""){
			alert("이메일을 입력해주세요")
			$("#email").focus();
			return false;
		} // if end
				
		// 아이디 중복확인 했는지
		let checkID = $.cookie("checkID"); // 쿠키값 가져오기
		if(checkID=="PASS"){
			return true;
		} else {
			$("#panel").css("color", "green");
			$("#panel").text("아이디 중복 확인 해주세요");
			$("#userid").focus();
			return false;
		} // if end
		
	} // send() end
	
	</script>

</body>
</html>