<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >
<html>
<head>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
var openwin;
	function openChild(val){
		
		var grid = $(val).parent().siblings().eq(1).find("#gr_id").val();
		alert(grid);
		
		window.name = "grList";
		
		openwin = window.open("./grListChild.do?gr_id="+grid, "childForm", "width=570, height=350, resizable = no, scrollbars = no");
		 
// 		openwin.document.getElementById("gr_id").value= grid;

	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@include file="/WEB-INF/views/Group/bootstrap.jsp"%>

<script src="./js/paging.js"></script>
</head>
<body>

<div class="container">
	
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
	G.GR_ID, G.GR_NAME, M.MEM_NAME FROM RC_GROUP G, RC_MEMBER M
	
	<form action="./allGrSelect.do" method="post" id='frmPaging'>
			<table class="table table-bordered">
				<tr>
					<th>그룹ID:</th>
					<th>그룹이름:</th>
					<th>담당자:</th>
				</tr>
				<c:forEach var="dto" items="${lists}">
					<tr>
						<td>${dto.GR_ID}</td>
						<td>${dto.gr_name}</td>
						<td>${dto.MEM_NAME}</td>
					</tr>						
				</c:forEach>
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
<!-- 	<table> -->
<%-- 	<c:forEach var="grList" items="${allGrlists }"> --%>
<!-- 		<tr> -->
<%-- 		<td>그룹 ID : </td><td><input type="text" value="${grList.GR_ID}" readonly="readonly" id="gr_id"></td> --%>
<%-- 		<td>그룹이름 :</td><td>${grList.GR_NAME }</td> --%>
<%-- 		<td>담 당 자 : </td><td>${grList.MEM_NAME }<input type="button" onclick="openChild(this)" value="그룹가입신청"></td> --%>
<!-- 		</tr>	 -->
<%-- 	</c:forEach> --%>
<!-- 	</table> -->
	

</body>
</html>