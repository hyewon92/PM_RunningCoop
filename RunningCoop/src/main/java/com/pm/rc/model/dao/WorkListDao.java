package com.pm.rc.model.dao;

import java.util.List;
import java.util.Map;

import com.pm.rc.dto.GbAttachDto;
import com.pm.rc.dto.GroupBoardDto;
import com.pm.rc.dto.WorkCommentDto;
import com.pm.rc.dto.WorkDetailDto;
import com.pm.rc.dto.WorkListDto;

/**
 * 업무리스트 관련 기능 인터페이스
 * @author 김혜원
 * */
public interface WorkListDao {

	/**
	 * 업무리스트 조회--1.진행중
	 * @param pr_id 프로젝트아이디
	 * @return List&lt;WorkListDto&gt;
	 * @author 김혜원
	 * */
	public List<WorkListDto> wkListSelect1(String pr_id);
	
	/**
	 * 업무리스트 조회--2.진행예정
	 * @param pr_id 프로젝트아이디
	 * @return List&lt;WorkListDto&gt;
	 * @author 김혜원
	 * */
	public List<WorkListDto> wkListSelect2(String pr_id);
	
	/**
	 * 업무리스트 조회--2.진행온료
	 * @param pr_id 프로젝트아이디
	 * @return List&lt;WorkListDto&gt;
	 * @author 김혜원
	 * */
	public List<WorkListDto> wkListSelect3(String pr_id);
	
	/**
	 * 프로젝트 업무 리스트 추가
	 * @param dto WorkListDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean wkListInsert(WorkListDto dto);
	
	/**
	 * 프로젝트 업무 리스트 삭제
	 * @param wk_id 워크리스트 아이디
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean wkListDelete(String wk_id);
	
	/**
	 * 프로젝트 업무 리스트 수정
	 * @param dto WorkListDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean wkListModify(WorkListDto dto);

	/**
	 * 워크리스트 작업진행률 수정
	 * @param map value:wk_id(업무리스트 아이디), wk_proRate(업무 진행률)
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean wkRateMoidfy(Map<String, String> map);
	
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
	 * 업무리스트 페이지 댓글 조회
	 * @param wk_id 워크리스트 아이디
	 * @return List&lt;WorkCommentDto&gt;
	 * */
	public List<WorkCommentDto> wCommListSelect(String wk_id);
	
	/**
	 * 업무리스트 페이지 댓글 추가
	 * @param dto WorkCommentDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean wCommentInsert(WorkCommentDto dto);
	
	/**
	 * 업무리스트 페이지 댓글 수정
	 * @param dto WorkCommentDto
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean wCommentModify(WorkCommentDto dto);
	
	/**
	 * 업무리스트 페이지 댓글 삭제
	 * @param wcom_id 워크리스트 코멘트 아이디
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean wCommentDelete(String wcom_id);
	
	/**첨부파일 조회
	 * @param wk_id 워크리스트 아이디
	 * @return List&lt;GbAttachDto&gt;
	 * */
	public List<GbAttachDto> btAttachSelect(String wk_id);
	
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
	
}
