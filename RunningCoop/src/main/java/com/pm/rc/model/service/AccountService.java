package com.pm.rc.model.service;

import java.util.List;
import java.util.Map;

import com.pm.rc.dto.MemberDto;

/**
 * 회원계정 관련 기능 인터페이스
 * @author 김혜원
 * */
public interface AccountService {
	
	/**
	 * 아이디조회(중복조회)
	 * @author 김혜원
	 * */
	public List<String> memIdSelect(String id);
	
	/**
	 * 회원등록
	 * @author 김혜원
	 * */
	public boolean MemInsert(MemberDto dto);
	
	/**
	 * 비밀번호 변경
	 * @author 김혜원
	 * */
	public boolean MemPwModify(String id);
	
	/**
	 * 계정정보조회
	 * @author 김혜원
	 * */
	public List<MemberDto> memListSelect(String id);
	
	/**
	 * 계정 정보 수정(mem_id, MemberDto)
	 * @author 김혜원
	 * */
	public boolean MemInfoModfy(Map<String, MemberDto> map);
	
	/**
	 * 계정탈퇴
	 * @author 김혜원
	 * */
	public boolean MemDelete(String id);

}
