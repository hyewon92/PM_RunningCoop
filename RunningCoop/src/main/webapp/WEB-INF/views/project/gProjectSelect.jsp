<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>그룹 프로젝트 선택화면</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
	.pr_list{
		border : 1px dotted black;
	}
	
	.pr_detail{
		font-size: 8pt;
		color: green;
	}
	
	.pr_detail_view{
		border : 1px dotted green;
		display : none;
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
	
	function createPro(){
		location.href="./createMPro.do";
	}
	
	function goToProject(val){
		location.href = "./goProject.do?pr_id="+val;
	}
</script>
</head>
<body>
<div id = "header">
	<jsp:include page="../header.jsp" flush="false" />
</div>
<div id = "container">
	<c:choose>
		<c:when test="${ fn:length(list) == 0 }">
			<p> 진행 중인 프로젝트가 없습니다</p>
		</c:when>
		<c:otherwise>
			<c:forEach var="list" items="${ list }">
				<div class="pr_list">
					<p>${ list.pr_id }</p>
					<span class="pr_detail" onclick="detailPro('${ list.pr_id}')">정보보기</span>
					<p onclick="goToProject('${ list.pr_id }')">${ list.pr_name }</p>
					<p>${ list.pr_proRate }</p>
					<p>${ list.pr_endDate }</p>
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	
	<input type="button" value="프로젝트 생성" onclick="createPro()"/>
	
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