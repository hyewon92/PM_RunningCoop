package com.pm.rc.socket;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.websocket.Session;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component(value="wsChat.do")
public class MySocketHandler extends TextWebSocketHandler {
   
   private ArrayList<WebSocketSession> list ; 
   private Map<WebSocketSession,String> map = new HashMap<WebSocketSession,String>();
   
   public MySocketHandler() {
      list = new ArrayList<WebSocketSession>();
   }
   
/*   public Session addSession(Session s, WebSocketSession session, HttpSession sysSession){
	   String mem_id = (String)sysSession.getAttribute("mem_id");
	   String gr_id = (String)sysSession.getAttribute("gr_id");
	   s.getUserProperties().put(mem_id, s);
	   return s;
   }*/
   
   @SuppressWarnings("unchecked")
@Override
   public void afterConnectionEstablished(WebSocketSession session) 
   throws Exception {
      System.out.println("afterConnectionEstablished()");
      super.afterConnectionEstablished(session);
      
      list.add(session);
      System.out.println("client session cnt : "+list.size()); 
      System.out.println("session connected : "+session.getId());
      map.put(session, "");
/*      
      Map<String, Object> mySession = session.getHandshakeAttributes();
      String myGrSession = (String)mySession.get("gr_id");
      String myIdSession = (String)mySession.get("mem_id");
      
      for(WebSocketSession s:list){
    	  Map<String, Object> memSession = session.getHandshakeAttributes();
    	  String gr_id = (String)memSession.get("gr_id");
          String mem_id = (String)memSession.get("mem_id");
          if(myGrSession.equals(gr_id)){
        	  memList.add(mem_id);
          }
      }
      JSONObject obj = new JSONObject();
      obj.put("memList", memList);
      session.sendMessage(new TextMessage(obj.toString()));*/
   }
   
   @Override
   public void handleTextMessage(WebSocketSession session,TextMessage message)
   throws Exception {
      System.out.println("handleTextMessage()");
      String msg = message.getPayload() ; 
      
      Map<String, Object> mySession = session.getHandshakeAttributes();
      String myGrSession = (String)mySession.get("gr_id");
      
      ArrayList<String> memList = new ArrayList<String>();;
      
      if( msg != null && !msg.equals("") ) {
         if(msg.indexOf("#$nick_") > -1 ) {
            map.put(session, msg.replace("#$nick_", ""));
            for(WebSocketSession s : list) {
            	Map<String, Object> sessionMap = s.getHandshakeAttributes();
            	String otherGrSession = (String)sessionMap.get("gr_id");
            	String otherMemSession = (String)sessionMap.get("mem_id");
            	System.out.println("myGrSession="+myGrSession);
            	System.out.println("otherGrSession"+otherGrSession);
               if( s!=session && myGrSession.equals(otherGrSession)) {
                  s.sendMessage(
                  new TextMessage("<font color='red' size='2px'>"+map.get(session)+" 님이 입장했습니다.</font>")
                  );
               }
               if(myGrSession.equals(otherGrSession)){
            	   memList.add(otherMemSession);
               }
            }
            JSONObject obj = new JSONObject();
            obj.put("memList", memList);
            session.sendMessage(new TextMessage(obj.toString()));
         }else {
            for(WebSocketSession s : list) {
            	Map<String, Object> sessionMap = s.getHandshakeAttributes();
            	String otherGrSession = (String)sessionMap.get("gr_id");
            	if(myGrSession.equals(otherGrSession)){
            		String m = "<font color='blue' size='2px'>"+msg+"</font>" ;
            		s.sendMessage(new TextMessage(m));
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
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
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