<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

로그인 성공
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
<input type = "button" value = "그룹선택(관리)" onclick = "location.href='./myGrSelect.do?mem_id=<%=userId%>'">
<input type = "button" value = "일정보기" onclick = "location.href='./viewSchedule.do?year=<%=year%>&month=<%=month%>'">
<input type = "button" value = "로그아웃" onclick = "location.href='./ckLogout.do'">
<input type="button" value="그룹생성" onclick="">
<form action="./allGrSelect.do" method="post">
<div>
	<input type="text" name="gr_name" />
	<input type="submit" value="그룹검색"/>
</div>
</form>
</body>
</html>