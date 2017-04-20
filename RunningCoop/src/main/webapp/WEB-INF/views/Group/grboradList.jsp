<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
	<c:forEach var="bdlist" items="gblist">
		<tr>
		<td>${bdlist.br_uuid}</td>
		<td>${bdlist.br_title }</td>
		<td>${bdlist.br_regdate }</td>
		<td>${bdlist.br_noticeyn}</td>
		<td>${bdlist.memberdto.mem_name}</td>
	</tr>
	</c:forEach>
	</table>

</body>
</html>