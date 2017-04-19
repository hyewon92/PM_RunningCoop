package com.pm.rc.control;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pm.rc.model.service.AccountService;

@Controller
public class MailController {
	
	Logger logger = LoggerFactory.getLogger(MailController.class);
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private AccountService accountService;
	
	@RequestMapping(value = "/searchPwMail.do", method = RequestMethod.GET)
	public String pwMail(Model model){
		return "account/pwMail";	//메일form jsp
	}
	
	//mailSending 코드
	@RequestMapping(value = "/pwMailSending.do")
	public String mailSending(Model model, HttpServletRequest request){
		logger.info("mailSending 실행");
		
		//임시비밀번호 생성
		String random = UUID.randomUUID().toString().replace("-", "");
		String mem_pw = random.substring(0, 13);
		String mem_id = request.getParameter("title");
		
		//회원(수신자)정보
		String setFrom = "pmrunningcoop@gmail.com";
		String toMail = request.getParameter("toMail");
		String title = "<RunningCoop> "+request.getParameter("title")+"님 비밀번호 변경 메일입니다";
		String content = "임시 비밀번호: "+mem_pw+"\n페이지 접속:http://localhost:8088/RunningCoop/main.do \n\n\n<RunningCoop개발팀 올림>";
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_id", mem_id);
		map.put("mem_pw", mem_pw);
		map.put("mem_email", toMail);
		boolean isc = accountService.memPwModify(map);
		if(isc==false){
			return "account/error/error";
		}else{
			try{
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
				messageHelper.setFrom(setFrom);
				messageHelper.setTo(toMail);
				messageHelper.setSubject(title);
				messageHelper.setText(content);
				mailSender.send(message);
			}catch(Exception e){
				System.out.println(e);
			}
			return "redirect:/searchPwMail.do";
		}
	}
	
}
