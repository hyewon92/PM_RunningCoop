package com.pm.rc.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pm.rc.dto.SbAttachDto;
import com.pm.rc.dto.SystemBoardDto;
import com.pm.rc.model.dao.SysBoardDao;

@Service
public class UserSysBoardServiceImpl implements UserSysBoardService {
	
	@Autowired
	private SysBoardDao sysBoardDao;

	@Override
	public List<Map<String, String>> noticeListSelect() {
		return sysBoardDao.noticeListSelect();
	}

	@Override
	public List<Map<String, String>> noticeSearchSelect(Map<String, String> map) {
		return sysBoardDao.noticeSearchSelect(map);
	}

	@Override
	public List<Map<String, String>> qnaListSelect() {
		return sysBoardDao.qnaListSelect();
	}

	@Override
	public List<Map<String, String>> qnaSearchSelect(Map<String, String> map) {
		return sysBoardDao.qnaSearchSelect(map);
	}

	@Override
	public Map<String, String> sysBoardViewSelect(Map<String, String> map) {
		String pw = map.get("sbr_pw");
		Map<String, String> view = new HashMap<String, String>();
		Map<String, String> attach = new HashMap<String, String>();
		if(pw == null){
			view = sysBoardDao.openViewSelect(map);
		} else if (pw != null){
			view = sysBoardDao.scrViewSelect(map);
		}
		attach = sysBoardDao.sysAttachSelect(map);
		if(attach != null){
			view.put("SATT_NAME", attach.get("SATT_NAME"));
			view.put("SATT_SIZE", attach.get("SATT_SIZE"));
		}
		return view;
	}

	@Override
	public boolean qnaBoardInsert(SystemBoardDto dto, SbAttachDto satt) {
		boolean board = sysBoardDao.qnaBoardInsert(dto);
		boolean attach = sysBoardDao.FileInsert(satt);
		boolean isc = false;
		if(board == true && attach == true){
			isc = true;
		} else {
			isc = false;
		}
		return isc;
	}

	@Override
	public boolean qnaBoardModify(SystemBoardDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean qnaBoardDelete(String sbr_uuid) {
		// TODO Auto-generated method stub
		return false;
	}

	

}
