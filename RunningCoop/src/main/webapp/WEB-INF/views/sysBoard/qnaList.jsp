<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>문의게시판</title>
<link rel="stylesheet" href="css/main.css" type="text/css"/>
<style type="text/css">
	table {
		border-collapse: collapse;
	}
	tr, th, td {
		border : 1px solid black;
	}
</style>
<script src="./js/paging.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<%@include file="/WEB-INF/views/Group/bootstrap.jsp"%>
<script type="text/javascript">
	$(function(){
		$(".sbr_title").on("click", function(){
			var scryn = $(this).children("input[name=scryn]").val();
			var uuid = $(this).children("input[name=uuid]").val();
			
			if(scryn == 'Y'){
				var pw = prompt("비밀번호를 입력해주세요", "");
				$("input[name=sbr_uuid]").val(uuid);
				$("input[name=sbr_pw]").val(pw);
				$("#scrView").submit();
			} else {
				location.href = "./boardView.do?sbr_uuid="+uuid;
			}
		});
	});
	
	function writer(){
		location.href = "./writeForm.do";
	}
</script>
</head>
<body>
<div id = "header">
	<jsp:include page="../header.jsp" flush="false"/>
</div>
<div id = "container">
<div id='select'>
			<span> <select class='btn btn-primary' id='listCount' name='listCount'
				onchange='listCnt();'>
					<option>선택</option>
					<option value='5' >5</option>
					<option value='10'>10</option>
					<option value='15'>15</option>
					<option value='20'>20</option>
			</select>
			</span>
		</div>
		<form action="./qnaList.do" method="post" id='frmPaging'>
	<table class="table table-bordered"> 
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			<c:choose>
			<c:when test="${ fn:length(list) == 0 }">
				<tr>
					<td colspan="4">작성된 글이 없습니다</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="list" items="${ list }" varStatus="vs">
					<tr>
						<td>${vs.count}</td>
						<td><span class = "sbr_title">
							<input type="hidden" name = "uuid" value = "${ list.get('SBR_UUID') }"/>
							<input type="hidden" name = "scryn" value="${ list.get('SBR_SCRYN') }"/>
							${ list.get("SBR_TITLE") }</span></td>
						<td>${ list.get("MEM_NAME") }</td>
						<td>${ list.get("SBR_REGDATE") }</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		</table>
		<!-- 5. paging view -->
			<!--출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
			<input type='hidden' name='index' id='index' value='${paging.index}'>
			<input type='hidden' name='pageStartNum' id='pageStartNum' value='${paging.pageStartNum}'>
			<input type='hidden' name='listCnt' id='listCnt' value='${paging.listCnt}'>		
		<div class="center">
				<ul class="pagination">
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
		</form>
		</div>
		<div>
		<form action="./qnaSList.do" method="POST">
			<input type="textbox" name="sbr_title" /> <input type="submit"
				value="검색" />
		</form>
		<form id="scrView" action="./scrBoardView.do" method="POST">
			<input type="hidden" name="sbr_uuid" value="">
			<input type="hidden" name="sbr_pw" value="">
		</form>
		<br>
		<br>
	
		<input type="button" id="write" value="게시글작성" onClick="writer()" />
</div>
<div id = "footer">
	<jsp:include page="../footer.jsp" flush="false" />
</div>
</body>
</html>