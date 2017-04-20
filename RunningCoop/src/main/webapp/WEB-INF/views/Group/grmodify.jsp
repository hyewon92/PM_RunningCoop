<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >
<html>
<head>
<style type="text/css">
#memModi{
cursor: pointer;}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="./realGrmodify.do" method="post">



	<table id="grdate">
		<c:forEach var="grSelect" items="${grSelect }">
				<td><input type="text" value="${grSelect.GR_ID}" name="gr_id" style="display: none;"> </td>
			<tr>
				<td><input type="text" value="${grSelect.GR_ID}" readonly="readonly"> </td>
				<td></td>
			</tr>
			<tr>
				<td>${grSelect.GR_NAME }</td>
				<td></td>
			</tr>
			<tr>
				<td>${grSelect.MEM_NAME }</td>
				<td></td>
			</tr>
			<tr>
				<td>${grSelect.GR_MEMCNT }</td>
				<td></td>
			</tr>
			<tr>
				<td>${grSelect.GR_GOAL }</td>
				<td><input type="text" value="" name="gr_goal"></td>
			</tr>
			<tr>
				<td>${grSelect.GR_SEARCHYN }</td>
				<td><span><input type="radio" name="gr_searchyn" value="Y">예</span><input type="radio" name="gr_searchyn" value="N">아니오</td>
			</tr>
			<tr>
				<td>${grSelect.GR_JOINYN }</td>
				<td><span><input type="radio" name="gr_joinyn" value="Y">예</span><input type="radio" name="gr_joinyn" value="N">아니오</td>
			</tr>
			<tr>
				<td>${grSelect.GR_REGDATE }</td>
				<td></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<input type="submit" value="정보수정">
					<input type="button" value="취     소" onclick="location.href='./grselect.do?gr_id=${grSelect.GR_ID}'" >
					
				</td>
				<td></td>
			
			</tr>
			
	<p style="border: 1px solid black; width: 65px;" onclick="location.href='./memModi.do?gr_id=${grSelect.GR_ID}'" id="memModi">멤버관리</p >
		</c:forEach>
	</table>
	</form>
</body>
</html>
