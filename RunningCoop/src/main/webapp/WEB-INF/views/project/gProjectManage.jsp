<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>그룹 프로젝트 관리 페이지</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
	#con_body{
		border : 1px solid black;
	}
	
	.mem_manage{
		display : none;
	}
	
	.calendar_manage{
		display : none;
	}
	
	.mem_list{
		width : 150px;
		height : 300px;
		overflow: scroll;
	}
</style>
<script type="text/javascript">
<%
	String mem_id = (String)session.getAttribute("mem_id");
%>
	$(function(){
		loadPage();
	})
	
	// 프로젝트 정보 관리
	function view_info_manage(){
		$(".info_manage").css("display", "block");
		$(".mem_manage").css("display", "none");
		$(".calendar_manage").css("display", "none");
		loadPage();
	}
	
	// 프로젝트 멤버 관리
	function view_mem_manage(){
		$(".info_manage").css("display", "none");
		$(".calendar_manage").css("display", "none");
		$(".mem_manage").css("display", "block");
		loadMember();
	}
	
	// 프로젝트 팀 일정 관리
	function view_calendar_manage(){
		$(".mem_manage").css("display", "none");
		$(".info_manage").css("display", "none");
		$(".calendar_manage").css("display", "block");
	}
	
	// 페이지 로드 시 실행 함수
	function loadPage(){
		var chkyn = $("#searchYN").val();
		if (chkyn == 'A'){
			$("input:radio[name='pr_searchYN']:radio[value='A']").attr("checked", true);
		} else {
			$("input:radio[name='pr_searchYN']:radio[value='N']").attr("checked", true);
		}
		var condition = $("#condition").val();
		if (condition == 'T'){
			$("select[name='pr_condition'] option:eq(0)").attr("selected", "selected");
		} else if (condition == 'I'){
			$("select[name='pr_condition'] option:eq(1)").attr("selected", "selected");
		} else {
			$("select[name='pr_condition'] option:eq(2)").attr("selected", "selected");
		}
	}
	
	// 프로젝트 정보 수정 기능
	function projectEdit(){
		var pr_id = $("#pr_id").val();
		var pr_name = $("input[name=pr_name]:eq(0)").val();
		var pr_endDate = $("input[name=pr_endDate]:eq(0)").val();
		var pr_goal = $("input[name=pr_goal]:eq(0)").val();
		var pr_searchYN = $("input[name=pr_searchYN]:checked").val();
		var pr_condition = $("select[name=pr_condition] option:selected").val();
		
		$.ajax({
			type : "POST",
			url : "./projectEdit.do",
			data : {"pr_id":pr_id, "pr_name":pr_name, "pr_endDate":pr_endDate, "pr_goal":pr_goal, "pr_searchYN":pr_searchYN, "pr_condition":pr_condition},
			async : false,
			success : function(msg){
				if(msg == "success"){
					location.reload();
				} else {
					alert("수정에 실패했습니다");
				}
			}
		})
	}
	
	// 프로젝트 멤버 조회 기능
	function loadMember(){
		var pr_id = $("#pr_id").val();
		
		$(".mem_list").children("p").remove();
		
		$.ajax({
			type : "POST",
			url : "./loadMember.do",
			data : "pr_id="+pr_id,
			async : false,
			success : function(msg){
				if(msg.length == 0){
					$(".mem_list").append("<p>멤버가 없습니다</p>");
				} else {
					for(var i = 0; i < msg.length; i++){
						if(msg[i].MEM_ID == '<%=mem_id%>'){
							$(".mem_list").append("<p>(PM)"+msg[i].MEM_NAME+"</p>");
						} else {
							$(".mem_list").append("<p><input type='checkbox' name='mem_list' value=\""+msg[i].MEM_ID+"\">"+msg[i].MEM_NAME+"</p>");
						}
					}
				}
			}
		})
	}
	
	// 초대가능한 그룹 멤버 조회 기능
	function invite_memList(){
		var pr_id = $("#pr_id").val();
		
		$.ajax({
			type : "POST",
			url : "./invite_memList.do",
			data : "pr_id="+pr_id,
			async : false,
			success : function(msg){
				if(msg.length == 0){
					$("#invitable_Memlist").append("<p>초대 가능한 멤버가 없습니다.</p>");
				} else {
					for(var i = 0; i < msg.length; i++){
						$("#invitable_Memlist").append("<p><input type='checkbox' name='mem_id' value='"+msg[i].mem_id+"'/>"+msg[i].mem_name+"</p>");
					}
					$("#invitable_Memlist").append("<input type='button' value='초대' onclick='inviteMem()'/>");
				}
			}
		})
	}
	
	// 멤버 초대 기능
	function inviteMem(){
		var pr_id = $("#pr_id").val();
		var inputbox = $("input:checkbox[name=mem_id]:checked");
		var mem_id = new Array(inputbox.length);
		for (var i = 0; i < inputbox.length; i++){
			mem_id[i] = inputbox.eq(i).val();
		}
		
		jQuery.ajaxSettings.traditional = true;
		
		$.ajax({
			type : "POST",
			url : "./invite_Member.do",
			data : {"mem_id": mem_id, "pr_id": pr_id},
			async : false,
			success : function(msg){
				if(msg == "success"){
					alert("멤버초대성공!");
					loadMember();
				} else {
					alert("멤버초대실패!");
					loadMember();
				}
			}
		})
	}
	
	// 멤버 강제 탈퇴 기능
	function delete_mem(){
		var pr_id = $("#pr_id").val();
		var inputbox = $("input:checkbox[name=mem_list]:checked");
		var mem_list = new Array(inputbox.length);
		
		for (var i = 0; i < inputbox.length; i++){
			if(inputbox.eq(i).val)
			mem_list[i] = inputbox.eq(i).val();
		}
		
		jQuery.ajaxSettings.traditional = true;
		
		$.ajax({
			type : "POST",
			url : "./delete_Member.do",
			data : {"mem_list": mem_list, "pr_id": pr_id},
			async : false,
			success : function(msg){
				if(msg == "success"){
					alert("멤버탈퇴성공!");
					loadMember();
				} else {
					alert("멤버탈퇴실패!");
					loadMember();
				}
			}
		})
	}
	
	// 담당자 위임 기능
	function commission_mem(){
		var pr_id = $("#pr_id").val();
		var inputbox = $("input:checkbox[name=mem_list]:checked");
		var mem_list = new Array(inputbox.length);
		
		if(inputbox.length != 1){
			alert("1명만 선택하세요!");
			inputbox.attr("checked", false);
		} else {
			var mem_id = mem_list[0];
			
			$.ajax({
				type : "POST",
				url : "./commissionPM.do",
				data : {"pr_id": pr_id, "mem_id": mem_id},
				async : false,
				success : function(msg){
					
				}
			})
		}
	}
	
