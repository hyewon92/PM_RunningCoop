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
	
	.id:focus, .pw:focus {
		border: 2px solid #69B55B;
		box-shadow: none;
	}
	
	.accountBtn{
		width: 80px;
		height: 20px;
   		padding: 2px;
		margin: auto;
		color: #9E9E9E;
	    font-size: 12px;
	    background-color: white;
	    border: 0.5px solid #9E9E9E;
	    text-align: center;
   		cursor: pointer;
	}
	
	.searchAccount{
		display: none;
		background: white;
	}
	
	.join_modal{
		display: none; /* Hidden by default */
	    position: fixed; /* Stay in place */
	    z-index: 1; /* Sit on top */
	    left: 0;
	    top: 0;
	    width: 100%; /* Full width */
	    height: 100%; /* Full height */
	    overflow: auto; /* Enable scroll if needed */
	    background-color: rgb(0,0,0); /* Fallback color */
	    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
	}
 	
	.joinModal_content{
		position: relative;
	    top: 5%;
	    background-color: #f5f6f7;
	    margin: auto;
	    padding: 0;
	    border: 1px solid #888;
	    width: 40%;
	    min-width: 350px;
	    height: 500px;
	    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
	    -webkit-animation-name: animatetop;
	    -webkit-animation-duration: 0.4s;
	    animation-name: animatetop;
	    animation-duration: 0.4s
	}
	
	.joinModal_header{
		text-align: center;
		padding: 7px;
	    background-color: #5cb85c;
	    color: white;
	}
	
	.joinModal_header img {
		width: 25px;
		height: 25px;
		float: right;
	}
	
	.joinModal_body{
		height: 90%;
	    margin: auto;
	    padding: 20px;
	}
	
	.joinField{
		border: 0;
	}
	
	.rowGroup{
		zoom: 1;
	    margin-bottom: 10px;
	    border: solid 1px #dadada;
	    background: #fff;
	}
	
	.join_row:FIRST-CHILD{
		border-top: none;
	}
	
	.join_row{
		box-sizing: border-box;
	    padding: 11px 11px 11px 13px;
	    background: #fff;	
	    border-bottom: solid 1px #dadada;
	}
	
	.join_row:eq(last){
		border-bottom: none;
	}
		
	.ps_box .int_id{
		background-position: 100% -57px;
	}
	
	.int_id{
		overflow: auto;
	}
	
	.ps_box{
		position: relative;
	    display: block;
	    height: 27px;
	    background: #fff;
	}
	
	.join_row .int{
		font-size: 12px;
	    position: relative;
	    z-index: 10;
	    height: 17px;
	    padding: 6px 0;
	    border: none;
	    background: #fff;
	}
	
	.join_row .int{
		width: 100%;
	}
	
	.int:focus{
		outline: none;
	}
