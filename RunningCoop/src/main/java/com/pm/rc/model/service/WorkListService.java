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
	 * @author 김혜원
	 * */
	public WorkDetailDto wdSelect(String wk_id);
	
	/**
	 * 하위업무리스트 추가(wk_id, WorkDetailDto)
	 * @author 김혜원
	 * */
	public boolean wdInsert(Map<String, WorkDetailDto> map);
	
	/**
	 * 하위업무리스트 수정(wd_id, WorkDetailDto)
	 * @author 김혜원
	 * */
	public boolean wdModify(Map<String, WorkDetailDto> map);
	
	/**
	 * 하위업무리스트 삭제
	 * @author 김혜원
	 * */
	public boolean wdDelete(String wd_id);
	
	/**
	 * 업무리스트 페이지 댓글 추가(wk_id, WorkCommentDto)
	 * @author 김혜원
	 * */
	public boolean wCommentInset(Map<String, WorkCommentDto> map);
	
	/**
	 * 업무리스트 페이지 댓글 수정(wcom_id, WorkCommentDto)
	 * @author 김혜원
	 * */
	public boolean wCommentModify(Map<String, WorkCommentDto> map);
	
	/**
	 * 업무리스트 페이지 댓글 삭제
	 * @author 김혜원
	 * */
	public boolean wCommentDelete(String wcom_id);
	
	/**
	 * 첨부파일 등록
	 * @author 김혜원
	 * */
	public boolean gbAttachInsert(GroupBoardDto dto);
	
	/**
	 * 첨부파일 삭제
	 * @author 김혜원
	 * */
	public boolean gbAttachModify(String gatt_seq);
	
	/**
	 * 하위업무 애로사항 체크
	 * @author 김혜원
	 * */
	public boolean wdErrorChk(String wd_id);
	
	/**
	 * 하위업무리스트 완료상태 수정
	 * @author 김혜원
	 * */
	public boolean wdComplModify(String wd_id);
	
	/**
	 * 워크리스트 작업진행률 수정
	 * @author 김혜원
	 * */
	public boolean wkRateMoidfy(String wk_id);

}
