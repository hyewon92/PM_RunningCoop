<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개인 프로젝트 선택화면</title>

<link rel="stylesheet" href="css/main.css" type="text/css"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="js/circle-progress.js"></script>

<script type="text/javascript">
	function pro_rate(val){
// 		(function($){
			$('.circle').circleProgress({
			    value: val/100
			  }).on('circle-animation-progress', function(event, progress) {
			    $(this).find('strong').html(Math.round(100 * progress) + '<i>%</i>');
			  });
// 		})(jQuery);
	}

	
	function detailPro(val){
		$.ajax({
			type : "POST",
			url : "./detailPro.do",
			data : "pr_id="+val,
			async : false,
			success : function(msg){
				showProDetail(msg)
			}
		});
	}
	
	function showProDetail(nodes){
		var pr_name = nodes.PR_NAME;
		var mem_name = nodes.MEM_NAME;
		var pr_memcnt = nodes.PR_MEMCNT;
		var pr_goal = nodes.PR_GOAL;
		var pr_enddate = nodes.PR_ENDDATE;
		var pr_etc = nodes.PR_ETC;
		
		$("#pr_name").text(pr_name);
		$("#mem_name").text(mem_name);
		$("#pr_memcnt").text(pr_memcnt);
		$("#pr_goal").text(pr_goal);
		$("#pr_enddate").text(pr_enddate);
		$("#pr_etc").text(pr_etc);
		
		$(".pr_detail_view").css("display","block");
		$(".pr_detail_view").dialog({
			title : "프로젝트 정보 보기",
			height : 400,
			width : 500,
			position : {my : "center", at : "center"},
			resizable : false,
			modal : true,
		});
	}
	
	function createPro(){
		location.href="./createMPro.do";
	}
	
	function goToProject(val){
		location.href = "./goProject.do?pr_id="+val;
	}
</script>
</head>
<body>
<div id = "header">
	<jsp:include page="../header.jsp" flush="false"/>
</div>
<div id = "container">
	<button class="body_btn pr_create" onclick="createPro()">프로젝트 생성</button>
	
	<div class="pr_detail_view">
		<p id="pr_name"></p>
		<p id="mem_name"></p>
		<p id="pr_memcnt"></p>
		<p id="pr_goal"></p>
		<p id="pr_enddate"></p>
		<p id="pr_etc"></p>
	</div>
	
	<div class = "project_list_view">
		<c:choose>
			<c:when test="${ fn:length(list) == 0 }">
				<p> 진행 중인 프로젝트가 없습니다</p>
			</c:when>
			<c:otherwise>
				<c:forEach var="list" items="${ list }">
					<div class="pr_list">
						<div class="pr_btn info_div">
						<img alt="프로젝트 정보" class="pr_detail" src="images/project/pr_information.png" onclick="detailPro('${ list.pr_id }')"/>
						</div>
						<div class="pr_btn rate_div" onclick="pro_rate('${ list.pr_proRate }')">
							<div class=”circle”>
							<canvas width="100px" height="100px"></canvas>
							<strong class=”circle_strong”></strong>
							</div>
						</div>
						<div class="pr_btn date_div">
							<span style="margin-right: 10px;">D-${ list.pr_endDate }</span>
						</div>
						<div class="pr_btn name_div">
							<span onclick="goToProject('${ list.pr_id }')">${ list.pr_name }</span>
						</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<div id = "footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>

</body>
</html>