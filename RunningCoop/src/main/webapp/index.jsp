<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 10. 첫페이지 이동화면 설정 -->
<!--  index Test 입니다 commit 되나 안되나 체크중 1 -->
<jsp:forward page="./first.do">
		<jsp:param value="test" name="name"/>
	</jsp:forward> 
</body>
</html>



