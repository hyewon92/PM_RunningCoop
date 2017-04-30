/**
 * teamCalendar.jsp 적용
 * @author 김혜원
 */

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
			url : "./detailTeamSchedule.do",
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
		var pr_name = schedule.dto.projectDto.pr_name;
		var sch_startDate = schedule.dto.sch_startDate;
		var sch_endDate = schedule.dto.sch_endDate;
		var sch_title = schedule.dto.sch_title;
		var sch_content = schedule.dto.sch_content;
		
		$("#sch_seq").val(sch_seq);
		$("#sch_startDate").text("시작:"+sch_startDate);
		$("#sch_endDate").text("종료:"+sch_endDate);
		$("#sch_title").text(pr_name+":"+sch_title);
		$("#sch_content").text(sch_content);
			
		$(".scheduleBox").css("display", "none");
		$(".detailBox").css("display", "block");
		$(".scheduleModiBox").css("display", "none");
		$(".listBox").css("display", "block");
	}
	
	//일정 삭제
	function goDelete(){
		var sch_seq = $("#sch_seq").val();
		var pr_id = $("#pr_id").val();
		if(confirm("정말로 삭제하시겠습니까?")){
			location.href = "./deleteTeamSchedule.do?pr_id="+pr_id+"&sch_seq="+sch_seq;
		}
	}
	
	//일정 수정 폼 활성화
	function goModify(){
		$("#sch_upSeq").val($("#sch_seq").val());
		$("#upPr_id").val($("#pr_id").val());
		$("#sch_upStartDate").val($("#sch_startDate").text().substring(3,13));
		$("#sch_upStartTime").val($("#sch_startDate").text().substring(14));
		$("#sch_upEndDate").val($("#sch_endDate").text().substring(3,13));
		$("#sch_upEndTime").val($("#sch_endDate").text().substring(14));
		$("#sch_upTitle").val($("#sch_title").text());
		$("#sch_upContent").val($("#sch_content").text());
		
		$(".scheduleModiBox").css("display", "block");
		$(".scheduleBox").css("display", "none");
		$(".scheduleDetailBox").css("display", "none");
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
			if($("#newStartTotal").val()==""||$("#newEndTotal").val()==""||$("#newStartTotal").val()>$("#newEndTotal").val()){
				return false;
			}
		});
		
		//일정 수정
 		$(".scheduleModiBox").submit(function(){
			var upStartTotal = $("#sch_upStartDate").val()+" "+$("#sch_upStartTime").val();
			$("#upStartTotal").val(upStartTotal);
			var upEndTotal = $("#sch_upEndDate").val()+" "+$("#sch_upEndTime").val();
			$("#upEndTotal").val(upEndTotal);
			if($("#upStartTotal").val()==""||$("#upEndTotal").val()==""||$("#upStartTotal").val()>$("#upEndTotal").val()){
				return false;
			}
		}); 
	});