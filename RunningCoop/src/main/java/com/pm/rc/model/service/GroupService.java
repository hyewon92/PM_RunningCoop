package com.pm.rc.model.service;

import java.util.List;
import java.util.Map;

import com.pm.rc.dto.GroupBoardDto;
import com.pm.rc.dto.GroupDto;
import com.pm.rc.dto.MemberDto;
import com.pm.rc.dto.ProjectDto;

//그룹 관련 기능
public interface GroupService {

	//내가 가입한 그룹 조회
	public List<GroupDto> myGrSelect(String mem_id);
	
	//그룹 검색 조회(그룹명)
	public List<GroupDto> allGrSelect(String gr_name);
	
	//그룹 상세 정보 출력
	public GroupDto grDetailSelect(String gr_id);
	
	//그룹 생성
	public boolean grInsert(GroupDto dto);
	
	//그룹 수정(gr_id, ProjectDto)
	public boolean grModify(Map<String, ProjectDto> map);
		
	//그룹 삭제
	public boolean grDelete(String gr_id);
	
	//시스템 회원 조회
	public List<MemberDto> sysMemSelect();
	
	//그룹멤버추가(gr_id, mem_id)
	public boolean grMemInsert(Map<String, String> map);
	
	//그룹멤버삭제(gr_id, mem_id)
	public boolean grMemDelete(Map<String, String> map);
	
	//그룹멤버조회
	public List<MemberDto> grMemSelect(String gr_id);
	
	//그룹게시판 게시글 목록
	public List<GroupBoardDto> gbListSelect();
	
	//그룹게시판 게시글 조회
	public GroupBoardDto gbViewSelect();
	
	//그룹게시판 게시글 등록
	public boolean gboardInsert(GroupBoardDto dto);
	
	//그룹게시판 게시글 수정(uuid, GroupBoardDto)
	public boolean gboardModify(Map<String, GroupBoardDto> map);
	
	//그룹게시판 게시글 삭제
	public boolean gboardDelete(String uuid);
	
	//그룹게시판 댓글 등록
	public boolean gbCommentInsert(GroupBoardDto dto);
	
	//그룹게시판 댓글 수정(uuid, GroupBoardDto)
	public boolean gbCommentModify(Map<String, GroupBoardDto> map);
	
	//그룹게시판 댓글 삭제
	public boolean bgCommentDelete(String uuid);
	
	//그룹 관리자 변경(gr_id, mem_id)
	public boolean grMgrModify(Map<String, String> map);
	
}
