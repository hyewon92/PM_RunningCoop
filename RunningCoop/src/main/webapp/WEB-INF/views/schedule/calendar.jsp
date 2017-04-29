<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.pm.rc.dto.ScheduleDto"%>
<%@ page import="java.util.Calendar"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#calendar th {
		background-color: aqua;
	}
	
	#calendar td {
		background-color: #ffe4c4;
		height: 80px;
		vertical-align: top;
	}
	
	a {
		text-decoration: none;
	}
	
	#list div {
		background-color: orange;
	}
	
	#list {
		font-size: 8pt;
	}
	
	.plus {
		width: 15px;
		height: 15px;
		float: right;
	}
	
	.arrow {
		width: 30px;
		height: 30px;
	}
	
	b {
		font-size: 30pt;
	}
	
	/* .scheduleDetailBox {
		border: 1px solid gray;
		border-collapse: collapse;
		display : none;
	} */
	
	.scheduleBox, .scheduleModiBox {
		border: 1px solid gray;
		border-collapse: collapse;
		display: none;
	}
	
	.listlBox{
		border-collapse: collapse;
		width: 200px;
		display: inline-block;
		float: left;
		display: none;
	}
	
	.detailBox{
		border: 1px solid gray;
		border-collapse: collapse;
		display : none;
		width: 500px;
		float: rigth;
	}
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>

