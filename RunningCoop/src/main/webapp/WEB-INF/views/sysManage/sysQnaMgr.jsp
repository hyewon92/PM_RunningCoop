<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시스템 문의 게시판 관리 페이지</title>
</head>
<body>
<div id = "header">
	<jsp:include page="../sysHeader.jsp" flush="false"/>
</div>
<div id = "container">
<div id = "mgr_Container">
	<table>
		<tr>
			<td>관리자 도구 모음</td>
			<td rowspan="7">
				<h3>문의 게시판 관리 페이지</h3>
				<input type="button" value="게시글 등록"/>
				<input type="button" value="선택 삭제"/>
				<table>
					<tr>
						<th>선택</th>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일자</th>
						<th>삭제</th>
					</tr>
					
				</table>
				<form action="">
					<input type="text" name="sbr_name"/>
					<input type="submit" value="검색"/>
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
</div>
</body>
</html>