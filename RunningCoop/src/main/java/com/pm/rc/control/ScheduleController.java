package com.pm.rc.control;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

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
	public String viewSchedule(HttpServletRequest req){
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH);
		req.setAttribute("year", year);
		req.setAttribute("month", month);
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
		System.out.println(dto.getSch_startDate());
		boolean isc = scheduleService.schInsert(dto);
		if(isc == false){
			return "schedule/error";
		}else{
			return "schedule/success";
		}
	}
}
