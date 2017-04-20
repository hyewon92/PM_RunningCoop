package com.pm.rc.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pm.rc.dto.GbAttachDto;
import com.pm.rc.dto.ProjectDto;

@Repository
public class ProjectDaoImpl implements ProjectDao {
	
	private Logger logger = LoggerFactory.getLogger(ProjectDaoImpl.class);
	
	private final String NAMESPACE = "com.pm.rc.project.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	

	@Override
	public List<ProjectDto> groupProSelect(Map<String, String> map) {
		return sqlSession.selectList(NAMESPACE+"groupProSelect", map);
	}

	@Override
	public List<ProjectDto> myProSelect(String mem_id) {
		return sqlSession.selectList(NAMESPACE+"myProSelect", mem_id);
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
	public Map<String, String> myToDoPrSelect(String mem_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, String> myPrSearchSelect(Map<String, String> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, String> allPrSearchSelect(String pr_name) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, String> prDetailSelect(String pr_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean gPrInsert_1(Map<String, String> map) {
		return false;
	}

	@Override
	public boolean gPrInsert_2(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean gPrInsert_3(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean iPrInsert_1(Map<String, String> map) {
		int num = sqlSession.insert(NAMESPACE+"iProInsert", map);
		if (num > 0){
			return true;
		} else {
			return false; 
		}
	}

	@Override
	public boolean iPrInsert_2(Map<String, String> map) {
		int num = sqlSession.insert(NAMESPACE+"iPromemInsert", map);
		if(num > 0){
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean projectEdit(ProjectDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean prMemInsert_1(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean prMemInsert_2(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean prMgrEdit_1(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean prMgrEdit_2(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Map<String, String> prMemListSelect(String pr_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean prMemDelete_1(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean prMemDelete_2(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<String> prRateEdit_1(String pr_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int prRateEdit_2(String wk_id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int prRateEdit_3(String wk_id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean prRateEdit_4(String pr_id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<String> projectDelete_1(Map<String, String> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Map<String, GbAttachDto>> projectDelete_2(String wk_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean projectDelete_3(String wk_id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean projectDelete_4(String wk_id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean projectDelete_5(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean projectDelete_6(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean projectDelete_7(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean projectDelete_8(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean projectDelete_9(Map<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}

}
