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
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>

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
// $(function(){
// })

function openChild(){
    window.open("./showGrCreate.do", "GroupCreate", "width=640, height=450, resizable = no, scrollbars = no");
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
<%-- 	<c:forEach var = "grdto" items="${lists}" >
	<table name="groupimg">
		<tr><td id="grimg"><a href="./gProSelect.do?gr_id=${grdto.gr_id}">${grdto.gr_id}</a></td></tr>
		<tr><td>${grdto.gr_name}</td></tr>
		<tr><td>${grdto.gr_memCnt}</td></tr>
		<tr><td>${grdto.gr_goal}</td></tr>
		<tr><td>${grdto.gr_regDate}</td></tr>
	</table>
	</c:forEach> --%>
	
	<div class="bodyContainer">

	<div class="container">
		<c:set var = "grdto2" value="${lists}" />
		<div class="group-title">내 그룹 (${fn:length(grdto2)})</div>
		
		<c:choose>
		    <c:when test="${fn:length(grdto2) > 0}">
		    	<c:forEach var = "grdto" items="${lists}" >
		     	<div class="group-box">
				<div class="group-image-box">
					<img src="./grImgs/img${grdto.gr_img}.png" class="group-image">
					<a href="#"><div class="detail-group-btn2">!</div></a>
				</div>
				<div>
					<div class="group-name">
						<a href="./gProSelect.do?gr_id=${grdto.gr_id}">
						${grdto.gr_name}
						</a>
					</div>
				</div>
				</div>
				</c:forEach> 
		    </c:when>
		
		    <c:otherwise>
		        <div>my group이 없습니다.</div>
		    </c:otherwise>
		</c:choose>   
		
		<c:set var = "waitg2" value="${watiLists}" />   
		<div style="clear:both;" class="group-title">승인 대기 그룹 (${fn:length(waitg2)})</div>
		
		<c:choose>
		    <c:when test="${fn:length(waitg2) > 0}">
		    	<c:forEach var = "waitg" items="${watiLists}" >
		     	<div class="group-box">
				<div class="group-image-box">
					<img src="./grImgs/img${waitg.gr_img}.png" class="group-image">
					<a href="#"><div class="detail-group-btn">!</div></a>
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
	</div>

<input type = "button" value = "그룹생성" onclick = "openChild()">
</div>

<div id="footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>	
</body>
</html>