<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(function(){
	var resutl = "${result}";
	if(resutl=="true"){
	close();
	}
})
</script>
<title>Insert title here</title>
</head>
<body>
<%
	String a=(String)request.getAttribute("grid");
	String mem_id = (String)session.getAttribute("mem_id");
%>
<form action="./grWaitInsert.do" method="post">
<p><input type="text" value="<%=mem_id%>" readonly="readonly" name="mem_id"></p>
<p><input type="text" id="gr_id" value="<%=a%>" readonly="readonly" name="gr_id"></p>
<p><textarea rows="10" cols="10" name="wait_content"></textarea></p>
<input type="submit" value="가입신청">
</form>
</body>
</html>