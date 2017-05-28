package com.pm.rc.control;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletConfigAware;

import com.pm.rc.dto.GroupBoardDto;
import com.pm.rc.dto.GroupDto;
import com.pm.rc.dto.MemberDto;
import com.pm.rc.dto.PagingDto;
import com.pm.rc.model.service.GroupService;
import com.pm.rc.model.service.ManagerService;

//4. dispatcher에 의해 연결된 Class @Controller 생성
@Controller
public class GroupController implements ServletConfigAware {
	
	/**
	 * 채팅에 관련된 정보를 담기 위해 Application 객체 생성
	 */
	private ServletContext servletContext;
	
	public String createUUID(){
		return UUID.randomUUID().toString();
	}
	
	//8. log처리를 위한 logger객체 생성
	Logger logger = LoggerFactory.getLogger(GroupController.class);
	
	private String GroupId = "";
	
	// Group 서비스
	@Autowired
	private GroupService service;
	// ManaGer 서비스
	
	@Autowired
	private ManagerService managserService;
	// Mail 서비스
	@Autowired
	private JavaMailSender mailSend;
	
	/*
	 *Application 객체를 사용하기 위해 객체를 담아줌
	 * */
	@Override
	public void setServletConfig(ServletConfig servletConfig) {
		servletContext = servletConfig.getServletContext();
	}
	
	// 그룹선택 초기 화면 
	@RequestMapping(value= "/myGrSelect.do" , method=RequestMethod.GET)
	public String myGrSelect(Model model, HttpServletRequest request ,HttpSession session){
		
		session.removeAttribute("gr_level");
		session.removeAttribute("gr_id");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_id", request.getParameter("mem_id"));
		logger.info("=================== 그룹 선택 화면 이동 =======================");
		
		List<GroupDto> lists = service.myGrSelect(map);
		List<GroupDto> watiLists = service.waitGrSelect(map);
		
		model.addAttribute("lists" , lists);
		model.addAttribute("watiLists" , watiLists);
		
		return "Group/myGrSelect";
	}
	
