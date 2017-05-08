<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
</script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<div id = "header">
	<jsp:include page="../header.jsp" flush="false"/>
</div>
<div id = "container">
<h1>로그인 성공!</h1>
<h4>어떤 작업을 하고 싶으세요?</h4>
<% String mem_id = (String)session.getAttribute("mem_id"); %>
<a href="./myGrSelect.do?mem_id=<%= mem_id %>">그룹 선택하러 가기</a><br>
<a href="./iProSelect.do">개인프로젝트 작업하기</a>
</div>
<div id = "footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>

</body>
</html>