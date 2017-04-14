package com.pm.rc.model.dao;

import java.util.List;

import com.pm.rc.dto.SbAttachDto;
import com.pm.rc.dto.SystemBoardDto;


/**
 * 시스템 게시판 관련 기능 인터페이스
 * @author 김호빈
 * @version SysBoardService Beta 1.0
 */
public interface SysBoardDao {
	
	/**
	 * 공지게시판 게시글 목록 출력
	 * @return 게시글의 목록을 list에 담아 반환
	 */
	public List<SystemBoardDto> noticeListSelect();
	
	/**
	 * 공지게시판 게시글 검색 목록 출력
	 * @param sbr_title
	 * @return 조건에 해당하는 게시글 목록을 list에 담아 반환
	 */
	public List<SystemBoardDto> noticeSearchSelect(String sbr_title);
	
	/**
	 * 게시글 내용 출력
	 * @param sbr_uuid 게시글 고유값
	 * @return SystemBoardDto에 해당하는 게시글의 정보를 담아 반환
	 */
	public SystemBoardDto noticeViewSelect(String sbr_uuid);
	
	/**
	 * 해당하는 게시글의 주소를 가진 첨부파일 목록을 출력
	 * @param sbr_uuid
	 * @return
	 */
	public List<SbAttachDto> noticeAttachSelect(String sbr_uuid);

}
