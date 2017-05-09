<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/main.css" type="text/css"/>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	$(function(){
		var resutl = "${rst}";
		if(resutl=="ture"){
		alert("메일 전송 완료");
		close();
		}
	})
</script>
</head>
<body>
<div id="header">
	<jsp:include page="../header.jsp" flush="false"/>
</div>
<div id="container">
	<form action="./goGroupMail.do" method="post">
	<table>
		<tr>보낸이</tr>
		<tr><td><input type="text" name="toSend"></td></tr>
		<tr><td><input type="submit" value="메일보내기"></td></tr>
	</table>
	</form>
</div>
<div id="footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>
</body>
</html>