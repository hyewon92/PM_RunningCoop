<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개인 프로젝트 관리 페이지</title>

<link rel="stylesheet" href="css/main.css" type="text/css"/>
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
	$(function(){
		loadPage();
	})
	
	function view_info_manage(){
		$(".info_manage").css("display", "block");
		loadPage();
	}
	
	
	
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
	
	// 프로젝트 해체 기능
	function project_delete(){
		var pr_id = $("#pr_id").val();
		
		$.ajax({
			type : "POST",
			url : "./project_Delete.do",
			data : "pr_id="+pr_id,
			async : false,
			success : function(msg){
				if(msg == "success"){
					alert("프로젝트 삭제 성공");
					location.href= "./iProSelect.do";
				} else {
					alert("프로젝트 삭제 실패");
					location.reload();
				}
			}
		})
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
		<input type="button" value="프로젝트 삭제" onclick="project_delete()"/>
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
	</div>
</div>
<div id = "footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>
</body>
</html>