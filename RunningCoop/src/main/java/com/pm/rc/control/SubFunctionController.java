package com.pm.rc.control;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SubFunctionController {
	
	@RequestMapping(value="/go_SearchForm.do")
	public String goSearch(){
		return "searchUnion";
	}
}
