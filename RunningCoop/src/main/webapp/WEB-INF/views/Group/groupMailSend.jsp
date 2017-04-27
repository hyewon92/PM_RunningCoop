<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<title>Insert title here</title>
</head>
<body>
	<form action="./goGroupMail.do" method="post">
	<table>
		<tr>보낸이</tr>
		<tr><td><input type="text" name="toSend"></td></tr>
		<tr><td><input type="submit" value="메일보내기"></td></tr>
	</table>
	</form>

</body>
</html>