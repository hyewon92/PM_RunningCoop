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
		Map<String, SbAttachDto> attach = new HashMap<String, SbAttachDto>();
		if(pw == null){
			view = sysBoardDao.openViewSelect(map);
		} else if (pw != null){
			view = sysBoardDao.scrViewSelect(map);
		}
		attach = sysBoardDao.sysAttachSelect(map);
		if(attach != null){
			String satt_name = ""+attach.get("SATT_NAME");
			String satt_size = ""+attach.get("SATT_SIZE");
			view.put("SATT_NAME", satt_name);
			view.put("SATT_SIZE", satt_size);
		}
		return view;
	}
	
	@Override
	public Map<String, String> editBoardViewSelect(Map<String, String> map){
		Map<String, String> view = new HashMap<String, String>();
		Map<String, SbAttachDto> attach = new HashMap<String, SbAttachDto>();
		view = sysBoardDao.editBoardViewSelect(map);
		attach = sysBoardDao.sysAttachSelect(map);
		if(attach != null){
			String satt_seq = ""+attach.get("SATT_SEQ");
			String satt_name = ""+attach.get("SATT_NAME");
			String satt_size = ""+attach.get("SATT_SIZE");
			String satt_path = ""+attach.get("SATT_PATH");
			view.put("SATT_SEQ", satt_seq);
			view.put("SATT_NAME", satt_name);
			view.put("SATT_SIZE", satt_size);
			view.put("SATT_PATH", satt_path);
		}
		return view;
	};

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
	public boolean qnaBoardEdit(SystemBoardDto dto, SbAttachDto satt) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean qnaBoardDelete(String sbr_uuid) {
		boolean bchk = sysBoardDao.sysBoardDelete(sbr_uuid);
		boolean achk = sysBoardDao.FileCheck(sbr_uuid);
		boolean aDelete = false;
		if(achk){
			aDelete = sysBoardDao.FileDelete(sbr_uuid);
		}
		if( bchk == true && aDelete == true){
			return true;
		} else {
			return false;
		}
	}

	@Override
	public Map<String, SbAttachDto> sysAttachSelect(Map<String, String> map) {
		return sysBoardDao.sysAttachSelect(map);
	}

	

}
