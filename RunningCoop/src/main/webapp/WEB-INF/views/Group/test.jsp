<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
#groupimg2{
background-image: url("./grImgs/img01.png");
background-repeat: no-repeat;
}
</style>
<script type="text/javascript">
function openChild(){
    window.open("./showGrCreate.do", "GroupCreate", "width=640, height=450, resizable = no, scrollbars = no");
 }
</script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("table[name=groupimg]").each(function(){
			var result = Math.floor(Math.random() * 14);
			$(this).css({"background":"url(./grImgs/img"+result+".png)", 'background-repeat' : 'no-repeat', 'background-position':'center center'}); 

		})
	})
</script>	
<title>Insert title here</title>
</head>
<body>

	<c:forEach var = "grdto" items="${lists}" >
	<table name="groupimg">
		<tr><td><a href="./gProSelect.do?gr_id=${grdto.gr_id}">${grdto.gr_id}</a> </td></tr>
		<tr><td>${grdto.gr_name}</td></tr>
		<tr><td>${grdto.gr_memCnt}</td></tr>
		<tr><td>${grdto.gr_goal}</td></tr>
		<tr><td>${grdto.gr_regDate}</td></tr>
		<tr><td><a href="./grselect.do?gr_id=${grdto.gr_id}">그룹관리</a></td></tr>
<%-- 			<td>${grdto.mem_name}</td> --%>
	</table>
	</c:forEach>

<p><input type="button" onclick="location.href='./grApply.do'" value="그룹승인관리"></p>
<input type = "button" value = "그룹생성" onclick = "openChild()">
	
</body>
</html>