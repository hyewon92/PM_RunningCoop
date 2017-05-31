<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Running Co-op :: 관리자 변경</title>

<link rel="stylesheet" href="css/main.css" type="text/css"/>

<%
	String gr_id = (String)session.getAttribute("gr_id");
	String mem_id2 = (String)session.getAttribute("mem_id");
%>

</head>
<body>
<div id="container">
	<form action="./grMgChange.do" method="get">
	<table>
		<tr>
			<td><input type="submit" value="관리자변경"></td>
			<td>이름</td>
			<td>아이디</td>
		</tr>
		<c:forEach var="memlists" items="${memlists}">
		<tr>
			<td><input name="mem_id" type="radio" value="${memlists.mem_id}"> ${memlists.mem_id}</td>
			<td>${memlists.mem_name}</td>
			<td style="display: none;"><input name="mem_id2" type="text" value="<%=mem_id2%>"></td>
		</tr>	
		</c:forEach>
	</table>
	</form>
</div>
</body>
</html>