<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="css/main.css" type="text/css"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<!-- <script type="text/javascript" src="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.js"></script> -->
<style type="text/css">
#groupimg2{
background-image: url("./grImgs/img01.png");
background-repeat: no-repeat;
}
.bodyContainer{
	text-align: center;
}
.container{
	display: inline-block;
	width:95%;
	margin: 0 auto;
}
.group-box{
	width: 29%;
	
	float: left;
	margin: 1.9%;
	border: 1px solid gray;
}
.group-image-box{
	width: 100%;
	height: 140px;
	background-color: #eee;
	line-height: 140px;
	vertical-align: middle;
	position: relative;
	display: inline-block;
}
.detail-group-btn{
	width:20px;
	height: 20px;
	border-radius: 20px;
	background-color: rgba(0,0,0,.5);
	color: white;
	position: absolute;
	top: 10px;
	right:34px;
	font-weight: bold;
	line-height: 20px;
	cursor: pointer;
}
.detail-group-btn2{
	width:20px;
	height: 20px;
	border-radius: 20px;
	background-color: rgba(0,0,0,.5);
	color: white;
	position: absolute;
	top: 10px;
	right:10px;
	font-weight: bold;
	line-height: 20px;
	cursor: pointer;
	z-index:100;
}
.delete-group-btn{
	width:20px;
	height: 20px;
	border-radius: 20px;
	background-color: rgba(0,0,0,.5);
	color: white;
	position: absolute;
	top: 10px;
	right:10px;
	font-weight: bold;
	line-height: 16px;
	cursor: pointer;
}
.delete-group-btn:hover{
	background-color: rgba(0,0,0,1);
}
.detail-group-btn:hover{
	background-color: rgba(0,0,0,1);
}
.group-image{
	max-width:80%;
	max-height: 120px;
	vertical-align: middle;
}
.group-name{
	text-align: left;
	text-indent: 5px;
	font-size: 1.4em;
	font-weight: bold;
	text-overflow: ellipsis;
	white-space: nowrap; 
	width:100%;
	overflow:hidden;
}
.group-title{
	text-align:left;
	border-bottom:1px solid #eee;
	padding-top:20px;
	padding-bottom:5px;
	font-weight:bold;
	text-indent:10px;
	color:#424242;
}
.openBtn{
	float:right;
}
.openBtn-text{
	position: relative;
    border: 1px solid gray;
    border-radius: 5px;
    font-size: .8em;  
    bottom: 3px;
    margin-bottom: 5px;
    padding: 3px;
    cursor:pointer;
}
</style>

<script type="text/javascript">
/* window.onload = function(){
	var val = $("#grimg").text();
	$.ajax({
		type : "POST",
		url : "./groupImg.do",
		data : "gr_id="+val,
		async : false,
		success : function(nodes){
// 			alert(nodes);
			$("table[name=groupimg]").css({"background":"url(./grImgs/img"+nodes+".png)", 'background-repeat' : 'no-repeat', 'background-position':'center center'}); 
 		}
	})
} */
$(function(){
	$('#watingGroups').hide();
})

function openChild(){
    window.open("./showGrCreate.do", "GroupCreate", "width=640, height=450, resizable = no, scrollbars = no");
 }

function openWatingGroup(){
	$('#watingGroups').toggle();
	console.log($('.openBtn-text').text());
	$('.openBtn-text').text()=='열기'?$('.openBtn-text').text('닫기'):$('.openBtn-text').text('열기');
}

function goProject(grid){
	
	location.href="./gProSelect.do?gr_id="+grid;
}

function gropuChildOpen(event){
	var grid= $(event.target).find('.gr_input_id').val();
	console.log($(event.target).find('.gr_input_id').val());
	event.stopPropagation();
	$.ajax({
		type : "POST",
		url : "./grselect.do",
		data : "gr_id="+grid,
		async : false,
		success : function(msg){
			showProDetail(msg)
		},
		error : function(request, status, error ) {   // 오류가 발생했을 때 호출된다. 
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			alert('관리자에게 문의하세요.');
		}
	});
}

function showProDetail(nodes){
	var gr_name 	= nodes.GR_NAME;
	var mem_name 	= nodes.MEM_NAME;
	var gr_memcnt 	= nodes.GR_MEMCNT;
	var gr_goal 	= nodes.GR_GOAL;
	var gr_regdate 	= nodes.GR_REGDATE;
	var gr_searchyn = nodes.GR_SEARCHYN;
	var gr_joinyn 	= nodes.GR_JOINYN;
	
	$("#gr_name").text(gr_name);
	$("#mem_name").text(mem_name);
	$("#gr_memcnt").text(gr_memcnt);
	$("#gr_goal").text(gr_goal);
	$("#gr_regdate").text(gr_regdate);
	$("#gr_searchyn").text(gr_searchyn);
	$("#gr_joinyn").text(gr_joinyn);
	
	$(".gr_detail_view").css("display","block");
	$(".gr_detail_view").dialog({
		title : "그룹 정보보기",
		height : 400,
		width : 500,
		position : {my : "center", at : "center"},
		resizable : false,
		modal : true
	});
}
// 	$("table[name=groupimg]").each(function(){
// 		var result = Math.floor(Math.random() * 14);
// 		$(this).css({"background":"url(./grImgs/img"+result+".png)", 'background-repeat' : 'no-repeat', 'background-position':'center center'}); 
</script>

