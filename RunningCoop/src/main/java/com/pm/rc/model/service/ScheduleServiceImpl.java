package com.pm.rc.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pm.rc.dto.ScheduleDto;
import com.pm.rc.model.dao.ScheduleDao;

@Service
public class ScheduleServiceImpl implements ScheduleService {
	
	@Autowired
	private ScheduleDao scheduleDao;

	@Override
	public List<ScheduleDto> teamSchSelect(String pr_id) {
		return null;
	}

	@Override
	public boolean teamSchInsert(ScheduleDto dto) {
		return false;
	}

	@Override
	public List<ScheduleDto> mySchSelect2(String mem_id) {
		return null;
	}

	@Override
	public boolean schInsert(ScheduleDto dto) {
		return scheduleDao.schInsert(dto);
	}

	@Override
	public boolean schModify(ScheduleDto dto) {
		return false;
	}

	@Override
	public boolean schDelete(String seq) {
		return false;
	}

}
