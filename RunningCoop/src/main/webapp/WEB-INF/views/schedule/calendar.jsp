<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.pm.rc.dto.ScheduleDto"%>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#calendar th{
		background-color: aqua;
	} 
	#calendar td{
		background-color: #ffe4c4; 
		height: 80px;
		vertical-align: top;
	}
	a{
		text-decoration: none; 
	}
	#list div{
		background-color: orange;
	}
	.plus{
		width:15px;
		height: 15px;
		float: right;
	}
	.arrow{
		width:30px;
		height:30px;
	}
	b{
		font-size: 30pt;
	}
</style>
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
		return "<a href = './writeSchedule.do?year="+year+"&month="+month+"&date="+date+"'>"
				+"<img class = 'plus' alt = '일정등록' src = 'images/plus.png'>";
	}
	
	//날짜 형식 맞추기(두자리:0x~31)
	public String dateForm(String date){
		return date.trim().length()<2 ? "0"+date:date;
	}
	
	//달력에 일정목록 출력
	public String schListView(int month, int day, List<ScheduleDto> lists){
		String list = "";
		for(ScheduleDto dto:lists){
			int startMonth = Integer.parseInt(dto.getSch_startDate().replace("-", "").substring(4, 6));
			int endMonth = Integer.parseInt(dto.getSch_endDate().replace("-", "").substring(4, 6));
			int startDate = Integer.parseInt(dto.getSch_startDate().replace("-", "").substring(6, 8));
			int endDate = Integer.parseInt(dto.getSch_endDate().replace("-", "").substring(6, 8));
		}
		return "";
	}
%>

<%
	//원하는 달로 이동하기 위해 현재 연도와 달 값 전달받음
	String cyear = request.getParameter("year");
	String cmonth = request.getParameter("month");
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

	<h1>일정관리</h1>
	<table id = "calendar">
		<caption>
			<a href = "./viewSchedule.do?year=<%=year-1%>&month=<%=month%>"><img alt = "이전 년도 이동" class = "arrow" src = "images/bigLeft.png"></a>
			<a href = "./viewSchedule.do?year=<%=year%>&month=<%=month-1%>"><img alt = "이전 월 이동" class = "arrow" src = "images/left.png"></a>
			<b><%=year %>년 <%=month %>월</b>
			<a href = "./viewSchedule.do?year=<%=year%>&month=<%=month+1%>"><img alt = "이전 월 이동" class = "arrow" src = "images/right.png"></a>
			<a href = "./viewSchedule.do?year=<%=year+1%>&month=<%=month%>"><img alt = "이전 월 이동" class = "arrow" src = "images/bigRight.png"></a>		
		</caption>
		<col width="80px"><col width="80px"><col width="80px"><col width="80px">
		<col width="80px"><col width="80px"><col width="80px">
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
					<td style = "color:<%=weekColor(i, dayOfWeek)%>;"><%=i %>
						<% String s_month = dateForm(String.valueOf(month)); %>
						<% String s_i = dateForm(String.valueOf(i)); %>
						<%=schWrite(year, s_month, s_i)%></a>
					</td>
					<%
					//토요일이 되면 줄바꿈
					if((i+dayOfWeek-1)%7==0){
					%></tr><tr>
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

</body>
</html>