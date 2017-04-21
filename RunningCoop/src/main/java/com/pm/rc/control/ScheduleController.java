package com.pm.rc.control;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pm.rc.dto.ProjectDto;
import com.pm.rc.dto.ScheduleDto;
import com.pm.rc.model.service.ScheduleService;

@Controller
public class ScheduleController {

	Logger logger = LoggerFactory.getLogger(ScheduleController.class);
	
	@Autowired
	private ScheduleService scheduleService;
	
	//달력 띄우기
	@RequestMapping(value = "/viewSchedule.do")
	public String viewSchedule(HttpSession session, HttpServletRequest req){
		logger.info("viewSchedule실행");
		String mem_id = (String)session.getAttribute("mem_id");
		List<ProjectDto> list = new ArrayList<ProjectDto>();
		list = scheduleService.mySchSelect(mem_id);
		req.setAttribute("list", list);
		logger.info("viewSchedule실행");
		return "schedule/calendar";
	}
	
	//일정 상세정보 조회
	@RequestMapping(value = "/detailSchedule.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, ScheduleDto> mySchView(HttpServletRequest req){
		logger.info("mySchView실행");
		String sch_seq = req.getParameter("sch_seq");
		Map<String, ScheduleDto> map = new HashMap<String, ScheduleDto>();
		ScheduleDto dto = new ScheduleDto();
		dto = scheduleService.mySchView(sch_seq);
		map.put("dto", dto);
		return map;
	}
	
	//일정입력화면 이동
/*	@RequestMapping(value = "/writeSchedule.do")
	public String schWrite(Model model, int year, String month, String date){
		logger.info("schWrite실행");
		String day = year+"-"+month+"-"+date;
		model.addAttribute("day", day);
		return "schedule/schWrite";
	}
	*/
	//일정등록
	@RequestMapping(value = "/insertSchedule.do", method = RequestMethod.POST)
	public String schInsert(ScheduleDto dto){
		logger.info("schInsert실행");
		boolean isc = scheduleService.schInsert(dto);
		if(isc == false){
			return "schedule/error";
		}else{
			String year = dto.getSch_startDate().substring(0, 4);
			String month = dto.getSch_startDate().substring(4, 6);
			return "redirect:/viewSchedule.do?year="+year+"&month="+month;
		}
	}
}
