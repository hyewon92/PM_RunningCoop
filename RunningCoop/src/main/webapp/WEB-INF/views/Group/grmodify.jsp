<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="css/main.css" type="text/css"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>

<% String mem_id = (String)session.getAttribute("mem_id"); %>
<script type="text/javascript">
	$(function(){
		var searchyn = $("#grsearchyn").text();
		var grjoinyn = $("#grjoinyn").text()
		
		if(searchyn=="Y"){
			$("input:radio[id='grsearchy']").attr("checked",true);
		}else{
			$("input:radio[id='grsearchy2']").attr("checked",true);
		}
		if(grjoinyn=="Y"){
			$("input:radio[id='grjoinyn']").attr("checked",true);
		}else{
			$("input:radio[id='grjoinyn2']").attr("checked",true);
		}
		
		$(".grModify").submit(function(){
			if($("#grGoal").val()==""){
				alert("내용을 입력해주세요")
				return false;
			}else{
				alert("정보수정 완료");
			}
		})
	})
	function groupManagerCh(){
		var mem = "<%=mem_id%>";
		alert(mem);
		window.open("./createGrManagerCh.do?mem_id=<%=mem_id%>", "GroupManagerCh", "width=570, height=350, resizable = no, scrollbars = no");
	}

</script>
<style type="text/css">
#memModi{
cursor: pointer;}
</style>
</head>
<body>
<div id = "header">
	<jsp:include page="../header.jsp" flush="false"/>
</div>
<div id="container">
	<form class="grModify" action="./realGrmodify.do" method="post">
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
					<td><input type="button" value="관리자위임" onclick="groupManagerCh()"></td>
				</tr>
				<tr>
					<td>${grSelect.GR_MEMCNT }</td>
					<td></td>
				</tr>
				<tr>
					<td>${grSelect.GR_GOAL }</td>
					<td><input type="text" value="" name="gr_goal" id="grGoal"></td>
				</tr>
				<tr>
					<td id="grsearchyn">${grSelect.GR_SEARCHYN }</td>
					<td><span><input type="radio" name="gr_searchyn" id="grsearchy" value="Y">예</span><input type="radio" name="gr_searchyn" id="grsearchy2" value="N">아니오</td>
				</tr>
				<tr>
					<td id="grjoinyn">${grSelect.GR_JOINYN }</td>
					<td><span><input type="radio" name="gr_joinyn" value="Y" id="grjoinyn">예</span><input type="radio" name="gr_joinyn" id="grjoinyn2" value="N">아니오</td>
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
				<tr>
		<td><p style="border: 1px solid black; width: 65px;" onclick="location.href='./memModi.do?gr_id=${grSelect.GR_ID}'" id="memModi">멤버관리</p ></td>
		<td><input type="button" onclick="location.href='./gbListSelect.do?gr_id=${grSelect.GR_ID}'">게시판관리</td>
		</tr>
			</c:forEach>
		</table>
		</form>
</div>
<div id = "footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>
</body>
</html>
