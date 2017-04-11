package com.pm.rc.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//22. Model 연결을 위한 MyBatis 실행
@Repository
public class TestDaoImpl implements TestDao {

	private Logger logger = LoggerFactory.getLogger(TestDaoImpl.class);
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Override
	public boolean testPrint(String name) {
		String sqlses = sqlsession.toString();
		logger.info("sqlsession 객체 \t{}", sqlses);
		return true;
	}
	
	
	

}
