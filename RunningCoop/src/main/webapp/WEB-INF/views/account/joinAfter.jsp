<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>회원가입이 성공적으로 처리됐습니다</h2>
	<form action="./ckLogin.do" method="post">
		<input type = "hidden" name = "mem_id" value = "${mem_id}">
		<input type = "hidden" name = "mem_pw" value = "${mem_pw}">
		<input type = "submit" value = "바로 로그인"/>
	</form>
	<input type = "button" value = "그룹 가입 신청하기" onclick = "location.href = './allGrselect.do'">

</body>
</html>