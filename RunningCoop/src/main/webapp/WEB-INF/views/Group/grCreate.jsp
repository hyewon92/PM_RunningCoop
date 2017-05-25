<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/main.css" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>

<% String mem_id = (String)session.getAttribute("mem_id"); %>
<script type="text/javascript">
	$(function(){
		var resutl = "${result}";
		if(resutl=="true"){
			alert("그룹가입신청 완료");
			close();
			}
		$(".createBox").submit(function(event){
			var chk = $("#chk").attr('name');
			if($("#grname").val()==""||$("#grgoal").val()==""||chk=="nochk"){
				alert("모두 입력해주세요");
				return false;
			}else{
				return true;
			}
		});
		$("#imgname").val("1");
		for(var i =1; i<15; i++){
			var imgNum = "이미지" + i;
			$('#imsg').append($('<option>').attr('value',imgNum).text(imgNum));
		};
		
		$('#imsg').change(function(){
			
			var imgln = $(this).val().length;
			var GroupImgs = $(this).val().substring(3, imgln );
			$("#imgname").val(GroupImgs);
			
			$("#imgbox").attr("src","./grImgs/img"+GroupImgs+".png");
		})
	});
	
	function closee(){
		close();
	}
	function grNameCheck(){
		var chgrName = $("#grname").val();
		$.ajax({
			type : "POST",
			url  : "./grNameCk.do",
			data : "gr_name="+chgrName,
			async: false,
			success : function(data){
				if(data==1){
					$("#chkReturn").text("이미 사용중인 이름입니다.");
					$("#chkReturn2").css('display','');
					$("#grname").val("");
				}else{
					$("#chkReturn").text("해당 이름으로 사용하셔도 됩니다.");
					$("#chkReturn2").css('display','');
					$("#chk").attr('name','yeschk');
				}
			}
		});
		return data;
	}
	
</script>
</head>
<body>
	<form class="createBox" action="./groupCreate.do" method="post">
	<table>
	<tr>
	<td>그룹이름:</td>
	<td><input type="text"  name="gr_name" id="grname"></td>
	<td><input type="button" value="중복확인" onclick="grNameCheck()" id="chk" name="nochk"></td>
	</tr>
	<tr style="display: none;" id="chkReturn2"><td></td><td  id="chkReturn"></td></tr>
	<tr>
	<td>그룹담당자아이디:</td>
	<td><input type="text" name="mem_id" value="<%=mem_id%>" readonly="readonly"></td>
	</tr>
	<tr>
	<td>그룹이미지</td>
	<td><select id="imsg"></select>
	<input type="hidden" id="imgname" value="" name="gr_img"></td>
	<td><img id="imgbox" alt="" src="./grImgs/img1.png"></td>
	</tr>
	<tr>
	<td>그룹검색거부</td>
	<td>허용<input type="radio" name="gr_searchyn" checked="checked" value="Y"> 거부<input type="radio" name="gr_searchyn" value="N"></td>
	</tr>
	<tr>
	<td>그룹가입신청거부</td>
	<td>허용<input type="radio" name="gr_joinyn" checked="checked" value="Y"> 거부<input type="radio" name="gr_joinyn" value="N"></td>
	</tr>
	<tr>
	<td>그룹목적</td>
	<td><textarea rows="15" cols="27" name="gr_goal" id="grgoal"></textarea></td>
	</tr>
	<tr>
	<td><input type="submit" value="그룹생성"></td>
	<td><input type="button" onclick="closee()" value="취소"></td>
	</tr>
	</table>
	</form>
</body>
</html>
