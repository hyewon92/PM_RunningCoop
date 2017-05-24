<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="css/main.css" type="text/css" />
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="./js/paging.js"></script>

<style type="text/css">
#grname{
cursor: pointer;
}
</style>
<% String mem_id = (String)session.getAttribute("mem_id"); %>
<script type="text/javascript">
var openwin;
	function openChild(val){
		var grid = $(val).prev().text();
		var userid = "<%=mem_id%>";
			$.ajax({
			type : "POST",
			url	 : "./grCheck.do",
			data : "gr_id="+grid+"&mem_id="+userid,
			async: false,
			success : function(data){
				if(data==1){
					alert("이미 가입된 그룹 입니다.");
				}else{
					window.name = "grList";
				    openwin = window.open("./grListChild.do?gr_id="+grid, "childForm", "width=570, height=350, resizable = no, scrollbars = no");
				}
			}
		});
	}
	function doSearch(){
		var type = $("#search_select_type option:selected").val();
		var work = $("#search_word_02").val();

		if(type == "choice"){
			alert("검색 타입을 선택해주세요!");
		} else if (type == "group"){
			$("#gr_name").val(work);
			$("#groupSearch").submit();	
		} else {
			$("#pr_name").val(work);
			$("#projectSearch").submit();
		}
	}	
</script>
</head>
<body>
<div id = "header">
	<jsp:include page="../header.jsp" flush="false"/>
</div>

<div id="container">
<h3>그룹 검색 목록</h3>
	<div class="search_project_div">
		<select class="search_select_type" id="search_select_type">
			<option value="choice">선택</option>
			<option value="group">그룹</option>
			<option value="project">프로젝트</option>
		</select>
		<input type="text" id="search_word_02" name="search_word"/>
		<button class="body_btn do_search_btn_02" onclick="doSearch()">검색</button>
	</div>
	
	<div id="div_select_area">
		<select class='project_list_select' id='listCount' name='listCount' onchange='listCnt();'>
			<option>선택</option>
			<option value='5' >5</option>
			<option value='10'>10</option>
			<option value='15'>15</option>
			<option value='20'>20</option>
		</select>
		<form action="./allGrSelect.do" method="post" id='frmPaging'>
			<input type='hidden' name='index' id='index' value='${paging.index}'>
			<input type='hidden' name='pageStartNum' id='pageStartNum' value='${paging.pageStartNum}'>
			<input type='hidden' name='listCnt' id='listCnt' value='${paging.listCnt}'>
			<input type="hidden" name="gr_name" id="gr_name" value="${gr_name}">
		</form>
	</div>
	
	<div class="div_result_area">
		<table class="projectTable">
			<tr>
				<th>번호</th>
				<th>그룹명</th>
				<th>그룹담당자</th>
				<th>생성일</th>
				<th>가입신청</th>
			</tr>
			<c:forEach var="dtos" items="${lists}" varStatus="vs">
				<tr>
					<td>${ vs.count}</td>
					<td id="gr_name">${dtos.gr_name}</td>
					<td>${dtos.memberdto.mem_name}</td>
					<td>${dtos.gr_regDate }</td>
					<c:if test="${ fn:contains(dtos.gr_joinYN, 'Y') == true }">
						<td><input type="button" value="가입신청" onclick="openChild(this)"/></td>
					</c:if>
					<c:if test="${ fn:contains(dtos.gr_joinYN, 'N') == true }">
						<td>가입불가</td>
					</c:if>
				</tr>						
			</c:forEach>
		</table>
		<div class="center">
			<ul class="pagination">
				<li><input type="hidden" value="${gr_name}" name="gr_name">
				<!--맨 첫페이지 이동 -->
				<li><a href='#' onclick='pagePre(${paging.pageCnt+1},${paging.pageCnt});'>&laquo;</a></li>
				<!--이전 페이지 이동 -->
				<li><a href='#' onclick='pagePre(${paging.pageStartNum},${paging.pageCnt});'>&lsaquo;</a></li>
				
				<!--페이지번호 -->
				<c:forEach var='i' begin="${paging.pageStartNum}" end="${paging.pageLastNum}" step="1">
					<li><a href='#' onclick='pageIndex(${i});'>${i}</a></li>
				</c:forEach>
				
				<!--다음 페이지 이동 -->
				<li><a href='#' onclick='pageNext(${paging.pageStartNum},${paging.total},${paging.listCnt},${paging.pageCnt});'>&rsaquo;</a></li>
				<!--마지막 페이지 이동 -->
				<li><a href='#' onclick='pageLast(${paging.pageStartNum},${paging.total},${paging.listCnt},${paging.pageCnt});'>&raquo;</a></li>
			</ul>
		</div>
	</div>
	
	<div class="hide_form">
		<form id="groupSearch" action="./allGrSelect.do" method="post">
			<div class="ui-widget">
				<input type="text" name="gr_name" id="gr_name" class="searchbox" value="${gr_name}"/>
			</div>
		</form>
		<form id="projectSearch" action="./allPrSelect.do" method="post">
			<div class="ui-widget">
				<input type="text" name="pr_name" id="pr_name" />
			</div>
		</form>
	</div>	
</div>
	
<div id = "footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>

</body>
</html>