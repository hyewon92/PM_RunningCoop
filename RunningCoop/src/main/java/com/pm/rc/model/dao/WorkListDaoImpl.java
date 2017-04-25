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
		List<Map<String, String>> list = null;
		list = sqlSession.selectList(NAMESPACE+"wkListSelect1", map);
		return list;
	}

	@Override
	public List<Map<String, String>> wkListSelect2(Map<String, String> map) {
		List<Map<String, String>> list = null;
		list = sqlSession.selectList(NAMESPACE+"wkListSelect2", map);
		return list;
	}

	@Override
	public List<Map<String, String>> wkListSelect3(Map<String, String> map) {
		List<Map<String, String>> list = null;
		list = sqlSession.selectList(NAMESPACE+"wkListSelect3", map);
		return list;
	}

	@Override
	public boolean wkListInsert(WorkListDto dto) {
		int num = sqlSession.insert(NAMESPACE+"wkListInsert", dto);
		if( num > 0){
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean wkListDelete_1(String wk_id) {
		int num = sqlSession.update(NAMESPACE+"wkListDelete_1", wk_id);
		if(num > 0){
			return true;
		} else {
			return false;
		}
	}
	
	@Override
	public boolean wkListDelete_2(String wk_id) {
		int num = sqlSession.update(NAMESPACE+"wkListDelete_2", wk_id);
		if (num > 0){
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean wkListModify(WorkListDto dto) {
		int num = sqlSession.update(NAMESPACE+"wkListModify", dto);
		if (num > 0){
			return true;
		} else {
			return false;
		}
	}

	
	@Override
	public int wkRateModify_1(String wk_id){
		List<WorkDetailDto> list = null;
		list = sqlSession.selectList(NAMESPACE+"wdSelect", wk_id);
		int size = list.size();
		return size;
	}
	
	@Override
	public int wkRateModify_2(String wk_id){
		List<WorkDetailDto> list = null;
		list = sqlSession.selectList(NAMESPACE+"wdComplSelect", wk_id);
		int size = list.size();
		return size;
	}
	
	@Override
	public boolean wkRateModify_3(Map<String, Object> map){
		int num = sqlSession.update(NAMESPACE+"wkProRateEdit", map);
		if (num > 0){
			return true;
		} else {
			return false;
		}
	}

	@Override
	public List<WorkDetailDto> wdSelect(String wk_id) {
		List<WorkDetailDto> dto = null;
		dto = sqlSession.selectList(NAMESPACE+"wdSelect", wk_id);
		return dto;
	}

	@Override
	public boolean wdInsert(WorkDetailDto dto) {
		int num = sqlSession.insert(NAMESPACE+"wdInsert", dto);
		if(num > 0){
			return true;
		} else{
			return false;
		}
	}

	@Override
	public boolean wdModify(WorkDetailDto dto) {
		int num = sqlSession.update(NAMESPACE+"wdModify", dto);
		if(num > 0){
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean wdDelete(String wd_id) {
		int num = sqlSession.update(NAMESPACE+"wdDelete", wd_id);
		if(num > 0){
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean wdErrorChk(String wd_id) {
		int num = sqlSession.update(NAMESPACE+"wdErrorChk", wd_id);
		if(num > 0){
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean wdComplModify(String wd_id) {
		int num = sqlSession.update(NAMESPACE+"wdComplModify", wd_id);
		if(num > 0){
			return true;
		} else {
			return false;
		}
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
