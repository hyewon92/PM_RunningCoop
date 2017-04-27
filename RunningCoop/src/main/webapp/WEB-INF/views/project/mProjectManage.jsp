<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개인 프로젝트 관리 페이지</title>
</head>
<body>
<div id = "header">
	<jsp:include page="../header.jsp" flush="false"/>
</div>
<div id = "container">
	<input type="hidden" value="${ pr_id }"/>
</div>
<div id = "footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>
</body>
</html>