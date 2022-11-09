<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>idCheck.jsp</title>
	<script src="../js/jquery-3.6.1.min.js"></script>
	<script src="../js/jquery.cookie.js"></script>
</head>
<body>
	
	<h3>회원 등록 폼</h3>
	<form name="memfrm">
		<table border="1" width="400px">
		<tr>
			<th>아이디</th>
			<td>
				<input type="text" id="userid">
				<input type="button" value="아이디중복확인" id="btn_userid">    
				<br>
				<div id="panel" style="display:none"></div>
			</td>
		</tr>
		</table>
	</form>
	
	<script>
	$("#btn_userid").click(function(){
	    $.post(
	             "idcheckproc.do"				// 요청 명령어
	            ,"userid="+ $("#userid").val()	// 전달값
	            ,responseProc					// 콜백함수
	            );
	}); // click() end

	function responseProc(result){
	    $("#panel").empty();
	    $("#panel").html(result);
	    $("#panel").show();
	}; // responseProc() end
	</script>

</body>
</html>