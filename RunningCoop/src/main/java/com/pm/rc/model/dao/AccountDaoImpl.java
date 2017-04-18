package com.pm.rc.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pm.rc.dto.MemberDto;

@Repository
public class AccountDaoImpl implements AccountDao {
	
	private Logger logger = LoggerFactory.getLogger(AccountDaoImpl.class);
	private final String NAMESPACE = "com.pm.rc.accountMapper.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public MemberDto loginPro(Map<String, String> map) {
		MemberDto loginDto = new MemberDto();
		loginDto = sqlSession.selectOne(NAMESPACE+"loginPro", map);
		return loginDto;
	}

	@Override
	public String memIdSelect(String mem_id) {
		String result = sqlSession.selectOne(NAMESPACE+"memIdSelect", mem_id);
		return result;
	}

	@Override
	public boolean memInsert(MemberDto dto) {
		int n = sqlSession.insert(NAMESPACE+"memInsert", dto);
		return n>0 ? true:false;
	}

	@Override
	public String memIdSearch(Map<String, String> map) {
		String result = sqlSession.selectOne(NAMESPACE+"memIdSearch", map);
		return result;
	}
	
	@Override
	public boolean memIdEmailChk(Map<String, String> map) {
		int result = sqlSession.selectOne(NAMESPACE+"memIdEmailChk", map);
		System.out.println("<<<<result>>>>:"+result);
		return result==1 ? true:false;
	}

	@Override
	public boolean memPwModify(Map<String, String> map) {
		int n = sqlSession.update(NAMESPACE+"memPwModify", map);
		return n>0 ? true:false;
	}

	@Override
	public MemberDto memSelect(String mem_id) {
		MemberDto dto = sqlSession.selectOne(NAMESPACE+"memSelect", mem_id);
		return dto;
	}

	@Override
	public boolean memInfoModify(MemberDto dto) {
		int n = sqlSession.update(NAMESPACE+"memInfoModify", dto);
		return n>0 ? true:false;
	}

	@Override
	public List<Map<String, String>> levelGmSelect(String mem_id) {
		List<Map<String, String>> result;
		result = sqlSession.selectList(NAMESPACE+"levelGmSelect", mem_id);
		return result;
	}

	@Override
	public List<Map<String, String>> levelPmSelect(String mem_id) {
		List<Map<String, String>> result;
		result = sqlSession.selectList(NAMESPACE+"levelPmSelect", mem_id);
		return result;
	}

	@Override
	public boolean memDelete_1(String mem_id) {
		int n = sqlSession.delete(NAMESPACE+"memDelete_1", mem_id);
		return n>0 ? true:false;
	}

	@Override
	public boolean memDelete_2() {
		int n = sqlSession.update(NAMESPACE+"memDelete_2");
		return n>0 ? true:false;
	}

	@Override
	public boolean memDelete_3(String mem_id) {
		int n = sqlSession.delete(NAMESPACE+"memDelete_3", mem_id);
		return n>0 ? true:false;
	}

	@Override
	public boolean memDelete_4() {
		int n = sqlSession.update(NAMESPACE+"memDelete_4");
		return n>0 ? true:false;
	}

	@Override
	public boolean memDelete_5(String mem_id) {
		int n = sqlSession.update(NAMESPACE+"memDelete_5", mem_id);
		return n>0 ? true:false;
	}

	@Override
	public boolean memDelete_6(String mem_id) {
		int n = sqlSession.delete(NAMESPACE+"memDelete_6", mem_id);
		return n>0 ? true:false;
	}

	@Override
	public boolean memDelete_7(String mem_id) {
		int n = sqlSession.delete(NAMESPACE+"memDelete_7", mem_id);
		return n>0 ? true:false;
	}

	@Override
	public boolean memDelete_8(String mem_id) {
		int n = sqlSession.update(NAMESPACE+"memDelete_8", mem_id);
		return n>0 ? true:false;
	}

}
