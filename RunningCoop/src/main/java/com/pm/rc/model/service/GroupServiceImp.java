package com.pm.rc.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pm.rc.dto.GroupBoardDto;
import com.pm.rc.dto.GroupDto;
import com.pm.rc.dto.MemberDto;
import com.pm.rc.model.dao.GroupBoardDao;
import com.pm.rc.model.dao.GroupDao;

@Service
public class GroupServiceImp implements GroupService{
	
	@Autowired
	private GroupDao groupdao; 
	@Autowired
	private GroupBoardDao groupboarddao;

	@Override
	public List<GroupDto> myGrSelect(Map<String, String> map) {
		return groupdao.myGrSelect(map);
	}

	@Override
	public List<Map<String, String>> grDetailSelect (Map<String, String> map) {
		return groupdao.grDetailSelect(map);
	}

	@Override
	public  List<GroupDto>  allGrSelect(Map<String, String> map) {
		return groupdao.allGrSelect(map);
	}

	@Override
	@Transactional
	public boolean grInsert(Map<String, String> map) {
		boolean rst = false;
		rst = groupdao.grInsert1(map);
		rst = groupdao.grInsert2(map);
		return rst;
	}

	@Override
	public boolean grModify(Map<String, String> map) {
		// TODO Auto-generated method stub
		return groupdao.grModify(map);
	}

	@Override
	public boolean grWaitInsert(Map<String, String> map) {
		
		return groupdao.grWaitInsert(map);
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
		return groupdao.grWaitList(gr_id);
	}

	@Override
	@Transactional
	public boolean grMemInsert(Map<String, String> map) {
		boolean isc = false;
		isc = groupdao.grMemInsert1(map);
		isc = groupdao.grMemInsert2(map);
		isc = groupdao.grMemInsert3(map);
		return isc;
	}

	@Override
	public boolean grMemReject(Map<String, String> map) {
		boolean isc =false;
		isc = groupdao.grMemInsert2(map);
		return isc;
	}

	@Override
	public boolean grMemDelete(Map<String, String> map) {
		
		return groupdao.grMemDelete1(map);
	}

	@Override
	public List<MemberDto> grMemSelect(String gr_id) {
		return groupdao.grMemSelect(gr_id);
	}
	
	@Override
	@Transactional
	public boolean grMemMultDelete(Map<String, String> map) {
		boolean isc = false;
		for(int i = 0 ; i < map.size(); i++){
			isc =groupdao.grMemDelete1(map);
			if(isc == false){
				break;
			}
		}
		return isc;
	}

	@Override
	public List<GroupBoardDto> gbListSelect(String gr_id) {
		
		return groupboarddao.gbListSelect(gr_id);
	}

	@Override
	public List<GroupBoardDto> gbNameSearch(Map<String, String> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public GroupBoardDto gbViewSelect(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean gboardInsert(GroupBoardDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean gboardModify(GroupBoardDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	@Transactional
	public boolean gboardDelete(String[] br_uuid) {
			boolean isc = false;
			for(int i = 0; i<br_uuid.length; i++){
				isc=groupboarddao.gboardDelete(br_uuid[i]);
				if(isc==false){
					break;
				}
			}
		return isc;
	}

	@Override
	public boolean gbCommentInsert(GroupBoardDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean gbCommentModify(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean bgCommentDelete(String br_uuid) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean grMgrModify(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}



}
