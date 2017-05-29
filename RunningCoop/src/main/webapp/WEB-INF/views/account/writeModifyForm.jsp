<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개인정보 수정</title>
<link rel="stylesheet" href="css/main.css" type="text/css">
<link rel="stylesheet" href="css/body/user_account.css">
<style type="text/css">

	.upperBox{
		width: 452px;
		height: 390px;
		margin: auto;
		padding: 2px;
		margin-top: 70px;
	}
	
	.modifyBox{
		width: 450px;
		height: 340px;
		border: 0.5px solid #B4B4B4; 
		margin: auto;
		padding: 20px;
	}
	
	.leaveBox{
		display: none;
		width: 450px;
		height: 340px;
		border: 0.5px solid #B4B4B4; 
		margin: auto;
		padding: 20px;
	}
	
	.upSpan{
		float:left; 
		font-size:12pt;
	}
	
	.leaveBtn {
		color: #fff;
		font-size: 14px;
	    background-color: #5cb85c;
	    border-color: #4cae4c;
	    display: inline-block;
	    padding: 2px 12px;
	    margin-bottom: 0;
	    font-size: 14px;
	    font-weight: normal;
	    text-align: center;
	    vertical-align: middle;
	    border: 1px solid transparent;
   	 	border-radius: 4px;	    
	}
	
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	var checked = false;
	function pw_chk(){
		if($("#upPw").val()!=$("#upPw2").val()){
			alert("비밀번호가 일치하지 않습니다.\n 재입력해주세요");
			$("#upPw").val("");
			$("#upPw").val("");
		}else{
			alert("비밀번호가 확인됐습니다.");
			checked = true;
		}
	}
	$(function(){
		$(".modifyBox").submit(function(event){
			if(!checked){
				alert("비밀번호를 확인해주세요.");
				return false;
			}
			var standardPhone = /\d{3,4}$/;
			var phoneNum = $("#upPhone").val();
			if(!standardPhone.test(phoneNum)||phoneNum.length>11){
				alert("숫자형식으로 3~4자씩 최대 11자리 입력해주세요");
				return false;
			}
			if(!$("#upPw").val()||!$("#upPw2").val()||!$("#upName").val()||!$("#upEmail").val()||!$("#upPhone").val()){
				alert("모두 입력해주세요");
				return false;
			}
		});
	});
	
	function goLeave(){
		if(confirm("정말 탈퇴하시겠습니까?")){
			showLeavBox();
		}
	}
	
	function showLeavBox(){
		$(".modifyBox").css("display", "none");	
		$(".leaveBox").css("display", "block");	
	}
	
	function showModiBox(){
		$(".modifyBox").css("display", "block");	
		$(".leaveBox").css("display", "none");	
	}
	
	function goListPm(){
		window.open("./viewListPm.do");
	}
	
	function goListGm(){
		window.open("./viewListGm.do");
	}
</script>
</head>
<body>

	<div id = "header">
		<jsp:include page="../header.jsp" flush="false"/>
	</div>
	
	<div id = "container">
		<div class = "upperBox">
			<div style = "width: 200px;">
				<div style = "width:100px; display: inline-block; float: left;"><input type = "button" class = "accountBtn" style = "width:100px; height: 30px; font-size:10pt; background-color: #5cb85c; color: white; border-right-color: white;" value = "개인정보 수정" onclick="showModiBox()"></div>
				<div style = "width:100px; display: inline-block;"><input type = "button" class = "accountBtn" style = "width:100px; height: 30px; font-size:10pt; background-color: #5cb85c; color: white;" value = "탈퇴하기" onclick = "goLeave()"></div>
			</div>
			<form class = "modifyBox" action="./memInfoModify.do" method="post">
				<div class = "rowGroup" style = "border-bottom: none;">
					<div class = "join_row" style = "margin-bottom: 5px;"><span class = "upSpan">아이디: </span><input type = "text" class = "int" id = "upId" name = "mem_id" value = "${dto.getMem_id()}" readonly="readonly" style = "width:80%; font-size:12pt;"></div>
					<div class = "join_row" style = "margin-bottom: 5px;"><span class = "upSpan">비밀번호: </span><input type = "password" class = "int" id = "upPw" name = "mem_pw" value = "${dto.getMem_pw() }"  style = "width:50%; font-size:12pt;"></div>
					<div class = "join_row" style = "margin-bottom: 5px;"><span class = "upSpan">비밀번호 재확인: </span><input type = "password" class = "int" id = "upPw2" style = "width:50%; font-size:12pt;"><input type = "button" class = "accountBtn" value = "확인" onclick = "pw_chk()" ></div>
				</div>
				<div class = "rowGroup" style = "border-bottom: none;">
					<div class = "join_row" style = "margin-bottom: 5px;"><span class = "upSpan">이름: </span><input type = "text" class = "int" id = "upName" name = "mem_name" value = "${dto.getMem_name() }" style = "width:80%; font-size:12pt;"></div>
					<div class = "join_row" style = "margin-bottom: 5px;"><span class = "upSpan">이메일: </span><input type = "text" class = "int" id = "upEmail" name = "mem_email" value = "${dto.getMem_email() }" style = "width:80%; font-size:12pt;"></div>
					<div class = "join_row" style = "margin-bottom: 5px;"><span class = "upSpan">연락처: </span><input type = "text" class = "int" id = "upPhone" name = "mem_phone" value = "${dto.getMem_phone() }" style = "width:80%; font-size:12pt;"></div>
				</div>
		
				<div class = "enter">
					<input type = "submit" class = "accountBtn" id = "modifyInfo" value = "수정" style = "width: 450px; height: 40px; font-size:14pt; border-radius: 4px; background-color: #5cb85c; color: #fff;">
				</div>
			</form>
			<form class = "leaveBox" action="./leaveService.do" method="post">
				<div class = "rowGroup" style = "margin-top: 15%; padding: 20px;">
					<div style = "overflow: hidden">
						<img alt="본인인증안내" src="images/exclamation.png" style = "width: 30px; height: 30px;">
						<p style = "font-size: 10pt; display: inline-block;">탈퇴하기 전에 그룹관리자, 프로젝트관리자 권한을 위임해야 합니다.</p>
					</div>
					<input type = "button" class = "leaveBtn" value = "프로젝트관리자 위임하기" style = "margin-right : 5px;" onclick = "goListPm()">
					<input type = "button" class = "leaveBtn" value = "그룹관리자 위임하기" onclick = "goListGm()">
				</div>
				<div class = "enter">
					<input type = "submit" class = "accountBtn" id = "leaveService" value = "탈퇴하기" style = "width: 450px; height: 40px; margin-top:10%; font-size:14pt; border-radius: 4px; background-color: #5cb85c; color: #fff;">
				</div>
			</form>
		</div>
	</div>
	
	<div id = "footer">
		<jsp:include page="../footer.jsp" flush="false"/>
	</div>
	
</body>
</html>