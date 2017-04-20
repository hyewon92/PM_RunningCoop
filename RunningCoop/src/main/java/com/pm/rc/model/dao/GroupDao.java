package com.pm.rc.model.dao;

import java.util.List;
import java.util.Map;

import com.pm.rc.dto.GbAttachDto;
import com.pm.rc.dto.GroupBoardDto;
import com.pm.rc.dto.GroupDto;
import com.pm.rc.dto.MemberDto;

/**
 * 그룹 관련 기능 인터페이스
 * @author 김혜원
 * @version GroupService Beta 1.0
 **/
public interface GroupDao {

	/**
	 *내가 가입한 그룹 조회(접속할 그룹 선택)
	 * @param mem_id 회원 아이디
	 * @return List&lt;GroupDto&gt;
	 * @author 김혜원
	 * */
	public List<GroupDto> myGrSelect(Map<String, String> map);
	
	/**
	 * 그룹 상세 정보 출력
	 * @param gr_id 그룹아이디
	 * @return List&lt;GroupDto&gt;
	 * @author 김혜원
	 * */
	public List<Map<String, String>> grDetailSelect (Map<String, String> map);
	
	/**
	 *  그룹 검색 조회(그룹명)
	 * @param  gr_name 그룹명
	 * @return GroupDto
	 * @author 김혜원
	 * */
	public  List<GroupDto>  allGrSelect(Map<String, String> map);
	
	/**
	 * 그룹 생성--1.그룹테이블
	 * @param map value: GroupDto, mem_id(회원아이디)
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean grInsert1(Map<String, Object> map);
	
	/**
	 * 그룹 생성--2.그룹소속테이블
	 * @param valu: GroupDto, mem_id 회원아이디
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean grInsert2(Map<String, String> map);
	
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
	 * 그룹 삭제(해체)
	 * @param gr_id 그룹아이디
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean grDelete(String gr_id);
	
	/**
	 * 시스템 회원 조회(아이디로 검색)->초대로
	 * @return List&lt;MemberDto&gt;
	 * @param mem_id 회원아이디
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
	 * 그룹멤버추가--1.가입승인
	 * @param map value:gr_id(그룹아이디), mem_id(회원아이디)
	 * @author 김혜원
	 * */
	public boolean grMemInsert1(Map<String, String> map);
	
	/**
	 * 그룹멤버추가--2.가입리스트 삭제
	 * @param map value:gr_id(그룹아이디), mem_id(회원아이디)
	 * @author 김혜원
	 * */
	public boolean grMemInsert2(Map<String, String> map);
	
	/**
	 * 그룹멤버추가--3.그룹멤버인원수 증가
	 * @param gr_id 그룹아이디
	 * @author 김혜원
	 * */
	public boolean grMemInsert3(String gr_id);
	
	/**
	 * 그룹 가입 요청 거절
	 * @param map value:gr_id(그룹아이디), mem_id(회원아이디)
	 * @return boolean
	 * */
	public boolean grMemReject(Map<String, String> map);
	
	/**
	 * 그룹멤버삭제(강제탈퇴)--1.테이블에서 지우기
	 * @param map value:gr_id(그룹아이디), mem_id(회원아이디)
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean grMemDelete1(Map<String, String> map);
	
	/**
	 * 그룹멤버삭제(강제탈퇴)--2.그룹 인원 수 수정
	 * @param gr_id 그룹아이디
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean grMemDelete2(String gr_id);
	
	/**
	 * 그룹멤버조회(멤버리스트 출력)
	 * @param gr_id 그룹아이디
	 * @return List&lt;MemberDto&gt;
	 * @author 김혜원
	 * */
	public List<MemberDto> grMemSelect(String gr_id);
	
	/**
	 * 그룹 관리자 변경
	 * @param map value: gr_id(그룹아이디), mem_id(회원아이디)
	 * @return boolean
	 * @author 김혜원
	 * */
	public boolean grMgrModify(Map<String, String> map);
	
}
