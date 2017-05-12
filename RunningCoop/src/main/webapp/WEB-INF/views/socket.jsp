<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#receive_msg{
		padding: 3px;
		width: 300px;
		height: 360px;
		overflow: auto;
		overflow-x: hidden;
	}
</style>

   <% 
   	String grId = (String)session.getAttribute("gr_id"); 
    String mem_id = (String)session.getAttribute("mem_id"); 
   %>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
      var ws = null ;
      var url = null ;
      var nick = null ; 
      
      $(document).ready(function() {
    	  
            nick = $("#nickName").val();
            $("#receive_msg").html('');
            $("#chat_div").show();
            $("#chat").focus();
            
            ws = new WebSocket("ws://192.168.4.116:8095/RunningCoop/wsChat.do");
            
            ws.onopen = function() {
               ws.send("#$nick_"+nick);
               
            };
            ws.onmessage = function(event) {
            	var msg = event.data;
            	var id = "<%=grId%>";
            	if(msg.startsWith("<font color=")){	//입장,퇴장
	               $("#receive_msg").append(msg+"<br/>");
					viewList(id);
            	}else if(msg.startsWith("[나]")){	//대화내용
            		$("#receive_msg").append($("<div>").text(msg).css("text-align", "right"));
            	}else{
            		$("#receive_msg").append($("<div>").text(msg).css("text-align", "left"));
            	}
            	
            	$("#receive_msg").scrollTop($("#receive_msg")[0].scrollHeight);
            }
            ws.onclose = function(event) {
               alert("채팅방이 삭제됩니다."); 
            }
      
         $("#chat_btn").bind("click",function() {
            if($("#chat").val() == '' ) {
               alert("내용을 입력하세요");
               return ;
            }else {
            	location.href = '#last';
               ws.send(nick+" : "+$("#chat").val());
               $("#chat").val('');
               $("#chat").focus();
            }
         });
      });
      
      window.onbeforeunload = function() {
    	 alert("채팅종료");
	     location.href = "./socketOut.do";
         ws.close();
         ws = null ;
      }
      function disconnect() {
         ws.close();
         ws = null ;
      } 
      
      function viewList(grId){
    	  $("#memList").children().remove();
    	  $.ajax({
    		 type: "POST",
    		 url: "./viewChatList.do",
    		 data: "mem_id="+$("#nickName"),
    		 async: false,
    		 success: function(result){
    			 for(var k in result.list){
 					if(result.list[k]==grId){
						$("#memList").append("<p>"+k+"</p>"); 
					}
    			 }
    		 }
    	  });
      }
      
/*       function closeChat(){
    	  alert("채팅종료");
	      location.href = "./socketOut.do";
      } */
      
/*       function printMemList(memList){
    	  $("#memBox").children("p").remove();
    	  var list = JSON.parse(memList);
    	  for(var i = 0; i < list.memList.length; i++){
    		  $("#memBox").append("<p>"+list.memList[i]+"</p>");
    	  }
      }
       */
</script>
</head>
<body>
   <table border="1">
   <tr>
      <td width="310px" height="370px" align="center">
      <div id="receive_msg" style="border:1px">
      <div id = "last"></div> 
      <input type="hidden" id="nickName" value = <%=mem_id%> />
      </div>
      </td>
   </tr>   
   </table>
   
   <div id="chat_div" style="display:none">
   <div id="memBox">
    <div id = "memList">
   	</div> 
   </div>
   <input type="text" id="chat" size="20"  
          onKeypress="if(event.keyCode==13) $('#chat_btn').click();" />
   <input type="button" id="chat_btn" value="입력"/>          
   </div>
      
</body>
</html>