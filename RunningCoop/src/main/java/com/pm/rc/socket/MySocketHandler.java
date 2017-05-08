package com.pm.rc.socket;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.websocket.Session;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component(value="wsChat.do")
public class MySocketHandler extends TextWebSocketHandler {
	
	Logger logger = LoggerFactory.getLogger(MySocketHandler.class);
   
   private ArrayList<WebSocketSession> list ; 
   private Map<WebSocketSession,String> map = new HashMap<WebSocketSession,String>();
   private ArrayList<String> memList;
   
   public MySocketHandler() {
      list = new ArrayList<WebSocketSession>();
   }
   
   @Override
   public void afterConnectionEstablished(WebSocketSession session) 
   throws Exception {
      logger.info("afterConnectionEstablished()실행");
      super.afterConnectionEstablished(session);
      
      list.add(session);	//전체 접속자 리스트에 새로운 접속자 추가
      System.out.println("client session cnt : "+list.size()); 
      System.out.println("session connected : "+session.getId());
      map.put(session, "");
   }
   
   @Override
   public void handleTextMessage(WebSocketSession session,TextMessage message)
   throws Exception {
	  logger.info("handleTextMessage()실행");
      String msg = message.getPayload();
      String txt = "";
      
      Map<String, Object> mySession = session.getHandshakeAttributes();	//WebsocketSession의 session값을 httpSesssion값으로 변경
      String myGrSession = (String)mySession.get("gr_id");	//접속자의 그룹 아이디
      memList = new ArrayList<String>();	//그룹 접속자 리스트
      
      if( msg != null && !msg.equals("") ) {
         if(msg.indexOf("#$nick_") > -1 ) {
            map.put(session, msg.replace("#$nick_", ""));
            
            for(WebSocketSession s : list) {	
            	Map<String, Object> sessionMap = s.getHandshakeAttributes();
            	String otherGrSession = (String)sessionMap.get("gr_id");
            	String otherMemSession = (String)sessionMap.get("mem_id");
            	logger.info("myGrSession="+myGrSession);
            	logger.info("otherGrSession="+otherGrSession);
               if(myGrSession.equals(otherGrSession)) {	//같은 그룹 소속일 때
                  s.sendMessage(
                  new TextMessage("<font color='red' size='2px'>"+map.get(session)+" 님이 입장했습니다.</font>")
                  );
                  memList.add(otherMemSession);	
               }
            }
            for(WebSocketSession s2 : list){	//그룹 접속자 리스트 보내기
            	JSONObject obj = new JSONObject();
            	obj.put("memList", memList);
            	s2.sendMessage(new TextMessage(obj.toString()));
            }
         }else {
        	 String msg2 = msg.substring(0, msg.indexOf(":")).trim();
            for(WebSocketSession s : list) {
            	Map<String, Object> sessionMap = s.getHandshakeAttributes();
            	String otherGrSession = (String)sessionMap.get("gr_id");
            	String myMemSession = (String)sessionMap.get("mem_id");
            	if(myGrSession.equals(otherGrSession)){
            		if(msg2.equals(myMemSession)){
            			msg = msg.replace(msg.substring(0, msg.indexOf(":")).trim(),"나");
            			txt = "<font color='pink' size='2px' style = 'float : right;'>"+msg+"</font>" ;
            		}else{
            			System.out.println("멤버에게");
            			txt = "<font color='black' size='2px' style = 'float : left;'>"+msg+"</font>" ;
            		}
            		s.sendMessage(new TextMessage(txt));
            	}
            }
         }
      }
   }
   
   @Override
   public void afterConnectionClosed(WebSocketSession session,CloseStatus status)
   throws Exception {
      super.afterConnectionClosed(session, status);
      Map<String, Object> mySession = session.getHandshakeAttributes();
      String myGrSession = (String)mySession.get("gr_id");
      list.remove(session);
      SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-DD HH24:MI:SS");
      String now = sdf.format(new Date());
      for(WebSocketSession a : list) {
    	  Map<String, Object> sessionMap = a.getHandshakeAttributes();
    	  String otherGrSession = (String)sessionMap.get("gr_id");
    	  if(myGrSession.equals(otherGrSession)){
    		  a.sendMessage(new TextMessage("<font color='blue' size='2px'>"+map.get(session)+"님이 퇴장했습니다 ("+now+")</font>"));
    	  }
      }
      map.remove(session);
   }
   
}