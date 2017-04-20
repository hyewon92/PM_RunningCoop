<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >

<html>
<head>
<style type="text/css">
img{
cursor:pointer;
width: 50px;
}
</style>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<table id="grdate">
	<c:forEach var = "grSelect" items="${grSelect }"> 
			<tr><td>${grSelect.GR_ID}</td></tr>
			<tr><td>${grSelect.GR_NAME }</td></tr>
			<tr><td>${grSelect.MEM_NAME }</td></tr>
			<tr><td>${grSelect.GR_MEMCNT }</td></tr>
			<tr><td>${grSelect.GR_GOAL }</td></tr>
			<tr><td>${grSelect.GR_REGDATE }</td></tr>
	<p><img alt="" src="http://wooreeweb.com/lecture/wp-content/uploads/2014/11/gear2-01.jpg" onclick="location.href='./grmodify.do?gr_id=${grSelect.GR_ID}'" ></p>
	</c:forEach>		
	</table> 
	
	

</body>
</html>