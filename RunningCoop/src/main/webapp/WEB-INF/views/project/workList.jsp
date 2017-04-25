<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로젝트 업무 리스트 화면</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
	.work_Detail_View{
		display : none;
	}
	
	.wd_title{
		cursor: pointer;
	}
	
	.work_Edit_Form{
		display : none;
	}
	
	.promem_list{
		display : none;
	}
	
	.workInsert_Form{
		border : 1px solid black;
		display : none;
	}
</style>
<script type="text/javascript">
	function viewWork(val){
		$("#wk_id").val(val);
		$.ajax({
			type : "POST",
			url : "./detailWork.do",
			data : "wk_id="+val,
			async : false,
			success : function(msg){
				$("#wd_Field").children("p").remove().children("div").remove();
				$(".work_Detail_View").css("display", "block");
				showWorkDetail(msg)
			}
		});
	}
	
	/* 하위 업무 리스트 출력 */
	function showWorkDetail(nodes){
		
		 if(nodes == null){
			$("#wd_Field").append("<p>하위 업무가 없습니다</p>");
		} else {
			$("#wd_Field").append("<p>선택|하위업무아이디|하위업무내용|애로사항여부|마감일자|완료여부</p>");
			  for(var i = 0; i < nodes.length; i++){
				var wd_id = nodes[i].wd_id;
				var wd_title = nodes[i].wd_title;
				var wd_erroryn = nodes[i].wd_errorYN;
				var wd_endDate = nodes[i].wd_endDate;
				var wd_complyn = nodes[i].wd_complYN;
				if ( wd_erroryn == 'N'){
					wd_erroryn = "애로사항 없음";
				} else {
					wd_erroryn = "애로사항 있음";
				}
				
				if ( wd_complyn == 'Y' ){
					wd_complyn = "완료업무";
				} else {
					wd_complyn = "미완료업무";
				}
				$("#wd_Field").append("<p id="+wd_id+" class='wd_list'>");
				$("#wd_Field").children("#"+wd_id).append("<input type='checkbox' name='wd_complyn'/>")
				.append("<span>"+wd_id+"</span>/")
				.append("<span class='wd_title' onclick='wdEditForm("+wd_id+")'>"+wd_title+"</span>/")
				.append("<span>"+wd_erroryn+"</span>/")
				.append("<span>"+wd_endDate+"</span>/")
				.append("<span>"+wd_complyn+"</span>")
				.append("<input type='button' value='완료' onclick='wdComplete("+wd_id+")'/>")
				.append("<input type='button' value='애로사항' onclick='wdError("+wd_id+")'/>")
				.append("<input type='button' value='삭제' onclick='wdDelete("+wd_id+")'/>");
			}
		}
		
		 /* 댓글 목록 출력 */
		wcomListView()
		
	}
	
	function wd_Insert(){
		var wd_title = $("#insert_wd_title").val();
		var wd_endDate = $("#insert_wd_endDate").val();
		var wk_id = $("#wk_id").val();
		$.ajax({
			type : "POST",
			url : "./wdInsert.do",
			data : {"wd_title":wd_title, "wd_endDate":wd_endDate, "wk_id":wk_id},
			async : false,
			success : function(msg){
				$("#wd_Field").children("p").remove().children("div").remove();
				showWorkDetail(msg)
			}
			
		});
	}
	
	function wdEditForm(val){
		var wd_id = $(val).children("span").eq(0).html();
		$(val).siblings("div").remove();
		$(val).after("<div>");
		$(val).siblings("div").append("하위업무내용<input type='textbox' id = 'newWdTitle' name='wd_title' value=''/>")
		.append("마감일자<input type='date' id = 'newWdEndDate' name='wd_endDate' value=''/>")
		.append("<input type='button' value='수정' onclick='wdEdit("+wd_id+")'/>")
		.append("<input type='button' value='취소' onclick='wdEdit_Cancle()'/>");
	}
	
	function wdEdit(val){
		var wd_title = $("#newWdTitle").val();
		var wd_endDate = $("#newWdEndDate").val();
		var wk_id = $("#wk_id").val();
		var wd_id = $(val).children("span").eq(0).html();
		
		$.ajax({
			type : "POST",
			url : "./wdEdit.do",
			data : {"wd_title":wd_title, "wd_endDate":wd_endDate, "wd_id":wd_id, "wk_id":wk_id},
			async : false,
			success : function(msg){
				$("#wd_Field").children("p").remove().children("div").remove();
				showWorkDetail(msg)
			}
		});
	}
	
	function wdEdit_Cancle(){
		$("#wd_Field").children("div").remove();
	}
	
	function wdComplete(val){
		var wd_id = $(val).children("span").eq(0).html();
		var wk_id = $("#wk_id").val();
		
		$.ajax({
			type : "POST",
			url : "./wdComplete.do",
			data : {"wd_id": wd_id, "wk_id": wk_id},
			async : false,
			success : function(msg){
				$("#wd_Field").children("p").remove().children("div").remove();
				showWorkDetail(msg)
			}
		});
	}
	
	function wdError(val){
		var wd_id = $(val).children("span").eq(0).html();
		var wk_id = $("#wk_id").val();
		
		$.ajax({
			type : "POST",
			url : "./wdError.do",
			data : {"wd_id": wd_id, "wk_id": wk_id},
			async : false,
			success : function(msg){
				$("#wd_Field").children("p").remove().children("div").remove();
				showWorkDetail(msg)
			}
		});
	}
	
	function wdDelete(val){
		var wd_id = $(val).children("span").eq(0).html();
		var wk_id = $("#wk_id").val();
		
		$.ajax({
			type : "POST",
			url : "./wdDelete.do",
			data : {"wd_id": wd_id, "wk_id": wk_id},
			async : false,
			success : function(msg){
				$("#wd_Field").children("p").remove().children("div").remove();
				showWorkDetail(msg)
			}
		});
	}
	
	function backToProject(){
		var pr_id = $("#pr_id").val();
		location.href="./goProject.do?pr_id="+pr_id;
	}
	
	function workEdit(val, val2, val3, val4){
		$(".workInsert_Form").css("display", "none");
		$(".work_Edit_Form").css("display", "block");
		$("#edit_wk_id").val(val);
		$("#input_wk_title").val(val2);
		$("#input_wk_endDate").val(val3);
		$(".input_mem_id").eq(1).val(val4);
	}
	
	function wkEditClose(){
		$("#edit_wk_id").val("");
		$("#work_Edit_Form").children("input[type=text]").val("").end().children("input[type=date]").val("");
		$("#work_Edit_Form").css("display", "none");
	}
	
	function searchMem(){
		$("#promem_list").css("display", "block");
		var pr_id = $("#pr_id").val();
		
		$.ajax({
			type : "POST",
			url : "./searchmem.do",
			data : "pr_id="+pr_id,
			async : false,
			success : function(nodes){
				$("#promem_list").children("fieldset").children("p").remove();
				$("#promem_list").children("fieldset").append("<input type='button' value='닫기' onclick='memList_Close()'/><br>");
				for(var i = 0; i < nodes.length; i++){
					var mem_name = nodes[i].MEM_NAME;
					var mem_id = nodes[i].MEM_ID;
					$("#promem_list").children("fieldset")
					.append("<span>"+mem_name+"</span>")
					.append("<input type='button' value='선택' onclick='trans_Memid(\""+mem_id+"\")'/><br>");
				}
			}
		});
	}
	
	function memList_Close(){
		$("#promem_list").css("display", "none").children("fieldset").children("legend").siblings().remove();
	}
	
	function trans_Memid(val){
		var mem_id = val;
		if ($(".workInsert_Form").css("display") == "block"){
			$(".input_mem_id").eq(0).val(mem_id);
		} else if ($(".workInsert_Form").css("display") == "none"){
			$(".input_mem_id").eq(1).val(mem_id);
		}
		$("#promem_list").css("display", "none").children("fieldset").children("legend").siblings().remove();
	}
	
	function work_Edit(){
		$("#work_Edit").submit();
	}
	
	function workInsert(){
		$(".work_Edit_Form").css("display", "none");
		$(".workInsert_Form").css("display", "block");
	}
	
	function workInsert_Form_Close(){
		$("#wk_insert_form").children("input[type=text]").val("");
		$("#wk_insert_form").children("input[type=date]").val("");
		$(".workInsert_Form").css("display", "none");
	}
	
	function workDelete(val){
		var pr_id = $("#pr_id").val();
		location.href="./workDelete.do?pr_id="+pr_id+"&wk_id="+val;
	}
	
	function wcomListView(){
		var wk_id = $("#wk_id").val();
		
		$.ajax({
			type : "POST",
			url : "./wcomlist.do",
			data : "wk_id="+wk_id,
			async : false,
			success : function(msg){
				showcommentList(msg)
			}
		})
	}
	
	function wcom_Insert(){
		var wk_id = $("#wk_id").val();
		var wcom_content = $("#new_wcom_content").val();
		$("#new_wcom_content").val("");
		
		$.ajax({
			type : "POST",
			url : "./wcominsert.do",
			data : {"wk_id": wk_id, "wcom_content": wcom_content},
			async : false,
			success : function(nodes){
				showcommentList(nodes)
			}
		})
	}
	
	function showcommentList(nodes){
		$("#wk_Comment_List").children("table").remove().end().children("p").remove();
		if( nodes.length == 0){
			$("#wk_Comment_List").append("<p>댓글이 없습니다</p>");
		} else {
			$("#wk_Comment_List").append("<table>")
			.children("table").append("<tr><td>작성자</td><td>내용</td><td>작성일</td></tr>");
			for(var i = 0; i < nodes.length; i++){
				$("#wk_Comment_List").children("table")
				.append("<tr><td>"+nodes[i].MEM_NAME+"</td><td>"+nodes[i].WCOM_CONTENT+"</td><td>"+nodes[i].WCOM_REGDATE+"</td></tr>");
			}
		}
		
	}
	
	
	
