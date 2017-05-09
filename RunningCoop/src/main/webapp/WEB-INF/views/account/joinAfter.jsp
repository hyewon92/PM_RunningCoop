<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	function grJoinChild (val){
		window.open("./groupGoGo.do?mem_id="+val, "GroupCreate", "width=640, height=450, resizable = no, scrollbars = no");
	}
	
</script>
<title>Insert title here</title>
</head>
<body>
	<h2>회원가입이 성공적으로 처리됐습니다</h2>
	<%
		String mem_id = (String)session.getAttribute("mem_id");
	%>
	<input type = "button" value = "메인으로 이동" onclick = "location.href='./firstLogin.do'">
	<input type = "button" value = "그룹 가입 신청하기" onclick = "grJoinChild('<%=mem_id%>')">

</body>
</html>