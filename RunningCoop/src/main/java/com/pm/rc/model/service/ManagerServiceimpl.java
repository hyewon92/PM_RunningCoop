package com.pm.rc.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pm.rc.dto.GroupDto;
import com.pm.rc.dto.MemberDto;
import com.pm.rc.dto.SystemBoardDto;
import com.pm.rc.model.dao.ManagerDao;

@Service
public class ManagerServiceimpl implements ManagerService {

	@Autowired
	private ManagerDao managerdao;
	
	@Override
	public List<GroupDto> grApplySelect(String gr_name) {
		return managerdao.grApplySelect(gr_name);
	}
	
	@Override
	public List<GroupDto> grApplySelectGroup(String gr_id) {
		return managerdao.grApplySelectGroup(gr_id);
	}

	@Override
	public List<GroupDto> grApplySelectGr(String gr_name) {
		
		return managerdao.grApplySelectGr(gr_name);
	}

	@Override
	@Transactional
	public boolean grDelete(String[] gr_id) {
		boolean rst = false;
		for(int i = 0 ; i< gr_id.length; i++){
			rst = managerdao.grDelete2(gr_id[i]);
			rst = managerdao.grDelete(gr_id[i]);
		}
		return rst;
	}

	@Override
	public List<MemberDto> allMemberSelect() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MemberDto> allMemberSelectSearch(String mem_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@Transactional
	public boolean grAppModify(String[] gr_id) {
		boolean isc = false;
		for(int i = 0 ; i < gr_id.length; i++){
			isc = managerdao.grAppModify(gr_id[i]);
		}
		return isc;
	}

	@Override
	@Transactional
	public boolean noticeInsert(Map<String, String> map) {
		boolean isc = false;
		if(map.get("satt_name")!=null){
			isc = managerdao.noticeInsert_1(map);
		}
		isc = managerdao.noticeInsert_2(map);
		return isc;
	}

	@Override
	public boolean noticeModify(Map<String, String> map) {
		boolean isc = false;
		String satt_name = map.get("satt_name");
		if(satt_name != null){
			isc = managerdao.noticeModify_1(map);
		}
		isc = managerdao.noticeModify_2(map);
		return isc;
	}

	@Override
	public boolean qnaReplyInsert(Map<String, String> map) {
		boolean isc = false;
		String satt_name = (String)map.get("satt_name");
		if(satt_name != null){
			isc = managerdao.qnaReplyInsert_1(map);
		}
		isc = managerdao.qnaReplyInsert_2(map);
		return isc;
	}

	@Override
	public boolean qnaReplyModify(SystemBoardDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean qnaReplyDelete(String sbr_uuid) {
		// TODO Auto-generated method stub
		return false;
	}



}
