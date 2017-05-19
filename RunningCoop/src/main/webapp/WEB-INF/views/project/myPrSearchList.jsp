<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>나의 프로젝트 검색</title>

<link rel="stylesheet" href="css/main.css" type="text/css"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="js/paging.js"></script>

<style type="text/css">
.pr_detail_view {
	display: none;
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
	
	$(function(){
		$("#group_project_list").css("display", "none");
		$("input[name=project_type]").on("change", function(){
			var value = $(this).val();
			if(value == "group"){
				$("#individual_project_list").css("display", "none");
				$("#group_project_list").css("display", "block");
			} else {
				$("#group_project_list").css("display", "none");
				$("#individual_project_list").css("display", "block");
			}
		});
	});
</script>
</head>
<body>
	<div id="header">
		<jsp:include page="../header.jsp" flush="false" />
	</div>
	<div id="container">
		<h3>나의 프로젝트 검색</h3>
		<div id="div_select_area">
			<input type="radio" name="project_type" value="individual" checked/>개인 프로젝트
			<input type="radio" name="project_type" value="group"/>그룹 프로젝트&nbsp;&nbsp;
			<select class='project_list_select' id='listCount' name='listCount' onchange="projectListCnt()">
					<option>선택</option>
					<option value='5'>5</option>
					<option value='10'>10</option>
					<option value='15'>15</option>
					<option value='20'>20</option>
			</select>
			<form action="./myPrSelect.do" method="post" id="frmPaging">
				<input type='hidden' name='gIndex' id='gIndex' value='${gPaging.index}'>
				<input type='hidden' name='gPageStartNum' id='gPageStartNum' value='${gPaging.pageStartNum}'>
				<input type='hidden' name='gListCnt' id='gListCnt' value='${gPaging.listCnt}'>
				<input type='hidden' name='iIndex' id='iIndex' value='${iPaging.index}'>
				<input type='hidden' name='iPageStartNum' id='iPageStartNum' value='${iPaging.pageStartNum}'>
				<input type='hidden' name='iListCnt' id='iListCnt' value='${iPaging.listCnt}'>
				<input type='hidden' name='pr_condition' value='${ pr_condition }'/>
			</form>
		</div>
		
		<div id="individual_project_list">
			<table class="projectTable">
				<tr>
					<th style="width: 8%;">번호</th>
					<th style="width: 8%;">소속</th>
					<th style="width: 54%;">프로젝트명</th>
					<th style="width: 10%;">PM명</th>
					<th style="widht: 10%;">진행상태</th>
					<th style="width: 10%;">비고</th>
				</tr>
				<tr>
					<td colspan="6" style="background-color : #E8E8E8;">개인프로젝트</td>
				</tr>
				<c:choose>
					<c:when test="${ fn:length(ilist) == 0 }">
						<tr>
							<td colspan="6">조회가능한 개인 프로젝트가 없습니다</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="ilist" items="${ ilist }" varStatus="vs">
							<tr>
								<td>${ vs.count }</td>
								<td>개인</td>
								<td><span class="pr_name" onclick="view_Detail('${ ilist.PR_ID}')">${ ilist.PR_NAME }</span></td>
								<td>${ ilist.MEM_NAME }</td>
								<td>${ ilist.PR_CONDITION }</td>
								<td></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
			
			<div class="pagenum_div">
				<ul class="pagination">
					<!--맨 첫페이지 이동 -->
					<li><a href='#'
						onclick='pagePre(${iPaging.pageCnt+1},${iPaging.pageCnt});'>&laquo;</a></li>
					<!--이전 페이지 이동 -->
					<li><a href='#'
						onclick='pagePre(${iPaging.pageStartNum},${iPaging.pageCnt});'>&lsaquo;</a></li>
					<!--페이지번호 -->
					<c:forEach var='i' begin="${iPaging.pageStartNum}" end="${iPaging.pageLastNum}" step="1">
						<li><a href='#' onclick='projectPageIndex(${i});'>${i}</a></li>
					</c:forEach>
					<!--다음 페이지 이동 -->
					<li><a href='#'
						onclick='pageNext(${iPaging.pageStartNum},${iPaging.total},${iPaging.listCnt},${iPaging.pageCnt});'>&rsaquo;</a></li>
					<!--마지막 페이지 이동 -->
					<li><a href='#'
						onclick='pageLast(${iPaging.pageStartNum},${iPaging.total},${iPaging.listCnt},${iPaging.pageCnt});'>&raquo;</a></li>
				</ul>
			</div>
		</div>
		
		<div id="group_project_list" style="display:none;">
				<table class="projectTable">
					<tr>
						<th style="width: 8%;">번호</th>
						<th style="width: 8%;">소속</th>
						<th style="width: 54%;">프로젝트명</th>
						<th style="width: 10%;">PM명</th>
						<th style="width: 10%;">진행상태</th>
						<th style="width: 10%;">비고</th>
					</tr>
					<tr>
						<td colspan="6" style="background : #E8E8E8;">그룹 프로젝트</td>
					</tr>
					<c:choose>
						<c:when test="${ fn:length(glist) == 0 }">
							<tr>
								<td colspan="6">조회가능한 그룹 프로젝트가 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="glist" items="${ gliist }" varStatus="vs">
								<tr>
									<td>${ vs.count }</td>
									<td>그룹</td>
									<td><span class="pr_name" onclick="view_Detail('${ glist.PR_ID }')">${ glist.PR_NAME }</span></td>
									<td>${ glist.MEM_NAME }</td>
									<td>${ glist.PR_CONDITION }</td>
									<td>${ glist.GR_NAME }</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
				
				<div class="pagenum_div">
					<ul class="pagination">
						<!--맨 첫페이지 이동 -->
						<li><a href='#' onclick='pagePre(${gPaging.pageCnt+1},${gPaging.pageCnt});'>&laquo;</a></li>
						<!--이전 페이지 이동 -->
						<li><a href='#' onclick='pagePre(${gPaging.pageStartNum},${gPaging.pageCnt});'>&lsaquo;</a></li>
						<!--페이지번호 -->
						<c:forEach var='i' begin="${gPaging.pageStartNum}" end="${gPaging.pageLastNum}" step="1">
							<li><a href='#' onclick='projectPageIndex(${i});'>${i}</a></li>
						</c:forEach>
						<!--다음 페이지 이동 -->
						<li><a href='#'
							onclick='pageNext(${gPaging.pageStartNum},${gPaging.total},${gPaging.listCnt},${gPaging.pageCnt});'>&rsaquo;</a></li>
						<!--마지막 페이지 이동 -->
						<li><a href='#'
							onclick='pageLast(${gPaging.pageStartNum},${gPaging.total},${gPaging.listCnt},${gPaging.pageCnt});'>&raquo;</a></li>
					</ul>
				</div>
		</div>
			
		<div class="pr_search_area">
			<form action="./myPrSelect.do" method="post">
				<input type="hidden" name="pr_condition" value="${ pr_condition }" />
				<input type="text" name="pr_name" />
				<input type="submit" class="body_btn pr_search_btn" value="검색" />
			</form>
		</div>
		
		<div class="pr_detail_view">
			<input type="button" value="닫기" onclick="goSelectPro()" />
			<p id="pr_name"></p>
			<p id="mem_name"></p>
			<p id="pr_memcnt"></p>
			<p id="pr_goal"></p>
			<p id="pr_enddate"></p>
			<p id="pr_etc"></p>
		</div>
	</div>
	
	<div id="footer">
		<jsp:include page="../footer.jsp" flush="false" />
	</div>
</body>
</html>