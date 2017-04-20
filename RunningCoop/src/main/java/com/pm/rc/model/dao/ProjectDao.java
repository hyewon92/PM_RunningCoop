package com.pm.rc.model.dao;

import java.util.List;
import java.util.Map;

import com.pm.rc.dto.GbAttachDto;
import com.pm.rc.dto.MemberDto;
import com.pm.rc.dto.ProjectDto;

public interface ProjectDao {
	
	/**
	 * 그룹에 소속된 내가 참여하는 진행중인 프로젝트 조회(메인에서 프로젝트 선택 시 출력화면)
	 * @param map (mem_id, gr_id를 담아 전송)
	 * @return
	 */
	public List<ProjectDto> groupProSelect(Map<String, String> map);
	
	/**
	 * 내가 진행중인 프로젝트 조회(그룹없는 개인사용자/ 메인에서 프로젝트 선택 시 출력화면)
	 * @param mem_id
	 * @return
	 */
	public List<ProjectDto> myProSelect(String mem_id);
	
	/**
	 * 나의 완료한 프로젝트 조회
	 * @param mem_id
	 * @return
	 */
	public Map<String, String> myDidPrSelect(String mem_id);
	
	/**
	 * 나의 진행중인 프로젝트 조회
	 * @param mem_id
	 * @return
	 */
	public Map<String, String> myDoingPrSelect(String mem_id);
	
	/**
	 * 나의 진행예정 프로젝트 조회
	 * @param mem_id
	 * @return
	 */
	public Map<String, String> myToDoPrSelect(String mem_id);
	
	/**
	 * 나의 프로젝트 목록에서 프로젝트 명으로 검색
	 * @param map (mem_id, pr_name)
	 * @return
	 */
	public Map<String, String> myPrSearchSelect(Map<String, String> map);
	
	/**
	 * 검색 화면에서 전체 프로젝트를 프로젝트 명으로 검색
	 * @param pr_name
	 * @return
	 */
	public Map<String, String> allPrSearchSelect(String pr_name);
	
	/**
	 * 해당하는 프로젝트의 상세정보를 조회
	 * @param pr_id
	 * @return
	 */
	public Map<String, String> prDetailSelect(String pr_id);
	
	/**
	 * 그룹 프로젝트 생성 절차 1 (프로젝트 생성)
	 * @param map
	 * @return
	 */
	public boolean gPrInsert_1(Map<String, String> map);
	
	/**
	 * 그룹 프로젝트 생성 절차2 (프로젝트 매니저 등록)
	 * @param map
	 * @return
	 */
	public boolean gPrInsert_2(Map<String, String> map);
	
	/**
	 * 그룹 프로젝트 생성 절차3 (그룹 프로젝트 등록)
	 * @param map
	 * @return
	 */
	public boolean gPrInsert_3(Map<String, String> map);
	
	/**
	 * 개인 프로젝트 생성 절차1 (프로젝트 생성)
	 * @param map
	 * @return
	 */
	public boolean iPrInsert_1(Map<String, String> map);
	
	/**
	 * 개인 프로젝트 생성 절차2 (프로젝트 매니저 등록)
	 * @param map
	 * @return
	 */
	public boolean iPrInsert_2(Map<String, String> map);
	
	/**
	 * 프로젝트 기본 정보 수정
	 * @param dto
	 * @return
	 */
	public boolean projectEdit(ProjectDto dto);
	
	/**
	 * 프로젝트 멤버 추가 절차 1 (프로젝트 멤버 데이터 삽입)
	 * @param map
	 * @return
	 */
	public boolean prMemInsert_1(Map<String, String> map);
	
	/**
	 * 프로젝트 멤버 추가 절차 2 (프로젝트 인원 수정)
	 * @param map
	 * @return
	 */
	public boolean prMemInsert_2(Map<String, String> map);
	
	/**
	 * 프로젝트 매니저 수정 절차 1 (프로젝트 매니저 권한 변경)
	 * @param map
	 * @return
	 */
	public boolean prMgrEdit_1(Map<String, String> map);
	
	/**
	 * 프로젝트 매니저 수정 절차 2 (새로운 프로젝트 매니저 권한 변경)
	 * @param map
	 * @return
	 */
	public boolean prMgrEdit_2(Map<String, String> map);
	
	/**
	 * 프로젝트 멤버 리스트 조회
	 * @param pr_id 해당하는 프로젝트 아이디
	 * @return
	 */
	public Map<String, String> prMemListSelect(String pr_id);
	
	/**
	 * 프로젝트 멤버 삭제 절차 1 (프로젝트 멤버 삭제)
	 * @param map
	 * @return
	 */
	public boolean prMemDelete_1(Map<String, String> map);
	
	/**
	 * 프로젝트 멤버 삭제 절차2 (프로젝트 인원 정보 수정)
	 * @param map
	 * @return
	 */
	public boolean prMemDelete_2(Map<String, String> map);
	
	/**
	 * 프로젝트 진행률 수정 절차 1 (해당 프로젝트의 전체 업무리스트 조회)
	 * @param pr_id
	 * @return (해당하는 프로젝트의 wk_id 리스트를 반환)
	 */
	public List<String> prRateEdit_1(String pr_id);
	
	/**
	 * 프로젝트 진행률 수정 절차 2 (해당 업무의 총 하위 업무리스트 조회) 업무 수만큼 반복
	 * @param wk_id
	 * @return
	 */
	public int prRateEdit_2(String wk_id);
	
	/**
	 * 프로젝트 진행률 수정 절차 3 (완료된 하위 업무리스트 조회) 업무 수만큼 반복
	 * @param wk_id
	 * @return
	 */
	public int prRateEdit_3(String wk_id);
	
	/**
	 * 구해진 프로젝트 진행률을 해당 프로젝트에 업데이트
	 * @param pr_id
	 * @return
	 */
	public boolean prRateEdit_4(String pr_id);
	
	/**
	 * 삭제할 프로젝트의 업무리스트 조회
	 * @param map (pr_id를 담아 전송)
	 * @return 해당하는 프로젝트의 wk_id리스트 반환
	 */
	public List<String> projectDelete_1(Map<String, String> map);
	
	/**
	 * 해당하는 업무리스트에 포함된 첨부파일 리스트 조회 (조회결과로 실제 파일 삭제 service에서)
	 * @param wk_id
	 * @return
	 */
	public List<Map<String, GbAttachDto>> projectDelete_2(String wk_id);
	
	/**
	 * 첨부파일 삭제
	 * @param wk_id
	 * @return
	 */
	public boolean projectDelete_3(String wk_id);
	
	/**
	 * 하위업무 삭제
	 * @param wk_id
	 * @return
	 */
	public boolean projectDelete_4(String wk_id);
	
	/**
	 * 프로젝트의 업무 삭제
	 * @param map
	 * @return
	 */
	public boolean projectDelete_5(Map<String, String> map);
	
	/**
	 * 프로젝트 멤버 삭제
	 * @param map
	 * @return
	 */
	public boolean projectDelete_6(Map<String, String> map);
	
	/**
	 * 프로젝트 그룹 관계 삭제
	 * @param map
	 * @return
	 */
	public boolean projectDelete_7(Map<String, String> map);
	
	/**
	 * 프로젝트 멤버 카운트 조정
	 * @param map
	 * @return
	 */
	public boolean projectDelete_8(Map<String, String> map);
	
	/**
	 * 프로젝트 비활성화
	 * @param map
	 * @return
	 */
	public boolean projectDelete_9(Map<String, String> map);

}
