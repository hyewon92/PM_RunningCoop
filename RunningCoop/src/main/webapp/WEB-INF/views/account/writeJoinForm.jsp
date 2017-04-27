<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입</title>
<style type="text/css">
	#resultIdChk{
	font-size: 7pt;
	color: red;
	}

	.ui-autocomplete {
    max-height: 100px;
    overflow-y: auto;
    overflow-x: hidden;
  }
  
  * html .ui-autocomplete {
    height: 100px;
  }
  
  #chkInfo{
  	display: none;
  }
  
</style>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"> -->
<!-- </script> -->
<script type="text/javascript">
	
	var interval;
	var checked = [false, false, false, false, false];
	
	//아이디 제약조건, 중복 확인
	function id_chk(){
		checked[0] = true;
		var mem_id = $("#id").val();
		var standardId = /^[a-z0-9]{8,12}$/g;
		if(!standardId.test(mem_id)){
			alert("아이디는 영소문자, 숫자를 포함하여 8~12자로 작성해야 합니다.");
			$("#id").val("");
			checked[0] = false;
		}else{
			$.ajax({
				type: "GET",
				url: "./memIdSelect.do",
				data: "mem_id="+mem_id,
				async: false,
				success: function(msg){
					printIdCk(msg)
				},
				error: function(){
					checked[0] = false;
					alert("아이디 중복 조회 전송 실패, 다시 해주세요");
				}
			});
		}
	}
	
	//아이디 중복확인 결과
	function printIdCk(map){
		if(map.result){
			$("#resultIdChk").text("사용 가능한 아이디입니다");
			checked = true;
		}else{
			$("#resultIdChk").text("중복된 아이디입니다. 다시 입력해주세요");
			checked = false;
		}
	}
	
	//비밀번호 제약조건, 재확인
	function pw_chk(){
		checked[1] = true;
		var standardPw = /^((?=.*\d)(?=.*[a-z]).{8,15})$/gm;

		if(!standardPw.test($("#pw").val())){
			checked[1] = false;
			alert("비밀번호는 영소문자, 숫자를 포함하여 8~16자로 작성해야 합니다.");
			$("#pw").val("");
			$("#pw2").val("");
		}else{
			if($("#pw").val()!=$("#pw2").val()){
				checked[1] = false;
				$("#modifyInfo").prop("disabled", true);
				alert("비밀번호가 일치하지 않습니다.\n 재입력해주세요.");
				$("#pw").val("");
				$("#pw").val("");
			}else{
				alert("비밀번호가 확인됐습니다.");
			}
		}
	}
	
	//이름 제약조건 확인
	function name_chk(){
		checked[2] = true;
		var standardName = /^[a-z0-9ㄱ-ㅎㅏ-ㅣ가-힣]{1,10}$/g;
		if(!standardName.test($("#name").val())){
			checked[2] = false;
			alert("이름은 대소문자를 구분한 영문, 한글, 숫자를 포함한 10자 이내로 작성해야 합니다.");
			$("#name").val("");
		}else{
			alert("사용가능합니다");
		}
	}
	
	//인증번호 메일 전송
	function sendMail(){
		checked[3] = true;
		var mem_name = $("#name").val();
		var toMail = $("#email").val();
		if(mem_name == null || toMail == null){
			alert("이름과 이메일을 모두 입력해주세요.");
		}else{
			$.ajax({
				type: "POST",
				url: "./joinMailSending.do",
				data: "mem_name="+mem_name+"&toMail="+toMail,
				async: false,
				success: function(){
					alert("해당 메일계정으로 인증번호를 전송했습니다.");
				},
				error: function(){
					checked[3] = false;
					alert("인증번호 전송 실패, 다시 시도해주세요.");
				}
			});
			$("#chkInfo").css("display","block");
			timeCount(240, sEvent, eEvent);
		}
	}
	
	//인증번호 입력 시간 카운트
	function timeCount(time, sEvent, eEvent){

		//카운트 시간 설정
		var setTime = time;
				
		//1초마다 실행
		interval = setInterval(function(){
			timer();
			}, 1000);
				
		function timer(){
			setTime = setTime-1;
			var minute = Math.floor(setTime/60);
			var second = Math.round(setTime%60);
				
			sEvent(minute, second);
				
			if(setTime==0){	//시간 내에 입력 안했을 때
				clearInterval(interval);
				eEvent();
				$.ajax({
					type: "POST",
					url: "./removeIdentify.do",
					async: false
				});
			}
		}
	}
	
	//카운트 동작 이벤트
	function sEvent(minute, second){
		$("#minute").text(minute);
		$("#second").text(second);
	}
	
	//카운트 종료 시 이벤트
	function eEvent(){
		alert("시간이 종료됐습니다. 다시 시도해주세요.");
	}
	
	//입력 후 시간 카운트 정지+세션(인증번호)삭제
	function endIdentify(){
		clearInterval(interval);
		$.ajax({
			type: "POST",
			url: "./removeIdentify.do",
			async: false
		});
	}
	
	//인증번호 입력확인
	function identifyNum(){
		var val = $("#num").val();
		$.ajax({
			type: "POST",
			url: "./ckIdentifyNum.do",
			data: "input="+val,
			async: false,
			success: function(msg){
				endIdentify();
				resultIdentify(msg)
			}
		});
	}
	
	//인증번호 입력 결과
	function resultIdentify(map){
		if(map.result){
			checked[4] = true;
			alert("인증이 완료됐습니다.");
		}else{
			checked[4] = false;
			alert("인증이 실패했습니다. 다시 해주세요.");
			$("#num").val("");
		}
	}
	
	//최종입력 제약조건
	$(function(){
			$(".joinBox").submit(function(event){
				//연락처 유효성 검사
				var phone1 = $("#phone1").val();
				var phone2 = $("#phone2").val();
				var phone3 = $("#phone3").val();
				alert(phone1);
				var standardPhone = /\d{3,4}$/;
				if(!standardPhone.test(phone1)||!standardPhone.test(phone2)||!standardPhone.test(phone3)){
					alert("숫자형식으로 3~4자씩 입력해주세요");
					return false;
				}
				else{
					$("#phone").val(phone1+phone2+phone3);
					alert($("#phone").val());
				
 					//공백 확인
					if($("#id").val()==""||$("#pw").val()==""||$("#pw2").val()==""||$("#mem_name")==""||$("mem_email")==""||$("#num")==""||$("#mem_phone")==""){
						alert("모두 입력해주세요.");
						return false;
					}
					//버튼 조회 확인
					for(var i = 0; i <checked.length; i++){
						if(!checked[i]){
							alert("모두 확인 조회를 해주세요.");
							return false;
							break;
						}
					} 
			}
		});
	});
	