<script type="text/javascript">
	//지정일 일정 조회
 	function dailyList(val1, val2, val3){
 		$(".listBox").children().remove();
		$.ajax({
			type : "POST",
			url : "./dailySchSelect.do",
			data: "date="+val1+"-"+val2+"-"+val3,
			async: false,
			success: function(msg){
				showDailyList(msg, val1, val2, val3)
			}
		});
	}
	
	//지정일 일정 출력
	function showDailyList(schedule, val1, val2, val3){
		if(schedule.length == 0){
			$(".listBox").append("<p>해당 일에 등록된 일정이 없습니다.</p>");
		}else{
			for(var i = 0; i < schedule.length; i++){
				if(schedule[i].projectDto!=null && schedule[i].projectDto!=undefined){
					var pr_name = schedule[i].projectDto.pr_name;
					var pr_id = schedule[i].pr_id;
				}
					var sch_seq = schedule[i].sch_seq;
					var sch_title = schedule[i].sch_title;
					var title = sch_title;
					if(schedule[i].pr_id != null){
						title = pr_name+":"+sch_title;
					}
				$(".listBox").css("display", "block");
				$(".detailBox").css("display", "none");
				$(".listBox").append("<span class = 'listChk' onclick = 'showDetail("+sch_seq+",\""+val1+"\",\""+val2+"\",\""+val3+"\")'>"+title+"</span><br>");
			}
		}
	}

	//일정 상세정보 조회
	function showDetail(val1, val2, val3, val4){
		$.ajax({
			type : "POST",
			url : "./detailSchedule.do",
			data: "sch_seq="+val1,
			async: false,
			success: function(msg){
				dailyList(val2, val3, val4);
				showSchDetail(msg)
			},
			error:function(){
				alert("error");
			}
		});
	}
	
	//일정 상세정보 출력
	function showSchDetail(schedule){
		var sch_seq = schedule.dto.sch_seq;
		var pr_id = schedule.dto.pr_id;
		var sch_startDate = schedule.dto.sch_startDate;
		var sch_endDate = schedule.dto.sch_endDate;
		var sch_title = schedule.dto.sch_title;
		var sch_content = schedule.dto.sch_content;
		
		$("#sch_seq").val(sch_seq);
		$("#sch_startDate").text("시작:"+sch_startDate);
		$("#sch_endDate").text("종료:"+sch_endDate);
		$("#sch_content").text(sch_content);
			
 		if(pr_id == null){
			$("#sch_title").text(sch_title);
		}else{
			$("#sch_title").text(schedule.dto.projectDto.pr_name+":"+sch_title);
		}
		 
		$(".scheduleBox").css("display", "none");
		$(".detailBox").css("display", "block");
		$(".scheduleModiBox").css("display", "none");
		$(".listBox").css("display", "block");
	}
	
	//일정 삭제
	function goDelete(){
		var sch_seq = $("#sch_seq").val();
		if(confirm("정말로 삭제하시겠습니까?")){
			location.href = "./deleteSchedule.do?sch_seq="+sch_seq;
		}
	}
	
	//일정 수정 폼 활성화
	function goModify(){
		alert($("#sch_startDate").text());
		$("#sch_upSeq").val($("#sch_seq").val());
		$("#sch_upStartDate").val($("#sch_startDate").text().substring(3,13));
		$("#sch_upStartTime").val($("#sch_startDate").text().substring(14));
		$("#sch_upEndDate").val($("#sch_endDate").text().substring(3,13));
		$("#sch_upEndTime").val($("#sch_endDate").text().substring(14));
		$("#sch_upTitle").val($("#sch_title").text());
		$("#sch_upContent").val($("#sch_content").text());
		
		$(".scheduleModiBox").css("display", "block");
		$(".scheduleBox").css("display", "none");
		$(".detailBox").css("display", "none");
		$(".listBox").css("display", "none");
	}
	
	//일정 등록 폼 활성화
	function openWriteForm(val1, val2, val3){
		var array = [val1, val2, val3];
		var day = array.join("-");
		
		$(".scheduleModiBox").css("display", "none");
		$(".scheduleDetailBox").css("display", "none");
		$(".scheduleBox").css("display", "block");
		$("#sch_newStartDate").val(day);
		$("#sch_newEndDate").val(day);
	}
	
	$(function(){
		//일정 등록
		$(".scheduleBox").submit(function(){
			var newStartTotal = $("#sch_newStartDate").val()+" "+$("#sch_newStartTime").val();
			$("#newStartTotal").val(newStartTotal);
			var newEndTotal = $("#sch_newEndDate").val()+" "+$("#sch_newEndTime").val();
			$("#newEndTotal").val(newEndTotal);
			if($("#newStartTotal")==""||$("#newEndTotal")==""){
				alert("날짜를 입력해주세요");
				return false;
			}
		});
		
		//일정 수정
 		$(".scheduleModiBox").submit(function(){
			var upStartTotal = $("#sch_upStartDate").val()+" "+$("#sch_upStartTime").val();
			$("#upStartTotal").val(upStartTotal);
			var upEndTotal = $("#sch_upEndDate").val()+" "+$("#sch_upEndTime").val();
			$("#upEndTotal").val(upEndTotal);
			if($("#upStartTotal")==""||$("#upEndTotal")==""){
				alert("날짜를 입력해주세요");
				return false;
			}
		}); 
	});
</script>
</head>