</script>
</head>
<body>
<div>
<input type="hidden" id = "pr_id" value="${ pr_id }"/> 
<div>
	<input type="button" value="업무 추가" onclick="workInsert()"/>
	<div id="workInsert_Form" class="workInsert_Form">
		<input type="button" value="닫기" onclick="workInsert_Form_Close()"/>
		<form id="wk_insert_form" action="./workInsert.do?pr_id=${ pr_id }" method="POST">
			업무 명 : <input type="text" name="wk_title" value=""/><br>
			업무 담당자 : <input type="text" class ="input_mem_id" name="mem_id" value=""/><input type="button" value="멤버조회" onclick="searchMem()"/><br>
			업무 마감기한 : <input type="date" name="wk_endDate" value=""/><br>
			<input type="submit" value="등록"/>
		</form>
	</div>
	<fieldset id="todoList">
		<legend>Todo</legend>
		<c:choose>
			<c:when test="${ fn:length(todo) == 0 }">
				<p>업무가 없습니다.</p>
			</c:when>
			<c:otherwise>
				<c:forEach var="todo" items="${ todo }">
					<span onclick = "viewWork('${ todo.get('WK_ID') }')">
						<input type="hidden" value="${ todo.get('WK_ID') }" /> 
						${ todo.get('WK_TITLE') }/(${ todo.get('MEM_NAME') })/${ todo.get('WK_PRORATE') }%
					</span>
					<input type="button" value="수정" onclick="workEdit('${ todo.get('WK_ID') }', '${ todo.get('WK_TITLE') }', '${ todo.get('WK_ENDDATE') }', '${ todo.get('MEM_ID') }')"/>
					<input type="button" value="삭제" onclick="workDelete('${ todo.get('WK_ID') }')"/><br>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</fieldset>
