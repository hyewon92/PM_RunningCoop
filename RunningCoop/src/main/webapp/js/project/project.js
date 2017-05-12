/* 업무 수정 폼 채우기  */
	function workEdit(val, val2, val3, val4){
		$(".workInsert_Form").css("display", "none");
		$(".work_Edit_Form").css("display", "block");
		$("#edit_wk_id").val(val);
		$("#input_wk_title").val(val2);
		$("#input_wk_endDate").val(val3);
		$(".input_mem_id").eq(1).val(val4);
	}
	
	/* 업무 수정 폼 닫기 */
	function wkEditClose(){
		$("#edit_wk_id").val("");
		$("#work_Edit_Form").children("input[type=text]").val("").end().children("input[type=date]").val("");
		$("#work_Edit_Form").css("display", "none");
	}
	
	/* 멤버 조회 기능 */
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
				if(nodes.length == 0){
					$("#promem_list").children("fieldset").append("<p>조회 결과가 없습니다.</p>");
				} else {
					for(var i = 0; i < nodes.length; i++){
						var mem_name = nodes[i].MEM_NAME;
						var mem_id = nodes[i].MEM_ID;
						$("#promem_list").children("fieldset")
						.append("<span>"+mem_name+"</span>")
						.append("<input type='button' value='선택' onclick='trans_Memid(\""+mem_id+"\")'/><br>");
					}
				}
			}
		});
	}
	
	/* 멤버 목록 닫기  */
	function memList_Close(){
		$("#promem_list").css("display", "none").children("fieldset").children("legend").siblings().remove();
	}
	
	/* 멤버 아이디 폼에 전송하기 */
	function trans_Memid(val){
		var mem_id = val;
		if ($(".workInsert_Form").css("display") == "block"){
			$(".input_mem_id").eq(0).val(mem_id);
		} else if ($(".workInsert_Form").css("display") == "none"){
			$(".input_mem_id").eq(1).val(mem_id);
		}
		$("#promem_list").css("display", "none").children("fieldset").children("legend").siblings().remove();
	}
	
	/* 업무 추가 폼 표시 */
	function workInsert(){
		$(".work_Edit_Form").css("display", "none");
		$(".workInsert_Form").css("display", "block");
		$(".workInsert_Form").dialog({
			title : "업무 추가",
			height : 300,
			width : 400,
			position : {my : "left bottom", at : "left bottom", of : "#add_work"},
			resizable : false,
			modal : true,
		});
	}
	
	/* 업무 삭제 기능 */
	function workDelete(val){
		var pr_id = $("#pr_id").val();
		location.href="./workDelete.do?pr_id="+pr_id+"&wk_id="+val;
	}