<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	function searchAccount(){
		location.href = "./searchAccount.do";
	}

	function goJoin(){
		location.href = "./goJoin.do";
	}
	
	function goLeave(){
		location.href = "./goLeave.do";
	}
</script>
</head>
<body>
	
	<div class = "accountBox">
	<form class = "LoginBox" action="./ckLogin.do" method="post">
		<div class = "login">
			<input type = "text" id = "id" name = "mem_id"><br>
			<input type = "password" id = "pw" name = "mem_pw">
		</div>
		<div class = "enter">
			<input type = "submit" id = "login">
		</div>
	</form>
	<input type = "button" value = "아이디/비밀번호찾기" onclick = "searchAccount()">
	<input type = "button" value = "회원가입" onclick = "goJoin()">
	<input type = "button" value = "탈퇴하기" onclick = "goLeave()">
	</div>

</body>
</html>