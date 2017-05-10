package com.pm.rc.model.dao;

import java.util.List;
import java.util.Map;

import com.pm.rc.dto.GroupDto;
import com.pm.rc.dto.MemberDto;

public interface ManagerDao {
	
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
	 * 그룹 생성 거절 다음 해당 그룹 관리자 삭제 (그룹생성Dao)
	 * @param gr_id 그룹아이디
	 * @return boolean
	 * @author 라한솔
	 */
	public boolean grDelete (String gr_id);
	
	/**
	 * 그룹 생성 거절 다음 해당 그룹 관리자 삭제 (해당 그룹 관리자 삭제)
	 * @param gr_id 그룹아디
	 * @return boolean
	 * @author 라한솔
	 */
	public boolean grDelete2 (String gr_id);
	
	/**
	 * 회원 목록 출력 
	 * @return list
	 * @author 라한솔
	 */
	public List<MemberDto> allMemberSelect();
	
	/**
	 * 회원 정보 수정
	 * @param dto MemberDto
	 * @return boolean
	 * @author 김혜원
	 * */
	public Boolean sysMemModify(MemberDto dto);
	
	/**
	 * 회원 목록 출력 (아이디 검색)
	 * @param mem_id
	 * @return list
	 * @author 라한솔
	 */
	public List<MemberDto> allMemberSelectSearch(Map<String, String> map);
	
	/**
	 * 회원 정보 조회
	 * @param mem_id
	 * @return MemberDto
	 * @author 김혜원
	 * */
	public MemberDto sysMemView(String mem_id);
	
	/**
	 * 그룹 생성 승인
	 * @param gr_id 그룹아이디
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean grAppModify(String gr_id);	
	
	/**
	 * 공지사항 등록 : 첨부파일 등록
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean noticeInsert_1(Map<String, String> map);
	
	/**
	 * 공지사항 등록 : 게시글 등록
	 * @param map
	 * @return
	 */
	public boolean noticeInsert_2(Map<String, String> map);
	
	/**
	 * 공지사항 수정 - 첨부파일 수정
	 * @param map
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean noticeModify_1(Map<String, String> map);
	
	/**
	 * 공지사항 수정 - 게시글 수정
	 * @param map
	 * @return
	 */
	public boolean noticeModify_2(Map<String, String> map);
	
	
	/**
	 * 문의 답글 등록 - 첨부파일 등록
	 * @param dto SystemBoardDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean qnaReplyInsert_1(Map<String, String> map);
	
	/**
	 * 문의 답글 등록 - 게시글 등록
	 * @param map
	 * @return
	 */
	public boolean qnaReplyInsert_2(Map<String, String> map);
	
	/**
	 * 그룹승인화면에서 그룹선택시 간략정보 출력
	 * @param String gr_Id
	 * @return List&lt;GroupDto&gt;
	 */
	public List<GroupDto> grApplySelectGroup(String gr_id);
}
