<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >
<html>
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	function cheakAll(all){
		var box = document.getElementsByName("chk");
		
		for(var i =0; i<box.length; i++){
			box[i].checked = all;
		}
	}
	function test01(){
		$("#aa").submit(function(){
			$(this).attr("action","grApplyYse.do");
		});
	}
	function test02(){
		$("#aa").submit(function(){
			$(this).attr("action","grApplyNo.do");
		});
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="aa" action="" method="post">
	<table>
	<tr>
		<td><input type="submit" value="승인" onclick="test01()"><input type="submit" value="거절" onclick="test02()"></td>
	</tr>
		<tr>
			<td><input type="checkbox" onclick="cheakAll(this.checked)"></td>
			<td>그룹아이디</td>
			<td>그룹명</td>
			<td>그룹관리지</td>
			<td>신청일자</td>
		</tr>
	<c:forEach var="apply" items="${Apply}">
		<tr>
			<td><input type="checkbox" name="gr_id" value="${apply.GR_ID}"></td>
			<td>${apply.GR_ID}</td>
			<td>${apply.GR_NAME}</td>
			<td>${apply.MEM_NAME}</td>
			<td>${apply.GR_REGDATE}</td>
		</tr>
	</c:forEach>
	</table>
	</form>

</body>
</html>