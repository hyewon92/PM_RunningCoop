<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개인정보 수정</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
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
			if($("#pw").val()==""||$("#pw2").val()==""||$("#mem_name")==""||$("mem_email")==""||$("#mem_phone")==""){
				alert("모두 입력해주세요");
				return false;
			}
		});
	});
</script>
</head>
<body>

	<form class = "accountBox" action="./memInfoModify.do" method="post">
		<div class = "essentialPart">
			아이디: <input type = "text" id = "id" name = "mem_id" value = "${dto.getMem_id()}" readonly="readonly"><br>
			패스워드: <input type = "password" id = "pw" name = "mem_pw" value = "${dto.getMem_pw() }"><br>
			패스워드 재확인: <input type = "password" id = "pw2"><input type = "button" value = "확인" onclick = "pw_chk()"><br>
			이름: <input type = "text" id = "name" name = "mem_name" value = "${dto.getMem_name() }"><br>
			이메일: <input type = "text" id = "email" name = "mem_email" value = "${dto.getMem_email() }"><br>
			연락처: <input type = "text" id = "phone" name = "mem_phone" value = "${dto.getMem_phone() }"><br>
		</div>

		<div class = "enter">
			<input type = "submit" id = "modifyInfo" value = "수정">
		</div>
	</form>

</body>
</html>