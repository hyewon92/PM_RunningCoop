package com.pm.rc.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pm.rc.dto.GbAttachDto;
import com.pm.rc.dto.GroupBoardDto;
import com.pm.rc.dto.WorkCommentDto;
import com.pm.rc.dto.WorkDetailDto;
import com.pm.rc.dto.WorkListDto;

@Repository
public class WorkListDaoImpl implements WorkListDao {
	
	private final String NAMESPACE = "com.pm.rc.worklist.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Map<String, String>> wkListSelect1(Map<String, String> map) {
		return sqlSession.selectList(NAMESPACE+"wkListSelect1", map);
	}

	@Override
	public List<Map<String, String>> wkListSelect2(Map<String, String> map) {
		return sqlSession.selectList(NAMESPACE+"wkListSelect2", map);
	}

	@Override
	public List<Map<String, String>> wkListSelect3(Map<String, String> map) {
		return sqlSession.selectList(NAMESPACE+"wkListSelect3", map);
	}

	@Override
	public boolean wkListInsert(WorkListDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean wkListDelete(String wk_id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean wkListModify(WorkListDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean wkRateMoidfy(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public WorkDetailDto wdSelect(String wk_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean wdInsert(WorkDetailDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean wdModify(WorkDetailDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean wdDelete(String wd_id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean wdErrorChk(String wd_id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean wdComplModify(String wd_id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<WorkCommentDto> wCommListSelect(String wk_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean wCommentInsert(WorkCommentDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean wCommentModify(WorkCommentDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean wCommentDelete(String wcom_id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<GbAttachDto> btAttachSelect(String wk_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean gbAttachInsert(GroupBoardDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean gbAttachModify(String gatt_seq) {
		// TODO Auto-generated method stub
		return false;
	}

}
