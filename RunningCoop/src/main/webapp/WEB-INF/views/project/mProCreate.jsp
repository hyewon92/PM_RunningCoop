<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개인 프로젝트 생성 화면</title>
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
<form action="./mProCreate.do" method="POST">
	<table>
		<tr>
			<th>프로젝트 명</th>
			<td>
				<input type="textbox" name="pr_name"/>
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
				<input type="textbox" name="pr_goal"/>
			</td>
		</tr>
		<tr>
			<th>비고</th>
			<td>
				<input type="textbox" name="pr_etc"/>
			</td>
		</tr>
	</table>
	<input type="submit" value="프로젝트 생성"/>
</form>
</body>
</html>