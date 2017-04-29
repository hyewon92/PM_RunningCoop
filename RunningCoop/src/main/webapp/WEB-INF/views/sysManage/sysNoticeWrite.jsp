<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시스템 공지 게시판 관리 페이지</title>
<link rel="stylesheet" href="daumOpenEditor/css/editor.css" type="text/css" charset="utf-8" />
<script src="daumOpenEditor/js/editor_loader.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
.formTable {
	width: 100%;
	display: table;
}

.tableBody {
	display: table-row-group;
}

.tableRow {
	border: 1px solid black;
	display: table-row;
}

.tableCol {
	border: 1px solid black;
	display: table-cell;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		/* file의 크기를 구하는 script */
		$("#file").bind('change', function() {
			var maxFileSize = 1024 * 1024 * 5;
			var InputFileSize = this.files[0].size;
			if (InputFileSize > maxFileSize) {
				alert("파일이 너무 큽니다");
				$(this).val("");
			} else {
				$("#filesize").val(InputFileSize);
			}
		});
	});

	/* 목록으로 돌아가는 script */
	function back() {
		history.back();
	}
</script>
</head>
<body>
	<div id="header">
		<jsp:include page="../sysHeader.jsp" flush="false" />
	</div>
	<div id="container">
		<div id="mgr_Container">
			<table>
				<tr>
					<td>관리자 도구 모음</td>
					<td rowspan="7">
						<h3>공지 게시판 게시글 작성 페이지</h3>
						<form id="boardWrite" action="./boardWrite.do" method="post"
							enctype="multipart/form-data">
							<input type="hidden" name="mem_id" value="${ mem_id }" />
							<div>
								<span> 제목 </span> <input type="text" name="sbr_title" />
							</div>
							<jsp:include page="../daumOpenEditor.jsp" flush="false"></jsp:include>
							<fieldset id="file_attach_list">
								<legend>첨부파일</legend>
								<input type="file" id="file" name="sbr_name" /> 
								<input type="hidden" id="filesize" name="sbr_size" />
							</fieldset>
						</form>
					</td>
				</tr>
				<tr>
					<td>그룹 승인 관리</td>
				</tr>
				<tr>
					<td>회원 관리</td>
				</tr>
				<tr>
					<td>공지 게시판 관리</td>
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
			/* 예제용 함수 */
			function saveContent() {
				Editor.save(); // 이 함수를 호출하여 글을 등록하면 된다.
			}

			function validForm(editor) {
				// Place your validation logic here

				// sample : validate that content exists
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

				// 본문 내용을 필드를 생성하여 값을 할당하는 부분
				var textarea = document.createElement('textarea');
				textarea.name = 'sbr_content';
				textarea.value = content;
				form.createField(textarea);

				var images = editor.getAttachments('image');
				for (i = 0; i < images.length; i++) {
					// existStage는 현재 본문에 존재하는지 여부
					if (images[i].existStage) {
						// data는 팝업에서 execAttach 등을 통해 넘긴 데이터
						alert('attachment information - image[' + i + '] \r\n'
								+ JSON.stringify(images[i].data));
						input = document.createElement('input');
						input.type = 'hidden';
						input.name = 'attach_image';
						input.value = images[i].data.imageurl; // 예에서는 이미지경로만 받아서 사용
						form.createField(input);
					}
				}

				var files = editor.getAttachments('file');
				for (i = 0; i < files.length; i++) {
					input = document.createElement('input');
					input.type = 'hidden';
					input.name = 'attach_file';
					input.value = files[i].data.attachurl;
					form.createField(input);
				}
				return true;
			}
		</script>
		<div>
			<button onclick='saveContent()'>등록</button>
		</div>
		<input type="button" value="목록으로" onclick="back()" />
	</div>
</body>
</html>