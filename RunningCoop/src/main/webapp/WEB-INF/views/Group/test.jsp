<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<table>
	<c:forEach var = "grdto" items="${lists }" >
		<tr>
			<td><a href="./grselect.do?gr_id=${grdto.gr_id }">${grdto.gr_id }</a> </td>
			<td>${grdto.gr_name }</td>
		</tr>
	</c:forEach>
	</table>
	
	<select>
	<c:forEach var="test1" items="${lists }">
		<option label="${test1.gr_name }"></option>
	</c:forEach>
</select>

<p><input type="button" onclick="location.href='./grApply.do'" value="그룹승인관리"></p>

<form action="./grApplySelectGroup.do" method="post">
<div>
	<input type="text" name="gr_name" />
	<input type="submit" value="그룹검색"/>
</div>
</form>
	
</body>
</html>