<%!
	//요일별 색깔(토요일:파랑, 일요일:빨강)
	public String weekColor(int i, int dayOfWeek){
	String color = "";
	if((i+dayOfWeek-1)%7==0){
		color = "blue";
	}else if((i+dayOfWeek-1)%7==1){
		color = "red";
	}
	return color;
	}

	//일정작성
	public String schWrite(int year, String month, String date){
		System.out.println("month="+month);
		System.out.println("date="+date);
		
		 /* "<a href = './writeSchedule.do?year="+year+"&month="+month+"&date="+date+"'>" */
		return	"<img class = 'plus' alt = '일정등록' src = 'images/plus.png' onclick='openWriteForm(\""+year+"\",\""+month+"\",\""+date+"\")'>";
	}
	
	//날짜 형식 맞추기(두자리:0x~31)
	public String dateForm(String date){
		return date.trim().length()<2 ? "0"+date:date;
	}
	
	//달력에 일정목록 출력
	public String schListView(int year, int month, int day, List<ScheduleDto> lists){
		String result = "";
		String s_year = dateForm(String.valueOf(year));
		String s_month = dateForm(String.valueOf(month));
		String s_day = dateForm(String.valueOf(day));
		String date = s_year+s_month;
		for(ScheduleDto dto:lists){
			System.out.println(dto);
			String title = dto.getSch_title();
			String event = "<span class = 'listChk' onclick = 'showDetail("+dto.getSch_seq()+",\""+s_year+"\",\""+s_month+"\",\""+s_day+"\")'>[조회]</span><br>";
			
			int startDate = Integer.parseInt(dto.getSch_startDate().substring(6, 8));
			int endDate = Integer.parseInt(dto.getSch_endDate().substring(6, 8));
			if(dto.getSch_startDate().substring(0, 6).equals(date)&&dto.getSch_endDate().substring(0, 6).equals(date)&&startDate<=day&&day<=endDate){
				System.out.println(dto.getSch_startDate()+":"+dto.getSch_title());
				if(dto.getSch_prosYN().equals("Y")){
					title = dto.getProjectDto().getPr_name()+":"+title;
				}
				if(title.length()>6){
					title = title.substring(0, 6)+"..";
				}
				result += title+event+"\n";
			}
		}
		return result;
	}
%>
<%
	//회원 계정 정보
	String mem_id = (String)session.getAttribute("mem_id");

	//원하는 달로 이동하기 위해 현재 연도와 달 값 전달받음
	String cyear = (String)request.getParameter("year");
	String cmonth = (String)request.getParameter("month");
	System.out.println("year:"+cyear+"/month:"+cmonth);
	
	//회원 일정 목록
	ArrayList<ScheduleDto> lists = (ArrayList<ScheduleDto>)request.getAttribute("list");
	
	//칼랜더 객체 생성
	Calendar cal = Calendar.getInstance();
	
	//원하는 달로 이동하기 위한 처리
	int year = cal.get(Calendar.YEAR);	//현재 년도
	if(cyear!=null){
		year = Integer.parseInt(cyear);	//전달받은 년도로 재설정
	}
	int month = cal.get(Calendar.MONTH)+1;
	if(cmonth!=null){
		month = Integer.parseInt(cmonth);	//전달받은 달로 재설정
	}
	
	if(month<1){
		month = 12;
		year--;
	}
	if(month>12){
		month = 1;
		year++;
	}
	cal.set(year, month-1, 1);	//수정된 날짜로 cal 객체 셋팅
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);	//수정된 년/월/1일에 대한 요일 구하기(그달의 첫날 요일)
	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH); 	//해당 달의 마지막 날 구하기
%>

<body>
<div id = "header">
	<jsp:include page="../header.jsp" flush="false"/>
