<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		String mem_id = (String)session.getAttribute("mem_id");
	%>
	
	<form action="./insertSchedule.do" method="post">	
		<div>
		<input type = "hidden" name = "mem_id" value = <%=mem_id%>>
		시작<input type="date" name = "sch_startDate">
		~
		종료시작<input type="date" name = "sch_endDate">
		<br>
		제목:<input type="text" name = "sch_title"><br>
		내용:<input type="text" name = "sch_content">
		</div>
		<div>
			<input type = "submit" value = "등록">
		</div>
	</form>
</body>
</html>