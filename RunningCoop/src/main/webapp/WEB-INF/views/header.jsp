<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>헤더</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<% 
   String userName = (String)session.getAttribute("mem_name"); 
   String userId = (String)session.getAttribute("mem_id");
%>
<%= userName%>님 접속중

<%
   Calendar cal = Calendar.getInstance();
   String year = String.valueOf(cal.get(Calendar.YEAR));
   String month = String.valueOf(cal.get(Calendar.MONTH)+1);
%>

<input type = "button" value = "개인정보 수정" onclick = "location.href='./writeModifyForm.do?mem_id=<%=userId%>'">
<input type = "button" value = "일정보기" onclick = "location.href='./viewSchedule.do?year=<%=year%>&month=<%=month%>'">
<input type = "button" value = "로그아웃" onclick = "location.href='./ckLogout.do'">
</body>
</html>