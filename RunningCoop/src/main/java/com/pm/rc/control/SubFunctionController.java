package com.pm.rc.control;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SubFunctionController {
	
	// 검색화면으로 이동
	@RequestMapping(value="/go_SearchForm.do")
	public String goSearch(){
		return "searchUnion";
	}
	
	// 홈버튼 홈으로 이동
	@RequestMapping(value="/goHome.do")
	public String goHome(){
		return "Group/myGrSelect";
	}
}
