<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function(){
		$(".createBox").submit(function(event){
			if($("#grname").val()==""||$("#grgoal").val()==""){
				
				alert("모두 입력해주세요");
				return false;
			}else{
			alert("그룹가입신청 완료");
			}
		});
	});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<% String mem_id = (String)session.getAttribute("mem_id"); %>
<title>Insert title here</title>
</head>
<body>
	<form class="createBox" action="./groupCreate.do" method="post">
	<table>
		<tr>
			<td><input type="text"  name="gr_name" id="grname"></td>
			<td><input type="text" name="gr_goal" id="grgoal"></td>
			<td><input type="text" name="mem_id" value="<%=mem_id%>"></td>
		</tr>
		<tr><td><input type="submit" value="그룹생성"></td></tr>
	</table>
	</form>
</body>
</html>