</div>
<div id = "container">
	<h1>일정관리</h1>
	<!-- 달력 출력 -->
	<table id="calendar">
		<caption>
			<a href="./viewSchedule.do?year=<%=year-1%>&month=<%=month%>"><img alt="이전 년도 이동" class="arrow" src="images/bigLeft.png"></a> 
			<a href="./viewSchedule.do?year=<%=year%>&month=<%=month-1%>"><img alt="이전 월 이동" class="arrow" src="images/left.png"></a> 
			<b><%=year %>년<%=month %>월</b> 
			<a href="./viewSchedule.do?year=<%=year%>&month=<%=month+1%>"><img alt="이전 월 이동" class="arrow" src="images/right.png"></a> 
			<a href="./viewSchedule.do?year=<%=year+1%>&month=<%=month%>"><img alt="이전 월 이동" class="arrow" src="images/bigRight.png"></a>
		</caption>
		<col width="80px">
		<col width="80px">
		<col width="80px">
		<col width="80px">
		<col width="80px">
		<col width="80px">
		<col width="80px">
		<tr>
			<th>일</th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th>토</th>
		<tr>
			<%
				//매 달 1일 시작 전 공백 채우기
				for(int i = 1; i < dayOfWeek; i++){
					out.print("<td>&nbsp;</td>");
				}
				//1일부터 구한 달력의 lastDay까지 날짜 출력
				for(int i = 1; i <= lastDay; i++){
			%>
			<td style="color:<%=weekColor(i, dayOfWeek)%>;">
				<% String s_month = dateForm(String.valueOf(month)); %>
				<% String s_i = dateForm(String.valueOf(i)); %> 
				<%=schWrite(year, s_month, s_i)%>
				<span class = "dailyList" onclick = "dailyList('<%=year%>', '<%=s_month%>', '<%=s_i%>')"><%=i %></span>
				<div id="list"><%=schListView(year, month, i, lists) %></div></td>
			<%
					//토요일이 되면 줄바꿈
					if((i+dayOfWeek-1)%7==0){
					%>
		</tr>
		<tr>
			<%	
					}%>
			<%
			//출력되는 일이 마지막 일이면 공백 출력
			if(i==lastDay&&(i+dayOfWeek-1)%7!=0){
				for(int j = 0; j < 7-(i+dayOfWeek-1)%7; j++){
					out.print("<td>&nbsp;</td>");
				}
			}
		} 
		%>
		</tr>
	</table>

	<!-- 일정 상세정보 출력부분 -->
	<div class="scheduleDetailBox">
		<div class = "listBox">
		</div>
		<div class  = "detailBox">
				<input type="hidden" id="sch_seq">
			<table>
				<tr>
					<td id="sch_startDate"></td>
					<td id="sch_endDate"></td>
				</tr>
				<tr>
					<td id="sch_title" colspan="2"></td>
				</tr>
				<tr>
					<td id="sch_content" colspan="2"></td>
				</tr>
			</table>
			<div>
				<input type="button" value="수정" onclick="goModify()"> 
				<input type="button" value="삭제" onclick="goDelete()">
			</div>
		</div>
	</div>

	<!-- 일정 수정 부분 -->
	<form class="scheduleModiBox" action="./modifySchedule.do" method="post">
		<div>
			<input type = "hidden" id = "sch_upSeq" name = "sch_seq"> 
			<input type = "hidden" name = "mem_id" value = <%=mem_id%>> 
			시작 <input type = "date" id = "sch_upStartDate"> 
			<input type = "time" id = "sch_upStartTime"> 
			<input type = "hidden" id = "upStartTotal" name = "sch_startDate"> ~ 
			종료<input type = "date" id = "sch_upEndDate"> 
			<input type = "time" id = "sch_upEndTime">
			<input type = "hidden" id = "upEndTotal" name = "sch_endDate"> <br>
			제목:<input type = "text" id = "sch_upTitle" name = "sch_title"><br> 
			내용:<input type = "text" id = "sch_upContent" name="sch_content">
		</div>
		<div>
			<input type="submit" value="수정">
		</div>
	</form>

	<!-- 일정 등록 부분 -->
	<form class="scheduleBox" action="./insertSchedule.do" method="post">
		<div>
			<input type = "hidden" name = "mem_id" value = <%=mem_id%>> 
			시작 <input type = "date" id = "sch_newStartDate"> 
			<input type = "time" id = "sch_newStartTime"> 
			<input type = "hidden" id = "newStartTotal" name = "sch_startDate"> ~ 
			종료<input type = "date" id = "sch_newEndDate"> 
			<input type = "time" id = "sch_newEndTime">
			<input type = "hidden" id = "newEndTotal" name = "sch_endDate"> <br>
			제목:<input type = "text" name = "sch_title"><br> 
			내용:<input type = "text" name = "sch_content">
		</div>
		<div>
			<input type="submit" value="등록">
		</div>
	</form>
</div>
<div id = "footer">
	<jsp:include page="../footer.jsp" flush="false"/>
</div>
</body>
</html>