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
	function accept1(memid){
		alert("${ grid }");
		var gr_id ="${ grid }";
		var mem_id = $(memid).parent().prev().text();
		
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
		var gr_id = "${grid}";
		
		if(rst){
			location.href = "./groupDelete.do?gr_id="+gr_id;
			alert("그룹이 삭제 되었습니다.");
		}
	}
	function groupMemAdd(){
		window.open("./groupSend.do", "sendForm", "width=570, height=350, resizable = no, scrollbars = no");
	}
	
	function memDelete(grmemid){
		var memID = $(grmemid).parent().siblings().eq(0).text();
		var grID = $(grmemid).parent().prev().text();
		
		location.href = "./groupMemDelete.do?gr_id="+grID+"&memID="+memID;
		alert(memID);
		alert(grID);
	}
</script>
<style type="text/css">
#groupMemAdd{
width : 200px;
cursor: pointer;}
img{
width: 20px;
cursor: pointer;}
</style>
<% String mem_id = (String)session.getAttribute("mem_id"); %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>그룹 멤버 리스트</h1>
<table>
	<tr>
	<td>아이디</td>
	<td>이  름</td>
	</tr>
	<c:forEach var="memls" items="${memList}">
		<tr>
			<td>${memls.mem_id}</td>
			<td>${memls.mem_name}</td>
			<td style="display: none;">${grid}</td>
			<td><img onclick="memDelete(this)" alt="cancle" src="./images/cancel.png"> </td>			
		</tr>
	</c:forEach>
</table>	
	<h1 id="groupMemAdd" onclick="groupMemAdd()">그룹초대</h1>		
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