package com.pm.rc.model.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pm.rc.dto.GbAttachDto;
import com.pm.rc.dto.GroupBoardDto;
import com.pm.rc.dto.WorkCommentDto;
import com.pm.rc.dto.WorkDetailDto;
import com.pm.rc.dto.WorkListDto;
import com.pm.rc.model.dao.WorkListDao;

@Service
public class WorkListServiceImpl implements WorkListService {
	
	@Autowired
	private WorkListDao dao;
	
	@Override
	public List<Map<String, String>> wkListSelect(Map<String, String> map) {
		List<Map<String, String>> list = null;
		
		if(map.get("wk_condition").equals("todo")){
			list = dao.wkListSelect1(map);
		} else if(map.get("wk_condition").equals("doing")){
			list = dao.wkListSelect2(map);
		} else if(map.get("wk_condition").equals("done")){
			list = dao.wkListSelect3(map);
		}
		
		return list;
	}

	@Override
	public boolean wkListInsert(WorkListDto dto) {
		return false;
	}

	@Override
	public boolean wkListDelete(String wk_id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean wkListModify(WorkListDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean wkRateModify(String wk_id) {
		int allWork = 0;
		int complWork = 0;
		int proRate = 0;
		
		allWork = dao.wkRateModify_1(wk_id);
		complWork = dao.wkRateModify_2(wk_id);
		System.out.println(complWork);
		proRate = (int)((double)complWork/(double)allWork * 100);
		System.out.println(proRate);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("wk_id", wk_id);
		map.put("wk_proRate", proRate);
		
		boolean isc = false;
		isc	= dao.wkRateModify_3(map);
		
		return isc;
	}

	@Override
	public List<WorkDetailDto> wdSelect(String wk_id) {
		return dao.wdSelect(wk_id);
	}

	@Override
	public boolean wdInsert(WorkDetailDto dto) {
		Date date = new Date();
		SimpleDateFormat dateForm = new SimpleDateFormat("yyMMdd");
		
		String id_1 = "WD";
		String id_2 = dateForm.format(date).toString();
		String uuid = createUUID();
		String id_3 = uuid.substring(uuid.lastIndexOf("-")+8);
		String wd_id = id_1+id_2+id_3;
		
		dto.setWd_id(wd_id);
		
		return dao.wdInsert(dto);
	}

	@Override
	public boolean wdModify(WorkDetailDto dto) {
		return dao.wdModify(dto);
	}

	@Override
	public boolean wdDelete(String wd_id) {
		return dao.wdDelete(wd_id);
	}

	@Override
	public boolean wdErrorChk(String wd_id) {
		return dao.wdErrorChk(wd_id);
	}

	@Override
	public boolean wdComplModify(String wd_id) {
		return dao.wdComplModify(wd_id);
	}

	@Override
	public List<WorkCommentDto> wCommListSelect(String wk_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean wCommentInsert(WorkCommentDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean wCommentModify(WorkCommentDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean wCommentDelete(String wcom_id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<GbAttachDto> btAttachSelect(String wk_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean gbAttachInsert(GroupBoardDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean gbAttachModify(String gatt_seq) {
		// TODO Auto-generated method stub
		return false;
	}
	
	// UUID 생성 메소드
		public String createUUID(){
			return UUID.randomUUID().toString();
		}

}
