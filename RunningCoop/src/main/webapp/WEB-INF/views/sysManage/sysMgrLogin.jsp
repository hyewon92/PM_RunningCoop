<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시스템관리자 로그인화면</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="js/account/account.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
	
	<div class = "accountBox">
	<h3>관리자 로그인 화면</h3>
	<form class = "LoginBox">
		<div class = "login">
			<input type = "text" id = "loginId" name = "mem_id"><br>
			<input type = "password" id = "loginPw" name = "mem_pw" onKeypress="if(event.keyCode==13) $('#loginBtn').click();">
		</div>
		<div class = "enter">
			<input type = "button" id = "loginBtn" onclick = "doLogin()" value = "로그인">
		</div>
	</form>
	</div>

</body>
</html>