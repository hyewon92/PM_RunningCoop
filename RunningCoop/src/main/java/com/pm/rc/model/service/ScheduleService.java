package com.pm.rc.model.service;

import java.util.List;
import java.util.Map;

import com.pm.rc.dto.ScheduleDto;

/**
 * 일정관리 관련 기능 인터페이스
 * @author 김혜원
 * */
public interface ScheduleService {

	/**
	 * 팀 일정 조회
	 * @author 김혜원
	 * */
	public List<ScheduleDto> teamSchSelect(String pr_id);
	
	/**
	 * 개인 일정 조회
	 * @author 김혜원
	 * */
	public List<ScheduleDto> mySchSelect2(String mem_id);
	
	/**
	 * 일정 등록
	 * @author 김혜원
	 * */
	public boolean schInsert(ScheduleDto dto);
	
	/**
	 * 일정 수정(sch_seq, ScheduleDto)
	 * @author 김혜원
	 * */
	public boolean schInsert(Map<String, ScheduleDto> map);
	
	/**
	 * 일정 삭제
	 * */
	public boolean schModify(String seq);
	
}
