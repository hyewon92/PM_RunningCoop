<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시스템 관리자 헤더</title>
</head>
<body>

	<% 
   String userName = (String)session.getAttribute("mem_name"); 
   String userId = (String)session.getAttribute("mem_id");
%>
<%= userName%>님 접속중

<input type = "button" value = "로그아웃" onclick = "location.href='./ckLogout.do'">

</body>
</html>