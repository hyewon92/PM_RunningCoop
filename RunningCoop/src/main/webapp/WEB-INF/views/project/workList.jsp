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

<link rel="stylesheet" href="css/main.css" type="text/css"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="js/project/project.js"></script>
<script type="text/javascript" src="js/project/worklist.js"></script>

<script type="text/javascript">
	<%String pr_level = (String) session.getAttribute("pr_level");%>
	/* 관리자 여부에 따라 프로젝트 관리 버튼 출력 */
	$(document).ready(function(){
		if( '<%=pr_level%>' == 'PM'){
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
			<div>
				<input type="hidden" id="pr_id" value="${ pr_id }" /> 
				<c:set var="pr_name" value="${ pr_detail }"></c:set>
				<p>${ pr_name.get('PR_NAME') }</p>
				<img alt="프로젝트 관리" class="pr_settings" src="images/project/pr_settings.png" onclick="location.href='./goProManage.do?pr_id=${ pr_id }'"/>
			</div>
			<div class="work_list">
				<div id="todoList" class="list_field">
					<div class="title_area">
						<span>Todo</span>
					</div>
					<div class="list_area">
						<table>
							<tr class="work" id="add_work" onclick="workInsert()">
								<td colspan="5"><img alt="업무 추가" src="images/project/pr_workAdd.png" /></td>
							</tr>
						<c:choose>
							<c:when test="${ fn:length(todo) == 0 }">
								<tr class="work">
									<td>
										업무가 없습니다.
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="todo" items="${ todo }">
									<tr class="work">
										<td onclick="viewWork('${ todo.get('WK_ID') }', 0)">${ todo.get('WK_TITLE') }</td>
										<td>${ todo.get('MEM_NAME') }</td>
										<td>${ todo.get('WK_PRORATE') }%</td>
										<td><input type="button" value="수정" onclick="workEdit('${ todo.get('WK_ID') }', '${ todo.get('WK_TITLE') }', '${ todo.get('WK_ENDDATE') }', '${ todo.get('MEM_ID') }')" /></td>
										<td><input type="button" value="삭제" onclick="workDelete('${ todo.get('WK_ID') }')" /></td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
						</table>
					</div>
				</div>
			</div>
			<div class="work_list">
				<div id="doingList" class="list_field">
					<div class="title_area">
						<span>Doing</span>
					</div>
					<div class="list_area">
						<table>
						<c:choose>
							<c:when test="${ fn:length(doing) == 0 }">
								<tr class="work">
									<td>업무가 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="doing" items="${ doing }">
									<tr class="work">
										<td onclick = "viewWork('${ doing.get('WK_ID')}', '${ doing.get('WK_PRORATE') }')">${ doing.get("WK_TITLE") }</td>
										<td>${ doing.get("MEM_NAME") }</td>
										<td>${ doing.get("WK_PRORATE") }%</td>
										<td><input type="button" value="수정" onclick="workEdit('${ doing.get('WK_ID') }', '${ doing.get('WK_TITLE') }', '${ doing.get('WK_ENDDATE') }', '${ doing.get('MEM_ID') }')" /></td>
										<td><input id=${doing.get('WK_ID')} type="button" value="삭제" onclick="workDelete('${ doing.get('WK_ID') }')" /></td>
										<td><img alt="" src="./images/bell.png" style="display:none;"></td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
						</table>
					</div>
				</div>
			</div>
			<div class="work_list" >
				<div id="doneList" class="list_field">
					<div class="title_area">
						<span>Done</span>
					</div>
					<div class="list_area">
						<table>
						<c:choose>
							<c:when test="${ fn:length(done) == 0 }">
								<tr class="work">
									<td>업무가 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="done" items="${ done }">
									<tr class="work">
										<td onclick="viewWork('${ done.get('WK_ID') }', '${ done.get('WK_PRORATE') }')">${ done.get("WK_TITLE") }</td>
										<td>${ done.get("MEM_NAME") }</td>
										<td>${ done.get("WK_PRORATE") }%</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div id="workInsert_Form" class="workInsert_Form">
			<div id="wk_insert_div">
				<form id="wk_insert_form" action="./workInsert.do?pr_id=${ pr_id }" method="POST">
					<table>
						<tr>
							<th>업무 명</th>
							<td><input type="text" name="wk_title" value="" /></td>
						</tr>
						<tr>
							<th>업무 담당자</th>
							<td><input type="text" id="insert_mem_id" name="mem_id" value="${ mem_id }" /></td>
						</tr>
						<tr>
							<th>업무 마감기한</th>
							<td><input type="date" name="wk_endDate" value="" /></td>
						</tr>
					</table>
					<input type="submit" class="body_btn workInsert_btn" value="등록" />
				</form>
			</div>
			<div id="promem_list_insert" class="promem_list">
				<table>
					<tr>
						<th colspan="2">프로젝트 멤버</th>
					</tr>
				</table>
			</div>
		</div>
		<div id="work_Edit_Form" class="work_Edit_Form">
			<form id="work_edit" action="./workEdit.do?pr_id=${ pr_id }" method="POST">
			<input type="hidden" id="edit_wk_id" name="wk_id" value="" />
			<table>
				<tr>
					<th>업무내용</th>
					<td><input type="text" id="input_wk_title" name="wk_title" value="" /></td>
				</tr>
				<tr>
					<th>마감기한</th>
					<td><input type="date" id="input_wk_endDate" name="wk_endDate" value="" /></td>
				</tr>
				<tr>
					<th>담당자</th>
					<td><input type="text" class="input_mem_id" name="mem_id" value="" />
						<input type="button" value="멤버조회" onclick="searchMem()" /></td>
				</tr>
			</table>
			</form>
			<input type="submit" value="수정" />
		</div>
		
		<div id="wd_modal">
			<div id="work_Detail">
				<input type="hidden" id="wk_id" value="" />
				<img alt="닫기" src="images/project/wd_close_btn.png" onclick="backToProject()"/>
				<div id="work_Detail_Insert">
					업무명 <input type="text" id="insert_wd_title" name="wd_title" value="" />
					마감기한<input type="date" id="insert_wd_endDate" name="wd_endDate"
						value="" /> <input type="button" value="추가" onclick="wd_Insert()" />
				</div>
				<div id="wd_Field">
					<p>업무 상세화면</p>
					<fieldset>
						<legend>업무 상세화면</legend>
						<div id = "allProgress">
							<div id = "partProgress"></div>
						</div>
					</fieldset>
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
				<div class="work_Comment_View">
					<fieldset id="wk_Comment_List">
						<legend>댓글</legend>
					</fieldset>
					<div>
						<input type="text" id="new_wcom_content" value="" /> <input
							type="button" value="등록" onclick="wcom_Insert()" />
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="footer">
		<jsp:include page="../footer.jsp" flush="false" />
	</div>
</body>
</html>