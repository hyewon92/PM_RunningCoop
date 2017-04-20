package com.pm.rc.control;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pm.rc.dto.GroupBoardDto;
import com.pm.rc.dto.GroupDto;
import com.pm.rc.dto.MemberDto;
import com.pm.rc.model.service.GroupService;

//4. dispatcher에 의해 연결된 Class @Controller 생성
@Controller
public class GroupController {
	
	//8. log처리를 위한 logger객체 생성
	Logger logger = LoggerFactory.getLogger(GroupController.class);
	
	// 23. IoC Autowired를 통해 실행되는 Service를 선언
	@Autowired
	private GroupService service;
	
	//5. mapping 메소드
	@RequestMapping(value = "/first.do", method = RequestMethod.GET)
	public String test01(String name , Model model, HttpServletRequest request){
		logger.info("first.jsp 실행");
		
		return "Group/first";
	}
	@RequestMapping(value= "/myGrSelect.do" , method=RequestMethod.GET)
	public String myGrSelect(Model model, HttpServletRequest request){
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_id", request.getParameter("mem_id"));
		System.out.println("여기는되나");
		logger.info("그룹선택 작동됨");
		List<GroupDto> lists = service.myGrSelect(map);
		model.addAttribute("lists" , lists);
		return "Group/test";
		
	}
	@RequestMapping(value="/grselect.do" ,  method=RequestMethod.GET)
	public String grDetailSelect(Model model, HttpServletRequest request){
		Map<String,String> map = new HashMap<String, String>();
		map.put("gr_id", request.getParameter("gr_id"));
		logger.info("그룹정보 띄우기");
		List<Map<String, String>> lists = service.grDetailSelect(map);
		model.addAttribute("grSelect" , lists);
		return "Group/test2";
	}
	
	@RequestMapping(value="/grmodify.do" , method=RequestMethod.GET)
	public String 	grmodifyMove(Model model, HttpServletRequest requestl){
		Map<String,String> map = new HashMap<String, String>();
		map.put("gr_id", requestl.getParameter("gr_id"));
		logger.info("그룹상세정보 띄우기");
		List<Map<String, String>> lists = service.grDetailSelect(map);
		model.addAttribute("grSelect" , lists);
		return "Group/grmodify";
	}
	@RequestMapping(value="/realGrmodify.do", method= RequestMethod.GET)
	public String grmodify (Model model, HttpServletRequest request){
		Map<String, String> map = new HashMap<String, String>();
		map.put("gr_id", request.getParameter("gr_id"));
		map.put("gr_goal", request.getParameter("gr_goal"));
		map.put("gr_searchyn", request.getParameter("gr_searchyn"));
		map.put("gr_joinyn", request.getParameter("gr_joinyn"));
		logger.info("그룹수정 수정입니다");
		service.grModify(map);
		return "Group/grmodify";
	}
	
	@RequestMapping(value="/allGrSelect.do", method=RequestMethod.POST)
	public String allGrSelect (Model model , HttpServletRequest request) {
		logger.info("그룹검색하기 그룹이름이름으로");
		Map<String, String> map = new HashMap<String, String>();
		map.put("gr_name" , request.getParameter("gr_name"));
		List<GroupDto> lists = service.allGrSelect(map);
		model.addAttribute("allGrlists", lists);
		return "Group/grList";
	}
	@RequestMapping(value="/memModi.do" , method=RequestMethod.GET)
	public String grMemSelect(String gr_id , Model model) {
		System.out.println("------------------"+gr_id);
		logger.info("그룹멤버리스트 출력");
		List<MemberDto> lists = service.grMemSelect(gr_id);
		model.addAttribute("memList",lists);
		
		model.addAttribute("grid",gr_id);
		
		List<MemberDto> lists2 = service.grWaitList(gr_id);
		model.addAttribute("grWait" , lists2);
		
		return "Group/memModify";
	}	

@RequestMapping(value="/grListChild.do" , method=RequestMethod.GET)
	public String test (HttpServletRequest req , Model model){
		logger.info("그룹리스트 에서 ");
		System.out.println(":444444444444444444444444444444444444444444444444444444");
		model.addAttribute("grid", req.getParameter("gr_id"));
		return "Group/grListChild";
	}
//	@RequestMapping(value="/MemMultDelete.do" , method=RequestMethod.POST)
//	public String grMemMultDelete (String[] memid , String[] gr_id){
//		logger.info(Arrays.toString(memid));
//		service.grMemMultDelete(memid);
//		return null;
//	}
	
	@RequestMapping(value="/grWaitInsert.do" , method=RequestMethod.POST)
	public boolean grWaitInsert(String mem_id , String gr_id , String wait_content){
		System.out.println(mem_id + "memiddddddddddddddddddddddddddd");
		System.out.println(gr_id+"gridddddddddddddddddddddddddddddd");
		System.out.println(wait_content+"waitcotttttttttttttttttttttttttttttttttt");
		logger.info("그룹가입신척 시작");
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_id", mem_id);
		map.put("gr_id", gr_id);
		map.put("wait_content", wait_content);
		boolean n = service.grWaitInsert(map);
		return n;
	}
	
	@RequestMapping(value="/groupAccept.do" )
	public String grWaitAccept (HttpServletRequest req){
		logger.info("그룹 가입신청 수락 시작");
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_id", req.getParameter("mem_id"));
		map.put("gr_id",req.getParameter("gr_id"));
		boolean n = service.grMemInsert(map);
		
		return "redirect:/memModi.do";
	}
	@RequestMapping(value="/grouprefusal.do")
	public String groupAccept (HttpServletRequest req){
		logger.info("그룹거절 시작");
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_id", req.getParameter("mem_id"));
		service.grMemReject(map);
		
		return "redirect:/memModi.do";
	}
	
	@RequestMapping(value="/gbListSelect.do")
	public String gbListSelect(String gr_id , Model model){
		logger.info("그룹게시판 목록출력");
		List<GroupBoardDto> lists = service.gbListSelect(gr_id);
		model.addAttribute("gblist" , lists);
		return "Group/grboradList";
	}

	
}
