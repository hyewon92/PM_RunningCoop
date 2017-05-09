<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#receive_msg{
		padding: 20px;
		width: 500px;
		height: 500px;
		overflow: auto;
		overflow-y: hidden;
	}
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
      var ws = null ;
      var url = null ;
      var nick = null ; 
      
      $(document).ready(function() {
         
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
            
            ws = new WebSocket("ws://192.168.0.150:8095/RunningCoop/wsChat.do");
            ws.onopen = function() {
               ws.send("#$nick_"+nick);
               
            };
            ws.onmessage = function(event) {
            	var msg = event.data;
            	if(msg.startsWith("<font color=")){	//입장,퇴장
	               $("#receive_msg").append(msg+"<br/>");
            	}else if(msg.startsWith("[나]")){	//대화내용
            		$("#receive_msg").append($("<div>").text(msg).css("text-align", "right"));
            	}else{
            		$("#receive_msg").append($("<div>").text(msg).css("text-align", "left"));
            	}
            	
            	$("#receive_msg").scrollTop($("#receive_msg")[0].scrollHeight);
     /*        	else{	//접속자 리스트
	            	printMemList(msg);	
            	} */
            }
            ws.onclose = function(event) {
               alert("채팅방이 삭제됩니다."); 
            }
      
         });
         
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
         ws.close();
         ws = null ;
      }
      function disconnect() {
         ws.close();
         ws = null ;
      } 
      
      function viewList(list){
    	  alert(list.length);
      }
      
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
      <td width="500px" height="500px" align="center">
      <div id="receive_msg" style="border:1px">
      <div id = "last"></div> 
      <input type="text" 
             id="nickName" 
             style="width:200px;height:25px" readonly="readonly" value = <%=session.getAttribute("mem_id") %>
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
   <% 
   	String grId = (String)session.getAttribute("gr_id"); 
   	String memList = (String)session.getAttribute("socket"+grId);
   %>
   	<input type = "button" value = "접속자 리스트 보기" onclick = "viewList(<%=memList%>)">
   </div>
   <input type="text" id="chat" style="width:460px" 
          onKeypress="if(event.keyCode==13) $('#chat_btn').click();" />
   <input type="button" id="chat_btn" value="입력" />          
   </div>
      
</body>
</html>