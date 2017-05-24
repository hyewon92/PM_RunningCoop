<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >
<html>
<head>
<%String gr_id = (String)session.getAttribute("gr_id");%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="css/main.css" type="text/css"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>

<% String mem_id = (String)session.getAttribute("mem_id"); %>
<script type="text/javascript">
// 그룹 정보 관리
function view_info_manage(){
	$(".info_manage").css("display", "block");
	$(".mem_manage").css("display", "none");
	$(".calendar_manage").css("display", "none");
	loadPage();
}

// 그룹 멤버 관리
function view_mem_manage(){
	$(".info_manage").css("display", "none");
	$(".calendar_manage").css("display", "none");
	$(".mem_manage").css("display", "block");
	loadMember();
}

// 그룹관리 관련기능
function view_calendar_manage(){
	$(".info_manage").css("display", "none");
	$(".calendar_manage").css("display", "block");
	$(".mem_manage").css("display", "none");
}

// 그룹 멤버 관리 클릭시 맴버 출력 gr_id 필요

function loadMember(){
	$("#memList").next().remove();
	var grId = $("#memgrid").val();
		$.ajax({
			type : "POST",
			url  : "./memModi.do",
			data : "gr_id="+grId,
			async : false,
			success : function(data){
				for(var i =0; i<data.length; i++){
						$("#memList").next().cremove();
					for(var i =0; i<data.length; i++){
					$("#memList").after("<tr><td>"+data[i].mem_id+"</td><td>"+data[i].mem_name+"</td><td>"
							+"<img onclick=memDelete(this) alt=cancle src="+'./images/cancel.png'+">");
					}
				}
			}
		});
}
//그룹 멤버 삭제
function memDelete(grmemid){
	var memID = $(grmemid).parent().siblings().eq(0).text();
	alert(memID);
	var grID = "<%=gr_id%>";
	alert(grID);
	
	var rst = confirm("멤버를 추방하시겠습니까?");
	if(rst){
	location.href = "./groupMemDelete.do?gr_id="+grID+"&memID="+memID;
	}
}

// 여기는 기존 스크립트
$(function(){
	var searchyn = $("#grsearchyn").text();
	var grjoinyn = $("#grjoinyn").text()
	
	if(searchyn=="Y"){
		$("input:radio[id='grsearchy']").attr("checked",true);
	}else{
		$("input:radio[id='grsearchy2']").attr("checked",true);
	}
	if(grjoinyn=="Y"){
		$("input:radio[id='grjoinyn']").attr("checked",true);
	}else{
		$("input:radio[id='grjoinyn2']").attr("checked",true);
	}
	
	$(".grModify").submit(function(){
		if($("#grGoal").val()==""){
			alert("내용을 입력해주세요")
			return false;
		}else{
			alert("정보수정 완료");
		}
	})
	for(var i =1; i<15; i++){
		var imgNum = "이미지" + i;
		$('#imsg').append($('<option>').attr('value',imgNum).text(imgNum));
	};
	var grimgnum = "이미지"+$("#gr_imgNum").text();
	
	$("#imsg").val(grimgnum).prop("selected", true);
	$('#imsg').change(function(){
		
		var imgln = $(this).val().length;
		var GroupImgs = $(this).val().substring(3, imgln );
		$("#imgname").val(GroupImgs);
		
		$("#imgbox").attr("src","./grImgs/img"+GroupImgs+".png");
	})	
	
})
function groupManagerCh(){
	var mem = "<%=mem_id%>";
	alert(mem);
	window.open("./createGrManagerCh.do?mem_id=<%=mem_id%>", "GroupManagerCh", "width=570, height=350, resizable = no, scrollbars = no");
}
//여기 까지 기존스크립트

</script>
<style type="text/css">
#memModi{
cursor: pointer;}
img{
width: 20px;
cursor: pointer;}
</style>
</head>
<body>
<div id = "header">
	<jsp:include page="../header.jsp" flush="false"/>
</div>
<div id="container">
<div id = "con_side">
		<input type="button" value="그룹정보 수정" class="gPr_manage_btn" onclick="view_info_manage()"/>
		<input type="button" value="멤버 관리" class="gPr_manage_btn" onclick="view_mem_manage()"/>
		<input type="button" value="가입 신청 리스트" class="gPr_manage_btn" onclick="view_calendar_manage()"/>
		<input type="button" value="그룹 해체" class="gPr_manage_btn" onclick="project_delete()"/>
	</div>
	<div id="con_body">
	<div class="info_manage">
	<form class="grModify" action="./realGrmodify.do" method="post">
		<table id="grdate">
			<c:set var="grSelect" value="${grSelect}"/>
				<tr>
				<td><input type="text" value="${grSelect.GR_ID}" id="memgrid" name="gr_id" style="display: none;"> </td>
				</tr>	
				<tr>
					<td>그룹아이디</td>
					<td><input type="text" value="${grSelect.GR_ID}" readonly="readonly"> </td>
				</tr>
				<tr>
					<td>그룹이름</td>
					<td>${grSelect.GR_NAME }</td>
				</tr>
				<tr>
					<td>그룹담당자</td>
					<td>${grSelect.MEM_NAME }</td>
					<td><input type="button" value="관리자위임" onclick="groupManagerCh()"></td>
				</tr>
				<tr>
					<td>그룹인원수</td>
					<td>${grSelect.GR_MEMCNT }</td>
				</tr>
				<tr>
					<td>그룹활동목적</td>
					<td>${grSelect.GR_GOAL }</td>
					<td><input type="text" value="" name="gr_goal" id="grGoal"></td>
				</tr>
				<tr>
					<td>그룹검색여부</td>
					<td id="grsearchyn">${grSelect.GR_SEARCHYN }</td>
					<td><span><input type="radio" name="gr_searchyn" id="grsearchy" value="Y">예</span><input type="radio" name="gr_searchyn" id="grsearchy2" value="N">아니오</td>
				</tr>
				<tr>
					<td>그룹가입신청여부</td>
					<td id="grjoinyn">${grSelect.GR_JOINYN }</td>
					<td><span><input type="radio" name="gr_joinyn" value="Y" id="grjoinyn">예</span><input type="radio" name="gr_joinyn" id="grjoinyn2" value="N">아니오</td>
				</tr>
				<tr>
					<td>그룹생성일자</td>
					<td>${grSelect.GR_REGDATE }</td>
				</tr>
				<tr>
					<td id="gr_imgNum" style="display: none;">${grSelect.GR_IMG}</td>
					<td>그룹이미지</td>
					<td><select id="imsg"></select><input type="hidden" id="imgname" value="" ></td>
					<td><img id="imgbox" alt="" src="./grImgs/img${grSelect.GR_IMG}.png"></td>
					</tr>
				<tr>
					<td colspan="1" style="text-align: center;">
						<input type="submit" value="정보수정">
					</td>
				</tr>
		</table>
		</form>
		</div>
			<div class="mem_manage">
				<h1>그룹 멤버 리스트</h1>
		<table >
			<tr>
				<td>아이디</td>
				<td>이  름</td>
				<td></td>
			</tr>
			<tr id="memList" style="display: none;">
			</tr>
		</table>
			</div>
		</div>
</div>
<div id = "footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>
</body>
</html>
