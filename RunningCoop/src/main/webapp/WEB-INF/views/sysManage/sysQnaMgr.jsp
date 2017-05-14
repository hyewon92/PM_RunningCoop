<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시스템 문의 게시판 관리 페이지</title>
<%@include file="/WEB-INF/views/Group/bootstrap.jsp"%>
<link rel="stylesheet" href="css/main.css" type="text/css"/>
<script src="./js/paging.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
#mgr_table{
	width : 1000px;
	height : 580px;
	border-collapse: collapse;
}

#qna_mgr_div{
	width : 850px;
	height : 580px;
	overflow: scroll;
}

#qna_mgr_table{
	border-collapse: collapse;
}

tr, th, td {
	border : 1px solid black;
}
</style>
<script type="text/javascript">
function checkAll(bool){
	var obj = document.getElementsByName("number");
	for (var i = 0; i < obj.length; i++){
		obj[i].checked = bool;
	}
}

function checkDelete(){
	var inputbox = $("input:checkbox[name=number]:checked");
	var numList = new Array(inputbox.length);
	
	for (var i = 0; i < inputbox.length; i++){
		if(inputbox.eq(i).val() != ""){
			numList[i] = inputbox.eq(i).val();
		}
	}
	
	if(numList.length > 0){
		jQuery.ajaxSettings.traditional = true;
		
		$.ajax({
			type : "POST",
			url : "./select_PostDelete.do",
			data : {"numList":numList},
			async : false,
			success : function(){
					location.reload();
			}
		})
	}
	
}
</script>
</head>
<body>
	<div id="sys_header">
		<jsp:include page="../sysHeader.jsp" flush="false" />
	</div>
	<div id="sys_container">
		<div id="mgr_Container">
						<div id="qna_mgr_div">
							<h3>문의 게시판 관리 페이지</h3>
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
							<form action="./sysQnaMgr.do" method="post" id='frmPaging'>			 
							<input type="button" value="게시글 등록" />
							<input type="button" value="선택 삭제" onclick="checkDelete()"/>
							<table class="table table-bordered">
								<tr>
									<th><input type="checkbox" name="number" onclick="checkAll(this.checked)"/></th>
<!-- 									<th>번호</th> -->
									<th>제목</th>
									<th>작성자</th>
									<th>작성일자</th>
									<th>삭제</th>
								</tr>
								<c:choose>
									<c:when test="${ fn:length(list) == 0 }">
										<tr>
											<td colspan="6">조회 가능한 게시글이 없습니다</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="list" items="${ list }" >
											<tr>
												<td><input type="checkbox" name="number"
													value="${ list.SBR_UUID }" /></td>
<%-- 												<td>${ vs.count }</td> --%>
												<td><span
													onclick="location.href='./viewQna.do?sbr_uuid=${ list.SBR_UUID }'">${ list.SBR_TITLE }</span></td>
												<td>${ list.MEM_NAME }</td>
												<td>${ list.SBR_REGDATE }</td>
												<td><input type="button" value="삭제"
													onclick="location.href='./sysboardDelete.do?noticeyn=N&sbr_uuid=${ list.SBR_UUID }'" /></td>
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
							<form action="./sysQnaSearch.do" method="post">
								<input type="text" name="sbr_title" /> 
								<input type="submit" value="검색" />
							</form>
						</div>
		</div>
	</div>
	<div id="sys_footer">
		<jsp:include page="../sysFooter.jsp" flush="false"/>
	</div>
</body>
</html>