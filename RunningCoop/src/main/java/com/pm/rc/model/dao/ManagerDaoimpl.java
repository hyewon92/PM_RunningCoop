package com.pm.rc.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pm.rc.dto.GroupDto;
import com.pm.rc.dto.ManagePagingDto;
import com.pm.rc.dto.MemberDto;

@Repository
public class ManagerDaoimpl implements ManagerDao {
	
	private Logger logger = LoggerFactory.getLogger(ManagerDaoimpl.class); 
	
	private final String NAMESPACE = "com.pm.rc.manager.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<GroupDto> grApplySelect(String gr_name) {
		logger.info("그룹생성신청daoimp 시작");
		Map<String, String> map = new HashMap<String, String>();
		map.put("gr_name", gr_name);
		List<GroupDto> lists = sqlSession.selectList(NAMESPACE+"grApplySelect",map);
		return lists;
	}
	
	@Override
	public List<GroupDto> grApplySelectGroup(String gr_id) {
		logger.info("그룹신청간략정보");
		List<GroupDto> lists = sqlSession.selectList(NAMESPACE+"grApplySelectGroup" , gr_id);
		return lists;
	}

	@Override
	public List<GroupDto> grApplySelectGr(String gr_name) {
		logger.info("그룹생성신청 그룹이름으로 검색 시작");
		List<GroupDto> lists = sqlSession.selectList(NAMESPACE+"grApplySelectGr" , gr_name);
		return lists;
	}

	@Override
	public boolean grDelete(String gr_id) {
		int n = sqlSession.delete(NAMESPACE+"grDelete",gr_id);
		return n>0? true:false;
	}

	@Override
	public boolean grDelete2(String gr_id) {
		int n = sqlSession.delete(NAMESPACE+"grDelete2",gr_id);
		return n>0? true:false;
	}

	@Override
	public List<MemberDto> allMemberSelect(ManagePagingDto maPaging) {
		return sqlSession.selectList(NAMESPACE+"allMemberSelect",maPaging);
	}
	
	@Override
	public int allMemberSelectCount() {
		return sqlSession.selectOne(NAMESPACE+"allMemberSelectCount");
	}

	@Override
	public List<MemberDto> allMemberSelectSearch(Map<String, String> map) {
		return sqlSession.selectList(NAMESPACE+"allMemberSelectSearch", map);
	}
	
	@Override
	public MemberDto sysMemView(String mem_id) {
		return sqlSession.selectOne(NAMESPACE+"sysMemView", mem_id);
	}
	

	@Override
	public Boolean sysMemModify(MemberDto dto) {
		int rst = sqlSession.update(NAMESPACE+"sysMemModify", dto);
		return rst > 0 ? true: false;
	}

	@Override
	public boolean grAppModify(String gr_id) {
		int rst = sqlSession.update(NAMESPACE+"grAppModify" , gr_id);
		return rst>0? true:false;
	}

	@Override
	public boolean noticeInsert_1(Map<String, String> map) {
		int num = sqlSession.insert(NAMESPACE+"noticeInsert_1", map);
		return num>0?true:false;
	}
	
	@Override
	public boolean noticeInsert_2(Map<String, String> map){
		int num = sqlSession.insert(NAMESPACE+"noticeInsert_2", map);
		return num>0?true:false;
	}

	@Override
	public boolean noticeModify_1(Map<String, String> map) {
		int num = sqlSession.update(NAMESPACE+"noticeModify_1", map);
		return num>0?true:false;
	}
	
	@Override
	public boolean noticeModify_2(Map<String, String> map){
		int num = sqlSession.update(NAMESPACE+"noticeModify_2", map);
		return num>0?true:false;
	}

	@Override
	public boolean qnaReplyInsert_1(Map<String, String> map) {
		int num = sqlSession.insert(NAMESPACE+"qnaReplyInsert_1", map);
		return num>0?true:false;
	}
	
	@Override
	public boolean qnaReplyInsert_2(Map<String, String> map){
		int num = sqlSession.insert(NAMESPACE+"qnaReplyInsert_2", map);
		return num>0?true:false;
	}

}
