<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개인 프로젝트 생성 화면</title>

<link rel="stylesheet" href="css/main.css" type="text/css"/>

<style type="text/css">
	table{
		border-collapse: collapse;
	}
	tr, th, td {
		border: 1px solid black;
	}
</style>
</head>
<body>
<div id = "header">
	<jsp:include page="../header.jsp" flush="false"/>
</div>
<div id = "container">
	<form action="./gProCreate.do" method="POST">
		<table>
			<tr>
				<th>소속그룹 아이디</th>
				<td><input type="text" name="gr_id" value="${ gr_id }" readonly/></td>
			</tr>
			<tr>
				<th>프로젝트 명</th>
				<td>
					<input type="text" name="pr_name"/>
				</td>
			</tr>
			<tr>
				<th>프로젝트 시작일자</th>
				<td>
					<input type="date" name="pr_startdate"/>
				</td>
			</tr>
			<tr>
				<th>프로젝트 종료일자</th>
				<td>
					<input type="date" name="pr_enddate"/>
				</td>
			</tr>
			<tr>
				<th>프로젝트 목적</th>
				<td>
					<input type="text" name="pr_goal"/>
				</td>
			</tr>
			<tr>
				<th>비고</th>
				<td>
					<input type="text" name="pr_etc"/>
				</td>
			</tr>
		</table>
		<input type="submit" value="프로젝트 생성"/>
	</form>
</div>
<div id = "footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>
</body>
</html>