<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html >
<html>
<head>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function chek(){
		var chb = $("input:checkbox[name=memid]:checked");
		
		for(var t = 0; t <chb.length; t++){
			alert(chb.eq(t).val());
		}
	}
	
	function val(){
		alert("${ grid }");
		
	}
	
</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>그룹 멤버 리스트</h1>
<table>
	<tr>
	<td></td>
	</tr>

	<tr>
	<td>아이디</td>
	<td>이  름</td>
	</tr>
	<c:forEach var="memls" items="${memList }">
		<tr>
			<td><input type="checkbox" value="${memls.mem_id }" name="memid">${memls.mem_id } </td>
			<td>${memls.mem_name }</td>
		</tr>
	</c:forEach>
	<tr>
			<td><input type="button" onclick="chek()" value="체크체크"> </td>
	</tr>
</table>	
	<h1>가입 신청 리스트</h1>
<table>
	<c:forEach var="memWait" items="${grWait}">
		<tr>
			<td>${memWait.mem_name}</td> 
			<td>${memWait.groupwaitdto.wait_regDate}</td>
			<td><input type="button" value="수락" onclick="val()"><input type="button" value="거절"></td>
		</tr>					
	</c:forEach>
</table>	
	
</body>
</html>