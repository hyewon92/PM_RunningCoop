package com.pm.rc.control;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pm.rc.dto.GroupDto;
import com.pm.rc.model.service.ManagerService;

@Controller
public class sysManagerController {

	@Autowired
	private ManagerService service;

	Logger logger = LoggerFactory.getLogger(sysManagerController.class);

	@RequestMapping(value="/systemManagerLogin.do", method=RequestMethod.GET)
	public String systemManagerLogin(){

		logger.info("===============관리자 로그인 페이지로 이동=================");

		return "sysManage/sysMgrLogin";
	}

	//그룹 생성 신청 리스트 출력함
	@RequestMapping(value="/grApply.do")
	public String groupApply(Model model){
		logger.info("그룹생성신청리스트출력시작");
		List<GroupDto> lists = service.grApplySelect(null);
		model.addAttribute("Apply",lists);
		return "sysManage/grApply";
	}

	//그룹승인 리스트 검색하여 출력
	@RequestMapping(value="/grApplySch.do")
	public String groupApply(Model model ,String gr_name){
		logger.info("그룹생성신청리스트출력시작");
		List<GroupDto> lists = service.grApplySelect(gr_name);
		model.addAttribute("Apply",lists);
		return "Group/grApply";
	}

	//그룹승인
	@RequestMapping(value="/grApplyYse.do" , method=RequestMethod.POST)
	public String grApplyYse(String[] gr_id){
		logger.info("그룹생성승인시작");
		service.grAppModify(gr_id);
		return "redirect:/grApply.do";
	}
	//그룹거절
	@RequestMapping(value="/grApplyNo.do" , method=RequestMethod.POST)
	public String grApplyNo(String[] gr_id){
		logger.info("그룹승인거절시작");
		service.grDelete(gr_id);
		return "redirect:/grApply.do";
	}

	// 그룹 간략정보 확인하기
	@RequestMapping(value="/groupInfoChild.do" )
	public String groupInfoChild(String gr_id , Model model){
		List<GroupDto> lists = service.grApplySelectGroup(gr_id);
		model.addAttribute("info" , lists);

		return "Group/applyChild";
	}

}
