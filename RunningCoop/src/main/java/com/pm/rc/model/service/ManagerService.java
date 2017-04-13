package com.pm.rc.model.service;

import java.util.List;
import java.util.Map;

import com.pm.rc.dto.SystemBoardDto;

/**
 * 시스템 관리자 기능 인터페이스(회원관리는 AccountService로)
 * @author 김혜원
 * */
public interface ManagerService {

	/**
	 * 그룹 생성 승인
	 * @param gr_id 그룹아이디
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean grAppModify(String gr_id);
	
	/**
	 * 공지사항 등록
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean noticeInsert(SystemBoardDto dto);
	
	/**
	 * 공지사항 수정
	 * @param map value:sbr_uuid(시스템게시글 번호), SystemBoardDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean noticeModify(Map<String, Object> map);
	
	/**
	 * 공지사항 삭제
	 * @param sbr_uuid 시스템게시글 번호
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean noticeDelete(String sbr_uuid);
	

	/**
	 * 문의 게시글 조회
	 * @return List&lt;SystemBoardDto&gt;
	 * @author 김혜원
	 * */
	public List<SystemBoardDto> qnaListSelect();
	
	
	/**
	 * 문의 답글 등록
	 * @param dto SystemBoardDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean qnaReplyInsert(SystemBoardDto dto);
	
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
	
}
