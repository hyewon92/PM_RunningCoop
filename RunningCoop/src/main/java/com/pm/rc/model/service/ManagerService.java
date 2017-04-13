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
	 * @author 김혜원
	 * */
	public boolean grAppModify(String gr_id);
	
	/**
	 * 공지사항 등록
	 * @author 김혜원
	 * */
	public boolean noticeInsert(SystemBoardDto dto);
	
	/**
	 * 공지사항 수정(sbr_uuid, SystemBoardDto)
	 * @author 김혜원
	 * */
	public boolean noticeModify(Map<String, SystemBoardDto> map);
	
	/**
	 * 공지사항 삭제
	 * */
	public boolean noticeDelete(String sbr_uuid);
	

	/**
	 * 문의 게시글 조회
	 * @author 김혜원
	 * */
	public List<SystemBoardDto> qnaListSelect();
	
	
	/**
	 * 문의 답글 등록
	 * @author 김혜원
	 * */
	public boolean qnaReplyInsert(SystemBoardDto dto);
	
	/**
	 * 문의 답글 수정
	 * @author 김혜원
	 * */
	public boolean qnaReplyModify(String sbr_uuid);
	
	/**
	 * 문의 답글 삭제
	 * @author 김혜원
	 * */
	public boolean qnaReplyDelete(String sbr_uuid);
	
}
