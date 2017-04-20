package com.pm.rc.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pm.rc.dto.GroupDto;
import com.pm.rc.dto.MemberDto;

@Repository
public class GroupDaoImp implements GroupDao{
	
	private Logger logger = LoggerFactory.getLogger(GroupDaoImp.class);
	
	private final String  NAMESPACE = "com.pm.rc.groupMapper.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<GroupDto> myGrSelect(Map<String, String> map) {
		List<GroupDto> lists = sqlSession.selectList(NAMESPACE+"myGrSelect" , map);
		logger.info("myGrSelect 작동결과");
		return lists;
	}

	@Override
	public List<Map<String, String>> grDetailSelect (Map<String,String> map) {
	List<Map<String, String>> lists = sqlSession.selectList(NAMESPACE +"grDetailSelect" , map);
		logger.info("grDetailSelect 작동결과");
		return lists;
	}

	@Override
	public List<GroupDto> allGrSelect(Map<String, String> map) {
		List<GroupDto> lists = sqlSession.selectList(NAMESPACE+"allGrSelect", map);
		logger.info("allGrSelect 작동결과 (그룹검색)");
		return lists;
	}

	@Override
	public boolean grInsert1(Map<String, Object> map) {
		return false;
	}

	@Override
	public boolean grInsert2(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean grModify(Map<String, String> map) {
		int n = sqlSession.update(NAMESPACE+"grModify", map);
		logger.info("grModify 작동결과");
		return n>0 ? true : false;
	}

	@Override
	public boolean grWaitInsert(Map<String, String> map) {
		System.out.println("mem_id:"+map.get("mem_id"));
		System.out.println("gr_id:"+map.get("gr_id"));
		int n  = sqlSession.insert(NAMESPACE+"grWaitInsert" , map);
	return n>0 ? true : false;
	}

	@Override
	public boolean grDelete(String gr_id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<MemberDto> sysMemSelect(String mem_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MemberDto> grWaitList(String gr_id) {
		List<MemberDto> lists = sqlSession.selectList(NAMESPACE+"grWaitList", gr_id);
		return lists;
	}

	@Override
	public boolean grMemInsert1(Map<String, String> map) {
		int rst = sqlSession.insert(NAMESPACE+"grMemInsert1",map);
		return rst>0? true:false;
	}

	@Override
	public boolean grMemInsert2(Map<String, String> map) {
		int rst = sqlSession.delete(NAMESPACE+"grMemInsert2" , map);
		return rst>0? true:false;
	}

	@Override
	public boolean grMemInsert3(Map<String, String> map) {
		int rst = sqlSession.update(NAMESPACE+"grMemInsert3" , map);
		return rst>0? true:false;
	}

	@Override
	public boolean grMemReject(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean grMemDelete1(Map<String, String> map) {
		logger.info("grMemDelete1 작동결과 ");
		int n = sqlSession.delete(NAMESPACE+"grMemDelete1" ,map);
		return n>0 ? true : false;
	}

	@Override
	public boolean grMemDelete2(String gr_id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<MemberDto> grMemSelect(String gr_id) {
		List<MemberDto> list = sqlSession.selectList(NAMESPACE+"grMemSelect", gr_id);
		logger.info("그룹멤버출력기능시작");
		return list;
	}

	@Override
	public boolean grMgrModify(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

}