</style>
<script type="text/javascript">

	var joinStatus = 0;

	$(function(){
		$(".loginBox").submit(function(){
			if($("#loginId").val()==""||$("#loginPw").val()==""){
				alert("아이디와 비밀번호 모두 입력해주세요");
				return false;
			}
		});
	});
	
	
	function joinAccount(){
		$(".join_modal").css("display", "block");
		joinStatus = 1;
	}
	
	function closeJoin(){
		$(".join_modal").css("display", "none");
		joinStatus = 0;
	}

	function goJoin(){
		location.href = "./goJoin.do";
	}
	
	
	/**
	회원가입
	*/
	
	var interval;
	var checked = [false, false, false, false, false];
	
	//아이디 제약조건, 중복 확인
	function id_chk(){
		if(joinStatus == 1){
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
	}
	
	//아이디 중복확인 결과
	function printIdCk(map){
		if(joinStatus == 1){
			if(map.result){
				$("#resultIdChk").html("사용 가능한 아이디입니다").css("font-size","7pt");
				checked = true;
			}else{
				$("#resultIdChk").html("중복된 아이디입니다.<br>다시 입력해주세요").css("font-size","7pt");
				checked = false;
			}
		}
	}
	
	//비밀번호 제약조건, 재확인
	function pw_chk(){
		if(joinStatus == 1){
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
	}
	
	//이름 제약조건 확인
	function name_chk(){
		if(joinStatus == 1){
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
	}
	
	//인증번호 메일 전송
	function sendMail(){
		if(joinStatus == 1){
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
				$(".timeWord").css("display","block");
				timeCount(240, sEvent, eEvent);
			}
		}
	}
	
	//인증번호 입력 시간 카운트
	function timeCount(time, sEvent, eEvent){
		if(joinStatus == 1){
			//카운트 시간 설정
			var setTime = time;
					
			//1초마다 실행
			interval = setInterval(function(){
				timer();
				}, 1000);
		}
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
		$("#minute").text(minute+"분");
		$("#second").text(second+"초");
	}
	
	//카운트 종료 시 이벤트
	function eEvent(){
		alert("시간이 종료됐습니다. 다시 시도해주세요.");
	}
	
	//입력 후 시간 카운트 정지+세션(인증번호)삭제
	function endIdentify(){
		if(joinStatus == 1){
			clearInterval(interval);
			$.ajax({
				type: "POST",
				url: "./removeIdentify.do",
				async: false
			});
		}
	}
	
	//인증번호 입력확인
	function identifyNum(){
		var val = $("#num").val();
		if(joinStatus == 1){
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
	}
	
	//인증번호 입력 결과
	function resultIdentify(map){
		if(joinStatus == 1){
			if(map.result){
				checked[4] = true;
				alert("인증이 완료됐습니다.");
			}else{
				checked[4] = false;
				alert("인증이 실패했습니다. 다시 해주세요.");
				$("#num").val("");
			}
		}
	}
	
	//최종입력 제약조건
	$(function(){
			$(".joinBox").submit(function(event){
				//연락처 유효성 검사
				var phone1 = $("#phone1").val();
				var phone2 = $("#phone2").val();
				var phone3 = $("#phone3").val();
				var standardPhone = /\d{3,4}$/;
				if(!standardPhone.test(phone1)||!standardPhone.test(phone2)||!standardPhone.test(phone3)){
					alert("숫자형식으로 3~4자씩 입력해주세요");
					return false;
				}
				else{
					$("#phone").val(phone1+phone2+phone3);
				
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
	
	<!-- 관리자 로그인 -->
	<div>
		<input type="button" class = "accountBtn" value="관리자 로그인" style = "position: absolute; right: 10px; top: 10px;" onclick="location.href='./systemManagerLogin.do'"/>
	</div>	
	
	<!-- 로고 -->
	<div class = "mainHeader">
		<img alt = "로고" src = "images/header/logo.png">
	</div>
	
	<!-- 게정 관리 부분 -->
	<div class = "mainContain">
		<!-- 로그인 -->
		<div class = "accountBox">
		<form class = "LoginBox" action="./ckLogin.do" method="post">
			<div class = "login">
				<div class = "idPart">
					<input type = "text" class = "id" id = "loginId" name = "mem_id" placeholder = "아이디" value = "">
				</div>
				<div class = "pwPart">
					<input type = "password" class = "pw" id = "loginPw" name = "mem_pw" placeholder = "비밀번호" value = "" onKeypress="if(event.keyCode==13) $('.accountBtn').click();">
				</div>
			</div>
			<div class = "enter">
				<input type = "submit" class = "accountBtn" id = "loginBtn" value = "로그인" style = "width: 300px; height: 40px; font-size:14pt; border-radius: 4px; background-color: #5cb85c; color: #fff;">
			</div>
		</form>
		<span style = "font-size: 8pt; color: black; text-decoration: underline;" onclick = "searchAccount()">아이디/비밀번호찾기</span>
		<span style = "font-size: 8pt; color: black; text-decoration: underline;" onclick = "joinAccount()">회원가입</span>
		</div>
		
		<!-- 회원가입 -->
		<div class = "join_modal">
			<div class = "joinModal_content">
				<div class = "joinModal_header">
					<p style="font-size:20px; display:inline;">회원가입</p>
					<img alt="닫기" src="images/project/wd_close_btn.png" onclick="closeJoin()"/>
				</div>
				<div class = "joinModal_body">
					<div class = "joinAccount">
						<form class = "joinBox" action="./chkJoin.do" method="post">
							<fieldset class = "joinField">
								<legend></legend>
								<div class = "rowGroup">
					 				<div class = "join_row">
					 					<span class = "ps_box int_id">
					 						<input type = "text" class = "int" id = "id" name = "mem_id" placeholder = "아이디(영소문자, 숫자 포함 8~12자)" style = "width: 50%; float:left;";> 
					 						<input type = "button" class = "accountBtn" id = "idChk" value = "중복확인" onclick = "id_chk()" style = "float:right; margin-right:5px;">
											<span id = "resultIdChk"></span>
					 					</span>
					 				</div>
					 				<div class = "join_row">
					 					<span class = "ps_box int_id">
					 						<input type = "password" class = "int" id = "pw" name = "mem_pw" placeholder = "비밀번호">
					 					</span>
					 				</div>
					 				<div class = "join_row">
					 					<span class = "ps_box int_id">
					 						<input type = "password" class = "int" id = "pw2" placeholder = "비밀번호 재확인"  style = "width: 70%; float: left;">
					 						<input type = "button" class = "accountBtn" value = "확인" onclick = "pw_chk()" style = "float:right; margin-right:5px;">
					 					</span>
					 				</div>
					 				<div class = "join_row">
					 					<span class = "ps_box int_id">
					 						<input type = "text" class = "int" id = "name" name = "mem_name" placeholder = "이름(대소문자를 구분한 영문, 한글, 숫자포함 10자 이내)" style = "width: 70%; float: left;">
					 						<input type = "button" class = "accountBtn" onclick = "name_chk()" value = "확인" style = "float:right; margin-right:5px;">
					 					</span>
					 				</div>
								</div>
								<div class = "rowGroup">
									<div class = "join_row">
										<span class = "ps_box int_id">
											 <input type = "text" class = "int" id = "email" name = "mem_email" placeholder = "이메일" style = "width: 75%; float: left;">
											 <input type = "button" class = "accountBtn" onclick = "sendMail()" value = "인증메일 전송" style = "float:right; margin-right:5px;">
										</span>
									</div>
									<div class = "join_row">
										<span class = "ps_box int_id">
											<div id = "chkInfo" style = "overflow: auto;">
												<%String num = (String)session.getAttribute("identifyNum"); %>
												<input type = "text" class= "int" id = "num" placeholder = "인증번호입력" style = "width: 60%; float: left;">
												<div class = "timeCut" style = "float: left; overflow: auto;">
													<span id = "minute" style = "font-size:9pt;"></span>
													<span id = "second" style = "font-size:9pt;"></span>
												</div>
												<input type = "button" class = "accountBtn" id = "btnIdentify" value = "확인" onclick = "identifyNum()" style = "float:right; margin-right:5px;">
											</div> 
										</span>
									</div>
									<div class = "join_row">
										<span class = "ps_box int_id" style = "overflow : auto;">
											<input type = "text" class = "int" id = "phone1" placeholder = "연락처(ex.010)" style = "width: 30%; float: left; text-align: center;"><span style = "font-size:14pt; float: left; padding: 0px 5px 0px 5px;">-</span>
											<input type = "text" class = "int" id = "phone2" placeholder = "연락처(ex.1234)" style = "width: 30%; float: left; text-align: center;"><span style = "font-size:14pt; float: left; padding: 0px 5px 0px 5px;">-</span>
											<input type = "text" class = "int" id = "phone3" placeholder = "연락처(ex.1234)" style = "width: 30%; float: left; text-align: center;">
											<input type = "hidden" id = "phone" name = "mem_phone"><br>
										</span>
									</div>
								</div>
							</fieldset>
							<div class = "enter">
								<input type = "submit" class = "accountBtn" id = "join" value = "가입" style = "width: 440px; height: 40px; padding-top: 5px; padding-bottom: 5px;">
							</div>
						</form>
					</div>						
				</div>
			</div>
		</div>
		<!-- 회원가입 끝 -->
	</div>
	
</body>
</html>