package com.pm.rc.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pm.rc.dto.ProjectDto;
import com.pm.rc.dto.ScheduleDto;
import com.pm.rc.model.dao.ScheduleDao;

@Service
public class ScheduleServiceImpl implements ScheduleService {
	
	@Autowired
	private ScheduleDao scheduleDao;

	@Override
	public List<ScheduleDto> teamSchSelect(String pr_id) {
		return scheduleDao.teamSchSelect(pr_id);
	}

	@Override
	public boolean teamSchInsert(ScheduleDto dto) {
		return scheduleDao.teamSchInsert(dto);
	}

	@Override
	public List<ScheduleDto> mySchSelect(String mem_id) {
		return scheduleDao.mySchSelect(mem_id);
	}
	
	@Override
	public ScheduleDto mySchView(String sch_seq) {
		return scheduleDao.mySchView(sch_seq);
	}

	@Override
	public boolean schInsert(ScheduleDto dto) {
		return scheduleDao.schInsert(dto);
	}

	@Override
	public boolean schModify(ScheduleDto dto) {
		return scheduleDao.schModify(dto);
	}

	@Override
	public boolean schDelete(String seq) {
		return scheduleDao.schDelete(seq);
	}

}
