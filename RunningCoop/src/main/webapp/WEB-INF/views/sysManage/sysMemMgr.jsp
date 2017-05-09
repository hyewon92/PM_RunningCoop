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
	function viewInsertForm() {
		$("#insert_Container").css("display", "block");
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
	<div id="header">
		<jsp:include page="../sysHeader.jsp" flush="false" />
	</div>
	<div id="container">
		<div id="insert_Container">
			<form action="">
				<fieldset>
					<legend>회원 등록 양식</legend>
					아이디 : <input type="text" name="mem_id" /><br/>
					비밀번호 : <input type="password" name="mem_pw" /><br/> 
					이름 : <input type="text" name="mem_name" /><br/> 
					이메일 : <input type="text" name="mem_email" /><br/>
					전화번호 : <input type="text" name="mem_phone" /><br/> 
					<input type="submit" value="등록" /> 
					<input type="button" value="취소" onclick="hideInsertForm()" />
				</fieldset>
			</form>
		</div>
		<div id="mgr_Container">
			<table id="mgr_table">
				<tr>
					<td>관리자 도구 모음</td>
					<td rowspan="7">
						<div id="mem_mgr_div">
							<h3>회원 목록</h3> 
						<table id="mem_mgr_table">
							<tr>
								<td colspan="8">
								<input type="button" value="회원 등록" 	onclick="viewInsertForm()" />
								<input type="button" value="선택삭제" />
								</td>
							</tr>
							<tr>
								<th><input type="checkbox" name="number" onclick="checkAll(this.checked)"/></th>
								<th>번호</th>
								<th>아이디</th>
								<th>이름</th>
								<th>이메일</th>
								<th>휴대폰 번호</th>
								<th>가입일자</th>
								<th>삭제</th>
							</tr>
							<c:choose>
								<c:when test="${ fn:length(list) == 0 }">
									<tr>
										<td colspan="8">조회 가능한 게시글이 없습니다</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${ list }" varStatus="vs">
										<tr>
											<td><input type="checkbox" name="number" value="${ list.mem_id }" /></td>
											<td>${ vs.count }</td>
											<td><span onclick="">${ list.mem_id }</span></td>
											<td>${ list.mem_name }</td>
											<td>${ list.mem_email }</td>
											<td>${ list.mem_phone }</td>
											<td>${ list.mem_regDate }</td>
											<td><input type="button" value="삭제" onclick="" /></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</table>
						<form action="./sysMemSearch.do" method="post">
							<input type="text" name="mem_name" />
							<input type="submit" value="검색" />
						</form>
						</div>
					</td>
				</tr>
				<tr>
					<td><a href="./grApply.do">그룹 승인 관리</a></td>
				</tr>
				<tr>
					<td><a href="./sysMemMgr.do">회원 관리</a></td>
				</tr>
				<tr>
					<td><a href="./sysNoticeMgr.do">공지 게시판 관리</a></td>
				</tr>
				<tr>
					<td><a href="./sysQnaMgr.do">문의 게시판 관리</a></td>
				</tr>
				<tr>
					<td>공백</td>
				</tr>
				<tr>
					<td><a href="./adminLogout.do">로그아웃</a></td>
				</tr>
			</table>
		</div>

	</div>
</body>
</html>