/* 업무 수정 폼 채우기  */
	function workEdit(val, val2, val3, val4){
		$(".workInsert_Form").css("display", "none");
		$(".work_Edit_Form").css("display", "block");
		$("#edit_wk_id").val(val);
		$("#input_wk_title").val(val2);
		$("#input_wk_endDate").val(val3);
		$(".input_mem_id").eq(1).val(val4);
		$(".work_Edit_Form").dialog({
			modal : true,
			title : "업무 수정",
			height : 300,
			position : {my : "center", at : "center"},
			resizable : false
		});
		
	}
	
	/* 업무 수정 폼 닫기 */
	function wkEditClose(){
		$("#edit_wk_id").val("");
		$("#work_Edit_Form").children("input[type=text]").val("").end().children("input[type=date]").val("");
		$("#work_Edit_Form").css("display", "none");
	}
	
	/* 멤버 조회 기능 */
	/*function searchMem(){
		$(".promem_list").css("display", "block");
		var pr_id = $("#pr_id").val();
		
		$.ajax({
			type : "POST",
			url : "./searchmem.do",
			data : "pr_id="+pr_id,
			async : false,
			success : function(nodes){
				$("#promem_list_insert").children("fieldset").children("p").remove();
				if(nodes.length == 0){
					$("#promem_list").children("fieldset").append("<p>조회 결과가 없습니다.</p>");
				} else {
					for(var i = 0; i < nodes.length; i++){
						var mem_name = nodes[i].MEM_NAME;
						var mem_id = nodes[i].MEM_ID;
						$("#promem_list_insert").children("fieldset")
						.append("<span>"+mem_name+"</span>")
						.append("<input type='button' value='선택' onclick='trans_Memid(\""+mem_id+"\")'/><br>");
					}
				}
			}
		});
	}*/
	
	/* 멤버 목록 닫기  */
	function memList_Close(){
		$("#promem_list").css("display", "none").children("fieldset").children("legend").siblings().remove();
	}
	
	/* 멤버 아이디 폼에 전송하기 */
	function trans_Memid(val){
		$("#insert_mem_id").val(val);
	}
	
	/* 업무 추가 폼 표시 */
	function workInsert(){
		$(".work_Edit_Form").css("display", "none");
		$(".workInsert_Form").css("display", "block");
		var pr_id = $("#pr_id").val();
		$.ajax({
			type : "POST",
			url : "./searchmem.do",
			data : "pr_id="+pr_id,
			async : false,
			success : function(nodes){
				$("#promem_list_insert").children("fieldset").children("p").remove();
				if(nodes.length == 0){
					$("#promem_list_insert").children("table")
					.append("<tr><td colspan='2'>조회 결과가 없습니다</td></tr>")
				} else {
					for(var i = 0; i < nodes.length; i++){
						var mem_name = nodes[i].MEM_NAME;
						var mem_id = nodes[i].MEM_ID;
						$("#promem_list_insert").children("table")
						.append("<tr><td><span>"+mem_name+"</span></td>" +
								"<td><input type='button' value='선택' class='body_btn workInsert_mem_btn' onclick='trans_Memid(\""+mem_id+"\")'/></td></tr>");
					}
				}
			}
		});
		$(".workInsert_Form").dialog({
			title : "업무 추가",
			height : 350,
			width : 650,
			position : {my : "center", at : "center"},
			resizable : false,
			modal : true,
		});
	}
	
	/* 업무 삭제 기능 */
	function workDelete(val){
		var pr_id = $("#pr_id").val();
		location.href="./workDelete.do?pr_id="+pr_id+"&wk_id="+val;
	}