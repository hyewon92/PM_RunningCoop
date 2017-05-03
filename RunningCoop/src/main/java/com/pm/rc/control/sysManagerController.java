package com.pm.rc.control;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.pm.rc.dto.GroupDto;
import com.pm.rc.model.service.ManagerService;
import com.pm.rc.model.service.UserSysBoardService;

@Controller
public class sysManagerController {

	@Autowired
	private ManagerService service;
	
	@Autowired
	private UserSysBoardService sservice;

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
	
	// 공지 게시판 관리 페이지 이동
	@RequestMapping(value="/sysNoticeMgr.do", method=RequestMethod.GET)
	public String sysBoardManager(Model model){
		
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		
		list = sservice.noticeListSelect();
		
		model.addAttribute("list", list);
		
		return "sysManage/sysNoticeMgr";
	}
	
	// 공지 게시글 작성페이지 이동
	@RequestMapping(value="/noticeWriteForm.do", method=RequestMethod.GET)
	public String NoticeWriteForm(){
		
		logger.info("==================== 공지 게시글 작성 폼으로 이동 =====================");
		
		return "sysManage/sysNoticeWrite";
	}
	
	// 공지 게시글 작성
	@RequestMapping(value="/noticeWrite.do", method=RequestMethod.POST)
	public String NoticeWriete(MultipartHttpServletRequest multipartRequest){
		String sbr_title = multipartRequest.getParameter("sbr_title");
		String sbr_content = multipartRequest.getParameter("sbr_content");
		String mem_id = multipartRequest.getParameter("mem_id");
		
		//UUID 생성 메소드
		String uuid = createUUID();
		int indexnum = uuid.lastIndexOf("-");
		String sbr_uuid = uuid.substring(indexnum+1);
		
		logger.info("===================== 공지 게시글 작성 =======================");
		logger.info("작성할 게시글 uuid : "+sbr_uuid);
		logger.info("게시글 제목 : "+sbr_title);
		logger.info("관리자 아이디 : "+mem_id);
		logger.info("게시글 내용 : "+sbr_content);
		logger.info("========================================================");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("sbr_uuid", sbr_uuid);
		
		MultipartFile file = multipartRequest.getFile("satt_name");
		
		if (file != null){
			String savePath = "C:\\RC_fileSave\\";
			
			String fuuid = createUUID();
			int indexNum = fuuid.lastIndexOf("-");
			
			String oldFileName = file.getOriginalFilename();
			String satt_size = ""+file.getSize();
			
			String newFileName = fuuid.substring(indexNum+1) + oldFileName;
			
			// 첨부파일 실제경로 저장
			try {
				file.transferTo(new File(savePath + newFileName));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			logger.info("=============== 공지게시판 첨부파일 추가 ===================");
			logger.info("첨부파일 명 : "+oldFileName);
			logger.info("첨부파일 크기 : "+satt_size);
			logger.info("첨부파일 경로 : "+savePath);
			logger.info("첨부파일 실제이름 : "+newFileName);
			logger.info("====================================================");
			
			map.put("satt_name", oldFileName);
			map.put("satt_rname", newFileName);
			map.put("satt_size", satt_size);
			map.put("satt_path", savePath);
			
		}
		
		map.put("sbr_title", sbr_title);
		map.put("sbr_content", sbr_content);
		map.put("mem_id", mem_id);
		
		boolean isc = false;
		isc = service.noticeInsert(map);
		
		if(isc){
			System.out.println("공지게시판 게시글 등록 완료");
		} else {
			System.out.println("공지게시판 게시글 등록 실패");
		}
		
		return "redirect:/sysNoticeMgr.do";
	}
	
	// 공지 게시글 수정 폼 이동
	@RequestMapping(value="/sysBoardEditMove.do", method=RequestMethod.GET)
	public String noticeEditForm(HttpServletRequest request, Model model){
		String sbr_uuid = request.getParameter("sbr_uuid");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("sbr_uuid", sbr_uuid);

		Map<String, String> view = new HashMap<String, String>();
		view = sservice.editBoardViewSelect(map);

		Map<String, String> attach = null;
		attach = sservice.sysAttachSelect(map);

		model.addAttribute("view", view);
		model.addAttribute("attach", attach);
		
		return "sysManage/sysBoardEdit";
	}
	
	
	// 공지 게시글 수정
	@RequestMapping(value="/sysboardEdit.do", method=RequestMethod.POST)
	public String noticeEdit(MultipartHttpServletRequest multipartRequest){
		String sbr_uuid = multipartRequest.getParameter("sbr_uuid");
		String sbr_title = multipartRequest.getParameter("sbr_title");
		String sbr_content = multipartRequest.getParameter("sbr_content");

		logger.info("=============== 공지 게시판 : 게시글 수정 =========================");
		logger.info("수정할 게시글 아이디 : "+sbr_uuid);
		logger.info("수정할 게시글 제목 : "+sbr_title);
		logger.info("수정할 게시글 내용 : "+sbr_content);
		logger.info("===========================================================");

		Map<String, String> map = new HashMap<String, String>();
		map.put("sbr_uuid", sbr_uuid);

		MultipartFile file = multipartRequest.getFile("satt_name");
		
		logger.info(file.getOriginalFilename());

		if (!file.getOriginalFilename().equals("")){
			String savePath = "C:\\RC_fileSave\\";

			// 기존 파일 삭제
			Map<String, String> originFile = new HashMap<String, String>();
			originFile = sservice.sysAttachSelect(map);

			File delFile = new File(originFile.get("SATT_PATH")+originFile.get("SATT_RNAME"));
			delFile.delete();

			// 새 파일 등록
			String fuuid = createUUID();
			int indexNum = fuuid.lastIndexOf("-");

			String oldFileName = file.getOriginalFilename();
			String satt_size = ""+file.getSize();

			String newFileName = fuuid.substring(indexNum+1) + oldFileName;

			// 첨부파일 실제경로 저장
			try {
				file.transferTo(new File(savePath + newFileName));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}

			logger.info("=============== 공지게시판 첨부파일 추가 ===================");
			logger.info("첨부파일 명 : "+oldFileName);
			logger.info("첨부파일 크기 : "+satt_size);
			logger.info("첨부파일 경로 : "+savePath);
			logger.info("첨부파일 실제이름 : "+newFileName);
			logger.info("====================================================");

			map.put("satt_name", oldFileName);
			map.put("satt_rname", newFileName);
			map.put("satt_size", satt_size);
			map.put("satt_path", savePath);

		}

		map.put("sbr_title", sbr_title);
		map.put("sbr_content", sbr_content);

		boolean isc = false;

		isc = service.noticeModify(map);

		if(isc == true){
			System.out.println("공지게시판 게시글 수정 성공");
		} else {
			System.out.println("공지게시판 게시글 수정 실패");
		}
		
		return "redirect:/viewNotice.do?sbr_uuid="+sbr_uuid;
	}
	
	// 공지 게시글 보기
	@RequestMapping(value="/viewNotice.do", method=RequestMethod.GET)
	public String viewNotice(HttpServletRequest request, Model model){
		
		String sbr_uuid = request.getParameter("sbr_uuid");
		
		logger.info("================== 공지 게시글 보기 ==================");
		logger.info("조회할 게시글 번호 : "+sbr_uuid);
		logger.info("================================================");
		
		Map<String, String> uuid = new HashMap<String, String>();
		uuid.put("sbr_uuid", sbr_uuid);
		
		Map<String, String> view = new HashMap<String, String>();
		view = sservice.sysBoardViewSelect(uuid);
		Map<String, String> attach = new HashMap<String, String>();
		attach = sservice.sysAttachSelect(uuid);
		
		model.addAttribute("view", view);
		
		if(attach != null){
			model.addAttribute("attach", attach);
		}
		
		return "sysManage/sysBoardView";
	}
	
	// UUID 생성 메소드
		public String createUUID(){
			return UUID.randomUUID().toString();
		}

}
