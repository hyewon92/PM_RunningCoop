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
	 * @author 김혜원
	 * */
	public boolean qnaBoardInsert(SystemBoardDto dto);
	
	/**
	 * 문의 게시글 수정(sbr_uuid, SystemBoardDto)
	 * @author 김혜원
	 * */
	public boolean qnaBoardModify(Map<String, SystemBoardDto> map);
	
	/**
	 * 문의 게시글 삭제
	 * @author 김혜원
	 * */
	public boolean qnaBoardDelete(String sbr_uuid);
	
	/**
	 * 문의 게시글 조회
	 * @author 김혜원
	 * */
	public List<SystemBoardDto> qnaDetailSelect();
	
	/**
	 * 문의 게시글 검색
	 * @author 김혜원
	 * */
	public List<SystemBoardDto> qnaBoardSelect(String sbr_title);
	
	/**
	 * 공지 게시글 조회
	 * @author 김혜원
	 * */
	public List<SystemBoardDto> noticeDetailSelect();
	
	/**
	 * 공지 게시글 검색
	 * @author 김혜원
	 * */
	public List<SystemBoardDto> noticeBoardSelect(String sbr_title);
}
