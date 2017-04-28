<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>사이드바메뉴</title>
<%
	String userName = (String) session.getAttribute("mem_name");
	String userId = (String) session.getAttribute("mem_id");
%>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
.ui-autocomplete {
	max-height: 100px;
	overflow-y: auto;
	/* prevent horizontal scrollbar */
	overflow-x: hidden;
}

* html .ui-autocomplete {
	height: 100px;
}
</style>
<script type="text/javascript">
   $(function(){
         $("#gr_name").autocomplete({
            source: function(request , response){
               $.ajax({
                  type:"POST",
                  url: "./autoauto.do",
                  dataType : "json",
                  async : false,
                  data:{ value : request.term},
                  success: function(data) {
                      response(
                                     $.map(data, function(item) {
                                         return {
                                             label: item.gr_name,
                                             value: item.gr_name
                                         }
                                     })
                                 );
            	      }
               });
            },
            minLength : 2,
            select : function ( event , ui){
            $("#gr_name").val(ui.item.label);
            }
         });
         
         $("#pr_name").autocomplete({
             source: function(request , response){
                $.ajax({
                   type:"POST",
                   url: "./autoprcomplete.do",
                   dataType : "json",
                   async : false,
                   data:{ value : request.term},
                   success: function(data) {
                       response(
                                      $.map(data, function(item) {
                                          return {
                                              label: item.pr_name,
                                              value: item.PR_NAME
                                          }
                                      })
                                  );
             	      }
                });
             },
             minLength : 2,
             select : function ( event , ui){
             $("#pr_name").val(ui.item.label);
             }
          });
         
         selectDoingPro();
         selectTodoPro();
         selectDonePro();
   });
   
	function selectDoingPro(){
	  var mem_id = "<%=userId%>";
	  		   
	  $.ajax({
	  	type : "POST",
	  	url : "./selectDoingPro.do",
	  	data : "mem_id="+mem_id,
	  	async : false,
	  	success : function(msg){
	  		$("#doingPro").html("진행중인 프로젝트 <a href='./goDoingSelect.do'>"+msg.DOINGPRO+"</a>건");
	  		},
	  	})
	}
  	   
  	   function selectTodoPro(){
  		   var mem_id = "<%=userId%>";
  		   
  		   $.ajax({
  			   type : "POST",
  			   url : "./selectTodoPro.do",
  			   data : "mem_id="+mem_id,
  			   async : false,
  			   success : function(msg){
  				   $("#todoPro").html("진행예정인 프로젝트 <a href='./goTodoSelect.do'>"+msg.TODOPRO+"</a>건");
  			   }
  		   })
  	   }
  	   
  	   function selectDonePro(){
  		   var mem_id = "<%=userId%>";

		$.ajax({
			type : "POST",
			url : "./selectDonePro.do",
			data : "mem_id=" + mem_id,
			async : false,
			success : function(msg) {
				$("#donePro").html("진행완료인 프로젝트 <a href='./goDoneSelect.do'>" + msg.DONEPRO + "</a>건");
			}
		})
	}
</script>
</head>
<body>

	<input type="button" value="프로젝트선택"
		onclick="location.href = './iProSelect.do'">
	<p id="doingPro"></p>
	<p id="todoPro"></p>
	<p id="donePro"></p>
	<input type="button" value="그룹선택"
		onclick="location.href='./myGrSelect.do?mem_id=<%=userId%>'"><br/>
	<input type="button" value="문의게시판"
		onclick="location.href = './qnaList.do'"><br/>
	<input type="button" value="공지게시판"
		onclick="location.href = './noticeList.do'"><br/>
	<form action="./allGrSelect.do" method="post">
		<div class="ui-widget">
			<input type="text" name="gr_name" id="gr_name" /> <input
				type="submit" value="그룹검색" />
		</div>
	</form>
	<form action="./allPrSelect.do" method="post">
		<div class="ui-widget">
			<input type="text" name="pr_name" id="pr_name" />
			<input type="submit" value="프로젝트 검색"/>
		</div>
	</form>
</body>
</html>