</script>
</head>
<body>

	<form class = "joinBox" action="./chkJoin.do" method="post">
		<fieldset>
			<legend>필수정보</legend>
			<div class = "essentialPart">
 				(*)아이디: <input type = "text" id = "id" name = "mem_id" title = "영소문자, 숫자 포함 8~12자">
				<input type = "button" id = "idChk" value = "중복확인" onclick = "id_chk()">
				<span id = "resultIdChk"></span>
				<br>
				(*)패스워드: <input type = "password" id = "pw" name = "mem_pw" title = "영소문자, 숫자 포함 8~16자"><br>
				(*)패스워드 재확인: <input type = "password" id = "pw2"><input type = "button" value = "확인" onclick = "pw_chk()"><br>
				(*)이름: <input type = "text" id = "name" name = "mem_name" title = "대소문자를 구분한 영문, 한글, 숫자포함 10자 이내">
						<input type = "button" onclick = "name_chk()" value = "확인">
				<br>
				(*)이메일: <input type = "text" id = "email" name = "mem_email" size="30px">
						 <input type = "button" value = "인증메일 전송" onclick = "sendMail()"><br>
				<div id = "chkInfo">
					<%String num = (String)session.getAttribute("identifyNum"); %>
					인증번호 입력: <input type = "text" id = "num">
					<input type = "button" id = "btnIdentify" value = "확인" onclick = "identifyNum()">
					<span id = "minute"></span>분
					<span id = "second"></span>초 
				</div> 
				(*)연락처: 
				<input type = "text" id = "phone1"> -
				<input type = "text" id = "phone2"> -
				<input type = "text" id = "phone3">
				<input type = "hidden" id = "phone" name = "mem_phone"><br>
			</div>
		</fieldset>
		<div class = "enter">
			<input type = "submit" id = "join" value = "가입" >
		</div>
	</form>
</body>
</html>