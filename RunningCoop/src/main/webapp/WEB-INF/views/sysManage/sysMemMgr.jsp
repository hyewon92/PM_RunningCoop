<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시스템 공지 게시판 관리 페이지</title>
<link rel="stylesheet" href="css/main.css" type="text/css"/>
<%@include file="/WEB-INF/views/Group/bootstrap.jsp"%>
<script src="./js/paging.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
#insert_Container {
	position: fixed;
	top: 250px;
	left: 300px;
	z-index: 1;
	background-color: white;
	display: none;
}

#mgr_table{
	width : 1000px;
	height : 580px;
	border-collapse: collapse;
}

#mem_mgr_div{
	width : 850px;
	height : 580px;
	overflow: scroll;
}

#mem_mgr_table{
	border-collapse: collapse;
}

tr, th, td {
	border : 1px solid black;
}
</style>
<script type="text/javascript">
	function selectMem(id) {
		$.ajax({
			type : "GET",
			url: "./sysMemView.do",
			data: "mem_id="+id,
			async: false,
			success: function(msg){
				var mem_id = msg.info.mem_id;
				var mem_pw = msg.info.mem_pw;
				var mem_name = msg.info.mem_name;
				var mem_email = msg.info.mem_email;
				var mem_phone = msg.info.mem_phone;
				
				$("#upMem_id").val(mem_id);
				$("#upMem_pw").val(mem_pw);
				$("#upMem_name").val(mem_name);
				$("#upMem_email").val(mem_email);
				$("#upMem_phone").val(mem_phone);
				$("#insert_Container").css("display", "block");
			}
		});
	}
	
	function hideInsertForm() {
		$("#insert_Container").css("display", "none");
	}
	
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
	<div class="sys_container">
		<div id="insert_Container">
			<form id= "memModify" action = "./sysMemModify.do" method = "POST">
				<fieldset>
					<legend>회원 수정 양식</legend>
					아이디 : <input type="text" id = "upMem_id" class = "upData" name="mem_id" /><br/>
					비밀번호 : <input type="password" id = "upMem_pw" class = "upData" name="mem_pw" /><br/> 
					이름 : <input type="text" id = "upMem_name" class = "upData" name="mem_name" /><br/> 
					이메일 : <input type="text" id = "upMem_email" class = "upData" name="mem_email" /><br/>
					전화번호 : <input type="text" id = "upMem_phone" class = "upData" name="mem_phone" /><br/> 
					<input type="submit" value="수정"/> 
					<input type="button" value="취소" onclick="hideInsertForm()" />
				</fieldset>
			</form>
		</div>
		<div id="mgr_Container">
						<div id="mem_mgr_div">
							<h3>회원 목록</h3>
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
						<form action="./sysMemMgr.do" method="post" id='frmPaging'>			 
						<table class="table table-bordered">
							<tr>
								<td colspan="6">
								<input type="button" value="회원 등록" 	onclick="viewInsertForm()" />
								</td>
							</tr>
							<tr>
								<th>아이디</th>
								<th>이름</th>
								<th>이메일</th>
								<th>휴대폰 번호</th>
								<th>가입일자</th>
								<th>수정</th>
								<th>
</th>
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
											<td><span onclick="">${ list.mem_id }</span></td>
											<td>${ list.mem_name }</td>
											<td>${ list.mem_email }</td>
											<td>${ list.mem_phone }</td>
											<td>${ list.mem_regDate }</td>
											<td><input type = "button" value = "수정" onclick="selectMem('${list.mem_id}')"/></td>
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
						<form action="./sysMemSearch.do" method="post">
							<input type="text" name="mem_name" />
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
