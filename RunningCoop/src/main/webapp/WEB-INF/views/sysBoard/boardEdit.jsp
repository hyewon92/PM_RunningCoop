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
<link rel="stylesheet" href="daumOpenEditor/css/editor.css" type="text/css" charset="utf-8" />
<script src="daumOpenEditor/js/editor_loader.js" type="text/javascript" charset="utf-8"></script>
<script src="daumOpenEditor/js/editor_creator.js" type="text/javascript" charset="utf-8"></script>

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
	<input type="hidden" value="${ sbr_uuid }" />
	<c:set var="view" value="${ view }" />
	<form id="boardEdit" action="./boardEdit.do" method="post" enctype="multipart/form-data">
	
		<div>
			<span>제목</span>
			<input type="textbox" name="sbr_title" value="${ view.get('SBR_TITLE') }" />
		</div>
		<div>
			<fieldset>
				<legend>첨부파일</legend>
				<c:forEach var="attach" items="${ attach }">
					<p>
						<input type="hidden" name="satt_seq" value="${ attach.get('SATT_SEQ') }" />
						<a href="#">${ attach.get("SATT_NAME") }</a>
						${ attach.get("SATT_SIZE") }
					</p>
				</c:forEach>
			</fieldset>
		</div>
		
		<jsp:include page="daumOpenEditor.jsp"></jsp:include>
		
		
		<script>
			var config = {
				initializedId : "",
				wrapper : "tx_trex_container",
				form : 'boardEdit',
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

			EditorCreator.convert(document.getElementsByName("sbr_content")[0],
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
		
		
	</form>
	
	
	<script type="text/javascript">
		/* 예제용 함수 */
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
</body>
</html>