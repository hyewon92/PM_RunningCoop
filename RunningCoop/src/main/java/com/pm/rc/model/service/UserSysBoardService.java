package com.pm.rc.model.service;

import java.util.List;
import java.util.Map;

import com.pm.rc.dto.SystemBoardDto;

/**
 * 회원 입장에서 시스템게시판(문의게시판, 공지게시판)관련 기능 인터페이스
 * @author 김혜원
 * */
public interface UserSysBoardService {
	
	/**
	 * 문의 게시글 등록
	 * @param SystemBoardDto
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean qnaBoardInsert(SystemBoardDto dto);
	
	/**
	 * 문의 게시글 수정
	 * @param dto SystemBoardDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean qnaBoardModify(SystemBoardDto dto);
	
	/**
	 * 문의 게시글 삭제
	 * @param sbr_uuid 시스템게시글 번호
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean qnaBoardDelete(String sbr_uuid);
	
	/**
	 * 문의 게시글 조회
	 * @return List&lt;SystemBoardDto&gt;
	 * @author 김혜원
	 * */
	public List<SystemBoardDto> qnaDetailSelect();
	
	/**
	 * 문의 게시글 검색
	 * @param sbr_title 시스템 게시글 제목
	 * @return List&lt;SystemBoardDto&gt;
	 * @author 김혜원
	 * */
	public List<SystemBoardDto> qnaBoardSelect(String sbr_title);
	
	/**
	 * 공지 게시글 조회
	 * @return List&lt;SystemBoardDto&gt;
	 * @author 김혜원
	 * */
	public List<SystemBoardDto> noticeDetailSelect();
	
	/**
	 * 공지 게시글 검색
	 * @param sbr_title 시스템 게시글 제목
	 * @return List&lt;SystemBoardDto&gt;
	 * @author 김혜원
	 * */
	public List<SystemBoardDto> noticeBoardSelect(String sbr_title);
}
