package com.pm.rc.control;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pm.rc.dto.ProjectDto;
import com.pm.rc.model.service.ProjectService;
import com.pm.rc.model.service.WorkListService;

@Controller
public class ProjectController {
	
	Logger logger = LoggerFactory.getLogger(ProjectController.class);
	
	@Autowired
	private ProjectService service;
	
	@Autowired
	private WorkListService wService;
	
	// 메인화면에서 그룹 프로젝트 선택
	@RequestMapping(value="/gProSelect.do", method=RequestMethod.GET)
	public String grProjectList(Model model, HttpServletRequest request){
		List<ProjectDto> list = null;
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_id", "user1");
		map.put("gr_id", "GR1704110001");
		list = service.groupProSelect(map);
		model.addAttribute("list", list);
		return "project/gProjectSelect";
	}
	
	// 메인화면에서 개인 프로젝트 선택
	@RequestMapping(value="/iProSelect.do", method=RequestMethod.GET)
	public String myProjectList(Model model, HttpServletRequest request, HttpSession session){
		List<ProjectDto> list = null;
		String mem_id = (String) session.getAttribute("mem_id");
		list = service.myProSelect(mem_id);
		model.addAttribute("list", list);
		return "project/mProjectSelect";
	}
	
	// 개인 프로젝트 생성화면 연결
	@RequestMapping(value="/createMPro.do", method=RequestMethod.GET)
	public String myProCreateMove(){
		return "project/mProCreate";
	}
	
	// 개인 프로젝트 생성 프로세스
	@RequestMapping(value="/mProCreate.do", method=RequestMethod.POST)
	public String myProCreate(HttpSession session, HttpServletRequest request){
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_id", (String) session.getAttribute("mem_id"));
		map.put("pr_name", request.getParameter("pr_name"));
		map.put("pr_startdate", request.getParameter("pr_startdate"));
		map.put("pr_enddate", request.getParameter("pr_enddate"));
		map.put("pr_goal", request.getParameter("pr_goal"));
		map.put("pr_etc", request.getParameter("pr_etc"));
		boolean isc = false;
		isc = service.iPrInsert(map);
		if(isc){
			System.out.println("개인 프로젝트 등록 성공");
			return "redirect:/iProSelect.do";
		} else {
			System.out.println("개인 프로젝트 등록 실패");
			return "redirect:/createMPro.do";
		}
	}
	
	// 프로젝트 정보 화면
	@RequestMapping(value="/detailPro.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> proDetail(HttpServletRequest request){
		logger.info("proDetail실행");
		String pr_id = request.getParameter("pr_id");
		Map<String, String> map = new HashMap<String, String>();
		map = service.prDetailSelect(pr_id);
		return map;
	}
	
	// 프로젝트 진행화면 이동
	@RequestMapping(value="/goProject.do", method=RequestMethod.GET)
	public String goToProject(Model model, HttpServletRequest request){
		String pr_id = request.getParameter("pr_id");
		
		logger.info("=================== 프로젝트 업무리스트 보기 =======================");
		logger.info("업무리스트를 볼 프로젝트 id :"+pr_id);
		logger.info("===========================================================");
		
		List<Map<String, String>> todo = null;
		List<Map<String, String>> doing = null;
		List<Map<String, String>> done = null;
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("pr_id", pr_id);
		map.put("wk_condition", "todo");
		todo = wService.wkListSelect(map);
		
		map.replace("wk_condition", "doing");
		doing = wService.wkListSelect(map);
		
		map.replace("wk_condition", "done");
		done = wService.wkListSelect(map);
		
		model.addAttribute("todo", todo);
		model.addAttribute("doing", doing);
		model.addAttribute("done", done);
		
		return "project/workList";
	}
	
	
	
	
	
	
	
	
}
