package com.pm.rc.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pm.rc.dto.GroupBoardDto;
import com.pm.rc.dto.GroupDto;
import com.pm.rc.dto.MemberDto;
import com.pm.rc.dto.PagingDto;
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
		return groupdao.grModify(map);
	}

	@Override
	public boolean grWaitInsert(Map<String, String> map) {
		
		return groupdao.grWaitInsert(map);
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
		isc = groupdao.grMemReject(map);
		return isc;
	}

	@Override
	@Transactional
	public boolean grMemDelete(Map<String, String> map) {
		boolean isc = false;
		isc = groupdao.grMemDelete1(map);
		isc = groupdao.grMemDelete2(map);
		return isc;
	}

	@Override
	public List<MemberDto> grMemSelect(String gr_id) {
		return groupdao.grMemSelect(gr_id);
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

	@Override
	public List<GroupDto> selectPaging(PagingDto paging) {
		return groupdao.selectPaging(paging);
	}

	@Override
	public int selectTotalPaging(String gr_name) {
		// TODO Auto-generated method stub
		return groupdao.selectTotalPaging(gr_name);
	}

	@Override
	@Transactional
	public boolean groupDelete(String gr_id) {
		boolean isc = false;
		isc = groupdao.groupDelete1(gr_id);
		System.out.println(isc+"1번쨍ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");
		isc = groupdao.groupDelete2(gr_id);
		System.out.println(isc+"2번쨍ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");
		isc = groupdao.groupDelete3(gr_id);
		System.out.println(isc+"3번쨍ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");
		isc = groupdao.groupDelete4(gr_id);
		System.out.println(isc+"4번쨍ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");
		isc = groupdao.groupDelete5(gr_id);
		System.out.println(isc+"5번쨍ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");
		isc = groupdao.groupDelete6(gr_id);
		System.out.println(isc+"6번쨍ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");
		isc = groupdao.groupDelete7(gr_id);
		System.out.println(isc+"7번쨍ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");
		isc = groupdao.groupDelete8(gr_id);
		System.out.println(isc+"8번쨍ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");
		isc = groupdao.groupDelete9(gr_id);
		System.out.println(isc+"9번쨍ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");
		isc = groupdao.groupDelete10(gr_id);
		System.out.println(isc+"10번쨍ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");
		isc = groupdao.groupDelete11(gr_id);
		System.out.println(isc+"11번쨍ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");
		isc = groupdao.groupDelete12(gr_id);
		System.out.println(isc+"12번쨍ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");
		isc = groupdao.groupDelete13(gr_id);
		System.out.println(isc+"13번쨍ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");
		return isc;
	}

	@Override
	public boolean grManagerChange(String mem_id) {
		boolean isc = false;
		isc = groupdao.newGrMgChange(mem_id);
		return isc;
	}
	
	@Override
	public boolean grManagerChange2(String mem_id2){
		boolean isc =false;
		isc = groupdao.oldGrMaChange(mem_id2);
		return isc;
	}

	@Override
	public int groupCheck(Map<String, String> map) {
		return groupdao.groupCheck(map);
	}

	@Override
	public int grNameCheck(String gr_name) {
		return groupdao.grNameCheck(gr_name);
	}



}
