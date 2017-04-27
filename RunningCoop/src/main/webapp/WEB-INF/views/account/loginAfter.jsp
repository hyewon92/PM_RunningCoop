<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">
   function openChild(){
      window.open("./showGrCreate.do", "GroupCreate", "width=640, height=450, resizable = no, scrollbars = no");
   }
</script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<title>Insert title here</title>
</head>
<body>
<div id = "header">
	<jsp:include page="../header.jsp" flush="false"/>
</div>
<div id = "container">
로그인 성공
</div>
<div id = "footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>



</body>
</html>