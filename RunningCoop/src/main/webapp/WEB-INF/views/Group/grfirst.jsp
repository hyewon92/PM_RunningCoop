<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/main.css" type="text/css">
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<div id="header">
	<jsp:include page="../header.jsp" flush="false"/>
</div>
<div id="container">
	<a href="./myGrSelect.do?mem_id=user1"> 그룹 선택 하기</a>
	
	<form action="./allGrSelect.do" method="post">
	<div>
		<input type="text" name="gr_name" />
		<input type="submit" value="그룹검색"/>
	</div>
	</form>
</div>
<div id="footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>
</body>
</html>