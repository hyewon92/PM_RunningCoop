<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 수정 화면</title>
<link rel="stylesheet" href="daumOpenEditor/css/editor.css"
	type="text/css" charset="utf-8" />
<script src="daumOpenEditor/js/editor_loader.js" type="text/javascript"
	charset="utf-8"></script>
<script src="daumOpenEditor/js/editor_creator.js" type="text/javascript"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>

<style type="text/css">
table {
	border-collapse: collapse;
}

tr, th, td {
	border: 1px solid black;
}
</style>

<script type="text/javascript">
	function back() {
		history.back();
	}
</script>
</head>
<body>
	<div id="header">
		<jsp:include page="../header.jsp" flush="false" />
	</div>
	<div id="container">
		<div id="mgr_Container">
			<table>
				<tr>
					<td>관리자 도구 모음</td>
					<td rowspan="7">
						<h3>공지 게시글 수정</h3> <c:set var="view" value="${ view }" />
						
						<form id="noticeEdit" action="./sysboardEdit.do" method="post"
							enctype="multipart/form-data">
							<div>
								<input type="hidden" name="sbr_uuid"
									value="${ view.get('SBR_UUID') }" /> <span>제목</span> <input
									type="text" name="sbr_title" value="${ view.get('SBR_TITLE') }" />
							</div>
							<div>
								<input type="checkbox" id="sbr_scryn" name="sbr_scryn" /><span>비밀글</span>
								<input type="text" id="sbr_pw" name="sbr_pw"
									style="display: none" />
							</div>
							<div>
								<fieldset>
									<legend>첨부파일</legend>
									<c:set var="attach" value="${ attach }" />
									<p>기존파일 : ${ attach.get("SATT_NAME") }(${ attach.get("SATT_SIZE")/1024 }KB)
									</p>
									<p>
										새로운 파일 <input type="hidden" id="filesize" name="satt_size"
											value="" /> <input type="file" id="file" name="satt_name" />
									</p>
								</fieldset>
							</div>
							<input type="hidden" id="sbr_content" value="${ view.get('SBR_CONTENT') }" />
						</form>
						<div>
							<button onclick='saveContent()'>등록</button>
						</div> <input type="button" value="목록으로" onclick="back()" />
					</td>
				</tr>
				<tr>
					<td><a href="./grApply.do">그룹 승인 관리</a></td>
				</tr>
				<tr>
					<td>회원 관리</td>
				</tr>
				<tr>
					<td><a href="./sysNoticeMgr.do">공지 게시판 관리</a></td>
				</tr>
				<tr>
					<td>문의 게시판 관리</td>
				</tr>
				<tr>
					<td>공백</td>
				</tr>
				<tr>
					<td>로그아웃</td>
				</tr>
			</table>
		</div>

		<!-- 다음 에디터 함수 -->
		<script type="text/javascript">
			var config = {
				initializedId : "",
				wrapper : "tx_trex_container",
				form : 'noticeEdit',
				txIconPath : "daumOpenEditor/images/icon/editor/",
				txDecoPath : "daumOpenEditor/images/deco/contents/",
				events : {
					preventUnload : false
				},
				sidebar : {
					attachbox : {
						show : true
					}
				}
			};

			EditorCreator.convert(document.getElementById("sbr_content"),
					'daumOpenEditor/pages/template/daumOpenEditor.jsp',
					function() {
						var content = '${ view.get("SBR_CONTENT") }';
						EditorJSLoader.ready(function(Editor) {
							new Editor(config);
							Editor.modify({
								content : content
							});
						});
					});
		</script>
		<script type="text/javascript">
			function saveContent() {
				Editor.save(); // 이 함수를 호출하여 글을 등록하면 된다.
			}

			function validForm(editor) {
				var validator = new Trex.Validator();
				var content = editor.getContent();
				if (!validator.exists(content)) {
					alert('내용을 입력하세요');
					return false;
				}

				return true;
			}

			function setForm(editor) {
				var i, input;
				var form = editor.getForm();
				var content = editor.getContent();

				var textarea = document.createElement('textarea');
				textarea.name = 'sbr_content';
				textarea.value = content;
				form.createField(textarea);

				return true;
			}
		</script>

	</div>
</body>
</html>