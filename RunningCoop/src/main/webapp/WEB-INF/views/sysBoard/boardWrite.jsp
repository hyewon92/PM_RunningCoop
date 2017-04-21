<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시스템게시판 글쓰기 화면(사용자 문의글)</title>
<link rel="stylesheet" href="daumOpenEditor/css/editor.css" type="text/css" charset="utf-8" />
<script src="daumOpenEditor/js/editor_loader.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	/* 비밀글 체크 시 비밀번호 입력가능한 인풋박스 출력 script */
	$(document).ready(function() {
		$("#sbr_scryn").click(function() {
			var chkyn = $(this).is(":checked");
			if (chkyn == true) {
				$("#sbr_pw").css("display", "block");
			} else if (chkyn == false) {
				$("#sbr_pw").css("display", "none");
			}
		});
		
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
</head>
<body>
	<form id="boardWrite" action="./boardWrite.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="mem_id" value="${ mem_id }" />
			<div>
				<span> 제목 </span>
				<input type="textbox" name="sbr_title" />
			</div>
			<div>
						<input type="checkbox" id="sbr_scryn" name="sbr_scryn" /><span>비밀글</span>
						<input type="textbox" id="sbr_pw" name="sbr_pw" style="display: none" />
			</div>			
						<jsp:include page="daumOpenEditor.jsp" flush="false"></jsp:include>
			<fieldset id="file_attach_list">
				<legend>첨부파일</legend>
				<input type="file" id="file" name="sbr_name"/>
				<input type="hidden" id="filesize" name="sbr_size" />
			</fieldset>
	</form>

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
                alert('attachment information - image[' + i + '] \r\n' + JSON.stringify(images[i].data));
                input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'attach_image';
                input.value = images[i].data.imageurl;  // 예에서는 이미지경로만 받아서 사용
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
<div><button onclick='saveContent()'>등록</button></div>
<input type="button" value="목록으로" onclick="back()" />

</body>
</html>