<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로젝트 업무 리스트 화면</title>
</head>
<body>
<fieldset id="todoList">
	<legend>Todo</legend>
	<c:forEach var="todo" items="${ todo }">
		<p><input type="hidden" value="${ todo.get('WK_ID') }"/>
		${ todo.get('WK_TITLE') }/(${ todo.get('MEM_NAME' })/${ todo.get('WK_PRORATE') }
		</p>
	</c:forEach>
</fieldset>
<fieldset id="doingList">
	<legend>Doing</legend>
	<c:forEach var="doing" items="${ doing }">
		<p><input type="hidden" value="${ doing.get('WK_ID') }"/>
		${ doing.get('WK_TITLE') }/(${ doing.get('MEM_NAME') })/${ done.get('WK_PRORATE') }
		</p>
	</c:forEach>
</fieldset>
<fieldset id="doneList">
	<legend>Done</legend>
	<c:forEach var="done" items="${ done }">
		<p><input type="hidden" value="${ done.get('WK_ID') }"/>
		${ done.get('WK_TITLE') }/(${ done.get('MEM_NAME') })/${ done.get('WK_PRORATE') }
		</p>
	</c:forEach>
</fieldset>

</body>
</html>