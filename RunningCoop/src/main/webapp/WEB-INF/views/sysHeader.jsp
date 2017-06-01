<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시스템 관리자 헤더</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
<% 
   String userName = (String)session.getAttribute("mem_name"); 
   String userId = (String)session.getAttribute("mem_id");
%>
<img alt="로고" class="sysHeader_logo" src="images/header/logo.png"/>
<div class="admin_menu">
	<span><%= userName%>님 접속중</span>
	<input type = "button" class="header_btn user_logout" value = "로그아웃" onclick = "location.href='./ckLogout.do'">
</div>
</body>
</html>