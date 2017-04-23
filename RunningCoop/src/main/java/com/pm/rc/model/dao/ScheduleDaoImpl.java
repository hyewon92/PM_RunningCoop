package com.pm.rc.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pm.rc.dto.ProjectDto;
import com.pm.rc.dto.ScheduleDto;

@Repository
public class ScheduleDaoImpl implements ScheduleDao {
	
	private Logger logger = LoggerFactory.getLogger(ScheduleDaoImpl.class);
	private final String NAMESPACE = "com.pm.rc.scheduleMapper.";
	
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
	public List<ScheduleDto> mySchSelect(String mem_id) {
		List<ScheduleDto> lists = new ArrayList<ScheduleDto>();
		lists = sqlSession.selectList(NAMESPACE+"mySchSelect", mem_id);
		return lists;
	}
	
	@Override
	public ScheduleDto mySchView(String sch_seq) {
		ScheduleDto dto = new ScheduleDto();
		dto = sqlSession.selectOne(NAMESPACE+"mySchView", sch_seq);
		return dto;
	}

	@Override
	public boolean schInsert(ScheduleDto dto) {
		int n = sqlSession.insert(NAMESPACE+"schInsert", dto);
		return n>0 ? true:false;
	}

	@Override
	public boolean schModify(ScheduleDto dto) {
		int n = sqlSession.update(NAMESPACE+"schModify", dto);
		return n>0 ? true:false;
	}

	@Override
	public boolean schDelete(String seq) {
		int n = sqlSession.delete(NAMESPACE+"schDelete", seq);
		return n>0 ? true:false;
	}

}
