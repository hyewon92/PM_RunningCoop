package com.pm.rc.control;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	public String viewSchedule(int year, int month){
		
		return "schedule/calendar";
	}
	
	//일정입력화면 이동
	@RequestMapping(value = "/writeSchedule.do")
	public String schWrite(int year, int month, int date){
		return "schedule/schWrite";
	}
	
	//일정등록
	@RequestMapping(value = "/insertSchedule.do", method = RequestMethod.POST)
	public String schInsert(ScheduleDto dto){
		boolean isc = scheduleService.schInsert(dto);
		if(isc == false){
			return "schedule/error";
		}else{
			return "schedule/success";
		}
	}
}
