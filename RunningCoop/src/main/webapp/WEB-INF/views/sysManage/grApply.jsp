<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >
<html>
<head>
<link rel="stylesheet" href="css/main.css" type="text/css"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
	table {
		border-collapse: collapse;
	}
	tr,td,th {
		border : 1px solid black;
	}
</style>
<script type="text/javascript">
	function cheakAll(all) {
		var box = document.getElementsByName("gr_id");

		for (var i = 0; i < box.length; i++) {
			box[i].checked = all;
		}
	}
	function test01() {
		$("#aa").submit(function() {
			$(this).attr("action", "grApplyYse.do");
		});
	}
	function test02() {
		$("#aa").submit(function() {
			$(this).attr("action", "grApplyNo.do");
		});
	}
	function gropuChildOpen(grid) {
		var ra = $(grid).parent().siblings().eq(0).find("input[name=gr_id]")
				.val();

		alert(ra);
		window.open("./groupInfoChild.do?gr_id=" + ra, "InfoChild",
				"width=570, height=350, resizable = no, scrollbars = no");
	}
</script>
<style type="text/css">
#groupChild {
	cursor: pointer;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시스템 관리자 - 그룹 생성 승인 관리</title>
</head>
<body>
	<div id="sys_header">
		<jsp:include page="../sysHeader.jsp" flush="false" />
	</div>
	<div id="sys_container">
		<div id="mgr_Container">
						<form id="aa" action="" method="post">
							<table>
								<tr>
									<td colspan="4"><input type="submit" value="승인"
										onclick="test01()"><input type="submit" value="거절"
										onclick="test02()"></td>
								</tr>
								<tr>
									<td><input type="checkbox"
										onclick="cheakAll(this.checked)"></td>
									<td>그룹명</td>
									<td>그룹관리자</td>
									<td>신청일자</td>
								</tr>
								<c:forEach var="apply" items="${Apply}">
									<tr>
										<td><input type="checkbox" name="gr_id"
											value="${apply.GR_ID}"></td>
										<td><a onclick="gropuChildOpen(this)" id="groupChild">${apply.GR_NAME}</a></td>
										<td>${apply.MEM_NAME}</td>
										<td>${apply.GR_REGDATE}</td>
									</tr>
								</c:forEach>
							</table>
						</form>

						<form action="./grApplySch.do" method="post">
							<div>
								<input type="text" name="gr_name" /> <input type="submit"
									value="그룹검색" />
							</div>
						</form>
		</div>
	</div>
	<div id="sys_footer">
		<jsp:include page="../sysFooter.jsp" flush="false"/>
	</div>
</body>
</html>