package com.pm.rc.model.service;

import java.util.Map;

import com.pm.rc.dto.GbAttachDto;
import com.pm.rc.dto.GroupBoardDto;
import com.pm.rc.dto.WorkCommentDto;
import com.pm.rc.dto.WorkDetailDto;

/**
 * 업무리스트 관련 기능 인터페이스
 * @author 김혜원
 * */
public interface WorkListService {
	
	/**
	 * 하위업무리스트 조회
	 * @param wk_id 워크리스트 아이디
	 * @return WorkDetailDto
	 * @author 김혜원
	 * */
	public WorkDetailDto wdSelect(String wk_id);
	
	/**
	 * 하위업무리스트 추가
	 * @param dto WorkDetailDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean wdInsert(WorkDetailDto dto);
	
	/**
	 * 하위업무리스트 수정
	 * @param dto WorkDetailDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean wdModify(WorkDetailDto dto);
	
	/**
	 * 하위업무리스트 삭제
	 * @param wd_id(하위업무리스트 아이디)
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean wdDelete(String wd_id);
	
	/**
	 * 업무리스트 페이지 댓글 추가
	 * @param map value:wk_id(업무리스트 아이디)값, WorkCommentDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean wCommentInsert(Map<String, Object> map);
	
	/**
	 * 업무리스트 페이지 댓글 수정
	 * @param map value:wcom_id(워크리스트 코멘트아이디), WorkCommentDto
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean wCommentModify(Map<String, Object> map);
	
	/**
	 * 업무리스트 페이지 댓글 삭제
	 * @param wcom_id 워크리스트 코멘트 아이디
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean wCommentDelete(String wcom_id);
	
	/**
	 * 첨부파일 등록
	 * @param dto GroupBoardDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean gbAttachInsert(GroupBoardDto dto);
	
	/**
	 * 첨부파일 삭제
	 * @param gatt_seq 그룹/프로젝트 게시판 첨부파일 번호
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean gbAttachModify(String gatt_seq);
	
	/**
	 * 하위업무 애로사항 체크
	 * @param wd_id 하위업무리스트 아이디
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean wdErrorChk(String wd_id);
	
	/**
	 * 하위업무리스트 완료상태 수정
	 * @param wd_id 하위업무리스트 아이디
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean wdComplModify(String wd_id);
	
	/**
	 * 워크리스트 작업진행률 수정
	 * @param wk_id 업무리스트 아이디
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean wkRateMoidfy(String wk_id);

}
