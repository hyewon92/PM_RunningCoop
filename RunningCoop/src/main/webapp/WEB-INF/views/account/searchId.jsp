<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디찾기</title>
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/body/user_account.css">
<style type="text/css">

</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	$(function(){
		$(".searchIdBox").submit(function(){
			alert("ㅇㅇㅇㅇ");
/*			if($("#searchName").val()==""||$("#searchEmail").val()==""){
				alert("이름과 이메일 모두 입력해주세요.");
				return false;
			}
			else{
				location.href = "./main.do";
				$(".join_modal").css("display", "block");
  				var searchForm = $(".searchIdBox").serialize();
				$.ajax({
					type : "POST",
					url : "./searchId.do",
					data: searchForm,
					async: false,
					success: function(result){
						alert(result.resultId);
  						if(result.resultId== "null" || result.resultId==""){
							$("#resultPart").val("조회된 결과가 없습니다");
						}else{
							$("#result").val(result.resultId); 
						}
					} 
				});  
			}*/
		});
	});
	
/* 	function closeSearchForm(){
		$(".search_modal").css("display", none);
	} */
</script>
</head>
<body>
	<!-- 로고 -->
	<div class = "mainHeader">
		<img alt = "로고" src = "images/header/logo.png">
	</div>
	
	<!-- 게정 관리 부분 -->
 	<div class = "mainContain">
		아이디 찾기
		<div class = "accountBox">
		<form class = "searchIdBox">
			<fieldset class = "joinField">
				<div class = "rowGroup">
					<div class = "join_row">
						<span class = "ps_box int_id">
							<input type = "text" class = "int" id = "searchName" name = "mem_name" placeholder = "이름" style = "width:100%;">
						</span>
					</div>
					<div class = "join_row">
						<span class = "ps_box int_id">
							<input type = "text" class = "int" id = "searchEmail" name = "mem_email" placeholder = "이메일" value = "" onKeypress="if(event.keyCode==13) $('.searchIdBox').submit();">
						</span>
					</div>
				</div>
				<span style = "font-size: 8pt;">회원정보에 등록한 이름과 이메일 계정이 입력한 이름, 이메일 계정과 같아야, 아이디를 조회할 수 있습니다.</span>
			</fieldset>
			<div class = "enter">
				<input type = "submit" class = "accountBtn" id = "searchIdBtn" value = "아이디찾기" style = "width: 300px; height: 40px; font-size:14pt; border-radius: 4px; background-color: #5cb85c; color: #fff;">
			</div>
		</form>
		<span style = "font-size: 10pt; color: black; text-decoration: underline;" onclick = "location.href='./searchPw.do'">비밀번호찾기</span>
		</div> 
		<!-- 아이디 찾기 끝 -->
		
		<!-- 아이디 결과 -->
  		<div class = "join_modal">
			<div class = "joinModal_content">
				<div class = "joinModal_header">
					<p style="font-size:20px; display:inline;">아이디 조회 결과</p>
				</div>
				<div class = "joinModal_body">
					<h3 id = "resultPart">회원님의 아이디는 <span id="result"></span>입니다.</h3>
					<input type = "button" value = "로그인하기" onclick = "closeSearchForm();">
					<input type = "button" value = "비밀번호찾기" onclick = "location.href='./searchPw.do'">
				</div>
			</div>
		</div> 
	</div>
</body>
</html>