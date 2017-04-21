package com.pm.rc.model.dao;

import java.util.List;

import com.pm.rc.dto.ProjectDto;
import com.pm.rc.dto.ScheduleDto;

/**
 * 일정관리 관련 기능 인터페이스
 * @author 김혜원
 * */
public interface ScheduleDao {
	
	/**
	 * 팀 일정 조회
	 * @param pr_id 프로젝트 아이디
	 * @return List&lt;ScheduleDto&gt;
	 * @author 김혜원
	 * */
	public List<ScheduleDto> teamSchSelect(String pr_id);
	
	/**
	 * 팀 일정 등록
	 * @param dto ScheduleDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean teamSchInsert(ScheduleDto dto);
	
	/**
	 * 개인&팀 일정 조회
	 * @param mem_id 멤버아이디
	 * @return  List&lt;ScheduleDto&gt;
	 * @author 김혜원
	 * */
	public List<ProjectDto> mySchSelect(String mem_id);
	
	/**
	 * 개인 일정 등록
	 * @param dto ScheduleDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean schInsert(ScheduleDto dto);
	
	/**
	 * 일정 수정
	 * @param  dto ScheduleDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean schModify(ScheduleDto dto);
	
	/**
	 * 일정 삭제
	 * @param seq sch_seq(일정번호)
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean schDelete(String seq);

}
