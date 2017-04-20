<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개인 프로젝트 선택화면</title>
<script type="text/javascript">
	function createPro(){
		location.href="./createMPro.do";
	}
</script>
</head>
<body>

<c:choose>
	<c:when test="${ fn:length(list) == 0 }">
		<p> 진행 중인 프로젝트가 없습니다</p>
	</c:when>
	<c:otherwise>
		<c:forEach var="list" items="${ list }">
			<div>
				<p>${ list.pr_id }</p>
				<p>${ list.pr_name }</p>
				<p>${ list.pr_proRate }</p>
				<p>${ list.pr_endDate }</p>
			</div>
		</c:forEach>
	</c:otherwise>
</c:choose>

<input type="button" value="프로젝트 생성" onclick="createPro()"/>

</body>
</html>