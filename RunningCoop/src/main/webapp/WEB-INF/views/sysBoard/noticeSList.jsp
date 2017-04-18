<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>검색했을 때</title>
<style type="text/css">
table {
	border-collapse: collapse;
}

tr, th, td {
	border: 1px solid black;
}
</style>
</head>
<body>
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<c:choose>
			<c:when test="${ fn:length(slist) == 0 }">
				<tr>
					<td colspan="4">작성된 글이 없습니다</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="slist" items="${ slist }" varStatus="vs">
					<tr>
						<td>${vs.count}</td>
						<td><a
							href="./boardView.do?sbr_uuid=${ slist.get('SBR_UUID') }">${ slist.get("SBR_TITLE") }</a></td>
						<td>${ slist.get("MEM_NAME") }</td>
						<td>${ slist.get("SBR_REGDATE") }</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	<form action="./noticeSList.do" method="POST">
		<input type="textbox" name="sbr_title" /> <input type="submit"
			value="검색" />
	</form>
	<br>
	<br>
	<input type="button" id="write" value="게시글작성" onClick="writer()" />
</body>
</html>