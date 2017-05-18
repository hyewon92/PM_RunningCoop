<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로젝트관리툴:Running Coop!</title>
<link rel="stylesheet" href="css/main.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);

	body{
		font-family: "Arial";
		font-family: 'Nanum Gothic', sans-serif;
		font-weight: bold;
	}
	.mainHeader{
		width: 100%;
		height: 15%;
		text-align: center;
		margin-top: 80px;
	}
	
	.mainContain{
		width: 100%;
		text-align: center;
	}
	
	.accountBox{
		width: 350px;
		height: 240px;
		border: 0.5px solid #B4B4B4; 
		margin: auto;
		padding: 20px;
	}
	
	.login{
		height: 130px;
	}
	
	.enter{
		height: 50px;
	}
	
/* 	.idPart, .pwPart{
		height: 50px;
		margin: auto;
	}
	
	.idPart span, .pwPart span{
		float: left;
		padding: 10px;
	} */
	
	.id, .pw{
		width: 300px;
		height: 40px;
		background: #EAEAEA;
		border: 2px solid transparent;
		transition: border .5s;
		border-radius: 4px;
		text-align: center;
		font-size: 14pt;
		font-weight: bolder;
		color: gray;
	}
	
	.id{
		margin-top: 8pt;
		margin-bottom: 4pt;
	}
	
	.pw{
		margin-top: 4pt;
	}
	
/* 	.pw{
		margin: 5px;
		width: 250px;
		height: 40px;
		background: #EAEAEA;
		border: 2px solid transparent;
		transition: border .5s;
		float: right;
	} */
	
	.id:focus, .pw:focus {
		border: 2px solid #69B55B;
		box-shadow: none;
	}
	
	.loginBtn{
		width: 300px;
		height: 40px;
   		padding: 2px 12px;
		margin: auto;
		color: #fff;
	    font-size: 14px;
	    background-color: #5cb85c;
	    border-color: #4cae4c;
	    border: 1px solid transparent;
   		border-radius: 4px;
   		cursor: pointer;
	}
	
	.searchAccount{
		display: none;
		background: white;
	}
	
	.joinAccount{
		display: none;
		background: white;
	}
	
	
	
</style>
<script type="text/javascript">
/* 	function goLogin(){
		if($("#id").val()==""||$("#pw").val()==""){
			alert("아이디, 비밀번호 모두 입력해주세요");
		}else{
			$(".loginBox").submit();
		}
	} */
	
	
	function joinAccount(){
		/* location.href = "./searchAccount.do"; */
		$(".joinAccount").css("display","block");
		$(".joinAccount").dialog({
			title : "회원가입",
			height : 250,
			width : 500,
			position : {my : "center", at : "center"},
			resizable : false,
			modal : true
		});
	}

	function goJoin(){
		location.href = "./goJoin.do";
	}
	
	
	/**
	회원가입
	*/
	
	function backToMain(){
		location.href = "./main.do";
	}
	
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

	<div class = "mainHeader">
		<img alt = "로고" src = "images/header/logo.png">
	</div>
	
	<div class = "mainContain">
		<div class = "accountBox">
		<form class = "LoginBox" action="./ckLogin.do" method="post">
			<div class = "login">
				<div class = "idPart">
					<input type = "text" class = "id" id = "id" name = "mem_id" placeholder = "아이디" value = "">
				</div>
				<div class = "pwPart">
					<input type = "password" class = "pw" id = "pw" name = "mem_pw" placeholder = "비밀번호" value = "" onKeypress="if(event.keyCode==13) $('.loginBtn').click();">
				</div>
			</div>
			<div class = "enter">
				<input type = "submit" class = "loginBtn" id = "loginBtn" value = "로그인">
			</div>
		</form>
		<span style = "font-size: 8pt; color: black; text-decoration: underline;" onclick = "searchAccount()">아이디/비밀번호찾기</span>
		<span style = "font-size: 8pt; color: black; text-decoration: underline;" onclick = "joinAccount()">회원가입</span>
		</div>
		
		<div>
			<input type="button" value="관리자 로그인" onclick="location.href='./systemManagerLogin.do'"/>
		</div>
		
		<!-- 회원가입 -->
		<div class = "modal">
			<div class = "modal_content">
				<div class = "modal_header">
					<h2 style="display:inline;">회원가입</h2>
					<img alt="닫기" src="images/project/wd_close_btn.png" onclick="backToMain()"/>
				</div>
				<div class = "modal_body">
				
				</div>
			</div>
		</div>
		<div class = "joinAccount">
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
		</div>
		
	</div>
	
</body>
</html>