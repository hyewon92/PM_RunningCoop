<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
   <script type="text/javascript" 
         src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
   <script type="text/javascript">
      var ws = null ;
      var url = null ;
      var nick = null ; 
      
      $(document).ready(function() {
         
         $("#nickName").focus();
         
         $("#join_room").bind("click",function() {
            if($("#nickName").val() == '') {
               alert("닉네임을 입력하세요!!");
               $("#nickName").focus();
               return ;       
            }
            nick = $("#nickName").val();
            $("#receive_msg").html('');
            $("#chat_div").show();
            $("#chat").focus();
            
            ws = new WebSocket("ws://172.30.1.12:8095/RunningCoop/wsChat.do");
            ws.onopen = function() {
               ws.send("#$nick_"+nick);
               
            };
            ws.onmessage = function(event) {
            	var msg = event.data;
            	if(msg.startsWith("<font color=")){
	               $("#receive_msg").append(msg+"<br/>");
            	}else{
	            	printMemList(msg);
            	}
            }
            ws.onclose = function(event) {
               alert("서버와의 연결이 종료되었습니다."); 
            }
      
         });
         
         $("#chat_btn").bind("click",function() {
            if($("#chat").val() == '' ) {
               alert("내용을 입력하세요");
               return ;
            }else {
               ws.send(nick+" : "+$("#chat").val());
               $("#chat").val('');
               $("#chat").focus();
            }
         });
      });
      
      window.onbeforeunload = function() {
         ws.close();
         ws = null ;
      }
      function disconnect() {
         ws.close();
         ws = null ;
      } 
      
      function printMemList(memList){
    	  var list = JSON.parse(memList);
    	  for(var i = 0; i < list.memList.length; i++){
    		  $("#memBox").append(list.memList[i]+"<br/>");
    	  }
      }
      
   </script>
</head>
<body>
   <table border="1">
   <tr>
      <td width="500px" height="500px" align="center">
      <div id="receive_msg" style="border:1px"> 
      <input type="text" 
             id="nickName" 
             style="width:200px;height:25px" value = <%=session.getAttribute("mem_id") %>
            onKeypress="if(event.keyCode==13) $('#join_room').click();" />
      &nbsp;
      <input type="button" value="대화방 입장" id="join_room">      
      </div>
      </td>
   </tr>   
   </table>
   <br/><br/><br/>
   
   <div id="chat_div" style="display:none">
   <div id="memBox">
   </div>
   <input type="text" id="chat" style="width:460px" 
          onKeypress="if(event.keyCode==13) $('#chat_btn').click();" />
   <input type="button" id="chat_btn" value="입력" />          
   </div>
      
</body>
</html>