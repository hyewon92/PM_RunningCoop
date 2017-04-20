<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 수정 화면</title>
<style type="text/css">
	table {
		border-collapse: collapse;
	}
	tr, th, td {
		border : 1px solid black;
	}
</style>
</head>
<body>
<input type="hidden" value="${ sbr_uuid }"/>
<c:set var="view"  value="${ view }"/>
<form id="boardWrite" action="./boardEdit.do" method="POST">
			<span>제목</span><input type="textbox" name = "sbr_title" value="${ view.get('SBR_TITLE') }"/><br>
			<span>첨부파일</span>
			<span><a href="#">${ view.get("SATT_NAME") }</a>${ view.get("SATT_SIZE") }</span><br>
			<jsp:include page="daumOpenEditor.jsp"></jsp:include><br>
			<input type="submit" value="수정"/>
</form>
</body>
</html>