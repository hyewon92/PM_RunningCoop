package com.pm.rc.control;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
		String mem_id = (String)session.getAttribute("mem_id");
		List<ScheduleDto> list = new ArrayList<ScheduleDto>();
		list = scheduleService.mySchSelect(mem_id);
		req.setAttribute("list", list);
		logger.info("viewSchedule실행");
		return "schedule/calendar";
	}
	
	//일정입력화면 이동
	@RequestMapping(value = "/writeSchedule.do")
	public String schWrite(Model model, int year, String month, String date){
		logger.info("schWrite실행");
		String day = year+"-"+month+"-"+date;
		model.addAttribute("day", day);
		return "schedule/schWrite";
	}
	
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
