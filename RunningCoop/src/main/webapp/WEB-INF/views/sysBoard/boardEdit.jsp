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
<link rel="stylesheet" href="daumOpenEditor/css/editor.css" type="text/css"/>
<script src="daumOpenEditor/js/editor_loader.js" type="text/javascript" charset="utf-8"></script>
<script src="daumOpenEditor/js/editor_creator.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="css/main.css" type="text/css"/>
<style type="text/css">
table {
	border-collapse: collapse;
}

tr, th, td {
	border: 1px solid black;
	display : 
}
</style>

<script type="text/javascript">
	function back() {
		history.back();
	}
	
	/* 비밀글 체크 시 비밀번호 입력가능한 인풋박스 출력 script */
	$(document).ready(function() {
		var scryn = $("#scryn").val();
		if(scryn == 'Y'){
			$("#sbr_scryn").attr("checked", true);
		}
		
		var chkyn = $("#sbr_scryn").is(":checked");
		if(chkyn == true){
			$("#sbr_pw").css("display", "inline");
		}
		
		$("#sbr_scryn").click(function() {
			var chkyn = $(this).is(":checked");
			if (chkyn == true) {
				$("#sbr_pw").css("display", "inline");
			} else if (chkyn == false) {
				$("#sbr_pw").css("display", "none");
			}
		});
	
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
</script>

</head>
<body>
<div id = "header">
	<jsp:include page="../header.jsp" flush="false"/>
</div>
<div id = "container">
	<c:set var="view" value="${ view }" />
	<form id="boardEdit" action="./boardEdit.do" method="post" enctype="multipart/form-data">
	
		<div>
		<input type="hidden" name="sbr_uuid" value="${ view.get('SBR_UUID') }"/>
			<span>제목</span>
			<input type="text" name="sbr_title" value="${ view.get('SBR_TITLE') }" />
		</div>
		<div>
			<input type="hidden" id="scryn" value="${ view.get('SBR_SCRYN') }"/>
			<input type="checkbox" id="sbr_scryn" name="sbr_scryn" /><span>비밀글</span>
			<input type="text" id="sbr_pw" name="sbr_pw" value="${ view.get('SBR_PW') }" style="display: none" />
		</div>
		<div>
			<textarea id="content" name="sbr_content"></textarea>
		</div>
		<div>
			<fieldset>
				<legend>첨부파일</legend>
				<c:set var="attach" value="${ attach }" />
					<p>기존파일 : 
						${ attach.get("SATT_NAME") }(${ attach.get("SATT_SIZE")/1024 }KB)
					</p>
					<p> 새로운 파일
					<input type="hidden" id="filesize" name="satt_size" value=""/>
					<input type="file" id="file" name="satt_name"/>
					</p> 
			</fieldset>
		</div>
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

			EditorCreator.convert(document.getElementById("content"),
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

	        var field = document.getElementById("content");
	        field.value = content;

			return true;
		}
	</script>
	<div>
		<button onclick='saveContent()'>등록</button>
	</div>
	<input type="button" value="목록으로" onclick="back()" />
</div>
<div id = "footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>
</body>
</html>