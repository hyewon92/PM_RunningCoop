<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >
<html>
<head>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
var openwin;
	function openChild(val){
		
		var grid = $(val).parent().siblings().eq(1).find("#gr_id").val();
		alert(grid);
		
		window.name = "grList";
		
		openwin = window.open("./grListChild.do?gr_id="+grid, "childForm", "width=570, height=350, resizable = no, scrollbars = no");
		 
// 		openwin.document.getElementById("gr_id").value= grid;

	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	G.GR_ID, G.GR_NAME, M.MEM_NAME FROM RC_GROUP G, RC_MEMBER M
	<table>
	<c:forEach var="grList" items="${allGrlists }">
		<tr>
		<td>그룹 ID : </td><td><input type="text" value="${grList.GR_ID}" readonly="readonly" id="gr_id"></td>
		<td>그룹이름 :</td><td>${grList.GR_NAME }</td>
		<td>담 당 자 : </td><td>${grList.MEM_NAME }<input type="button" onclick="openChild(this)" value="그룹가입신청"></td>
		</tr>	
	</c:forEach>
	</table>
	

</body>
</html>