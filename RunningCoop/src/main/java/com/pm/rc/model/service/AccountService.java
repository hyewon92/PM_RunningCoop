package com.pm.rc.model.service;

import java.util.List;
import java.util.Map;

import com.pm.rc.dto.MemberDto;

/**
 * 회원계정 관련 기능 인터페이스
 * @author 김혜원
 * @version AccountService Beta 1.0
 * */
public interface AccountService {
	
	/**
	 * 로그인 프로세스
	 * @param map value:mem_id(회원아이디), mem_pw(회원비밀번호)
	 * @return MemberDto로 회원의 아이디와 이름을 받아 세션을 생성할 때 사용
	 * @author 김호빈
	 */
	public List<MemberDto> loginPro(Map<String, String> map);
	
	/**
	 * 회원가입 시 아이디 중복 조회 프로세스
	 * @param mem_id - 회원이 입력한 아이디를 value로 전송
	 * @return 중복되면 사용불가, 중복이 없으면 사용가능
	 * @author 김호빈
	 */
	public String memIdSelect(String mem_id);
	
	/**
	 * 회원 등록 프로세스
	 * @param dto 회원이 폼에 작성한 데이터를 MemberDto로 value 전송
	 * @return 정상적으로 등록되면 true, 등록되지 않으면 false 반환
	 * @author 김호빈
	 */
	public boolean memInsert(MemberDto dto);
	
	/**
	 * 아이디 찾기(아이디 분실했을 때)
	 * @param map - MemberDto를 key로 하고 회원이 입력한 값을 value로 전송
	 * @return 두가지 값을 비교하여 나오는 아이디를 String으로 반환
	 * @author 김호빈
	 */
	public String memIdSearch(Map<String, MemberDto> map);
	
	/**
	 * 비밀번호 변경
	 * @author 김혜원
	 * */
	public boolean memPwModify(String mem_id);
	
	/**
	 * 계정정보조회
	 * @author 김혜원
	 * */
	public MemberDto memSelect(String mem_id);
	
	/**
	 * 계정 정보 수정(mem_id, MemberDto)
	 * @author 김혜원
	 * */
	public boolean memInfoModify(Map<String, MemberDto> map);
	
	/**
	 * GM으로 소속된 그룹 찾기
	 * @param mem_id 회원아이디
	 * @author 김혜원
	 * */
	public Map<String, String[]> levelGmSelect(String mem_id); 
	
	
	/**
	 * PM으로 소속된 프로젝트 찾기
	 * @param mem_id 회원아이디
	 * @author 김혜원
	 * */
	public Map<String, String[]> levelPmSelect(String mem_id); 
	
	/**
	 * 서비스 탈퇴 (dao많음 주의)
	 * @author 김혜원
	 * */
	public boolean memDelete(String mem_id);

}
