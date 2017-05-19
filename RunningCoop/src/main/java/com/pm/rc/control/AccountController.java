package com.pm.rc.control;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pm.rc.dto.MemberDto;
import com.pm.rc.model.service.AccountService;

@Controller
public class AccountController {

	Logger logger = LoggerFactory.getLogger(AccountController.class);

	@Autowired
	private AccountService accountService;

	//로그인 페이지 접속
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String enterMain(){
		logger.info("main실행");
		return "account/main";
	}

	//로그인 체크
	@RequestMapping(value = "/ckLogin.do", method = RequestMethod.POST)
	public String ckLogin(HttpServletRequest req, HttpSession session){
		logger.info("ckLogin실행");
		String mem_id = (String)req.getParameter("mem_id");
		String mem_pw = (String)req.getParameter("mem_pw");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("mem_id", mem_id);
		map.put("mem_pw", mem_pw);
		MemberDto dto = new MemberDto();
		dto = accountService.loginPro(map);
		if(dto == null){
			return "account/error/error";
		}else{
			if(dto.getMem_level().equals("Y")){
				session.setAttribute("mem_id", dto.getMem_id());
				session.setAttribute("mem_name", dto.getMem_name());
				session.setAttribute("mem_level", dto.getMem_level());
				return "sysManage/grApply";
			} else{
				session.setAttribute("mem_id", dto.getMem_id());
				session.setAttribute("mem_name", dto.getMem_name());
				return "redirect:/myGrSelect.do?mem_id="+dto.getMem_id();
			}
		}
	}


		/*//그룹 검색 쿼리 추가해야 함
		if(dto == null){
			return "account/error/error";
		}else{
			if(dto.getMem_level().equals("Y")){
				session.setAttribute("mem_id", dto.getMem_id());
				session.setAttribute("mem_name", dto.getMem_name());
				session.setAttribute("mem_level", dto.getMem_level());
				return "sysManage/grApply";
			} else {
				session.setAttribute("mem_id", dto.getMem_id());
				session.setAttribute("mem_name", dto.getMem_name());
				return "account/loginAfter";
			}
		}*/

	//아이디 찾기(화면이동)
	@RequestMapping(value = "/searchAccount.do")
	public String searchAccount(){
		logger.info("searchAccount 실행");
		return "account/searchId";
	}

	//아이디찾기
	@RequestMapping(value = "/searchId.do", method = RequestMethod.POST)
	public String searchId(Model model, HttpServletRequest req){
		logger.info("searchId 실행");
		String name = req.getParameter("mem_name");
		String email =req.getParameter("mem_email");
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_name", name);
		map.put("mem_email", email);
		String id = accountService.memIdSearch(map);
		if(id==null){
			return "account/error/error";
		}else{
			model.addAttribute("id",id);
			model.addAttribute("email",email);
			return "account/resultId";
		}
	}

	//비밀번호찾기(화면 이동)
	@RequestMapping(value = "/searchPw.do")
	public String searchPw(){
		logger.info("searchPw 실행");
		return "account/searchPw";
	}

	//비밀번호찾기
	@RequestMapping(value = "/resultPw.do", method = RequestMethod.POST)
	public String resultPw(HttpServletRequest req){
		logger.info("resultPw 실행");
		String title = req.getParameter("mem_id");
		String toMail = req.getParameter("mem_email");
		return "redirect:/pwMailSending.do?title="+title+"&toMail="+toMail;
	}

	//로그아웃
	@RequestMapping(value = "/ckLogout.do", method = RequestMethod.GET)
	public String ckLogout(HttpSession session){
		logger.info("ckLogout");
		session.invalidate();
		return "account/main";
	}

	//회원가입 페이지 접속
	@RequestMapping(value = "/goJoin.do", method = RequestMethod.GET)
	public String goJoin(){
		logger.info("goJoin실행");
		return "account/writeJoinForm";
	}

	//아이디 중복 조회
	@RequestMapping(value = "/memIdSelect.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Boolean> memIdSelect(String mem_id){
		logger.info("memIdSelect실행");
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		System.out.println("mem_id="+mem_id);
		String isc = accountService.memIdSelect(mem_id);
		if(isc!=null){
			map.put("result", false);
		}else{
			map.put("result", true);
		}
		return map;
	}

	//본인인증 번호(세션) 삭제
	@RequestMapping(value = "/removeIdentify.do")
	@ResponseBody
	public void removeIdentify(HttpSession session){
		logger.info("removeIdentify실행");
		System.out.println("삭제 전 인증번호:"+session.getAttribute("identifyNum"));
		session.removeAttribute("identifyNum");
		System.out.println("삭제 후 인증번호:"+session.getAttribute("identifyNum"));
	}

	//본인인증 번호 확인
	@RequestMapping(value = "/ckIdentifyNum.do")
	@ResponseBody
	public Map<String, Boolean> ckIdentifyNum(HttpSession session,String input){
		logger.info("ckIdentifyNum실행");
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		System.out.println("인증번호:"+session.getAttribute("identifyNum"));
		System.out.println("입력값:"+input);
		String identifyNum = (String)session.getAttribute("identifyNum");
		if(input.equals(identifyNum)){
			System.out.println("번호 일치, 성공");
			map.put("result",true);
		}else{
			System.out.println("번호 불일치, 실패");
			map.put("result",false);
		}
		return map;
	}

