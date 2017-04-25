<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입</title>
<style type="text/css">
	.ui-autocomplete {
    max-height: 100px;
    overflow-y: auto;
    overflow-x: hidden;
  }
  * html .ui-autocomplete {
    height: 100px;
  }
</style>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"> -->
<!-- </script> -->
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
	
	function openChild(){
		window.open("./showGrCreate.do", "GroupCreate", "width=640, height=450, resizable = no, scrollbars = no");
	}
	
	 $(function(){
         $("#gr_name").autocomplete({
            source: function(request , response){
               $.ajax({
                  type:"POST",
                  url: "./autoauto.do",
                  dataType : "json",
                  async : false,
                  data:{ value : request.term},
                  success: function(data) {
                      response(
                                     $.map(data, function(item) {
                                         return {
                                             label: item.gr_name,
                                             value: item.gr_name
                                         }
                                     })
                                 );
                  }
               });
            },
            minLength : 1,
            select : function ( event , ui){
            $("#gr_name").val(ui.item.label);
            }
         });
   });
	
	function searchGrName(){
		var gr_name = $("#gr_name").val();
		window.open("./allGrSelect.do?gr_name="+gr_name, "그룹검색", "width=780, height=550, resizable = no, scrollbars = yes");
	}
	
</script>
</head>
<body>

	<form class = "joinBox" action="./chkJoin.do" method="post">
		<fieldset>
			<legend>필수정보</legend>
			<div class = "essentialPart">
				(*)아이디: <input type = "text" id = "id" name = "mem_id">
				<input type = "button" id = "idChk" value = "중복확인" onclick = "id_chk()"><br>
				(*)패스워드: <input type = "password" id = "pw" name = "mem_pw"><br>
				(*)패스워드 재확인: <input type = "password" id = "pw2"><input type = "button" value = "확인" onclick = "pw_chk()"><br>
				(*)이름: <input type = "text" id = "name" name = "mem_name"><br>
				(*)연락처: <input type = "text" id = "phone" name = "mem_phone"><br>
				(*)이메일: <input type = "text" id = "email" name = "mem_email"><br>
			</div>
		</fieldset>
		<fieldset>
			<legend>선택정보</legend>
			<div class="ui-widget">
				<input type = "text" name = "gr_name" id = "gr_name" placeholder = "그룹명으로 검색"/>
				<input type = "button" value = "그룹검색" onclick = "searchGrName()"/>
			</div>
		</fieldset>
		<div class = "enter">
			<input type = "submit" id = "join" value = "가입" >
		</div>
	</form>
</body>
</html>