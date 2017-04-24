package com.pm.rc.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pm.rc.dto.GbAttachDto;
import com.pm.rc.dto.GroupBoardDto;
import com.pm.rc.dto.WorkCommentDto;
import com.pm.rc.dto.WorkDetailDto;
import com.pm.rc.dto.WorkListDto;
import com.pm.rc.model.dao.WorkListDao;

@Service
public class WorkListServiceImpl implements WorkListService {
	
	@Autowired
	private WorkListDao dao;
	
	@Override
	public List<Map<String, String>> wkListSelect(Map<String, String> map) {
		List<Map<String, String>> list = null;
		
		if(map.get("wk_condition").equals("todo")){
			list = dao.wkListSelect1(map);
		} else if(map.get("wk_condition").equals("doing")){
			list = dao.wkListSelect2(map);
		} else if(map.get("wk_condition").equals("done")){
			list = dao.wkListSelect3(map);
		}
		
		return list;
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
	public List<WorkDetailDto> wdSelect(String wk_id) {
		return dao.wdSelect(wk_id);
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
