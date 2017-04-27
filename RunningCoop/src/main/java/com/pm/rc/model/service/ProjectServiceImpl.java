package com.pm.rc.model.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pm.rc.dto.MemberDto;
import com.pm.rc.dto.ProjectDto;
import com.pm.rc.model.dao.ProjectDao;

@Service
public class ProjectServiceImpl implements ProjectService {
	
	@Autowired
	private ProjectDao dao;

	@Override
	public List<ProjectDto> groupProSelect(Map<String, String> map) {
		return dao.groupProSelect(map);
	}

	@Override
	public List<ProjectDto> myProSelect(String mem_id) {
		return dao.myProSelect(mem_id);
	}

	@Override
	public Map<String, String> myDidPrSelect(String mem_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, String> myDoingPrSelect(String mem_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, String> myTodoPrSelect(String mem_id) {
		return null;
	}

	@Override
	public Map<String, String> allPrSearchSelect(String pr_name) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, String> myPrSearchSelect(Map<String, String> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, String> prDetailSelect(String pr_id) {
		return dao.prDetailSelect(pr_id);
	}

	@Override
	public boolean gPrInsert(Map<String, String> map) {
		Date date = new Date();
		SimpleDateFormat dateForm = new SimpleDateFormat("yyMMdd");
		String id_1 = "PR";
		String id_2 = dateForm.format(date).toString();
		String uuid = createUUID();
		System.out.println(uuid);
		String id_3 = uuid.substring(uuid.lastIndexOf("-")+9);
		System.out.println(id_3);
		String pr_id = id_1+id_2+id_3;
		
		map.put("pr_id", pr_id);
		
		boolean isc = false;
		boolean pisc = false;
		boolean misc = false;
		boolean gisc = false;
		
		pisc = dao.gPrInsert_1(map);
		
		if(pisc){
			misc = dao.gPrInsert_2(map);
		}
		
		if(misc){
			gisc = dao.gPrInsert_3(map);
		}
		
		if(pisc == true && misc == true && gisc == true){
			isc = true;
		}
		return isc;
	}

	@Override
	public boolean iPrInsert(Map<String, String> map) {
		Date date = new Date();
		SimpleDateFormat dateForm = new SimpleDateFormat("yyMMdd");
		String id_1 = "PR";
		String id_2 = dateForm.format(date).toString();
		String uuid = createUUID();
		System.out.println(uuid);
		String id_3 = uuid.substring(uuid.lastIndexOf("-")+9);
		System.out.println(id_3);
		String pr_id = id_1+id_2+id_3;
		
		map.put("pr_id", pr_id);
		boolean isc = false;
		boolean pisc = false;
		boolean misc = false;
		
		pisc = dao.iPrInsert_1(map);
		
		if(pisc){
			misc = dao.iPrInsert_2(map);
		}
		
		if(pisc == true && misc == true){
			isc = true;
		}
		return isc;
	}
	
	@Override
	public MemberDto prManagerSelect(String pr_id){
		return dao.prManagerSelect(pr_id);
	}

	@Override
	public boolean projectEdit(ProjectDto dto) {
		return dao.projectEdit(dto);
	}

	@Override
	public boolean projectDelete(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<MemberDto> prMemInsertSearch(Map<String, String> map) {
		return dao.prMemInsertSearch(map);
	}

	@Override
	public boolean prMemInsert(Map<String, Object> map) {
		String pr_id = (String) map.get("pr_id");
		String[] memList = (String[]) map.get("mem_list");
		
		Map<String, String> insert = new HashMap<String, String>();
		insert.put("pr_id", pr_id);
		
		boolean isc = false;
		
		for(int i = 0; i < memList.length; i++){
			insert.put("mem_id", memList[i]);
			isc = dao.prMemInsert_1(insert);
			if(isc == false){
				break;
			}
		}
		
		boolean isc2 = false;
		isc2 = dao.prMemInsert_2(pr_id);
		
		if(isc == true && isc2 == true){
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean prMemDelete(Map<String, Object> map) {
		String pr_id = (String) map.get("pr_id");
		String[] mem_list = (String[]) map.get("mem_list");
		
		Map<String, String> member = new HashMap<String, String>();
		member.put("pr_id", pr_id);
		
		boolean isc = false;
		
		for(int i = 0; i < mem_list.length; i++){
			member.put("mem_id", mem_list[i]);
			isc = dao.prMemDelete_1(member);
			
			if(isc == false){
				break;
			}
		}
		
		boolean isc2 = false;
		isc2 = dao.prMemDelete_2(pr_id);
		
		if(isc == true && isc2 == true){
			return true;
		} else {
			return false;
		}
	}

	@Override
	public List<Map<String, String>> prMemListSelect(String pr_id) {
		return dao.prMemListSelect(pr_id);
	}

	@Override
	public boolean prMgrModify(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean prRateEdit(String pr_id) {
		// TODO Auto-generated method stub
		return false;
	}
	
	public String createUUID(){
		return UUID.randomUUID().toString();
	}

	@Override
	public Map<String, String> myLevelSelect(Map<String, String> map) {
		return dao.myLevelSelect(map);
	}

}
