<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디찾기</title>
</head>
<body>

	<form action="./searchId.do" method = "post">
		<div class = "idForm">
			이름: <input type = "text" name = "mem_name">
			이메일: <input type = "text" name = "mem_email">
		</div>
		<div>
			<input type = "submit" value = "아이디 찾기">
		</div>
		<input type = "button" value = "비밀번호 찾기" onclick = "location.href='./searchPw.do'">
	</form>

</body>
</html>