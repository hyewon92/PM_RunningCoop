	$(window).load(function(){
		var wk_id2 = $("#wk_id").val();
		if ( wd_erroryn == 'N'){
			$("#"+wk_id2).next().css("display","none");
		} else {
			$("#"+wk_id2).next().css("display","");
		}

	alramCh = $(val1).children("span").eq(2).html();
	})
/* 업무 상세 페이지 조회 메소드 */
	function viewWork(val, val2){
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
				changeProgress(val2);
			}
		});
		/*Progress bar 생성*/
		 var width = 0;
		 function changeProgress(val){
			 var progress = parseInt(val);
			 var elem = $("#partProgress");
			 var id = setInterval(frame, 10);
			 
			 function frame(){
				 if(width >= progress){
					 clearInterval(id);
				 }else{
					 width+=1;
					 elem.css("width",width+"%");
					 elem.html(width*1+"%");
				 }
			 }
		 }
	}
	
	/* 업무 상세 페이지 - 하위 업무 리스트 출력 */
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
				var erroryn = "";
				var wk_id2 = $("#wk_id").val();
				if ( wd_erroryn == 'N'){
					erroryn = "애로사항 없음";
					$("#"+wk_id2).next().css("display","none");
				} else {
					erroryn = "애로사항 있음";
					$("#"+wk_id2).next().css("display","");
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
				.append("<span style='display: none;'>"+wd_erroryn+"</span>")
				.append("<span>"+erroryn+"</span>/")
				.append("<span>"+wd_endDate+"</span>/")
				.append("<span>"+wd_complyn+"</span>")
				.append("<input type='button' value='완료' onclick='wdComplete("+wd_id+")'/>")
				.append("<input type='button' value='애로사항' onclick='wdError("+wd_id+")'/>")
				.append("<input type='button' value='삭제' onclick='wdDelete("+wd_id+")'/>");
			}
		}
		 
		 /* 댓글 목록 출력 */
		wcomListView()
		/* 첨부파일 목록 출력 */
		attachListView()
		
	}
	
	/* 업무 상세 페이지 - 하위 업무 추가 기능 */
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
	
	/* 업무 상세 페이지 - 하위 업무 수정 폼 출력 */
	function wdEditForm(val){
		var wd_id = $(val).children("span").eq(0).html();
		$(val).siblings("div").remove();
		$(val).after("<div>");
		$(val).siblings("div").append("하위업무내용<input type='textbox' id = 'newWdTitle' name='wd_title' value=''/>")
		.append("마감일자<input type='date' id = 'newWdEndDate' name='wd_endDate' value=''/>")
		.append("<input type='button' value='수정' onclick='wdEdit("+wd_id+")'/>")
		.append("<input type='button' value='취소' onclick='wdEdit_Cancle()'/>");
	}
	
	/* 업무 상세 페이지 - 하위 업무 수정 기능 */
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
	
	/* 업무 상세 페이지 - 하위 업무 수정 폼 닫기 */
	function wdEdit_Cancle(){
		$("#wd_Field").children("div").remove();
	}
	
	/* 업무 상세 페이지 - 하위 업무 완료 기능 */
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
	
	/* 업무 상세 페이지 - 하위 업무 애로사항 표시 기능 */
	function wdError(val1){
		var wd_id = $(val1).children("span").eq(0).html();
		var wd_erroryn = $(val1).children("span").eq(2).html();
		
		var wk_id = $("#wk_id").val();
		$.ajax({
			type : "POST",
			url : "./wdError.do",
			data : {"wd_id": wd_id, "wk_id": wk_id,"wd_erroryn" : wd_erroryn},
			async : false,
			success : function(msg){
				$("#wd_Field").children("p").remove().children("div").remove();
				showWorkDetail(msg)
			}
		});
	}
	
	/* 업무 상세 페이지 - 하위 업무 삭제 기능 */
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
	
	/* 업무 상세 페이지 - 업무 상세 페이지 닫기 */
	function backToProject(){
		var pr_id = $("#pr_id").val();
		location.href="./goProject.do?pr_id="+pr_id;
	}
	
	/* 업무 상세 페이지 - 업무 코멘트 목록 조회 기능 */
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
	
	/* 업무 상세 페이지 - 업무 코멘트 추가 기능 */
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
	
	
	/* 업무 상세 페이지 - 업무 코멘트 목록 출력 기능 */
	function showcommentList(nodes){
		$("#wk_Comment_List").children("table").remove().end().children("p").remove();
		if( nodes.length == 0){
			$("#wk_Comment_List").append("<p>댓글이 없습니다</p>");
		} else {
			$("#wk_Comment_List").append("<table>")
			.children("table").append("<tr><td>작성자</td><td>내용</td><td>작성일</td></tr>");
			for(var i = 0; i < nodes.length; i++){
				var mem_id = nodes[i].MEM_ID;
				var mem_name = nodes[i].MEM_NAME;
				var wcom_content = nodes[i].WCOM_CONTENT;
				var wcom_id = nodes[i].WCOM_ID;
				var wcom_regdate = nodes[i].WCOM_REGDATE;
				if(mem_id == '<%=mem_id%>'){
					$("#wk_Comment_List").children("table")
					.append("<tr><td>"+mem_name+"</td><td>"+wcom_content+"<input type='button' value='수정' onclick='wcom_Edit(this, \""+wcom_id+"\", \""+wcom_content+"\")'/><input type='button' value='삭제' onclick='wcom_Delete(\""+wcom_id+"\")'/></td><td>"+wcom_regdate+"</td></tr>");
				} else {
					$("#wk_Comment_List").children("table")
					.append("<tr><td>"+nodes[i].MEM_NAME+"</td><td>"+nodes[i].WCOM_CONTENT+"</td><td>"+nodes[i].WCOM_REGDATE+"</td></tr>");
				}
			}
		}
		
	}
	
	/* 업무 상세 페이지 - 업무 코멘트 수정 폼 출력 */
	function wcom_Edit(val, val2, val3){
		var wcom_id = val2;
		var wcom_content = val3;
		
		$(val).parents("tr").siblings(".commentEditForm").remove();
		$(val).parents("tr").after("<tr class='commentEditForm'><td><input type='hidden' name='wcom_id' value='"+wcom_id+"'/></td>"+
				"<td><input type='text' name='wcom_content' value='"+wcom_content+"'/>"+
				"<td><input type='button' value='수정' onclick='commentEdit()'</td></tr>");
		
	}
	
	/* 업무 상세 페이지 - 업무 코멘트 수정 기능  */
	function commentEdit(){
		var wk_id = $("#wk_id").val();
		var wcom_id = $(".commentEditForm").eq(0).find("input[name=wcom_id]").val();
		var wcom_content = $(".commentEditForm").eq(0).find("input[name=wcom_content]").val();
		
		$(".commentEditForm").remove();
		$.ajax({
			type : "POST",
			url : "./wcomEdit.do",
			data : {"wk_id": wk_id, "wcom_id": wcom_id, "wcom_content": wcom_content},
			async : false,
			success : function(nodes){
				showcommentList(nodes)
			}
		});
	}
	
	/* 업무 상세 페이지 - 업무 코멘트 삭제 기능 */
	function wcom_Delete(val){
		var wk_id = $("#wk_id").val();
		var wcom_id = val;
		
		$.ajax({
			type : "POST",
			url : "./wcomDelete.do",
			data : {"wk_id":wk_id, "wcom_id":wcom_id},
			async : false,
			success : function(nodes){
				showcommentList(nodes)
			}
		});
	}
	
	/* 업무 상세 페이지 - 첨부 파일 리스트 조회 */
	function attachListView(){
		var wk_id = $("#wk_id").val();
		
		$.ajax({
			type : "POST",
			url : "./attachlist.do",
			data : "wk_id="+wk_id,
			async : false,
			success : function(msg){
				showattachList(msg)
			}
		})
	}
	
	/* 업무 상세 페이지 - 첨부파일 리스트 출력 기능 */
	function showattachList(nodes){
		$("#wk_Attach_List").children("table").remove().end().children("p").remove();
		if(nodes.length == 0){
			$("#wk_Attach_List").append("<p>첨부파일이 없습니다</p>");
		} else {
			for(var i = 0; i < nodes.length; i++){
				var gatt_seq = nodes[i].gatt_seq;
				var gatt_name = nodes[i].gatt_name;
				var gatt_size = nodes[i].gatt_size;
				$("#wk_Attach_List").append("<p><a href='./gbfileDown.do?gatt_seq="+gatt_seq+"'>"+gatt_name+"</a>("+gatt_size+")<input type='button' value='삭제' onclick='attachDelete(\""+gatt_seq+"\")'</p>");
			}
		}
	}
	
	/* 업무 상세 페이지 - 첨부파일 추가 */
	function wkAttach_Insert(val){
		var wk_id = $("#wk_id").val();
		$(val).siblings("input[name=wk_id]").eq(0).val(wk_id);
		
		var formData = new FormData(document.getElementById("file_attach_form"));
		
		$("#file_attach_form").children("input[type=hidden]").val("").end().children("input[type=file]").val("");
		
		$.ajax({
			type : "POST",
			url : "./attachInsert.do",
			data : formData,
			processData : false,
			contentType : false,
			async : false,
			success : function(msg){
				showattachList(msg)
			}
		});
		
	}
	
	/* 첨부파일 삭제 기능 */
	function attachDelete(val){
		var wk_id = $("#wk_id").val();
		$.ajax({
			type : "POST",
			url : "./attachdelete.do",
			data : "gatt_seq="+val+"&wk_id="+wk_id,
			async : false,
			success : function(msg){
				showattachList(msg)
			}
		})
	}