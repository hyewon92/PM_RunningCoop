package com.pm.rc.control;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pm.rc.model.service.TestService;

//4. dispatcher에 의해 연결된 Class @Controller 생성
@Controller
public class TestController {
	
	//8. log처리를 위한 logger객체 생성
	Logger logger = LoggerFactory.getLogger(TestController.class);
	
	// 23. IoC Autowired를 통해 실행되는 Service를 선언
	@Autowired
	private TestService service;
	
	//5. mapping 메소드
	@RequestMapping(value = "/first.do", method = RequestMethod.GET)
	public String test01(String name){
		System.out.println("name="+name);
		service.testPrint(name);
		logger.info("first.jsp 실행");
		return "/WEB-INF/views/first.jsp";
	}
}
