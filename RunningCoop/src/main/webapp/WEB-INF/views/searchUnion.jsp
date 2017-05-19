<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>통합 검색 화면</title>
<link rel="stylesheet" href="css/main.css" type="text/css"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>

<script type="text/javascript">
	function doSearch(){
		var type = $("#select_type option:selected").val();
		var work = $("#search_word").val();

		if(type == "choice"){
			alert("검색 타입을 선택해주세요!");
		} else if (type == "group"){
			$("#gr_name").val(work);
			$("#groupSearch").submit();
		} else {
			$("#pr_name").val(work);
			$("#projectSearch").submit();
		}
	}
</script>
</head>
<body>
<div id = "header">
	<jsp:include page="header.jsp" flush="false"/>
</div>
<div id = "container">
	
	<div class="search_union_div">
		<select id="select_type">
			<option value="choice">선택</option>
			<option value="group">그룹</option>
			<option value="project">프로젝트</option>
		</select>
		<input type="text" id="search_word" name="search_word"/>
		<button class="body_btn do_search_btn" onclick="doSearch()">검색</button>
	</div>
	
	<div class="hide_form">
		<form id="groupSearch" action="./allGrSelect.do" method="post">
			<div class="ui-widget">
				<input type="text" name="gr_name" id="gr_name" class="searchbox"/>
			</div>
		</form>
		<form id="projectSearch" action="./allPrSelect.do" method="post">
			<div class="ui-widget">
				<input type="text" name="pr_name" id="pr_name" />
			</div>
		</form>
	</div>
	
</div>
<div id = "footer">
	<jsp:include page="footer.jsp" flush="false"/>
</div>
</body>
</html>