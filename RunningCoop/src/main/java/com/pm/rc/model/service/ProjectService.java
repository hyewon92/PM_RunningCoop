package com.pm.rc.model.service;

import java.util.List;
import java.util.Map;

import com.pm.rc.dto.MemberDto;
import com.pm.rc.dto.ProjectDto;
import com.pm.rc.dto.WorkListDto;

public interface ProjectService {

	/**
	 * 소속 그룹+내가 참여하는 진행중인 프로젝트(메인) 조회
	 * @param map value:mem_id(회원아이디), gr_id(그룹아이디)
	 * @return List&lt;ProjectDto&gt;
	 * @author 김혜원
	 * */
	public List<ProjectDto> groupProSelect(Map<String, String> map);
	
	/**
	 * 개인 사용자가 소속되어있는 프로젝트 (진행중) 를 조회 (메인) o
	 * @param String mem_id 회원 아이디
	 * @return List&lt;ProjectDto&gt;
	 * @author 라한솔
	 */	
	public List<ProjectDto> myProSelect(String mem_id);
	
	/**
	 * 내가 완료한 프로젝트
	 * @param mem_id 회원아이디
	 * @return List&lt;ProjectDto&gt;
	 * @author 김혜원
	 * */
	public Map<String, String> myDidPrSelect(String mem_id);
	
	/**
	 * 내가 진행중인 프로젝트
	 * @param mem_id 회원아이디
	 * @return List&lt;ProjectDto&gt;
	 * @author 김혜원
	 * */
	public Map<String, String> myDoingPrSelect(String mem_id);
	
	/**
	 * 내가 해야 할 프로젝트
	 * @param mem_id 회원아이디
	 * @return List&lt;ProjectDto&gt;
	 * @author 김혜원
	 * */
	public Map<String, String> myTodoPrSelect(String mem_id);
	
	/**
	 * 시스템 전체  프로젝트 조회(검색)
	 * @param pr_name 프로젝트명
	 * @return List&lt;ProjectDto&gt;
	 * @author 김혜원
	 * */
	public Map<String, String> allPrSearchSelect(String pr_name);
	
	/**
	 * 프로젝트명으로 검색 (내 프로젝트 목록에서 검색)
	 * @param map mem_id, pr_name을 받아서 검색
	 * @return List&lt;ProjectDto&gt;
	 * @author 김혜원
	 * */
	public Map<String, String> myPrSearchSelect(Map<String, String> map);

	/**
	 * 프로젝트 상세정보 조회
	 * @param pr_id 프로젝트 아이디
	 * @return ProjectDto
	 * @author 김혜원
	 * */
	public Map<String, String> prDetailSelect(String pr_id);
	
	/**
	 * 그룹 프로젝트 생성
	 * @param map, group 정보, project정보, mem_id를 담아 전송
	 * @return boolean
	 * */
	public boolean gPrInsert(Map<String, String>  map);
	
	/**
	 * 개인 프로젝트 생성
	 * @param map value:mem_id(회원아이디), project 정보
	 */
	public boolean iPrInsert(Map<String, String> map);
	
	/**
	 * 프로젝트 매니저 조회
	 * @param pr_id
	 * @return
	 */
	public MemberDto prManagerSelect(String pr_id);
	
	/**
	 * 프로젝트 기본정보 수정
	 * @param ProjectDto
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean projectEdit(ProjectDto dto);
	
	/**
	 * 프로젝트 삭제
	 * @param map pr_id, mem_id 등을 담아 전송
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean projectDelete(Map<String, String> map);
	
	/**
	 * 프로젝트 초대 가능 멤버 조회 (그룹 내 프로젝트에 참여하지 않는 멤버)
	 * @param map
	 * @return
	 */
	public List<MemberDto> prMemInsertSearch(Map<String, String> map);
	
	/**
	 * 프로젝트 멤버 추가
	 * @param map value:mem_id(회원아이디), pr_id(프로젝트아이디) 
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean prMemInsert(Map<String, Object> map);
	
	/**
	 * 프로젝트 멤버 삭제
	 * @param map value:mem_id(회원아이디), pr_id(프로젝트아이디)
	 * @return boolean 
	 * @author 김혜원
	 * */
	public boolean prMemDelete(Map<String, Object> map);
	
	/**
	 * 프로젝트 멤버 조회
	 * @param pr_id 프로젝트아이디
	 * @return List&lt;MemberDto&gt;
	 * @author 김혜원
	 * */
	public List<Map<String, String>> prMemListSelect(String pr_id);
	
	/**
	 * 프로젝트 담당자 수정(pr_id, mem_id)
	 * @param map value:pr_id(프로젝트아이디), mem_id(기존 매니저 회원아이디), mem_id(새로운 매니저 회원 아이디)
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
	public boolean prRateEdit(String pr_id);
	
	/**
	 * 프로젝트 내 권한 조회
	 * @param map : 조회할 pr_id와 mem_id를 담은 map
	 * @return
	 */
	public String myLevelSelect(Map<String, String> map);
	
	/**
	 * 프로젝트 및 그룹 내 멤버 정보 조회 : 멤버정보 조회
	 * @param map
	 * @return
	 */
	public Map<String, String> memInfoSelect_1(Map<String, String> map);
	
	/**
	 * 프로젝트 및 그룹 내 멤버 정보 조회 : 그룹 내 참여한 프로젝트 조회
	 * @param map
	 * @return
	 */
	public List<Map<String, String>> memInfoSelect_2(Map<String, String> map);
	
}
