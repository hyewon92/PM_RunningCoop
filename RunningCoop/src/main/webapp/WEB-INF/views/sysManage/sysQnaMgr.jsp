<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시스템 문의 게시판 관리 페이지</title>
</head>
<body>
	<div id="header">
		<jsp:include page="../sysHeader.jsp" flush="false" />
	</div>
	<div id="container">
		<div id="mgr_Container">
			<table>
				<tr>
					<td>관리자 도구 모음</td>
					<td rowspan="7">
						<h3>문의 게시판 관리 페이지</h3> <input type="button" value="게시글 등록" /> <input
						type="button" value="선택 삭제" />
						<table>
							<tr>
								<th>선택</th>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일자</th>
								<th>삭제</th>
							</tr>
							<c:choose>
								<c:when test="${ fn:length(list) == 0 }">
									<tr>
										<td colspan="6">조회 가능한 게시글이 없습니다</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${ list }" varStatus="vs">
										<tr>
											<td><input type="checkbox" name="number"
												value="${ list.SBR_UUID }" /></td>
											<td>${ vs.count }</td>
											<td><span
												onclick="location.href='./viewQna.do?sbr_uuid=${ list.SBR_UUID }'">${ list.SBR_TITLE }</span></td>
											<td>${ list.MEM_NAME }</td>
											<td>${ list.SBR_REGDATE }</td>
											<td><input type="button" value="삭제"
												onclick="location.href='./sysboardDelete.do?sbr_uuid=${ list.SBR_UUID }'" /></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</table>
						<form action="">
							<input type="text" name="sbr_name" /> <input type="submit"
								value="검색" />
						</form>
					</td>
				</tr>
				<tr>
					<td><a href="./grApply.do">그룹 승인 관리</a></td>
				</tr>
				<tr>
					<td>회원 관리</td>
				</tr>
				<tr>
					<td><a href="./sysNoticeMgr.do">공지 게시판 관리</a></td>
				</tr>
				<tr>
					<td><a href="./sysQnaMgr.do">문의 게시판 관리</a></td>
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