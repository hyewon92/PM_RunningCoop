<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로젝트 업무 리스트 화면</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="js/project/project.js"></script>
<script type="text/javascript" src="js/project/worklist.js"></script>
<style type="text/css">
.work_Detail_View {
	display: none;
}

.wd_title {
	cursor: pointer;
}

.work_Edit_Form {
	display: none;
}

.promem_list {
	display: none;
}

.workInsert_Form {
	border: 1px solid black;
	display: none;
}

.project_manage {
	display: none;
}
</style>
<script type="text/javascript">
	<%String mem_id = (String) session.getAttribute("mem_id");%>
	/* 관리자 여부에 따라 프로젝트 관리 버튼 출력 */
	$(document).ready(function(){
		var manager = $("#manager_id").val();
		if( manager == '<%=mem_id%>'){
			$(".project_manage").css("display", "block");
		}
	})
</script>
</head>
<body>
	<div id="header">
		<jsp:include page="../header.jsp" flush="false" />
	</div>
	<div id="container">
		<div id="work_list_area">
			<input type="hidden" id="pr_id" value="${ pr_id }" /> <input
				type="hidden" id="manager_id" value="${ manager }" /> <input
				type="button" class="project_manage" value="프로젝트 관리"
				onclick="location.href='./goProManage.do?pr_id=${ pr_id }'" />
			<div class="work_list">
				<input type="button" value="업무 추가" onclick="workInsert()" />
				<fieldset id="todoList" class="list_field">
					<legend>Todo</legend>
					<c:choose>
						<c:when test="${ fn:length(todo) == 0 }">
							<p>업무가 없습니다.</p>
						</c:when>
						<c:otherwise>
							<c:forEach var="todo" items="${ todo }">
								<span onclick="viewWork('${ todo.get('WK_ID') }')"> <input
									type="hidden" value="${ todo.get('WK_ID') }" /> ${ todo.get('WK_TITLE') }/(${ todo.get('MEM_NAME') })/${ todo.get('WK_PRORATE') }%
								</span>
								<input type="button" value="수정"
									onclick="workEdit('${ todo.get('WK_ID') }', '${ todo.get('WK_TITLE') }', '${ todo.get('WK_ENDDATE') }', '${ todo.get('MEM_ID') }')" />
								<input type="button" value="삭제"
									onclick="workDelete('${ todo.get('WK_ID') }')" />
								<br>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</fieldset>
			</div>
			<div class="work_list">
				<fieldset id="doingList" class="list_field">
					<legend>Doing</legend>
					<c:choose>
						<c:when test="${ fn:length(doing) == 0 }">
							<p>업무가 없습니다.</p>
						</c:when>
						<c:otherwise>
							<c:forEach var="doing" items="${ doing }">
								<span onclick="viewWork('${ doing.get('WK_ID') }')"> <input
									type="hidden" value="${ doing.get('WK_ID') }" /> ${ doing.get("WK_TITLE") }/(${ doing.get("MEM_NAME") })/${ doing.get("WK_PRORATE") }%
								</span>
								<input type="button" value="수정"
									onclick="workEdit('${ doing.get('WK_ID') }', '${ doing.get('WK_TITLE') }', '${ doing.get('WK_ENDDATE') }', '${ doing.get('MEM_ID') }')" />
								<input type="button" value="삭제"
									onclick="workDelete('${ doing.get('WK_ID') }')" />
								<br>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</fieldset>
			</div>
			<div class="work_list">
				<fieldset id="doneList" class="list_field">
					<legend>Done</legend>
					<c:choose>
						<c:when test="${ fn:length(done) == 0 }">
							<p>업무가 없습니다.</p>
						</c:when>
						<c:otherwise>
							<c:forEach var="done" items="${ done }">
								<span onclick="viewWork('${ done.get('WK_ID'), done.get('WK_PRORATE}')"> <input
									type="hidden" value="${ done.get('WK_ID') }" /> ${ done.get("WK_TITLE") }/(${ done.get("MEM_NAME") })/${ done.get("WK_PRORATE") }%
								</span>
								<br />
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</fieldset>
			</div>
		</div>
		<div id="workInsert_Form" class="workInsert_Form">
			<input type="button" value="닫기" onclick="workInsert_Form_Close()" />
			<form id="wk_insert_form" action="./workInsert.do?pr_id=${ pr_id }" method="POST">
				업무 명 : <input type="text" name="wk_title" value="" /><br> 업무
				담당자 : <input type="text" class="input_mem_id" name="mem_id" value="${ mem_id }" />
					   <input type="button" value="멤버조회" onclick="searchMem()" /><br>
				업무 마감기한 : <input type="date" name="wk_endDate" value="" /><br> 
				<input type="submit" value="등록" />
			</form>
		</div>
		<div id="work_Edit_Form" class="work_Edit_Form">
			<fieldset>
				<legend>업무 수정 양식</legend>
				<form id="work_edit" action="./workEdit.do?pr_id=${ pr_id }"
					method="POST">
					<input type="hidden" id="edit_wk_id" name="wk_id" value="" /> <input
						type="button" value="닫기" onclick="wkEditClose()" /><br /> 업무 내용<input
						type="text" id="input_wk_title" name="wk_title" value="" /> 마감 기한<input
						type="date" id="input_wk_endDate" name="wk_endDate" value="" />
					담당자 <input type="text" class="input_mem_id" name="mem_id" value="" />
					<input type="button" value="멤버조회" onclick="searchMem()" /><br>
					<input type="submit" value="수정" />
				</form>
			</fieldset>
		</div>
		<div id="promem_list" class="promem_list">
			<fieldset>
				<legend>프로젝트 멤버</legend>
			</fieldset>
		</div>
		<div id="work_Detail" class="work_Detail_View">
			<input type="hidden" id="wk_id" value="" /> <input type="button"
				value="닫기" onclick="backToProject()" />
			<div id="work_Detail_Insert">
				업무명 <input type="text" id="insert_wd_title" name="wd_title" value="" />
				마감기한<input type="date" id="insert_wd_endDate" name="wd_endDate"
					value="" /> <input type="button" value="추가" onclick="wd_Insert()" />
			</div>
			<fieldset id="wd_Field">
				<legend>업무 상세화면</legend>
			</fieldset>
			<div class="work_Comment_View">
				<fieldset id="wk_Comment_List">
					<legend>댓글</legend>
				</fieldset>
				<div>
					<input type="text" id="new_wcom_content" value="" /> <input
						type="button" value="등록" onclick="wcom_Insert()" />
				</div>
			</div>
			<div class="work_Attach_View">
				<fieldset id="wk_Attach_List">
					<legend>첨부파일</legend>
				</fieldset>
				<div id="file_area">
					<form id="file_attach_form" action="./attachInsert.do"
						method="POST" enctype="multipart/form-data">
						<input type="hidden" name="wk_id" value="" /> <input type="file"
							id="new_attach_file" name="gatt_name" value="" /> <input
							type="button" value="등록" onclick="wkAttach_Insert(this)" />
					</form>
				</div>
			</div>
		</div>
	</div>
	<div id="footer">
		<jsp:include page="../footer.jsp" flush="false" />
	</div>
</body>
</html>