</head>
<body>
<div id="header">
	<jsp:include page="../header.jsp" flush="false"/>
</div>

<div id="container">
	<!-- 그룹 정보 상세보기 팝업 START -->
	<div class="gr_detail_view">
		<table class="gr_detail_table">
			<tr>
				<th>그룹명</th>
				<td><span id="gr_name"></span></td>
			</tr>
			<tr>
				<th>그룹장</th>
				<td><span id="mem_name"></span></td>
			</tr>
			<tr>
				<th>그룹 멤버수</th>
				<td><span id="gr_memcnt"></span></td>
			</tr>
			<tr>
				<th>그룹목표</th>
				<td><span id="gr_goal"></span></td>
			</tr>
			<tr>
				<th>그룹 등록일</th>
				<td><span id="gr_regdate"></span></td>
			</tr>
			<tr>
				<th>그룹 공개여부</th>
				<td><span id="gr_searchyn"></span></td>
			</tr>
			<tr>
				<th>그룹 신청 가능 여부</th>
				<td><span id="gr_joinyn"></span></td>
			</tr>

		</table>
	</div>
	<!-- 그룹 정보 상세보기 팝업 END -->
	
	<div class="bodyContainer">

	<div>
		<input type = "button" value = "그룹생성" onclick = "openChild()">
	</div>
	
	<div class="container">
		<c:set var = "grdto2" value="${lists}" />
		<div class="group-title">내 그룹 (${fn:length(grdto2)})</div>
			<div id="myGroups">
				<c:choose>
				    <c:when test="${fn:length(grdto2) > 0}">
				    	<c:forEach var = "grdto" items="${lists}" >
				    	<a href="#" onclick="goProject('${grdto.gr_id}')">
				     	<div class="group-box">
						<div class="group-image-box">
							<img src="./grImgs/img${grdto.gr_img}.png" class="group-image">
							<div class="detail-group-btn2" onclick="gropuChildOpen(event);">
							!<input type="hidden" value="${grdto.gr_id}" class="gr_input_id"/>
							</div>
						</div>
						<div>
							<div class="group-name">
								
								${grdto.gr_name}
								
							</div>
						</div>
						</div>
						</a>
						</c:forEach> 
				    </c:when>
				
				    <c:otherwise>
				        <div>my group이 없습니다.</div>
				    </c:otherwise>  
				</c:choose>   
			</div>
		<c:set var = "waitg2" value="${watiLists}" />   
<<<<<<< HEAD
		<div style="clear:both;" class="group-title">
			승인 대기 그룹 (${fn:length(waitg2)})
			<div class="openBtn">
			<span class="openBtn-text" onclick="openWatingGroup()">열기</span>
			</div>
		</div>
			<div id="watingGroups">
				<c:choose>
				    <c:when test="${fn:length(waitg2) > 0}">
				    	<c:forEach var = "waitg" items="${watiLists}" >
				     	<div class="group-box">
						<div class="group-image-box">
							<img src="./grImgs/img${waitg.gr_img}.png" class="group-image">
							<a href="#" onclick="gropuChildOpen(event);"><div class="detail-group-btn">!
							<input type="hidden" value='${waitg.gr_id}'/ class="gr_input_id"></div></a>
							<a href="#"><div class="delete-group-btn">x</div></a>
						</div>
						<div>
							<div class="group-name">
								${waitg.gr_name}
							</div>
						</div>
						</div>
						</c:forEach> 
				    </c:when>
				
				    <c:otherwise>
				        <div>승인 대기 그룹이 없습니다.</div>
				    </c:otherwise>
				</c:choose>
			</div>
=======
		<div style="clear:both;" class="group-title">승인 대기 그룹 (${fn:length(waitg2)})</div>
		
		<c:choose>
		    <c:when test="${fn:length(waitg2) > 0}">
		    	<c:forEach var = "waitg" items="${watiLists}" >
		     	<div class="group-box">
				<div class="group-image-box">
					<img src="./grImgs/img${waitg.gr_img}.png" class="group-image">
					<a href="#"><div class="detail-group-btn">!</div></a>
					<a href=""><div class="delete-group-btn">x</div></a>
				</div>
				<div>
					<div class="group-name">
						${waitg.gr_name}
					</div>
				</div>
				</div>
				</c:forEach> 
		    </c:when>
		
		    <c:otherwise>
		        <div>승인 대기 그룹이 없습니다.</div>
		    </c:otherwise>
		</c:choose>
			
		</div>
	</div>


</div>

<div id="footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>	
</body>
</html>