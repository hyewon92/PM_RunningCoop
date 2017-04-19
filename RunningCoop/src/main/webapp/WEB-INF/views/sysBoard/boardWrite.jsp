<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시스템게시판 글쓰기 화면(사용자 문의글)</title>
<script type="text/javascript" src = "http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#sbr_scryn").click(function(){
			var chkyn = $(this).is(":checked");
			if(chkyn == true){
				$("#sbr_pw").css("display", "block");
			} else if (chkyn == false){
				$("#sbr_pw").css("display", "none");
			}
		});
		
		$("#file").bind('change', function(){
			var maxFileSize = 1024*1024*5;
			var InputFileSize = this.files[0].size;
			if(InputFileSize > maxFileSize){
				alert("파일이 너무 큽니다");
				$(this).val("");
			} else {
				$("#filesize").val(InputFileSize);
			}
		});
	});
	
	function back(){
		history.back();
	}
</script>
<style type="text/css">
	table {
		border-collapse: collapse;
	}
	
	tr, th, td {
		border : 2px solid black;
	}
</style>
</head>
<body>

<form action="./boardWrite.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="mem_id" value="${ mem_id }"/>
	<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="textbox" name = "sbr_title"/>
			</td>
		<tr>
			<td>
				<input type="checkbox" id = "sbr_scryn" name = "sbr_scryn" />비밀글
			</td>
			<td>
				<input type="textbox" id = "sbr_pw" name = "sbr_pw" style="display: none"/>
		</tr>
		<tr>
			<td colspan="3">
				<textarea rows="10" cols="50" name="sbr_content"></textarea>
			</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td colspan="2">
				<input type="file" id = "file" name="satt_name"/>
				<input type="hidden" id ="filesize" name="satt_size"/>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<input type="submit" value="등록"/>
				<input type="button" value="목록으로" onclick="back()"/>
			</td>
		</tr>	
	</table>
</form>

</body>
</html>