</div>
<div>
	<fieldset id="doingList">
		<legend>Doing</legend>
		<c:choose>
			<c:when test="${ fn:length(doing) == 0 }">
				<p>업무가 없습니다.</p>
			</c:when>
			<c:otherwise>
				<c:forEach var="doing" items="${ doing }">
					<span onclick = "viewWork('${ doing.get('WK_ID') }')">
						<input type="hidden" value="${ doing.get('WK_ID') }" /> 
						${ doing.get("WK_TITLE") }/(${ doing.get("MEM_NAME") })/${ doing.get("WK_PRORATE") }%
					</span>
					<input type="button" value="수정" onclick="workEdit('${ doing.get('WK_ID') }', '${ doing.get('WK_TITLE') }', '${ doing.get('WK_ENDDATE') }', '${ doing.get('MEM_ID') }')"/>
					<input type="button" value="삭제" onclick="workDelete('${ doing.get('WK_ID') }')"/><br>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</fieldset>
</div>
<div>
	<fieldset id="doneList">
		<legend>Done</legend>
		<c:choose>
			<c:when test="${ fn:length(done) == 0 }">
				<p>업무가 없습니다.</p>
			</c:when>
			<c:otherwise>
				<c:forEach var="done" items="${ done }">
					<span onclick = "viewWork('${ done.get('WK_ID') }')">
						<input type="hidden" value="${ done.get('WK_ID') }" /> 
						${ done.get("WK_TITLE") }/(${ done.get("MEM_NAME") })/${ done.get("WK_PRORATE") }%
					</span><br/>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</fieldset>
</div>
</div>
<div id = "work_Edit_Form" class="work_Edit_Form">
	<fieldset>
		<legend>업무 수정 양식</legend>
		<form id = "work_edit" action="./workEdit.do?pr_id=${ pr_id }" method="POST">
		<input type="hidden" id="edit_wk_id" name = "wk_id" value=""/>
		<input type="button" value="닫기" onclick="wkEditClose()"/><br/>
		업무 내용<input type="text" id = "input_wk_title" name="wk_title" value=""/>
		마감 기한<input type="date" id = "input_wk_endDate" name="wk_endDate" value=""/>
		담당자 <input type="text" class = "input_mem_id" name="mem_id" value=""/>
		<input type="button" value="멤버조회" onclick="searchMem()"/><br>
		<input type="submit" value="수정" />
		</form>
	</fieldset>
</div>
<div id = "promem_list" class="promem_list">
	<fieldset>
		<legend>프로젝트 멤버</legend>
	</fieldset>
</div>
	<div id = "work_Detail" class = "work_Detail_View">
	<input type="hidden" id = "wk_id" value=""/>
	<input type="button" value="닫기" onclick="backToProject()"/>
		<div id = "work_Detail_Insert">
			업무명 <input type = "text" id = "insert_wd_title" name="wd_title" value=""/> 
			마감기한<input type = "date" id="insert_wd_endDate" name = "wd_endDate" value=""/>
			<input type = "button" value = "추가" onclick = "wd_Insert()"/>
		</div>
		<fieldset id = "wd_Field">
			<legend>업무 상세화면</legend>
		</fieldset>
		<div class = "work_Comment_View">
			<fieldset id = "wk_Comment_List">
				<legend>댓글</legend>
			</fieldset>
			<div>
				<input type="text" id="new_wcom_content" value=""/>
				<input type="button" value="등록" onclick="wcom_Insert()"/>
			</div>
		</div>
	</div>

</body>
</html>