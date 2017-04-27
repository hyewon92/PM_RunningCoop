package com.pm.rc.control;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pm.rc.model.service.AccountService;

@Controller
public class MailController {
	
	String setFrom = "pmrunningcoop@gmail.com";
	
	Logger logger = LoggerFactory.getLogger(MailController.class);
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private AccountService accountService;
	
	@RequestMapping(value = "/searchPwMail.do", method = RequestMethod.GET)
	public String pwMail(Model model){
		return "account/pwMail";	//메일form jsp
	}
	
	//비밀번호 발급 mailSending
	@RequestMapping(value = "/pwMailSending.do")
	public String pwMailSending(Model model, HttpServletRequest req){
		logger.info("mailSending 실행");
		
		//임시비밀번호 생성
		String random = UUID.randomUUID().toString().replace("-", "");
		String mem_pw = random.substring(0, 13);
		String mem_id = req.getParameter("title");
		
		//회원(수신자)정보
		String toMail = req.getParameter("toMail");
		String title = "<RunningCoop> "+req.getParameter("title")+"님 비밀번호 변경 메일입니다";
		String content = "임시 비밀번호: "+mem_pw+"\n페이지 접속:http://localhost:8088/RunningCoop/main.do \n\n<RunningCoop개발팀 올림>";
		
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
	
	//본인인증 mailSending
	@RequestMapping(value = "/joinMailSending.do")
	@ResponseBody
	public void JoinMailSending(HttpSession session, String mem_name, String toMail){
		logger.info("JoinMailSending실행");
		//인증번호 생성
		String random = "";
		String num = "";
		for(int i = 0; i <5; i++){
			num = String.valueOf(Math.round(Math.random()*10));
			random += num;
		}
		session.setAttribute("identifyNum", random); 
		
		//회원(수신자)정보
		String title = "<RunningCoop> "+mem_name+"님 본인인증 번호입니다";
		String content = "인증번호: "+random+"\n 시간 내에 입력 해주시기 바랍니다.(시간 초과 시 초기화 됨)";
		
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
	}
	
	@RequestMapping(value="/groupSend.do")
	public String groupSend (){
		return "Group/groupMailSend";
	}
	@RequestMapping(value="/goGroupMail.do" )
	public String goGroupMail(String toSend , Model model){
		//회원(수신자)정보
				String toMail = toSend;
				String title = "<RunningCoop>으로 초대합니다";
				String content = "그룹 ID 로 초대합니다";
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
				String result = "ture";
				model.addAttribute("rst",result);
		
	 	return "Group/groupMailSend";
	}
	
	
}