<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript">
   function openChild(){
      window.open("./showGrCreate.do", "GroupCreate", "width=640, height=450, resizable = no, scrollbars = no");
   }
</script>
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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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
            minLength : 1,
            select : function ( event , ui){
            $("#gr_name").val(ui.item.label);
            }
         });
   });

</script>

<title>Insert title here</title>
</head>
<body>

로그인 성공
<% 
   String userName = (String)session.getAttribute("mem_name"); 
   String userId = (String)session.getAttribute("mem_id");
%>
<%= userName%>님 접속중

<%
   Calendar cal = Calendar.getInstance();
   String year = String.valueOf(cal.get(Calendar.YEAR));
   String month = String.valueOf(cal.get(Calendar.MONTH)+1);
%>
<input type = "button" value = "개인정보 수정" onclick = "location.href='./writeModifyForm.do?mem_id=<%=userId%>'">
<input type = "button" value = "그룹선택(관리)" onclick = "location.href='./myGrSelect.do?mem_id=<%=userId%>'">
<input type = "button" value = "일정보기" onclick = "location.href='./viewSchedule.do?year=<%=year%>&month=<%=month%>'">
<input type = "button" value = "그룹생성" onclick = "openChild()">
<input type = "button" value = "문의게시판" onclick = "location.href = './qnaList.do'"> 
<input type = "button" value = "공지게시판" onclick = "location.href = './noticeList.do'">
<input type = "button" value = "프로젝트" onclick = "location.href = './iProSelect.do'">
<form action="./allGrSelect.do" method="post">
<div class="ui-widget">
   <input type="text" name="gr_name" id="gr_name"/>
   <input type="submit" value="그룹검색"/>
</div>
</form>
<input type = "button" value = "로그아웃" onclick = "location.href='./ckLogout.do'">
</body>
</html>