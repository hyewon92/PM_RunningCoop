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
<h1>그룹보기</h1>
<c:forEach var="info" items="${info}">
	<table>
		<tr>
			<td>그룹명</td>
			<td>${info.GR_NAME}</td>
		</tr>
		<tr>
			<td>그룹관리자</td>
			<td>${info.MEM_NAME}</td>
		</tr>
		<tr>
			<td>그룹생성목적</td>
			<td>${info.GR_GOAL}</td>
		</tr>
		<tr>
			<td>신청일자</td>
			<td>${info.GR_REGDATE}</td>
		</tr>
	</table>
</c:forEach>

</body>
</html>