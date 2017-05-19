<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공지게시판</title>
<link rel="stylesheet" href="css/main.css" type="text/css"/>
<style type="text/css">
	table {
		border-collapse: collapse;
	}
	tr, th, td {
		border : 1px solid black;
	}
</style>
<script type="text/javascript">
	function writer() {
		location.href = "writeForm.do";
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
		<form action="./noticeList.do" method="post" id='frmPaging'>
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
					<td><a href="./boardView.do?sbr_uuid=${ list.get('SBR_UUID') }">${ list.get("SBR_TITLE") }</a></td>
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
	<form action="./noticeSList.do" method="POST">
		<input type="textbox" name="sbr_title" /> <input type="submit"
			value="검색" />
	</form>
	<br>
	<br>
</div>
<div id = "footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>
</body>
</html>