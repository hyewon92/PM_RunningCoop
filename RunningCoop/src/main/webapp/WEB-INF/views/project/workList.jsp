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
</style>
<script type="text/javascript">
	function viewWork(val){
		$.ajax({
			type : "POST",
			url : "./detailWork.do",
			data : "wk_id="+val,
			async : false,
			success : function(msg){
				$("#wd_Field").children("p").remove();
				$(".work_Detail_View").css("display", "block");
				showWorkDetail(msg)
			}
		});
	}
	
	function showWorkDetail(nodes){
		
		 if(nodes == null){
			$("#wd_Field").append("<p>하위 업무가 없습니다</p>");
		} else {
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
				$("#wd_Field").append("<p>"+wd_id+"/"+wd_title+"/"+wd_erroryn+"/"+wd_endDate+"/"+wd_complyn+"</p>");
				
			}
		}
		
	}
	
	function wd_Insert(){
		$.ajax({
			
			
		});
	}
</script>
</head>
<body>
	<fieldset id="todoList">
		<legend>Todo</legend>
		<c:choose>
			<c:when test="${ fn:length(todo) == 0 }">
				<p>업무가 없습니다.</p>
			</c:when>
			<c:otherwise>
				<c:forEach var="todo" items="${ todo }">
					<p onclick = "viewWork(${ todo.get('WK_ID') })">
						<input type="hidden" value="${ todo.get('WK_ID') }" /> 
						${ todo.get('WK_TITLE') }/(${ todo.get('MEM_NAME' })/${ todo.get('WK_PRORATE') }
					</p>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</fieldset>
	<fieldset id="doingList">
		<legend>Doing</legend>
		<c:choose>
			<c:when test="${ fn:length(doing) == 0 }">
				<p>업무가 없습니다.</p>
			</c:when>
			<c:otherwise>
				<c:forEach var="doing" items="${ doing }">
					<p onclick = "viewWork('${ doing.get('WK_ID') }')">
						<input type="hidden" value="${ doing.get('WK_ID') }" /> 
						${ doing.get("WK_TITLE") }/(${ doing.get("MEM_NAME") })/${ doing.get("WK_PRORATE") }%
					</p>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</fieldset>
	<fieldset id="doneList">
		<legend>Done</legend>
		<c:choose>
			<c:when test="${ fn:length(done) == 0 }">
				<p>업무가 없습니다.</p>
			</c:when>
			<c:otherwise>
				<c:forEach var="done" items="${ done }">
					<p onclick = "viewWork(${ done.get('WK_ID') })">
						<input type="hidden" value="${ done.get('WK_ID') }" /> 
						${ done.get("WK_TITLE") }/(${ done.get("MEM_NAME") })/${ done.get("WK_PRORATE") }
					</p>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</fieldset>
	<div id = "work_Detail" class = "work_Detail_View">
		<fieldset id = "wd_Field">
			<legend>업무 상세화면</legend>
			
			
		</fieldset>
		<div id = "work_Detail_Insert">
			<form>
			업무명 <input type = "textbox" name="wd_title" value=""/> 마감기한<input type = "date" name = "wd_endDate" value=""/>
			</form>
			<input type = "button" value = "추가" onclick = "wd_Insert()"/>
		</div>
	</div>

</body>
</html>