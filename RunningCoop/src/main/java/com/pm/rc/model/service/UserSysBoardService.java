package com.pm.rc.model.service;

import java.util.List;
import java.util.Map;

import com.pm.rc.dto.SbAttachDto;
import com.pm.rc.dto.SystemBoardDto;

/**
 * 회원 입장에서 시스템게시판(문의게시판, 공지게시판)관련 기능 인터페이스
 * @author 김혜원
 * */
public interface UserSysBoardService {
	
	/**
	 * 공지 게시글 목록 출력
	 * @return List&lt;SystemBoardDto&gt;
	 * @author 김혜원
	 * */
	public List<Map<String, String>> noticeListSelect();
	
	/**
	 * 공지 게시글 검색 목록 출력
	 * @param map sbr_title을 받은 Map객체를 전송
	 * @return List&lt;SystemBoardDto&gt;
	 * @author 김혜원
	 * */
	public List<Map<String, String>> noticeSearchSelect(Map<String, String> map);
	
	/**
	 * 문의 게시글 목록 출력
	 * @return 문의 게시글의 목록을 
	 * */
	public List<Map<String, String>> qnaListSelect();
	
	/**
	 * 문의 게시글 검색
	 * @param map : sbr_title을 key로 주고 게시글의 
	 * @return List&lt;SystemBoardDto&gt;
	 * @author 김혜원
	 * */
	public List<Map<String, String>> qnaSearchSelect(Map<String, String> map);
	
	/**
	 * 게시글 보기 서비스
	 * @param map sbr_uuid, sbr_pw을 Map객체에 담아 전송
	 * @return 해당하는 게시글의 정보를 Map에 담아 반환
	 */
	public Map<String, String> sysBoardViewSelect(Map<String, String> map);
	
	/**
	 * 문의 게시글 등록
	 * @param dto SystemBoardDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean qnaBoardInsert(SystemBoardDto dto, SbAttachDto satt);
	
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
	
	
}
