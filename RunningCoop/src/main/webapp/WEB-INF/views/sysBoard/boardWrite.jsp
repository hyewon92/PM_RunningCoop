<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시스템게시판 글쓰기 화면(사용자 문의글)</title>

<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#sbr_scryn").click(function() {
			var chkyn = $(this).is(":checked");
			if (chkyn == true) {
				$("#sbr_pw").css("display", "block");
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
						<span> 제목 </span>
						<input type="textbox" name="sbr_title" />
						<input type="checkbox" id="sbr_scryn" name="sbr_scryn" />비밀글
						<input type="textbox" id="sbr_pw" name="sbr_pw"
							style="display: none" />
						<jsp:include page="daumOpenEditor.jsp" flush="false"></jsp:include>
						<span> 첨부파일 </span>
						<input type="file" id="file" name="satt_name" /> <input
							type="hidden" id="filesize" name="satt_size" />
						<input type="submit" value="등록" /> <input type="button"
							value="목록으로" onclick="back()" />
	</form>
</body>
</html>