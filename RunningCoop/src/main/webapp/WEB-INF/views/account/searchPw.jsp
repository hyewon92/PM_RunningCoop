<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비밀번호찾기</title>
</head>
<body>

	<form action="./resultPw.do" method = "post">
		<div class = "pwForm">
			아이디: <input type = "text" name = "mem_id">
			이메일: <input type = "text" name = "mem_email">
		</div>
		<div>
			<input type = "submit" value = "비밀번호 찾기">
		</div>
	</form>

</body>
</html>