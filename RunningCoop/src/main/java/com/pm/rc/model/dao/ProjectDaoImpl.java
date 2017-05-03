package com.pm.rc.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pm.rc.dto.GbAttachDto;
import com.pm.rc.dto.MemberDto;
import com.pm.rc.dto.ProjectDto;
import com.pm.rc.dto.ProjectPagingDto;

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
		return sqlSession.selectOne(NAMESPACE+"myDidPrSelect", mem_id);
	}

	@Override
	public Map<String, String> myDoingPrSelect(String mem_id) {
		return sqlSession.selectOne(NAMESPACE+"myDoingPrSelect", mem_id);
	}

	@Override
	public Map<String, String> myToDoPrSelect(String mem_id) {
		return sqlSession.selectOne(NAMESPACE+"myToDoPrSelect", mem_id);
	}
	
	@Override
	public List<Map<String, String>> myDidGPrListSelect(ProjectPagingDto prPaging) {
		return sqlSession.selectList(NAMESPACE+"myDidGPrListSelect", prPaging);
	}
	
	@Override
	public int createMyDidGprListTotalCount(String mem_id) {
		return sqlSession.selectOne(NAMESPACE+"createMyDidGprListTotalCount",mem_id);
	}

	@Override
	public List<Map<String, String>> myDidIPrListSelect(String mem_id) {
		return sqlSession.selectList(NAMESPACE+"myDidIPrListSelect", mem_id);
	}

	@Override
	public List<Map<String, String>> myDoingGPrListSelect(ProjectPagingDto prPaging) {
		return sqlSession.selectList(NAMESPACE+"myDoingGPrListSelect", prPaging);
	}
	
	@Override
	public int myDoingGpTotalcount(String mem_id) {
		return sqlSession.selectOne(NAMESPACE+"countTotalpaging",mem_id);
	}

	@Override
	public List<Map<String, String>> myDoingIPrListSelect(String mem_id) {
		return sqlSession.selectList(NAMESPACE+"myDoingIPrListSelect", mem_id);
	}

	@Override
	public List<Map<String, String>> myTodoGPrListSelect(ProjectPagingDto prPaging) {
		return sqlSession.selectList(NAMESPACE+"myTodoGPrListSelect", prPaging);
	}

	@Override
	public int myTodoGPlistTotalCount(String mem_id) {
		return sqlSession.selectOne(NAMESPACE+"createMytodoGPlistTotalCount",mem_id);
	}
	
	@Override
	public List<Map<String, String>> myTodoIPrListSelect(String mem_id) {
		return sqlSession.selectList(NAMESPACE+"myTodoIPrListSelect", mem_id);
	}
	
	@Override
	public List<Map<String, String>> myGPrSearchSelect(Map<String, String> map) {
		return sqlSession.selectList(NAMESPACE+"myGPrSearchSelect", map);
	}

	@Override
	public List<Map<String, String>> myIPrSearchSelect(Map<String, String> map) {
		return sqlSession.selectList(NAMESPACE+"myIPrSearchSelect", map);
	}

	@Override
	public List<Map<String, String>> allPrSearchSelect(Map<String, String> map) {
		return sqlSession.selectList(NAMESPACE+"allPrSearchSelect", map);
	}

	@Override
	public Map<String, String> prDetailSelect(String pr_id) {
		return sqlSession.selectOne(NAMESPACE+"prDetailSelect", pr_id);
	}

	@Override
	public boolean gPrInsert_1(Map<String, String> map) {
		int num = sqlSession.insert(NAMESPACE+"gProInsert", map);
		return num>0?true:false;
	}

	@Override
	public boolean gPrInsert_2(Map<String, String> map) {
		int num = sqlSession.insert(NAMESPACE+"gPromemInsert", map);
		return num>0?true:false;
	}

	@Override
	public boolean gPrInsert_3(Map<String, String> map) {
		int num = sqlSession.insert(NAMESPACE+"gGroupProInsert", map);
		return num>0?true:false;
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
	public MemberDto prManagerSelect(String pr_id){
		return sqlSession.selectOne(NAMESPACE+"prManagerSelect", pr_id);
	}

	@Override
	public boolean projectEdit(ProjectDto dto) {
		int num = sqlSession.update(NAMESPACE+"projectEdit", dto);
		return num>0?true:false;
	}
	
	@Override
	public List<MemberDto> prMemInsertSearch(Map<String, String> map) {
		return sqlSession.selectList(NAMESPACE+"prMemInsertSearch", map);
	}

	@Override
	public boolean prMemInsert_1(Map<String, String> map) {
		int num = sqlSession.insert(NAMESPACE+"prMemInsert", map);
		return num>0?true:false;
	}

	@Override
	public boolean prMemInsert_2(String pr_id) {
		int num = sqlSession.update(NAMESPACE+"prMemUpdate", pr_id);
		return num>0?true:false;
	}

	@Override
	public boolean prMgrEdit_1(Map<String, String> map) {
		int num = sqlSession.update(NAMESPACE+"prMgrEdit_1", map);
		return num > 0?true:false;
	}

	@Override
	public boolean prMgrEdit_2(Map<String, String> map) {
		int num = sqlSession.update(NAMESPACE+"prMgrEdit_2", map);
		return num > 0?true:false;
	}

	@Override
	public List<Map<String, String>> prMemListSelect(String pr_id) {
		return sqlSession.selectList(NAMESPACE+"prMemListSelect", pr_id);
	}

	@Override
	public boolean prMemDelete_1(Map<String, String> map) {
		int num = sqlSession.delete(NAMESPACE+"prMemDelete", map);
		return num > 0?true:false;
	}

	@Override
	public boolean prMemDelete_2(String pr_id) {
		int num = sqlSession.update(NAMESPACE+"prMemUpdate", pr_id);
		return num > 0?true:false;
	}

	@Override
	public List<String> prRateEdit_1(String pr_id) {
		return sqlSession.selectList(NAMESPACE+"prRateEdit_1", pr_id);
	}

	@Override
	public boolean prRateEdit_2(Map<String, String> map) {
		int num = sqlSession.update(NAMESPACE+"prRateEdit_2", map);
		return num>0?true:false;
	}

	@Override
	public Map<String, String> myLevelSelect(Map<String, String> map) {
		return sqlSession.selectOne(NAMESPACE+"myLevelSelect", map);
	}

	@Override
	public Map<String, String> memInfoSelect_1(Map<String, String> map) {
		return sqlSession.selectOne(NAMESPACE+"memInfoSelect_1", map);
	}

	@Override
	public List<Map<String, String>> memInfoSelect_2(Map<String, String> map) {
		return sqlSession.selectList(NAMESPACE+"memInfoSelect_2", map);
	}

	@Override
	public List<String> projectDelete_1(String pr_id) {
		return sqlSession.selectList(NAMESPACE+"projectDelete_1", pr_id);
	}

	@Override
	public List<GbAttachDto> projectDelete_2(String wk_id) {
		return sqlSession.selectList(NAMESPACE+"projectDelete_2", wk_id);
	}

	@Override
	public boolean projectDelete_3(String wk_id) {
		int num = sqlSession.delete(NAMESPACE+"projectDelete_3", wk_id);
		return num>0?true:false;
	}

	@Override
	public boolean projectDelete_4(String wk_id) {
		int num = sqlSession.update(NAMESPACE+"projectDelete_4", wk_id);
		return num>0?true:false;
	}
	
	@Override
	public boolean projectDelete_5(String wk_id) {
		int num = sqlSession.update(NAMESPACE+"projectDelete_5", wk_id);
		return num>0?true:false;
	}

	@Override
	public boolean projectDelete_6(String pr_id) {
		int num = sqlSession.update(NAMESPACE+"projectDelete_6", pr_id);
		return num>0?true:false;
	}

	@Override
	public boolean projectDelete_7(String pr_id) {
		int num = sqlSession.delete(NAMESPACE+"projectDelete_7", pr_id);
		return num>0?true:false;
	}

	@Override
	public boolean projectDelete_8(String pr_id) {
		int num = sqlSession.delete(NAMESPACE+"projectDelete_8", pr_id);
		return num>0?true:false;
	}

	@Override
	public boolean projectDelete_9(String pr_id) {
		int num = sqlSession.update(NAMESPACE+"projectDelete_9", pr_id);
		return num>0?true:false;
	}

	@Override
	public boolean projectDelete_10(String pr_id) {
		int num = sqlSession.update(NAMESPACE+"projectDelete_10", pr_id);
		return num>0?true:false;
	}

	@Override
	public void editGProCondition_1(Map<String, String> map) {
		sqlSession.update(NAMESPACE+"editGProCondition_1", map);
	}

	@Override
	public void editGProCondition_2(Map<String, String> map) {
		sqlSession.update(NAMESPACE+"editGProCondition_2", map);
	}

	@Override
	public void editIProCondition_1(String mem_id) {
		sqlSession.update(NAMESPACE+"editIProCondition_1", mem_id);
	}

	@Override
	public void editIProCondition_2(String mem_id) {
		sqlSession.update(NAMESPACE+"editIProCondition_2", mem_id);
	}
	
}
