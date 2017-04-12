package com.pm.rc.model.service;

import java.util.List;
import java.util.Map;

import com.pm.rc.dto.MemberDto;
import com.pm.rc.dto.ProjectDto;
import com.pm.rc.dto.WorkListDto;

//프로젝트 관련 기능
public interface ProjectService {

	//소속 그룹+내가 참여하는 진행중인 프로젝트(메인) 조회(mem_id, gr_id, pr_condition)
	public List<ProjectDto> groupProSelect(Map<String, String> map);
	
	//내가 참여했던 모든 프로젝트 조회(mem_id랑 pr_condition 받음)
	public List<ProjectDto> myPrSelect(Map<String, String> map);
	
	//시스템 전체  프로젝트 조회(검색)
	public List<ProjectDto> allPrSelect();
	
	//프로젝트명으로 검색
	public List<ProjectDto> prNameSelect(String pr_name);

	//프로젝트 상세정보 조회
	public ProjectDto prDetailSelect(String pr_id);
	
	//프로젝트 생성
	public boolean prInsert(ProjectDto dto);
	
	//프로젝트 수정(pr_id, ProjectDto)
	public boolean prModify(Map<String, ProjectDto> map);
	
	//프로젝트 삭제
	public boolean prDelete(String pr_id);
	
	//프로젝트 멤버 추가(mem_id, pr_id)
	public boolean prMemInsert(Map<String, String> map);
	
	//프로젝트 멤버 삭제(mem_id, pr_id)
	public boolean prMemDelete(Map<String, String> map);
	
	//프로젝트 멤버 조회
	public List<MemberDto> prMemSelect(String pr_id);
	
	//프로젝트 업무 리스트 추가
	public boolean wkListInsert(WorkListDto dto);
	
	//프로젝트 업무 리스트 삭제
	public boolean wkListDelete(String wk_id);
	
	//프로젝트 담당자 수정(pr_id, mem_id)
	public boolean prMgrModify(Map<String, String> map);
	
	//프로젝트 진행률
	public boolean prRateModify(String pr_id);
	
}
