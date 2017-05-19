<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/main.css" type="text/css"/>
<style type="text/css">
	.btn{
		width: 220px;
		height: 40px;
	  	padding: 2px;
		margin: auto;
		color: white;
	    font-size: 18px;
	    background-color: #5cb85c;
	    border: 0.5px solid transparent;
	    border-radius: 4px;
	    text-align: center;
	  	cursor: pointer;
	}
</style>
<script type="text/javascript">
	function grJoinChild (val){
		window.open("./groupGoGo.do?mem_id="+val, "GroupCreate", "width=640, height=450, resizable = no, scrollbars = no");
	}
	
</script>
<title>Insert title here</title>
</head>
<body>
	<%
		String mem_id = (String)session.getAttribute("mem_id");
	%>
	<div id = "header">
		<jsp:include page="../header.jsp" flush="false"/>
	</div>
	<div id = "container" style = "padding:30px;">
		<div style = "height:20%; margin-bottom: 40px;"><img src = "images/welcome.png" style = "margin-top:100px; width:600px; height:40px;"></div>
		<div style = "overflow: hidden">
			<div style = "float: left; width: 50%;">
				<div style = "width:100%;">
					<img src = "images/group.png" style = "width:160px; height: 160px; margin-bottom:30px;">
				</div>
				<input type = "button" class = "btn" value = "메인으로 이동" onclick = "location.href='./firstLogin.do'">
			</div>
			<div>
				<div style = "width:100%;">
					<img src = "images/project.png" style = "width:160px; height: 160px; margin-bottom:30px;">
				</div>
				<input type = "button" class = "btn"  value = "그룹 가입 신청하기" onclick = "grJoinChild('<%=mem_id%>')">
			</div>
		</div>
	</div>
	
	<div id = "footer">
		<jsp:include page="../footer.jsp" flush="false"/>
	</div>
</body>
</html>