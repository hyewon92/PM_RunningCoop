<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로젝트 검색 목록</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
	.pr_detail_view{
		border : 1px dotted green;
		display : none;
	}
	
	.pr_name {
		cursor : pointer;
	}
</style>
<script type="text/javascript">
function detailPro(val){
	$.ajax({
		type : "POST",
		url : "./detailPro.do",
		data : "pr_id="+val,
		async : false,
		success : function(msg){
			showProDetail(msg)
		}
	});
}

function showProDetail(nodes){
	var pr_name = nodes.PR_NAME;
	var mem_name = nodes.MEM_NAME;
	var pr_memcnt = nodes.PR_MEMCNT;
	var pr_goal = nodes.PR_GOAL;
	var pr_enddate = nodes.PR_ENDDATE;
	var pr_etc = nodes.PR_ETC;
	
	$("#pr_name").text(pr_name);
	$("#mem_name").text(mem_name);
	$("#pr_memcnt").text(pr_memcnt);
	$("#pr_goal").text(pr_goal);
	$("#pr_enddate").text(pr_enddate);
	$("#pr_etc").text(pr_etc);
	
	$(".pr_detail_view").css("display", "block");
}

function goSelectPro(){
	$(".pr_detail_view").css("display", "none");
	$(".pr_detail_view").eq(0).children("p").html("");
}
</script>
</head>
<body>
<div id = "header">
	<jsp:include page="../header.jsp" flush="false"/>
</div>
<div id = "container">
<h3>프로젝트 검색 목록</h3>
<table>
	<tr>
		<th>번호</th>
		<th>소속</th>
		<th>프로젝트명</th>
		<th>PM명</th>
	</tr>
	<c:choose>
		<c:when test="${ fn:length(list) == 0 }">
			<tr>
				<td colspan="4">검색된 프로젝트가 없습니다</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="list" items="${ list }" varStatus="vs">
				<tr>
					<td>${ vs.count }</td>
					<td>${ list.GRYN }</td>
					<td><span class="pr_name" onclick="detailPro('${list.PR_ID}')">${ list.PR_NAME }</span></td>
					<td>${ list.MEM_NAME }</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>
<div class="pr_detail_view">
	<input type="button" value="닫기" onclick="goSelectPro()"/>
		<p id="pr_name"></p>
		<p id="mem_name"></p>
		<p id="pr_memcnt"></p>
		<p id="pr_goal"></p>
		<p id="pr_enddate"></p>
		<p id="pr_etc"></p>
	</div>
</div>
<div id = "footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>
</body>
</html>