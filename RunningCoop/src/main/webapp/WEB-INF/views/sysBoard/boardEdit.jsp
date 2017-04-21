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
	<form id="boardWrite" action="./boardEdit.do" method="post" enctype="multipart/form-data">
		<span>제목</span><input type="textbox" name="sbr_title"
			value="${ view.get('SBR_TITLE') }" /><br> 
			<span>첨부파일</span>
			<c:forEach var="attach" items="${ attach }">
			<p><a href="#">${ attach.get("SATT_NAME") }</a>${ attach.get("SATT_SIZE") }</p>
			</c:forEach>
			<br>
		<jsp:include page="daumOpenEditor.jsp"></jsp:include>
		<script>
	    var config = {
	            initializedId: "",
	            wrapper: "tx_trex_container",
	            form: 'boardWrite',
	            txIconPath: "daumOpenEditor/images/icon/editor/",
	            txDecoPath: "daumOpenEditor/images/deco/contents/",
	            events: {
	                preventUnload: false
	            },
	            sidebar: {
	                attachbox: {
	                    show: true
	                }
	            }
	        };

	        EditorCreator.convert(document.getElementsByName("sbr_content")[0], 'daumOpenEditor/pages/template/simple.html', function () {
	        	var content = '${ view.get("SBR_CONTENT") }';
	            EditorJSLoader.ready(function (Editor) {
	                new Editor(config);
	                Editor.modify({
	                    content: content
	                });
	            });
	        });
		
		</script>
		<br>
	</form>
	<script type="text/javascript">
		/* 예제용 함수 */
		function saveContent() {
			Editor.save(); // 이 함수를 호출하여 글을 등록하면 된다.
		}

		/**
		 * Editor.save()를 호출한 경우 데이터가 유효한지 검사하기 위해 부르는 콜백함수로
		 * 상황에 맞게 수정하여 사용한다.
		 * 모든 데이터가 유효할 경우에 true를 리턴한다.
		 * @function
		 * @param {Object} editor - 에디터에서 넘겨주는 editor 객체
		 * @returns {Boolean} 모든 데이터가 유효할 경우에 true
		 */
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

		/**
		 * Editor.save()를 호출한 경우 validForm callback 이 수행된 이후
		 * 실제 form submit을 위해 form 필드를 생성, 변경하기 위해 부르는 콜백함수로
		 * 각자 상황에 맞게 적절히 응용하여 사용한다.
		 * @function
		 * @param {Object} editor - 에디터에서 넘겨주는 editor 객체
		 * @returns {Boolean} 정상적인 경우에 true
		 */
		function setForm(editor) {
			var i, input;
			var form = editor.getForm();
			var content = editor.getContent();

			// 본문 내용을 필드를 생성하여 값을 할당하는 부분
			var textarea = document.createElement('textarea');
			textarea.name = 'sbr_content';
			textarea.value = content;
			form.createField(textarea);

			/* 아래의 코드는 첨부된 데이터를 필드를 생성하여 값을 할당하는 부분으로 상황에 맞게 수정하여 사용한다.
			 첨부된 데이터 중에 주어진 종류(image,file..)에 해당하는 것만 배열로 넘겨준다. */
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