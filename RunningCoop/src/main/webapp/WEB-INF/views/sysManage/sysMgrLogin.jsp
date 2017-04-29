<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시스템관리자 로그인화면</title>

<script type="text/javascript">
</script>
</head>
<body>
	
	<div class = "accountBox">
	<h3>관리자 로그인 화면</h3>
	<form class = "LoginBox" action="./ckLogin.do" method="post">
		<div class = "login">
			<input type = "text" id = "id" name = "mem_id"><br>
			<input type = "password" id = "pw" name = "mem_pw">
		</div>
		<div class = "enter">
			<input type = "submit" id = "login">
		</div>
	</form>
	</div>

</body>
</html>