</script>
</head>
<body>
<div id = "header">
	<jsp:include page="../header.jsp" flush="false"/>
</div>
<div id = "container">
	<input type="hidden" id = "pr_id" value="${ pr_id }"/>
	<div id = "con_header">
		<span>프로젝트 관리</span> <input type="button" value="닫기"/>
	</div>
	<div id = "con_side">
		<input type="button" value="프로젝트 정보관리" onclick="view_info_manage()"/>
		<input type="button" value="멤버 관리" onclick="view_mem_manage()"/>
		<input type="button" value="팀 일정 관리" onclick="view_calendar_manage()"/>
		<input type="button" value="프로젝트 삭제"/>
	</div>
	<div id = "con_body">
		<div class = "info_manage">
			<c:set var="detail" value="${ detail }"></c:set>
			프로젝트 정보 수정 화면 <br/><br/>
			프로젝트 명 : <input type="text" name="pr_name" value="${ detail.PR_NAME }"/><br>
			담당자 : ${ detail.MEM_NAME }<br>
			프로젝트 시작일 : ${ detail.PR_STARTDATE }<br/>
			마감기한 : <input type="date" name="pr_endDate" value="${ detail.PR_ENDDATE }"/><br>
			프로젝트 목적 : <input type="text" name="pr_goal" value="${ detail.PR_GOAL }"/><br>
			<input type="hidden" id="searchYN" value="${ detail.PR_SEARCHYN }"/>
			공개 여부 : <input type="radio" name="pr_searchYN" value="A"/>공개 <input type="radio" name="pr_searchYN" value="N"/>비공개<br>
			<input type="hidden" id="condition" value="${ detail.PR_CONDITION }"/>
			진행상태 : <select name = "pr_condition">
				<option value="T">진행 예정</option>
				<option value="I">진행 중</option>
				<option value="C">진행 완료</option>
			</select><br/><br/>
			<input type="button" value="수정" onclick="projectEdit()"/>
		</div>
		<div class = "mem_manage">
			<div class = "mem_manage_con" id = "mem_list">
				프로젝트 멤버 리스트<br/><br/>
				<div class="mem_list"></div>
			</div>
			<div class="mem_manage_con" id = "mem_control" >
				<input type="button" value="멤버 초대" onclick="invite_memList()"/><br>
				<input type="button" value="멤버 삭제" onclick="delete_mem()"/><br>
				<input type="button" value="담당자 위임" onclick="commission_mem()"/><br>
				<input type="button" value="멤버 정보 보기"/>
			</div>
			<div id = "invitable_Memlist"></div>
		</div>
		<div class = "calendar_manage">
			<div>
				달력
			</div>
			<div>
				세부일정 조회/추가
			</div>
		</div>
	</div>
</div>
<div id = "footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>
</body>
</html>