<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js">
</script>
<script type="text/javascript">
	function id_chk(){
		var mem_id = $("#id").val();
		window.open("./memIdSelect.do?mem_id="+mem_id, "아이디중복확인", "width=300, height=250, left=400");
	}
	
	function pw_chk(){
		if($("#pw").val()!=$("#pw2").val()){
			$("#modifyInfo").prop("disabled", true);
			alert("비밀번호가 일치하지 않습니다.\n 재입력해주세요");
			$("#pw").val("");
			$("#pw").val("");
		}else{
			alert("비밀번호가 확인됐습니다.");
		}
	}
	
	$(function(){
		$(".accountBox").submit(function(event){
			if($("#id").val()==""||$("#pw").val()==""||$("#pw2").val()==""||$("#mem_name")==""||$("mem_email")==""||$("#mem_phone")==""){
				alert("모두 입력해주세요");
				return false;
			}
		});
	});
</script>
</head>
<body>

	<form class = "joinBox" action="./chkJoin.do" method="post">
		<div class = "essentialPart">
			(*)아이디: <input type = "text" id = "id" name = "mem_id">
			<input type = "button" id = "idChk" value = "중복확인" onclick = "id_chk()"><br>
			(*)패스워드: <input type = "password" id = "pw" name = "mem_pw"><br>
			(*)패스워드 재확인: <input type = "password" id = "pw2"><input type = "button" value = "확인" onclick = "pw_chk()"><br>
			(*)이름: <input type = "text" id = "name" name = "mem_name"><br>
			(*)연락처: <input type = "text" id = "phone" name = "mem_phone"><br>
			(*)이메일: <input type = "text" id = "email" name = "mem_email"><br>
		</div>
		<div class = "selectivePart">
			그룹: <input type = "text" id = "gr_id" name = "gr_id"> 
		</div>
		<div class = "enter">
			<input type = "submit" id = "join" value = "가입" >
		</div>
	</form>
</body>
</html>