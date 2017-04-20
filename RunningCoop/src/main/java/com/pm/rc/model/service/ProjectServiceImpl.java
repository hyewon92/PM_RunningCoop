package com.pm.rc.model.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		// TODO Auto-generated method stub
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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean gPrInsert(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean iPrInsert(Map<String, String> map) {
		Date date = new Date();
		SimpleDateFormat dateForm = new SimpleDateFormat("yyMMdd");
		String id_1 = "PR";
		String id_2 = dateForm.format(date).toString();
		String uuid = createUUID();
		String id_3 = uuid.substring(uuid.lastIndexOf("-")+9);
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
	public boolean projectEdit(ProjectDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean projectDelete(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Map<String, String> prMemInsertSearch(Map<String, String> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean prMemInsert(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean prMemDelete(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Map<String, String> prMemListSelect(String pr_id) {
		// TODO Auto-generated method stub
		return null;
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

}
