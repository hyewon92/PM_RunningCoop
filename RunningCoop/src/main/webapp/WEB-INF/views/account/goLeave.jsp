<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/main.css" type="text/css">
<script type="text/javascript">
	function goListPm(){
		window.open("./viewListPm.do","PM목록","width = 500, height = 700, resizable = no, scrollbars = no");
	}
	function goListGm(){
		window.open("./viewListGm.do","GM목록","width = 500, height = 700, resizable = no, scrollbars = no");
	}
</script>
</head>
<body>
	<div id = "header">
  		<jsp:include page="../header.jsp" flush="false"/>
	</div>
	<div id = "container">
		<center>탈퇴하기 전에 그룹관리자, 프로젝트관리자 권한을 위임해야 합니다.</center>
		<br>
		<input type = "button" value = "프로젝트관리자 위임하기" onclick = "goListPm()">
		<input type = "button" value = "그룹관리자 위임하기" onclick = "goListGm()">
		<br>
		<input type = "button" value = "탈퇴하기" onclick = "location.href='./leaveService.do'">
	</div>
	<div id = "footer">
   		<jsp:include page="../footer.jsp" flush="false"/>
	</div>
</body>
</html>