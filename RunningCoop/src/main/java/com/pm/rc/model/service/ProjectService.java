package com.pm.rc.model.service;

import java.util.List;
import java.util.Map;

import com.pm.rc.dto.MemberDto;
import com.pm.rc.dto.ProjectDto;
import com.pm.rc.dto.WorkListDto;

/** 
 * 프로젝트 관련 기능 인터페이스
 * @author 김혜원
 * */
public interface ProjectService {

	/**
	 * 소속 그룹+내가 참여하는 진행중인 프로젝트(메인) 조회
	 * @param map value:mem_id(회원아이디), gr_id(그룹아이디)
	 * @return List&lt;ProjectDto&gt;
	 * @author 김혜원
	 * */
	public List<ProjectDto> groupProSelect(Map<String, String> map);
	
	/**
	 * 내가 완료한 프로젝트
	 * @param mem_id 회원아이디
	 * @return List&lt;ProjectDto&gt;
	 * @author 김혜원
	 * */
	public List<ProjectDto> myDidPrSelect(String mem_id);
	
	/**
	 * 내가 진행중인 프로젝트
	 * @param mem_id 회원아이디
	 * @return List&lt;ProjectDto&gt;
	 * @author 김혜원
	 * */
	public List<ProjectDto> myDoingPrSelect(String mem_id);
	
	/**
	 * 내가 해야 할 프로젝트
	 * @param mem_id 회원아이디
	 * @return List&lt;ProjectDto&gt;
	 * @author 김혜원
	 * */
	public List<ProjectDto> myTodoPrSelect(String mem_id);
	
	/**
	 * 시스템 전체  프로젝트 조회(검색)
	 * @param pr_name 프로젝트명
	 * @return List&lt;ProjectDto&gt;
	 * @author 김혜원
	 * */
	public List<ProjectDto> allPrSelect(String pr_name);
	
	/**
	 * 프로젝트명으로 검색 
	 * @param pr_name 프로젝트명
	 * @return List&lt;ProjectDto&gt;
	 * @author 김혜원
	 * */
	public List<ProjectDto> prNameSelect(String pr_name);

	/**
	 * 프로젝트 상세정보 조회
	 * @param pr_id 프로젝트 아이디
	 * @return ProjectDto
	 * @author 김혜원
	 * */
	public ProjectDto prDetailSelect(String pr_id);
	
	/**
	 * 프로젝트 생성
	 * @param dto ProjectDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean prInsert(ProjectDto dto);
	
	/**
	 * 프로젝트 수정
	 * @param ProjectDto
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean prModify(ProjectDto dto);
	
	/**
	 * 프로젝트 삭제
	 * @param pr_id 프로젝트아이디
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean prDelete(String pr_id);
	
	/**
	 * 프로젝트 멤버 추가
	 * @param map value:mem_id(회원아이디), pr_id(프로젝트아이디) 
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean prMemInsert(Map<String, String> map);
	
	/**
	 * 프로젝트 멤버 삭제
	 * @param map value:mem_id(회원아이디), pr_id(프로젝트아이디)
	 * @return boolean 
	 * @author 김혜원
	 * */
	public boolean prMemDelete(Map<String, String> map);
	
	/**
	 * 프로젝트 멤버 조회
	 * @param pr_id 프로젝트아이디
	 * @return List&lt;MemberDto&gt;
	 * @author 김혜원
	 * */
	public List<MemberDto> prMemSelect(String pr_id);
	
	/**
	 * 프로젝트 담당자 수정(pr_id, mem_id)
	 * @param map value:pr_id(프로젝트아이디), mem_id(회원아이디)
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean prMgrModify(Map<String, String> map);
	
	/**
	 * 프로젝트 진행률
	 * @param pr_id 프로젝트 아이디
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean prRateModify(String pr_id);
	
}
