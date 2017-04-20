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
<form action="./boardEdit.do" method="POST">
	<table>
		<tr>
			<th>제목</th>
			<td><input type="textbox" name = "sbr_title" value="${ view.get('SBR_TITLE') }"/></td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
				<input type="file" name = "satt_name" value="${ view.get('SATT_NAME') }"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<textarea cols="50" rows="30">${ view.get("SBR_CONTENT") }</textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="수정"/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>