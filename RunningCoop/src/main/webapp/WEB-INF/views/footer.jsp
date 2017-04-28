<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>사이드바메뉴</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
   });

</script>
</head>
<body>
<% 
   String userName = (String)session.getAttribute("mem_name"); 
   String userId = (String)session.getAttribute("mem_id");
%>
<input type = "button" value = "그룹선택(관리)" onclick = "location.href='./myGrSelect.do?mem_id=<%=userId%>'">
<input type = "button" value = "문의게시판" onclick = "location.href = './qnaList.do'"> 
<input type = "button" value = "공지게시판" onclick = "location.href = './noticeList.do'">
<input type = "button" value = "프로젝트" onclick = "location.href = './iProSelect.do'">
<form action="./allGrSelect.do" method="post">
<div class="ui-widget">
   <input type="text" name="gr_name" id="gr_name"/>
   <input type="submit" value="그룹검색"/>
</div>
</form>
</body>
</html>