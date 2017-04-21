package com.pm.rc.model.service;

import java.util.List;

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
	public List<GroupDto> grApplySelect() {
		return managerdao.grApplySelect();
	}

	@Override
	public List<GroupDto> grApplySelectGr(String gr_name) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@Transactional
	public boolean grDelete(String[] gr_id) {
		boolean rst = false;
		for(int i = 0 ; i< gr_id.length; i++){
			rst = managerdao.grDelete(gr_id[i]);
			rst = managerdao.grDelete2(gr_id[i]);
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
	public boolean noticeInsert(SystemBoardDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean noticeModify(SystemBoardDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean noticeDelete(String sbr_uuid) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<SystemBoardDto> qnaListSelect() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean qnaReplyInsert(SystemBoardDto dto) {
		// TODO Auto-generated method stub
		return false;
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
