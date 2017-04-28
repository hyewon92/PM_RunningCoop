<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>진행 중인 프로젝트 목록 조회 페이지</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
	.pr_detail_view {
		display : none;
	}
	
	.pr_name {
		cursor: pointer;
	}
</style>
<script type="text/javascript">
	function view_Detail(val){
		$.ajax({
			type : "POST",
			url : "./detailPro.do",
			data : "pr_id="+val,
			async : false,
			success : function(nodes){
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
		});
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
<h3>진행 중인 프로젝트 목록</h3>
<table>
	<tr>
		<th>번호</th>
		<th>소속</th>
		<th>프로젝트명</th>
		<th>PM명</th>
		<th>비고</th>
	</tr>
	<tr>
		<td colspan = "5">그룹 프로젝트</td>
	</tr>
	<c:choose>
		<c:when test="${ fn:length(gPrList) == 0 }">
			<tr>
				<td colspan="5">조회 가능한 그룹 프로젝트가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="glist" items="${ gPrList }" varStatus="vs">
				<tr>
					<td>${ vs.count }</td>
					<td>그룹</td>
					<td><span class = "pr_name" onclick="view_Detail('${ glist.PR_ID }')">${ glist.PR_NAME }</span></td>
					<td>${ glist.MEM_NAME }</td>
					<td>${ glist.GR_NAME }</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<tr>
		<td colspan = "5">개인프로젝트</td>
	</tr>
	<c:choose>
		<c:when test="${ fn:length(iPrList) == 0 }">
			<tr>
				<td colspan="5">조회가능한 그룹 프로젝트가 없습니다</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="ilist" items="${ iPrList }">
				<tr>
					<td></td>
					<td>개인</td>
					<td><span class = "pr_name" onclick="view_Detail('${ ilist.PR_ID}')">${ ilist.PR_NAME }</span></td>
					<td>${ ilist.MEM_NAME }</td>
					<td></td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>
<div class = "pr_search_area">
	<form action="./myPrSelect.do" method="post">
		<input type="hidden" name="pr_condition" value="T"/>
		<input type="text" name="pr_name"/>
		<input type="submit" value="검색"/>
	</form>
</div>
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