	//회원가입처리
	@RequestMapping(value = "/chkJoin.do", method = RequestMethod.POST)
	public String ckJoin(HttpSession session, MemberDto dto){
		logger.info("ckJoin실행");
		boolean isc = accountService.memInsert(dto);
		if(isc == false){
			return "account/error/error";
		}else{
			session.setAttribute("mem_id", dto.getMem_id());
			session.setAttribute("mem_pw", dto.getMem_pw());
			session.setAttribute("mem_name", dto.getMem_name());
			return "account/joinAfter";
		}
	}

	//회원가입 후 바로 메인화면 이동
	@RequestMapping(value = "/firstLogin.do")
	public String firstLogin(){
		logger.info("firstLogin실행");
		return "Group/myGrSelect";
	}

	//탈퇴하기(페이지이동)
	@RequestMapping(value = "/goLeave.do", method = RequestMethod.GET)
	public String goLeave(HttpSession session, Model model){
		logger.info("goLeave실행");
		//		String mem_id = (String)session.getAttribute("mem_id");
		return "account/goLeave";
		/*		//pm목록 보는 서비스(PM권한 위임)
		List<Map<String, String>> pmSearchList = accountService.levelPmSelect(mem_id);
		//gm목록 보는 서비스(PM권한 위임)
		List<Map<String, String>> gmSearchList = accountService.levelGmSelect(mem_id);
		if(pmSearchList.size()!=0){
			model.addAttribute("pmSearchList", pmSearchList);
			return "account/listPmGroup";
		}else{
			if(gmSearchList.size()!=0){
				model.addAttribute("gmSearchList", gmSearchList);
				return "account/listGmProject";
			}else{
				//탈퇴처리
				boolean isc = accountService.memDelete(mem_id);
				if(isc == true){
					session.invalidate();
					return "account/bye";
				}else{
					return "account/error/error";
				}
			}
		}*/
	}

	//탈퇴 전 pm리스트 출력
	@RequestMapping(value = "/viewListPm.do")
	public String viewListPm(HttpSession session, Model model){
		logger.info("viewListPm실행");
		String mem_id = (String)session.getAttribute("mem_id");
		//pm목록 보는 서비스(PM권한 위임)
		List<Map<String, String>> pmSearchList = accountService.levelPmSelect(mem_id);
		model.addAttribute("pmSearchList", pmSearchList);
		return "account/listPmProject";
	}

	//탈퇴 전 gm리스트 출력
	@RequestMapping(value = "/viewListGm.do")
	public String viewListGm(HttpSession session, Model model){
		logger.info("viewListGm실행");
		String mem_id = (String)session.getAttribute("mem_id");
		//pm목록 보는 서비스(PM권한 위임)
		List<Map<String, String>> gmSearchList = accountService.levelGmSelect(mem_id);
		model.addAttribute("gmSearchList", gmSearchList);
		return "account/listGmGroup";
	}

	//탈퇴처리
	@RequestMapping(value = "/leaveService.do")
	public String leaveService(HttpSession session, HttpServletResponse resp){
		logger.info("leaveService실행");

		resp.setContentType("text/html;charset:UTF-8");
		resp.setHeader("Cache-Control", "no-cache");	

		//탈퇴전 gm,pm 재확인
		String mem_id = (String)session.getAttribute("mem_id");
		List<Map<String, String>> pmSearchList = accountService.levelPmSelect(mem_id);
		List<Map<String, String>> gmSearchList = accountService.levelGmSelect(mem_id);
		if(pmSearchList.size()!=0||gmSearchList.size()!=0){
			try {
				resp.getWriter().print("<script>alert('PM/GM으로 소속된 프로젝트가 있습니다. 확인해주세요')</script>");
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "account/goLeave";
		}else{
			//탈퇴처리
			boolean isc = accountService.memDelete(mem_id);
			if(isc == true){
				session.invalidate();
				return "account/bye";
			}else{
				return "account/error/error";
			}
		}
	}

	//서비스 탈퇴

	/*	//GM위임하기
	@RequestMapping(value = "/giveGm.do", method = RequestMethod.POST)
	public String giveGm(Model model, String gr_id){
		logger.info("giveGm실행");
		System.out.println("소속 그룹아이디: "+gr_id);
		model.addAttribute("gr_id",gr_id);
		return "account/grMemList";
	}
	 */
	//개인정보 수정(폼으로 이동)
	@RequestMapping(value = "/writeModifyForm.do", method = RequestMethod.GET)
	public String writeModify(Model model, String mem_id){
		logger.info("writeModifyForm실행");
		System.out.println(mem_id);
		MemberDto dto = accountService.memSelect(mem_id);
		model.addAttribute("dto", dto);
		return "account/writeModifyForm";
	}

	//개인정보 수정
	@RequestMapping(value = "/memInfoModify.do", method = RequestMethod.POST)
	public String memInfoModify(MemberDto dto){
		logger.info("memInfoModify실행");
		boolean result = accountService.memInfoModify(dto);
		if(result==true){
			return "Group/myGrSelect";
		}else{
			return "account/error/error";
		}
	}
	
	

}
