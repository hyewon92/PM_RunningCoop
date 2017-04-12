package com.pm.rc.model.service;

import java.util.List;

import com.pm.rc.dto.ScheduleDto;

//일정 관련 기능
public interface ScheduleService {

	//팀 일정 조회
	public List<ScheduleDto> teamSchSelect(String pr_id);
	
	//팀 일정 조회
		public List<ScheduleDto> teamSchSelect2(String pr_id);
	
}
