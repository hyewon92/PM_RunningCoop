<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>문의게시판</title>
<link rel="stylesheet" href="css/main.css" type="text/css"/>
<style type="text/css">
	table {
		border-collapse: collapse;
	}
	tr, th, td {
		border : 1px solid black;
	}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function(){
		$(".sbr_title").on("click", function(){
			var scryn = $(this).children("input[name=scryn]").val();
			var uuid = $(this).children("input[name=uuid]").val();
			
			if(scryn == 'Y'){
				var pw = prompt("비밀번호를 입력해주세요", "");
				$("input[name=sbr_uuid]").val(uuid);
				$("input[name=sbr_pw]").val(pw);
				$("#scrView").submit();
			} else {
				location.href = "./boardView.do?sbr_uuid="+uuid;
			}
		});
	});
	
	function writer(){
		location.href = "./writeForm.do";
	}
</script>
</head>
<body>
<div id = "header">
	<jsp:include page="../header.jsp" flush="false"/>
</div>
<div id = "container">
<h3>그룹 게시판</h3>
<div class="pr_search_area">
		<form action="./qnaSList.do" method="POST">
			<input type="text" name="sbr_title" /> 
			<input type="submit" value="검색" class="body_btn pr_search_btn"/>
		</form>
	</div>
		<div class="user_control_div">
		<input type="button" id="write" class="body_btn qna_writeForm_btn" value="게시글작성" onClick="writer()" />
	</div>
<div class="notice_board_list">
	<table class="noticeTable">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			<c:choose>
			<c:when test="${ fn:length(grlists) == 0 }">
				<tr>
					<td colspan="4">작성된 글이 없습니다</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="list" items="${grlists}" varStatus="vs">
					<tr>
						<td>${vs.count}</td>
						<td><span class = "sbr_title">
							<input type="hidden" name = "uuid" value = "${ list.get('BR_UUID') }"/>
							<input type="hidden" name = "scryn" value="${ list.get('BR_TITLE') }"/>
							${ list.get("MEM_NAME") }</span></td>
						<td>${ list.get("BR_REGDATE") }</td>
						<td>${ list.get("BR_NOTICEYN") }</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		</table>
		</div>
</div>
<div id = "footer">
	<jsp:include page="../footer.jsp" flush="false" />
</div>
</body>
</html>