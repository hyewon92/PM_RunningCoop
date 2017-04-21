package com.pm.rc.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pm.rc.dto.SbAttachDto;
import com.pm.rc.dto.SystemBoardDto;

@Repository
public class SysBoardDaoImpl implements SysBoardDao {
	
	private final String NAMESPACE = "com.pm.rc.sysBoard.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Map<String, String>> noticeListSelect() {
		List<Map<String, String>> list;
		list = sqlSession.selectList(NAMESPACE+"noticeListSelect");
		return list;
	}

	@Override
	public List<Map<String, String>> noticeSearchSelect(Map<String, String> map) {
		List<Map<String, String>> list;
		list = sqlSession.selectList(NAMESPACE+"noticeSearchSelect", map);
		return list;
	}

	@Override
	public List<Map<String, String>> qnaListSelect() {
		List<Map<String, String>> list;
		list = sqlSession.selectList(NAMESPACE+"qnaListSelect");
		return list;
	}

	@Override
	public List<Map<String, String>> qnaSearchSelect(Map<String, String> map) {
		List<Map<String, String>> list;
		list = sqlSession.selectList(NAMESPACE+"qnaSearchSelect", map);
		return list;
	}

	@Override
	public Map<String, String> openViewSelect(Map<String, String> map) {
		Map<String, String> view = new HashMap<String, String>();
		view = sqlSession.selectOne(NAMESPACE+"openViewSelect", map);
		return view;
	}

	@Override
	public Map<String, String> scrViewSelect(Map<String, String> map) {
		Map<String, String> view = new HashMap<String, String>();
		view = sqlSession.selectOne(NAMESPACE+"scrViewSelect", map);
		return view;
	}
	
	@Override
	public Map<String, String> editBoardViewSelect(Map<String, String> map){
		Map<String, String> view = new HashMap<String, String>();
		view = sqlSession.selectOne(NAMESPACE+"editViewSelect", map);
		return view;
	};

	@Override
	public Map<String, String> sysViewSelect(Map<String, String> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Map<String, String>> sysAttachSelect(Map<String, String> map) {
		List<Map<String, String>> attach = null;
		attach = sqlSession.selectList(NAMESPACE+"sysAttachSelect", map);
		return attach;
	}
	
	@Override
	public boolean noticeBoardInsert(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean qnaBoardInsert(Map<String, Object> map) {
		boolean isc = false;
		int num = sqlSession.insert(NAMESPACE+"qnaBoardInsert", map);
		if(num > 0){
			isc = true;
		} else {
			isc = false;
		}
		return isc; 
	}

	@Override
	public boolean qnaReplyInsert(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean FileInsert(Map<String, Object> map) {
		boolean isc = false;
		int num = sqlSession.insert(NAMESPACE+"FileInsert", map);
		if(num > 0){
			isc = true;
		}
		return isc;
	}

	@Override
	public boolean sysBoardUpdate(SystemBoardDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean FileUpdate(SbAttachDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean sysBoardDelete(String sbr_uuid) {
		boolean isc = false;
		int num = sqlSession.update(NAMESPACE+"sysBoardDelete", sbr_uuid);
		if(num > 0){
			isc = true;
		}
		return isc;
	}
	
	@Override
	public boolean FileCheck(String sbr_uuid) {
		boolean isc = false;
		Map<String, String> uuid = new HashMap<String, String>();
		uuid.put("sbr_uuid", sbr_uuid);
		Map<String, SbAttachDto> attach = new HashMap<String, SbAttachDto>();
		attach = sqlSession.selectOne(NAMESPACE+"sysAttachSelect", uuid);
		if( attach != null){
			isc = true;
		}
		return isc;
	}

	@Override
	public boolean FileDelete(String sbr_uuid) {
		boolean isc = false;
		int num = sqlSession.delete(NAMESPACE+"sysAttachDelete", sbr_uuid);
		if (num > 0){
			isc = true;
		}
		return isc;
	}


}