	//그룹선택하여 정보 확인 및 그룹관리 화면
	@RequestMapping(value="/grselect.do", method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody	
	public Map<String, String> grDetailSelect(Model model, HttpServletRequest request){
		Map<String,String> map = new HashMap<String, String>();
		map.put("gr_id", request.getParameter("gr_id"));
		logger.info("그룹정보 띄우기");
		Map<String, String> map2 = new HashMap<String, String>();
		map2 = service.grDetailSelect(map);
		
		return map2;
	}
	
	// 승인대기 그룹 삭제후 다시 승인대기 그룹 뿌려주는 메소드
	@RequestMapping(value="/waitGrSelect.do", method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public boolean waitGrSelect(Model model , HttpServletRequest req){
		String gr_id = req.getParameter("gr_id");
		boolean isc = false;
		isc = service.waitGrSelectDelete(gr_id);
			return isc;
	}
	//그룹관리 화면
	@RequestMapping(value="/grmodify.do" , method=RequestMethod.GET)
	public String 	grmodifyMove(Model model, HttpServletRequest requestl){
		Map<String,String> map = new HashMap<String, String>();
		map.put("gr_id", requestl.getParameter("gr_id"));
		logger.info("그룹상세정보 띄우기");
//		List<Map<String, String>> lists = service.grDetailSelect(map);
		Map<String, String> lists = service.grDetailSelect(map);
		System.out.println(lists.get("GR_ID")+"ffffffffffffffffffffffffffff");
		model.addAttribute("grSelect" , lists);
		return "Group/grInformationModify";
	}
	//그룹 정보 수정 하는 곳
	@RequestMapping(value="/realGrmodify.do", method= RequestMethod.POST)
	public String grmodify (Model model, HttpServletRequest request){
		String retrGrid = request.getParameter("gr_id");
		
		System.out.println("grrrrrrrrrrrrrrrrrrrrrrrrrrrridddddddddddddddddddddddddddddddddddddddddddddddd"+retrGrid);
		Map<String, String> map = new HashMap<String, String>();
		map.put("gr_id", request.getParameter("gr_id"));
		map.put("gr_goal", request.getParameter("gr_goal"));
		map.put("gr_searchyn", request.getParameter("gr_searchyn"));
		map.put("gr_joinyn", request.getParameter("gr_joinyn"));
		logger.info("그룹수정 수정입니다");
		service.grModify(map);
		return "redirect:/grmodify.do?gr_id="+retrGrid;
	}
	
	// 그룹으로 검색하여 페이징처리 그리고 그룹 검색하는 곳
	@RequestMapping(value="/allGrSelect.do", method={RequestMethod.POST ,RequestMethod.GET})
	public String allGrSelect (Model model , HttpServletRequest request,String gr_name) {
		PagingDto paging = new PagingDto(request.getParameter("index"),
									     request.getParameter("pageStartNum"),
									     request.getParameter("listCnt"),
									     gr_name);
		
		List<GroupDto> lists = service.selectPaging(paging);
		paging.setTotal(service.selectTotalPaging(request.getParameter("gr_name")));
		logger.info("그룹검색하기 그룹이름이름으로");
		String grid = request.getParameter("gr_name");
		model.addAttribute("lists",lists);
		model.addAttribute("paging",paging);
		model.addAttribute("gr_name",grid);
		lists.forEach(System.err::println);
		return "Group/grSeachList";
	}
	// 멤버 관리 화면
	@RequestMapping(value="/memModi.do" , method={RequestMethod.GET,RequestMethod.POST})
	public String grMemSelect(String gr_id,Model model) {
		System.out.println("------------------"+gr_id);
		logger.info("그룹멤버리스트 출력");
		List<MemberDto> lists = service.grMemSelect(gr_id);
		model.addAttribute("memList",lists);
		model.addAttribute("grid",gr_id);
		List<MemberDto> lists2 = service.grWaitList(gr_id);
		model.addAttribute("grWait" , lists2);
		
		return "Group/memModify";	
	}	

	// 그룹 가입신청화면으로 연결
	@RequestMapping(value="/grListChild.do" , method=RequestMethod.GET)
	public String test (HttpServletRequest req , Model model){
		logger.info("그룹리스트 에서 ");
		model.addAttribute("grid", req.getParameter("gr_id"));
		return "Group/grJoinRequest";
	}
	
	// 그룹 가입신청 시작
	@RequestMapping(value="/grWaitInsert.do" , method={RequestMethod.POST,RequestMethod.GET})
	public String grWaitInsert(String memid , String grid , String wait_content, String gr_name, Model model){
		logger.info("그룹가입신척 시작");
		System.out.println(memid+"멤아디"+grid+"지알아디"+wait_content+"자기소개"+"gr_name"+gr_name);
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_id", memid);
		map.put("gr_id", grid);
		map.put("wait_content", wait_content);
		boolean n = service.grWaitInsert(map);
		model.addAttribute("result", n);
		if(n=true){
			return "redirect:/allGrSelect.do?gr_name="+gr_name;
		}else{
			return "account/error/error";
		}
		
	}
	// 그룹가입신척 수락하는곳
	@RequestMapping(value="/groupAccept.do" )
	public String grWaitAccept (HttpServletRequest req){
		String grid = req.getParameter("gr_id");
		logger.info("그룹 가입신청 수락 시작");
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_id", req.getParameter("mem_id"));
		map.put("gr_id",req.getParameter("gr_id"));
		boolean n = service.grMemInsert(map);
		
		return "redirect:/memModi.do?gr_id="+grid;
	}
	
	// 그룹가입신청 거절
	@RequestMapping(value="/grouprefusal.do")
	public String groupAccept (HttpServletRequest req){
		String gr_id = req.getParameter("gr_id");
		logger.info("그룹거절 시작");
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_id", req.getParameter("mem_id"));
		map.put("gr_id",req.getParameter("gr_id"));
		boolean n = service.grMemReject(map);
		
		return "redirect:/memModi.do?gr_id="+gr_id;
	}
	
	// 그룹 게시판 목록 출력함
	@RequestMapping(value="/gbListSelect.do")
	public String gbListSelect(String gr_id , Model model){
		logger.info("그룹게시판 목록출력");
		GroupId = gr_id;
		List<GroupBoardDto> lists = service.gbListSelect(gr_id);
		model.addAttribute("gblist" , lists);
		return "Group/grboradList";
	}
	
	// 그룹 게시글 다중삭제
	@RequestMapping(value="/bordeMultDelet.do" ,method=RequestMethod.GET)
	public String grbdMultDelet(String[] cnkUuid ){
		logger.info("그룹게시판 다중삭제");
		service.gboardDelete(cnkUuid);
		
		return "redirect:/gbListSelect.do?gr_id="+GroupId;
	}
	
	//그룹 생성으로 연결합니다
	@RequestMapping(value="/showGrCreate.do")
	public String groupCreateChilde(){
		return "redirect:/myGrSelect.do";
	}
	
	// 그룹 생성시작
	@RequestMapping(value="/groupCreate.do" , method=RequestMethod.POST)
	public String grCreate(Map<String, String> map , HttpServletRequest req , Model model){
		logger.info("그룹생성 시작");
		Date date = new Date();
	      SimpleDateFormat dateForm = new SimpleDateFormat("yyMMdd");
	      String id_1 = "GR";
	      String id_2 = dateForm.format(date).toString();
	      String uuid = createUUID();
	      System.out.println(uuid);
	      String id_3 = uuid.substring(uuid.lastIndexOf("-")+9);
	      System.out.println(id_3);
	      String gr_id = id_1+id_2+id_3;
	      
	      System.out.println("================================");
	      System.out.println(req.getParameter("gr_joinyn")+"|||||"+req.getParameter("gr_searchyn")+"||"+req.getParameter("gr_img"));
	      System.out.println(gr_id);
	      System.out.println("================================");
	      
	      map.put("gr_id", gr_id);
	      map.put("gr_name", req.getParameter("gr_name"));
	      map.put("gr_goal", req.getParameter("gr_goal"));
	      map.put("mem_id", req.getParameter("mem_id"));
	      map.put("gr_img",req.getParameter("gr_img"));
	      map.put("gr_searchyn",req.getParameter("gr_searchyn"));
	      map.put("gr_joinyn",req.getParameter("gr_joinyn"));
	      
	      boolean n = service.grInsert(map);
	   
			model.addAttribute("result", n);
			if(n=true){
				return "redirect:/myGrSelect.do";
			}else{
				return "account/error/error";
			}
	      
	}
	
	
	//오토컴플리트 처리
	@RequestMapping(value="/autoauto.do" , method=RequestMethod.POST)
	@ResponseBody
	public List<GroupDto> autoTest (String value){
		Map<String, String> map = new HashMap<String, String>();
		System.err.println("ㅎㅎ2");
		map.put("gr_name", value);
		System.out.println(map.get("gr_name"));
		List<GroupDto> lists = service.allGrSelect(map);
		return lists;
	}
	
	// 그룹삭제 
	@RequestMapping(value="/groupDelete.do" , method=RequestMethod.GET)
	public String groupDelete(String gr_id,HttpSession session){
		logger.info("그룹삭제 시작합니다");
		boolean isc = false;
		isc = service.groupDelete(gr_id);
			if(isc=true){
				return "account/loginAfter";
			}else{
				return "account/error/error";
			}
	}
	//그룹멤버 삭제
	@RequestMapping(value="/groupMemDelete.do" , method=RequestMethod.GET)
	public String groupMemDelete(String gr_id , String memID){
		logger.info("그룹멤버 삭제하기 시작합니다 ");
		System.out.println("memID " + memID);
		System.out.println("grID " + gr_id);
		Map<String, String> map = new HashMap<String, String>();
		map.put("gr_id", gr_id);
		map.put("mem_id", memID);
		boolean isc = false;
		isc = service.grMemDelete(map);
		return "redirect:/memModi.do?gr_id="+gr_id;
	}
	// 회원가입 후에 그룹가입신청 연결
	@RequestMapping(value="/groupGoGo.do")
	public String groupGoGo(){
		return "account/grGogo";
	}
	
	// WebSocket 채팅 접속했을 때
	@RequestMapping(value="/socketOpen.do" , method=RequestMethod.GET)
	public String socketOpen(HttpSession session, Model model){
		logger.info("socketOpen 소켓 화면 이동 1)리스트에 접속자 값 넣기");
		String mem_id = (String)session.getAttribute("mem_id");
		String gr_id = (String)session.getAttribute("gr_id");
		//GrChatMemberDto chatDto = new GrChatMemberDto();
		//servletContext.setAttribute(mem_id, chatDto);
		//ArrayList<String> chatList = (ArrayList<String>)servletContext.getAttribute("chatList");
		System.out.println("servletContext.getAttribute()::::::::::::::"+servletContext.getAttribute("chatList"));
		HashMap<String, String> chatList = (HashMap<String, String>)servletContext.getAttribute("chatList");
		if(chatList == null){
			chatList = new HashMap<String, String>();
			chatList.put(mem_id, gr_id);
			servletContext.setAttribute("chatList", chatList);
		}else{
			chatList.put(mem_id, gr_id);
			servletContext.setAttribute("chatList", chatList);
		}
		logger.info("socketOpen 소켓 화면 이동 2)리스트 값 전달");
		//model.addAttribute("chatList", chatList);
		
		return "socket";
	}
	
	//WebSocket 채팅 종료했을 때
	@RequestMapping(value = "/socketOut.do", method={RequestMethod.GET, RequestMethod.POST})
	public void socketOut(HttpSession session, Model model){
		logger.info("socketOut 소켓에서 나오기");
		String mem_id = (String)session.getAttribute("mem_id");
		HashMap<String, String> chatList = (HashMap<String, String>)servletContext.getAttribute("chatList");
		System.out.println("기존 접속 회원 리스트:"+chatList);
		if(chatList != null){
			chatList.remove(mem_id);
		}
		System.out.println("갱신 후 접속 회원 리스트:"+chatList);
		servletContext.setAttribute("chatList", chatList);
		
	}
	
	//채팅 접속자 리스트 출력
	@RequestMapping(value = "/viewChatList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Map<String, String>> viewChatList(){
		Map<String, Map<String, String>> map = new HashMap<String, Map<String, String>>();
		Map<String, String> chatList = (HashMap<String, String>)servletContext.getAttribute("chatList");
		System.out.println("ajax확인::::::::::::::::::::::::::"+chatList);
		String msg = chatList.get("user12");
		System.out.println(msg);
		map.put("list", chatList);
		return map;
	}
	
	@RequestMapping(value="/socketOpen2.do" , method=RequestMethod.GET)
	public String socketOpen2(){
		logger.info("socketOpen 소켓 화면 이동 2");
		return "socket2";
	}
	@RequestMapping(value="/createGrManagerCh.do",method=RequestMethod.GET)
	public String createGrManagerCh(String mem_id, Model model, HttpSession session){
		model.addAttribute("mem_id",mem_id);
		String gr_id = (String)session.getAttribute("gr_id");
		List<MemberDto> lists = service.grMemSelect(gr_id);
		model.addAttribute("memlists" , lists);
		
		return "Group/grManagerChange";
	}
	
	//그룹 관리자 위임
	@RequestMapping(value="/grMgChange.do", method=RequestMethod.GET)
	public String grMgChange(HttpServletRequest req, HttpSession session){
		Map<String, String> map = new HashMap<String, String>();
		String gr_id = (String)session.getAttribute("gr_id");
		String mem_id = req.getParameter("mem_id");
		String mem_id2 = req.getParameter("mem_id2");
		
		boolean isc = false;
		isc = service.grManagerChange(mem_id);
		isc = service.grManagerChange2(mem_id2);
		
		if(isc==true){
			return "redirect:/grmodify.do?gr_id="+gr_id;
		}else{
			return "no";
		}
	}
	
	// 그룹 중복가입 처리
	@RequestMapping(value="/grCheck.do" , method=RequestMethod.POST)
	@ResponseBody
	public int grCheck(HttpServletRequest req, Model model){
		logger.info("grCheck 시작");
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_id", req.getParameter("mem_id"));
		map.put("gr_id", req.getParameter("gr_id"));
		int n = service.groupCheck(map);
		return n;
	}
	
	@RequestMapping(value="/grNameCk.do", method=RequestMethod.POST)
	@ResponseBody
	public int grNameCk(HttpServletRequest req){
		logger.info("=========그룹생성 신청 그룹이름 중복체크 시작 ========");
		int n = service.grNameCheck(req.getParameter("gr_name"));
		return n;
	}
	
	@RequestMapping(value="/grBoradList.do" , method=RequestMethod.GET)
	public String grBoradList(String gr_id, Model model){
		logger.info("=========그룹게시판 목록 시작 ========");
		String gr = gr_id;
		System.out.println("그룹아이디 받아옴 값="+gr);
		List<Map<String, String>> lists = service.grBoradList(gr_id);
		model.addAttribute("grlists", lists);		
		return "Group/grBorad";
	}
	
	@RequestMapping(value="groupImg.do", method=RequestMethod.POST)
	@ResponseBody
	public int groupImgCk (String gr_id){
		logger.info("=========그룹선택시 이미지 출력 시작 ========");
		int n = service.groupImg(gr_id);
//		List<GroupDto> lists = service.groupImg(gr_id);
//		System.out.println("asdfasdfasdf"+lists.get(0).getGr_img());
	return n;	
	}
	
}
