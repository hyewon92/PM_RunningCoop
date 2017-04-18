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
	 * @param sbr_title 해당하는 게시글 제목에 포함되는 단어
	 * @return 조건에 해당하는 게시글 목록을 list에 담아 반환
	 */
	public List<SystemBoardDto> noticeSearchSelect(String sbr_title);
	
	/**
	 * 문의게시판 게시글 목록 출력
	 * @return 게시글의 목록을 list에 담아 반환
	 */
	public List<SystemBoardDto> qnaListselect();
	
	/**
	 * 문의게시판 게시글 검색 목록 출력
	 * @param sbr_title 해당하는 게시글 제목에 포함되는 단어
	 * @return 조건에 해당하는 게시글 목록을 list에 담아 반환
	 */
	public List<SystemBoardDto> qnaSearchSelect (String sbr_title);
	
	/**
	 * 공개 게시글 내용 출력
	 * @param sbr_uuid 게시글 고유값
	 * @return SystemBoardDto에 해당하는 게시글의 정보를 담아 반환
	 */
	public SystemBoardDto openViewSelect(String sbr_uuid);
	
	/**
	 * 비공개 게시글 내용 출력
	 * @param dto : sbr_uuid와 sbr_pw를 담아 전송
	 * @return 해당하는 게시글의 정보를 dto형태로 반환
	 */
	public SystemBoardDto scrViewSelect (SystemBoardDto dto);
	
	/**
	 * 관리자가 게시글을 조회할 때 게시글 내용 출력
	 * @param sbr_uuid : 해당 게시글 uuid
	 * @return 해당하는 게시글의 정보를 dto형태로 반환
	 */
	public SystemBoardDto sysViewSelect (String sbr_uuid);
	
	/**
	 * 해당하는 게시글의 주소를 가진 첨부파일 목록을 출력
	 * @param sbr_uuid
	 * @return 해당하는 조건의 첨부파일을 list로 반환
	 */
	public List<SbAttachDto> sysAttachSelect(String sbr_uuid);
	
	/**
	 * 공지게시판 게시글 작성
	 * @param dto 입력받은  정보를 dto형태로 전송
	 * @return 작성 성공하면 true, 실패하면 false
	 */
	public boolean noticeBoardInsert(SystemBoardDto dto);
	
	/**
	 * 문의게시판 게시글 작성
	 * @param dto 입력받은 정보를 dto형태로 전송
	 * @return 작성 성공하면 true, 실패하면 false
	 */
	public boolean qnaBoardInsert (SystemBoardDto dto);
	
	/**
	 * 관리자가 문의글에 답글을 작성
	 * @param dto : 입력한 정보를 dto형태로 전송
	 * @return 등록 성공하면 true, 실패하면 false
	 */
	public boolean qnaReplyInsert (SystemBoardDto dto);
	
	/**
	 * 게시글 작성 시 파일 업로드
	 * @param dto 입력받은 정보를 dto형태로 전송
	 * @return 작성 성공하면 true, 실패하면 false
	 */
	public boolean FileInsert (SbAttachDto dto);
	
	/**
	 * 게시글 수정 (공지/문의 통합)
	 * @param dto : 입력받은 정보를 dto형태로 전송
	 * @return 수정 성공하면 true, 실패하면 false
	 */
	public boolean sysBoardUpdate (SystemBoardDto dto);
	
	/**
	 * 수정되는 게시글의 첨부파일을 수정 (공지/문의 통합)
	 * @param dto : 입력받은 정보를 dto형태로 전송
	 * @return 수정 성공하면 true, 실패하면 false
	 */
	public boolean FileUpdate (SbAttachDto dto);
	
	/**
	 * 게시글 삭제 (공지/문의 통합)
	 * @param sbr_uuid : 해당하는 게시글의 게시글 uuid를 값으로 전송
	 * @return 삭제 성공하면 true, 실패하면 false
	 */
	public boolean sysBoardDelete (String sbr_uuid);
	
	/**
	 * 삭제되는 게시글의 첨부파일을 삭제
	 * @param sbr_uuid : 삭제되는 게시글의 uuid를 반환
	 * @return 삭제 성공하면 true, 실패하면 false
	 */
	public boolean FileDelete (String sbr_uuid);

}
