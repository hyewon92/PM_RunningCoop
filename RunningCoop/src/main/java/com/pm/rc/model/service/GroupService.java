package com.pm.rc.model.service;

import java.util.List;
import java.util.Map;

import com.pm.rc.dto.GroupBoardDto;
import com.pm.rc.dto.GroupDto;
import com.pm.rc.dto.MemberDto;
import com.pm.rc.dto.PagingDto;

/**
 * 그룹관련 기능 인터페이스
 * @author 김혜원
 * */
public interface GroupService {
	
	/**
	 * 그룹 이름으로 검색 결과 페이징 처리부분
	 * @author 라한솔
	 */
	public List<GroupDto> selectPaging(PagingDto paging);
	public int selectTotalPaging(String gr_name);
	
	/**
	 * 내가 가입한 그룹 조회
	 * @param mem_id 회원 아이디
	 * @return List&lt;GroupDto&gt;
	 * @author 김혜원
	 * */
	public List<GroupDto> myGrSelect(Map<String, String> map);
	
	/**
	 * 그룹 검색 조회(그룹명)
	 * @param gr_name 그룹명
	 * @return List&lt;GroupDto&gt;
	 * @author 김혜원
	 * */
	public  List<GroupDto> allGrSelect(Map<String, String> map);
	
	/**
	 * 그룹 상세 정보 출력
	 * @param gr_id 그룹아이디
	 * @return GroupDto
	 * @author 김혜원
	 * */
	public List<Map<String, String>> grDetailSelect(Map<String, String> map);
	
	/**
	 * 그룹 생성
	 * @param map value: GroupDto, mem_id(회원아이디)
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean grInsert(Map<String, String> map);
	
	/**
	 * 그룹 정보 수정
	 * @param dto GroupDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean grModify(Map<String, String> map);
	
	/**
	 * 그룹 가입 신청
	 * @param map value:mem_id, gr_id
	 * @return boolean
	 * */
	public boolean grWaitInsert(Map<String, String> map);
		
	/**
	 * 시스템 회원 조회(아이디로 검색)->초대로
	 * @param mem_id 회원아이디
	 * @return List&lt;MemberDto&gt;
	 * @author 김혜원
	 * */
	public List<MemberDto> sysMemSelect(String mem_id);

	/**
	 * 그룹 가입 요청 리스트 출력
	 * @param gr_id 그룹아이디
	 * @return List&lt;MemberDto&gt;
	 * */
	public List<MemberDto> grWaitList(String gr_id);
	
	/**
	 * 그룹가입승인
	 * @param map value:gr_id(그룹아이디), mem_id(회원아이디)
	 * @author 김혜원
	 * */
	public boolean grMemInsert(Map<String, String> map);
	
	/**
	 * 그룹 가입 요청 거절
	 * @param map value:gr_id(그룹아이디), mem_id(회원아이디)
	 * @return boolean
	 * */
	public boolean grMemReject(Map<String, String> map);
	
	/**
	 * 그룹멤버삭제
	 * @param map value:gr_id(그룹아이디), mem_id(회원아이디)
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean grMemDelete(Map<String, String> map);
	
	/**
	 * 그룹멤버조회
	 * @param gr_id 그룹아이디
	 * @return List&lt;MemberDto&gt;
	 * @author 김혜원
	 * */
	public List<MemberDto> grMemSelect(String gr_id);
	
	/**
	 * 그룹게시판 게시글 목록
	 * @param map value:gr_id(그룹아이디), mem_id(회원아이디)
	 * @return List&lt;GroupBoardDto&gt;
	 * @author 김혜원
	 * */
	public List<GroupBoardDto> gbListSelect(String gr_id);
	
	/**
	 * 그룹게시판 게시글 검색
	 * @param map gr_id(그룹아이디), br_title(게시글 제목)
	 * @return List&lt;GroupBoardDto&gt;
	 * */
	public List<GroupBoardDto> gbNameSearch(Map<String, String> map);
	
	
	/**
	 * 그룹게시판 게시글 조회
	 * @param map value: gr_id, br_uuid, GroupBoardDto
	 * @return GroupBoardDto
	 * @author 김혜원
	 * */
	public GroupBoardDto gbViewSelect(Map<String, Object> map);
	
	/**
	 * 그룹게시판 게시글 등록
	 * @param dto GroupBoardDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean gboardInsert(GroupBoardDto dto);
	
	/**
	 * 그룹게시판 게시글 수정
	 * @param dto GroupBoardDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean gboardModify(GroupBoardDto dto);
	
	/**
	 * 그룹게시판 게시글 삭제
	 * @param br_uuid 그룹게시글번호
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean gboardDelete(String[] br_uuid);
	
	/**
	 * 그룹게시판 댓글 등록
	 * @param dto GroupBoardDto객체
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean gbCommentInsert(GroupBoardDto dto);
	
	/**
	 * 그룹게시판 댓글 수정
	 * @param map value:br_uuid(그룹게시글번호), content(내용)
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean gbCommentModify(Map<String, String> map);
	
	/**
	 * 그룹게시판 댓글 삭제
	 * @param br_uuid 그룹게시글번호
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean bgCommentDelete(String br_uuid);
	
	/**
	 * 그룹 관리자 변경
	 * @param map value: gr_id(그룹아이디), mem_id(회원아이디)
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean grMgrModify(Map<String, String> map);
	
	/**
	 * 그룹 삭제 할경우 프로젝트정보 ,그룹정보 삭제
	 * @param String gr_id
	 * @return boolean
	 * @author 라한솔
	 */
	public boolean groupDelete(String gr_id);
	
	/**
	 * 그룹 관리자 위임 
	 * @param String mem_id , mem_id2
	 * @return boolean
	 * @author 라한솔
	 */
	public boolean grManagerChange(Map<String, String> map);
	
	/**
	 * 그룹가입시 중복체크
	 * @param gr_id ,mem_id
	 * @return list
	 * @author 라한솔
	 */
	public int groupCheck (Map<String, String> map);
}
