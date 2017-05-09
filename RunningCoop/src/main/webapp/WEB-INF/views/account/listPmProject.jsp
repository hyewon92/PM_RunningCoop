<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/main.css" type="text/css">
</head>
<body>

	<div id = "header">
   		<jsp:include page="../header.jsp" flush="false"/>
	</div>

	<div id = "container">
		<h1>PM으로 소속된 프로젝트 목록</h1>
		<table>
			<tr>
				<th>프로젝트아이디</th>
				<th>프로젝트명</th>
				<th>권한</th>
				<th>그룹아이디</th>
				<th>위임하기</th>
			</tr>
	 		<c:choose>
				<c:when test="${fn:length(gmSearchList)==0}">
					<tr>
						<td colspan="4">해당 프로젝트가 없습니다</td>
					</tr>
				</c:when>
				<c:otherwise> 
					<c:forEach var="pmList" items="${pmSearchList}">
						<tr>
							<td>${ pmList.get("PR_ID")}</td>
							<td>${ pmList.get("PR_NAME")}</td>
							<td>${ pmList.get("PR_LEVEL")}</td>
							<td>${ pmList.get("GR_ID")}</td>
							<td><input type = "button" value = "위임하기" onclick = "location.href='./goProManage.do?pr_id=${ pmList.get('PR_ID')}'"></td>
						</tr>
					</c:forEach>
	 			</c:otherwise>
			</c:choose>
		</table>
	</div>
	
	<div id = "footer">
		<jsp:include page="../footer.jsp" flush="false"/>
	</div>

</body>
</html>