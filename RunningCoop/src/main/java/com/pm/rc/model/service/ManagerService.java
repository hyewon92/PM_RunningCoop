package com.pm.rc.model.service;

import java.util.List;
import java.util.Map;

import com.pm.rc.dto.GroupDto;
import com.pm.rc.dto.MemberDto;
import com.pm.rc.dto.SystemBoardDto;

/**
 * 시스템 관리자 기능 인터페이스(회원관리는 AccountService로)
 * @author 김혜원
 * */
public interface ManagerService {
	
	/**
	 * 그룹생성승인요청 리스트 출력  (전부)
	 * @return list 
	 * @author 라한솔
	 */
	public List<GroupDto> grApplySelect (String gr_name);
	
	/**
	 * 그룹생성승인요청 리스트 출력 (그룹 이름 검색)
	 * @param gr_name 그룹이름
	 * @return list
	 * @author 라한솔
	 */
	public List<GroupDto> grApplySelectGr(String gr_name);
	
	/**
	 * 그룹 생성 거절 다음 해당 그룹 관리자 삭제
	 * @param gr_id 그룹아이디
	 * @return boolean
	 * @author 라한솔
	 */
	public boolean grDelete (String[] gr_id);
	
	/**
	 * 회원 목록 출력 
	 * @return list
	 * @author 라한솔
	 */
	public List<MemberDto> allMemberSelect();
	
	/**
	 * 회원 목록 출력 (아이디 검색)
	 * @param mem_id
	 * @return list
	 * @author 라한솔
	 */
	public List<MemberDto> allMemberSelectSearch(String mem_id);
	
	/**
	 * 그룹 생성 승인
	 * @param gr_id 그룹아이디
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean grAppModify(String[] gr_id);	
	
	/**
	 * 공지사항 등록
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean noticeInsert(Map<String, String> map);
	
	/**
	 * 공지사항 수정
	 * @param dto SystemBoardDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean noticeModify(Map<String, String> map);
	
	/**
	 * 문의 답글 등록
	 * @param dto SystemBoardDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean qnaReplyInsert(Map<String, String> map);
	
	/**
	 * 문의 답글 수정
	 * @param dto SystemBoardDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean qnaReplyModify(SystemBoardDto dto);
	
	/**
	 * 문의 답글 삭제
	 * @param sbr_uuid 시스템게시글번호
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean qnaReplyDelete(String sbr_uuid);
	
	/**
	 * 그룹승인화면에서 그룹선택시 간략정보 출력
	 * @param String gr_Id
	 * @return List&lt;GroupDto&gt;
	 */
	public List<GroupDto> grApplySelectGroup(String gr_id);
	
}
