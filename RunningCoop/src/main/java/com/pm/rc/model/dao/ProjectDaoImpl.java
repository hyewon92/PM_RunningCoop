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
		logger.info("============== 그룹 프로젝트 리스트 조회 dao 시작 ==============");
		return sqlSession.selectList(NAMESPACE+"groupProSelect", map);
	}

	@Override
	public List<ProjectDto> myProSelect(String mem_id) {
		logger.info("============== 개인 프로젝트 리스트 조회 dao 시작 ==============");
		return sqlSession.selectList(NAMESPACE+"myProSelect", mem_id);
	}

	@Override
	public Map<String, String> myDidPrSelect(String mem_id) {
		logger.info("============== 나의 진행완료 프로젝트 갯수 조회 dao 시작 ==============");
		return sqlSession.selectOne(NAMESPACE+"myDidPrSelect", mem_id);
	}

	@Override
	public Map<String, String> myDoingPrSelect(String mem_id) {
		logger.info("============== 나의 진행중인 프로젝트 갯수 조회 dao 시작 ==============");
		return sqlSession.selectOne(NAMESPACE+"myDoingPrSelect", mem_id);
	}

	@Override
	public Map<String, String> myToDoPrSelect(String mem_id) {
		logger.info("============== 나의 진행예정 프로젝트 갯수 조회 dao 시작 ==============");
		return sqlSession.selectOne(NAMESPACE+"myToDoPrSelect", mem_id);
	}
	
	@Override
	public List<Map<String, String>> myDoingGPrListSelect(ProjectPagingDto prPaging) {
		logger.info("============== 나의 진행중인 그룹 프로젝트 리스트 조회 dao 시작 ==============");
		return sqlSession.selectList(NAMESPACE+"myDoingGPrListSelect", prPaging);
	}
	
	@Override
	public int myDoingGpTotalcount(String mem_id) {
		logger.info("============== 나의 진행중인 그룹 프로젝트 갯수 조회 dao 시작 ==============");
		return sqlSession.selectOne(NAMESPACE+"myDoingGpTotalcount", mem_id);
	}
	
	@Override
	public List<Map<String, String>> myDoingIPrListSelect(ProjectPagingDto prPaging) {
		logger.info("============== 나의 진행중인 개인 프로젝트 리스트 조회 dao 시작 ==============");
		return sqlSession.selectList(NAMESPACE+"myDoingIPrListSelect", prPaging);
	}
	
	@Override
	public int myDoingIpTotalcount(String mem_id){
		logger.info("============== 나의 진행중인 개인 프로젝트 갯수 조회 dao 시작 ==============");
		return sqlSession.selectOne(NAMESPACE+"myDoingIpTotalcount", mem_id);
	}
	
	@Override
	public List<Map<String, String>> myTodoGPrListSelect(ProjectPagingDto prPaging) {
		logger.info("============== 나의 진행예정 그룹 프로젝트 리스트 조회 dao 시작 ==============");
		return sqlSession.selectList(NAMESPACE+"myTodoGPrListSelect", prPaging);
	}
	
	@Override
	public int myTodoGpTotalcount(String mem_id) {
		logger.info("============== 나의 진행예정 그룹 프로젝트 갯수 조회 dao 시작 ==============");
		return sqlSession.selectOne(NAMESPACE+"myTodoGpTotalcount", mem_id);
	}
	
	@Override
	public List<Map<String, String>> myTodoIPrListSelect(ProjectPagingDto prPaging) {
		logger.info("============== 나의 진행예정 개인 프로젝트 리스트 조회 dao 시작 ==============");
		return sqlSession.selectList(NAMESPACE+"myTodoIPrListSelect", prPaging);
	}
	
	@Override
	public int myTodoIpTotalcount(String mem_id){
		logger.info("============== 나의 진행예정 개인 프로젝트 갯수 조회 dao 시작 ==============");
		return sqlSession.selectOne(NAMESPACE+"myTodoIpTotalcount", mem_id);
	}
	
	@Override
	public List<Map<String, String>> myDidGPrListSelect(ProjectPagingDto prPaging) {
		logger.info("============== 나의 진행완료 그룹 프로젝트 리스트 조회 dao 시작 ==============");
		return sqlSession.selectList(NAMESPACE+"myDidGPrListSelect", prPaging);
	}
	
	@Override
	public int myDidGpTotalcount(String mem_id) {
		logger.info("============== 나의 진행완료 그룹 프로젝트 갯수 조회 dao 시작 ==============");
		return sqlSession.selectOne(NAMESPACE+"myDidGpTotalcount",mem_id);
	}

	@Override
	public List<Map<String, String>> myDidIPrListSelect(ProjectPagingDto prPaging) {
		logger.info("============== 나의 진행완료 개인 프로젝트 리스트 조회 dao 시작 ==============");
		return sqlSession.selectList(NAMESPACE+"myDidIPrListSelect", prPaging);
	}
	
	@Override
	public int myDidIpTotalcount(String mem_id){
		logger.info("============== 나의 진행완료 개인 프로젝트 갯수 조회 dao 시작 ==============");
		return sqlSession.selectOne(NAMESPACE+"myDidIpTotalcount", mem_id);
	}
	
	@Override
	public List<Map<String, String>> myGPrSearchSelect(ProjectDto dto) {
		logger.info("============== 나의 그룹 프로젝트 리스트 조회 dao 시작 ==============");
		return sqlSession.selectList(NAMESPACE+"myGPrSearchSelect", dto);
	}
	
	@Override
	public int myGpSearchTotalcount(ProjectDto dto){
		logger.info("============== 나의 그룹 프로젝트 갯수 조회 dao 시작 ==============");
		return sqlSession.selectOne(NAMESPACE+"myGpSearchTotalcount", dto);
	}

	@Override
	public List<Map<String, String>> myIPrSearchSelect(ProjectDto dto) {
		logger.info("============== 나의 개인 프로젝트 리스트 조회 dao 시작 ==============");
		return sqlSession.selectList(NAMESPACE+"myIPrSearchSelect", dto);
	}
	
	@Override
	public int myIpSearchTotalcount(ProjectDto dto){
		logger.info("============== 나의 개인 프로젝트 갯수 조회 dao 시작 ==============");
		return sqlSession.selectOne(NAMESPACE+"myIpSearchTotalcount", dto);
	}

	@Override
	public List<Map<String, String>> allPrSearchSelect(ProjectPagingDto prPaging) {
		logger.info("============== 전체 프로젝트 리스트 조회 dao 시작 ==============");
		return sqlSession.selectList(NAMESPACE+"allPrSearchSelect", prPaging);
	}
	
	@Override
	public int allPrSearchTotalCount(ProjectPagingDto prPaging) {
		logger.info("============== 전체 프로젝트 갯수 조회 dao 시작 ==============");
		return sqlSession.selectOne(NAMESPACE+"allPrSearchTotalCount", prPaging);
	}

	@Override
	public Map<String, String> prDetailSelect(String pr_id) {
		logger.info("============== 프로젝트 상세정보 조회 dao 시작 ==============");
		return sqlSession.selectOne(NAMESPACE+"prDetailSelect", pr_id);
	}

	@Override
	public boolean gPrInsert_1(Map<String, String> map) {
		logger.info("============== 그룹 프로젝트 생성절차 - 프로젝트 생성  dao 시작 ==============");
		int num = sqlSession.insert(NAMESPACE+"gProInsert", map);
		return num>0?true:false;
	}

	@Override
	public boolean gPrInsert_2(Map<String, String> map) {
		logger.info("============== 그룹 프로젝트 생성절차 - 그룹 프로젝트 매니저 등록  dao 시작 ==============");
		int num = sqlSession.insert(NAMESPACE+"gPromemInsert", map);
		return num>0?true:false;
	}

	@Override
	public boolean gPrInsert_3(Map<String, String> map) {
		logger.info("============== 그룹 프로젝트 생성절차 - 그룹 프로젝트 등록  dao 시작 ==============");
		int num = sqlSession.insert(NAMESPACE+"gGroupProInsert", map);
		return num>0?true:false;
	}

	@Override
	public boolean iPrInsert_1(Map<String, String> map) {
		logger.info("============== 개인 프로젝트 생성절차 - 프로젝트 생성  dao 시작 ==============");
		int num = sqlSession.insert(NAMESPACE+"iProInsert", map);
		if (num > 0){
			return true;
		} else {
			return false; 
		}
	}

	@Override
	public boolean iPrInsert_2(Map<String, String> map) {
		logger.info("============== 개인 프로젝트 생성절차 - 프로젝트 매니저 등록 dao 시작 ==============");
		int num = sqlSession.insert(NAMESPACE+"iPromemInsert", map);
		if(num > 0){
			return true;
		} else {
			return false;
		}
	}
	
	@Override
	public MemberDto prManagerSelect(String pr_id){
		logger.info("============== 프로젝트 매니저 조회  dao 시작 ==============");
		return sqlSession.selectOne(NAMESPACE+"prManagerSelect", pr_id);
	}

	@Override
	public boolean projectEdit(ProjectDto dto) {
		logger.info("============== 프로젝트 기본정보 수정  dao 시작 ==============");
		int num = sqlSession.update(NAMESPACE+"projectEdit", dto);
		return num>0?true:false;
	}
	
	@Override
	public List<MemberDto> prMemInsertSearch(Map<String, String> map) {
		logger.info("============== 프로젝트에 초대가능한 그룹멤버 조회  dao 시작 ==============");
		return sqlSession.selectList(NAMESPACE+"prMemInsertSearch", map);
	}

	@Override
	public boolean prMemInsert_1(Map<String, String> map) {
		logger.info("============== 프로젝트 멤버 추가 절차 - 프로젝트 멤버 등록 dao 시작 ==============");
		int num = sqlSession.insert(NAMESPACE+"prMemInsert", map);
		return num>0?true:false;
	}

	@Override
	public boolean prMemInsert_2(String pr_id) {
		logger.info("============== 프로젝트 멤버 추가 절차 - 프로젝트 인원 수정 dao 시작 ==============");
		int num = sqlSession.update(NAMESPACE+"prMemUpdate", pr_id);
		return num>0?true:false;
	}

	@Override
	public boolean prMgrEdit_1(Map<String, String> map) {
		logger.info("============== 프로젝트 매니저 수정 절차 - 기존 프로젝트 매니저 권한 변경 dao 시작 ==============");
		int num = sqlSession.update(NAMESPACE+"prMgrEdit_1", map);
		return num > 0?true:false;
	}

	@Override
	public boolean prMgrEdit_2(Map<String, String> map) {
		logger.info("============== 프로젝트 매니저 수정 절차 - 새 프로젝트 매니저 권한 변경 dao 시작 ==============");
		int num = sqlSession.update(NAMESPACE+"prMgrEdit_2", map);
		return num > 0?true:false;
	}

	@Override
	public List<Map<String, String>> prMemListSelect(String pr_id) {
		logger.info("============== 프로젝트 멤버 리스트 조회 dao 시작 ==============");
		return sqlSession.selectList(NAMESPACE+"prMemListSelect", pr_id);
	}

	@Override
	public boolean prMemDelete_1(Map<String, String> map) {
		logger.info("============== 프로젝트 멤버 삭제 절차 - 프로젝트 멤버 삭제 dao 시작 ==============");
		int num = sqlSession.delete(NAMESPACE+"prMemDelete", map);
		return num > 0?true:false;
	}

	@Override
	public boolean prMemDelete_2(String pr_id) {
		logger.info("============== 프로젝트 멤버 삭제 절차 - 프로젝트 인원 정보 수정 dao 시작 ==============");
		int num = sqlSession.update(NAMESPACE+"prMemUpdate", pr_id);
		return num > 0?true:false;
	}

	@Override
	public List<String> prRateEdit_1(String pr_id) {
		logger.info("============== 프로젝트 진행률 수정 절차 - 해당 프로젝트의 전체 업무 리스트 조회 dao 시작 ==============");
		return sqlSession.selectList(NAMESPACE+"prRateEdit_1", pr_id);
	}

	@Override
	public boolean prRateEdit_2(Map<String, String> map) {
		logger.info("============== 프로젝트 진행률 수정 절차 - 업무 진행률 업데이트 dao 시작 ==============");
		int num = sqlSession.update(NAMESPACE+"prRateEdit_2", map);
		return num>0?true:false;
	}

	@Override
	public Map<String, String> myLevelSelect(Map<String, String> map) {
		logger.info("============== 프로젝트 내 권한 조회 dao 시작 ==============");
		return sqlSession.selectOne(NAMESPACE+"myLevelSelect", map);
	}

	@Override
	public Map<String, String> memInfoSelect_1(Map<String, String> map) {
		logger.info("============== 프로젝트 및 그룹 내 멤버 정보 조회 dao 시작 ==============");
		return sqlSession.selectOne(NAMESPACE+"memInfoSelect_1", map);
	}

	@Override
	public List<Map<String, String>> memInfoSelect_2(Map<String, String> map) {
		logger.info("============== 그룹 내 참여 프로젝트 조회 dao 시작 ==============");
		return sqlSession.selectList(NAMESPACE+"memInfoSelect_2", map);
	}

	@Override
	public List<String> projectDelete_1(String pr_id) {
		logger.info("============== 프로젝트 삭제 절차 - 삭제할 프로젝트의 업무리스트 조회 dao 시작 ==============");
		return sqlSession.selectList(NAMESPACE+"projectDelete_1", pr_id);
	}

	@Override
	public List<GbAttachDto> projectDelete_2(String wk_id) {
		logger.info("============== 프로젝트 삭제 절차 - 삭제할 프로젝트에 포함된 첨부파일 리스트 조회 dao 시작 ==============");
		return sqlSession.selectList(NAMESPACE+"projectDelete_2", wk_id);
	}

	@Override
	public boolean projectDelete_3(String wk_id) {
		logger.info("============== 프로젝트 삭제 절차 - 첨부파일 삭제 dao 시작 ==============");
		int num = sqlSession.delete(NAMESPACE+"projectDelete_3", wk_id);
		return num>0?true:false;
	}

	@Override
	public boolean projectDelete_4(String wk_id) {
		logger.info("============== 프로젝트 삭제 절차 - 업무코멘트 삭제 dao 시작 ==============");
		int num = sqlSession.update(NAMESPACE+"projectDelete_4", wk_id);
		return num>0?true:false;
	}
	
	@Override
	public boolean projectDelete_5(String wk_id) {
		logger.info("============== 프로젝트 삭제 절차 - 하위 업무 삭제 dao 시작 ==============");
		int num = sqlSession.update(NAMESPACE+"projectDelete_5", wk_id);
		return num>0?true:false;
	}

	@Override
	public boolean projectDelete_6(String pr_id) {
		logger.info("============== 프로젝트 삭제 절차 - 프로젝트 업무 삭제 dao 시작 ==============");
		int num = sqlSession.update(NAMESPACE+"projectDelete_6", pr_id);
		return num>0?true:false;
	}

	@Override
	public boolean projectDelete_7(String pr_id) {
		logger.info("============== 프로젝트 삭제 절차 - 프로젝트 멤버 삭제 dao 시작 ==============");
		int num = sqlSession.delete(NAMESPACE+"projectDelete_7", pr_id);
		return num>0?true:false;
	}

	@Override
	public boolean projectDelete_8(String pr_id) {
		logger.info("============== 프로젝트 삭제 절차 - 그룹 프로젝트 관계 삭제 dao 시작 ==============");
		int num = sqlSession.delete(NAMESPACE+"projectDelete_8", pr_id);
		return num>0?true:false;
	}

	@Override
	public boolean projectDelete_9(String pr_id) {
		logger.info("============== 프로젝트 삭제 절차 - 프로젝트 멤버 수 수정 시작 ==============");
		int num = sqlSession.update(NAMESPACE+"projectDelete_9", pr_id);
		return num>0?true:false;
	}

	@Override
	public boolean projectDelete_10(String pr_id) {
		logger.info("============== 프로젝트 삭제 절차 - 프로젝트 비활성화 dao 시작 ==============");
		int num = sqlSession.update(NAMESPACE+"projectDelete_10", pr_id);
		return num>0?true:false;
	}

	@Override
	public void editGProCondition_1(Map<String, String> map) {
		logger.info("============== 그룹 프로젝트 진행 상태 수정(진행중) dao 시작 ==============");
		sqlSession.update(NAMESPACE+"editGProCondition_1", map);
	}

	@Override
	public void editGProCondition_2(Map<String, String> map) {
		logger.info("============== 그룹 프로젝트 진행 상태 수정(진행완료) dao 시작 ==============");
		sqlSession.update(NAMESPACE+"editGProCondition_2", map);
	}

	@Override
	public void editIProCondition_1(String mem_id) {
		logger.info("============== 개인 프로젝트 진행 상태 수정(진행중) dao 시작 ==============");
		sqlSession.update(NAMESPACE+"editIProCondition_1", mem_id);
	}

	@Override
	public void editIProCondition_2(String mem_id) {
		logger.info("============== 개인 프로젝트 진행 상태 수정(진행완료) dao 시작 ==============");
		sqlSession.update(NAMESPACE+"editIProCondition_2", mem_id);
	}
	
}
