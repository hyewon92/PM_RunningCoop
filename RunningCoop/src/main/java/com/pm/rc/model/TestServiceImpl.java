package com.pm.rc.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TestServiceImpl implements TestService {

	// 24. IoC 실행 DAO를 Autowired
	@Autowired
	private TestDao dao;
	
/*	@Override
	public boolean testPrint(String name) {
		return false;
	}
	*/
	@Override
	// 29. annotation으로 Transaction 처리
//	@Transactional -> insert, delete, update
//	@Transactional(readOnly=true) //-> select
	public boolean testPrint(String name) {
		return dao.testPrint(name);
	}

}
