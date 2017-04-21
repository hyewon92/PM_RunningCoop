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
// 	function chek(){
// 		var chb = $("input:checkbox[name=memid]:checked");
		
// 		for(var t = 0; t <chb.length; t++){
// 			location.href="./grMemMultDelete.do?";
// 			alert(chb.eq(t).val());
// 		}
// 	}
	
	function accept1(memid){
		alert("${ grid }");
		var gr_id ="${ grid }";
// 		var mem_id = $(memid).parent().siblings().eq(2).find("#memid").text();
		var mem_id = $(memid).parent().prev().text();
		alert(mem_id);
		
		location.href="./groupAccept.do?mem_id="+mem_id+"&gr_id="+gr_id;
				
	}
	
	function refusal1(memid){
		var gr_id ="${ grid }";
		var mem_id = $(memid).parent().prev().text();
		
		location.href="./grouprefusal.do?mem_id="+mem_id+"&gr_id="+gr_id;
		alert("asdf");
	}
	
	function groupBye(){
		var rst = confirm("그룹을 해체하시겠습니까?");
		
		if(rst){
			location.href = "./groupDelete.do?"
		}
	}
	

</script>
<% String mem_id = (String)session.getAttribute("mem_id"); %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>그룹 멤버 리스트</h1>
	<form action="./MemMultDelete" method="post">
<table>
	<tr>
	<td>아이디</td>
	<td>이  름</td>
	</tr>
	<c:forEach var="memls" items="${memList }">
		<tr>
			<td><input type="checkbox" value="${memls.mem_id }" name="memid">${memls.mem_id } </td>
			<td>${memls.mem_name }</td>
			<td style="display: none;"><input type="text" name="gr_id" value="${ grid }"></td>
		</tr>
	</c:forEach>
</table>	
	</form>
			<input type="submit" value="azx">
	<h1>가입 신청 리스트</h1>
<table>
	<c:forEach var="memWait" items="${grWait}">
		<tr>
			<td>${memWait.mem_name}</td> 
			<td>${memWait.groupwaitdto.wait_regDate}</td>
			<td id="memid">${memWait.mem_id}</td>
			<td><input type="button" value="수락" onclick="accept1(this)"><input type="button" value="거절" onclick="refusal1(this)"></td>
		</tr>					
	</c:forEach>
</table>	

	<h1>그룹 해체</h1>
	<input type="button" value="그룹 해체" onclick="groupBye()">
	
</body>
</html>