package com.pm.rc.control;

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

import com.pm.rc.dto.ProjectDto;
import com.pm.rc.model.service.ProjectService;

@Controller
public class ProjectController {
	
	Logger logger = LoggerFactory.getLogger(ProjectController.class);
	
	@Autowired
	private ProjectService service;
	
	// 메인화면에서 그룹 프로젝트 선택하는 화면
	@RequestMapping(value="./gProSelect.do", method=RequestMethod.GET)
	public String grProjectList(Model model, HttpServletRequest request){
		List<ProjectDto> list = null;
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_id", "user1");
		map.put("gr_id", "GR1704110001");
		list = service.groupProSelect(map);
		model.addAttribute("list", list);
		return "gProjectSelect";
	}
	
	

}
