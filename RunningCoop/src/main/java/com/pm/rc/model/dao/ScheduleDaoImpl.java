package com.pm.rc.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pm.rc.dto.ScheduleDto;

@Repository
public class ScheduleDaoImpl implements ScheduleDao {
	
	private Logger logger = LoggerFactory.getLogger(ScheduleDaoImpl.class);
	private final String NAMESPACE = "com.pm.rc.accountMapper.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<ScheduleDto> teamSchSelect(String pr_id) {
		return null;
	}

	@Override
	public boolean teamSchInsert(ScheduleDto dto) {
		return false;
	}

	@Override
	public List<ScheduleDto> mySchSelect2(String mem_id) {
		return null;
	}

	@Override
	public boolean schInsert(ScheduleDto dto) {
		int n = sqlSession.insert(NAMESPACE+"schInsert", dto);
		return n>0 ? true:false;
	}

	@Override
	public boolean schModify(ScheduleDto dto) {
		return false;
	}

	@Override
	public boolean schDelete(String seq) {
		return false;
	}

}
