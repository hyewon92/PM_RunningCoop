package com.pm.rc.control;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.pm.rc.dto.GroupDto;
import com.pm.rc.dto.PagingProDto;
import com.pm.rc.dto.MemberDto;
import com.pm.rc.dto.SystemBoardDto;
import com.pm.rc.model.service.ManagerService;
import com.pm.rc.model.service.UserSysBoardService;

@RestController
public class sysManagerController {

	@Autowired
	private ManagerService service;

	Logger logger = LoggerFactory.getLogger(sysManagerController.class);

	//시스템관리자 로그인
	public Map<String, Boolean> adminLogin(@RequestBody(required = false) Map param){
		logger.info("시스템 관리자 로그인");
		String sParam1 =(String)param.get("mem_id");
		String sParam2 =(String)param.get("mem_pw");
		Boolean isc = false;
		
		Map<String, String> pMap = new HashMap<String, String>();
		pMap.put("mem_id", sParam1);
		pMap.put("mem_pw", sParam2);
		
		isc = service.adminLogin(pMap);
		
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("result", isc);
		
	}
	
	//그룹 생성 신청 리스트 출력함
	@RequestMapping(value="/grApply.do")
	public Map<String, List<GroupDto>> groupApply(@RequestBody(required = false) Map param){	//param: gr_name
		logger.info("그룹생성신청리스트출력시작");
		Map<String, List<GroupDto>> map = new HashMap<String, List<GroupDto>>();
		List<GroupDto> lists = new ArrayList<GroupDto>() ;
		String sParam = null;
		sParam = (String) param.get("gr_name");
		if(sParam == null){
			lists = service.grApplySelect(null);
		}else{
			lists = service.grApplySelect(sParam);
		}
		map.put("result", lists);
		return map;
	}

	//그룹승인 리스트 검색하여 출력
/*	@RequestMapping(value="/grApplySch.do")
	public String groupApply(Model model ,String gr_name){//맵
		logger.info("그룹생성신청리스트출력시작");
		List<GroupDto> lists = service.grApplySelect(gr_name);
		model.addAttribute("Apply",lists);
		return "Group/grApply";
	}*/

	//그룹승인
	@RequestMapping(value="/grApplyYse.do" , method=RequestMethod.POST)
	public Map<String, Boolean> grApplyYse(@RequestBody(required = false) Map param){	//gr_id 배열
		logger.info("그룹생성승인시작");
		Boolean isc = false;
		String[] sParam = null;
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		sParam = (String[])param.get("gr__id");
		isc = service.grAppModify(sParam);
		map.put("result", isc);
		return map;
	}
	
	//그룹거절
	@RequestMapping(value="/grApplyNo.do" , method=RequestMethod.POST)
	public Map<String, Boolean> grApplyNo(@RequestBody(required = false) Map param){	//gr_id 배열
		logger.info("그룹승인거절시작");
		Boolean isc = false;
		String[] sParam = null;
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		sParam = (String[])param.get("gr__id");
		isc = service.grDelete(sParam);
		map.put("result", isc);
		return map;
	}

	// 그룹 간략정보 확인하기
	@RequestMapping(value="/groupInfoChild.do" )
	public Map<String, List<GroupDto>> groupInfoChild(@RequestBody(required = false) Map param){	//param: gr_id
		logger.info("그룹 간략정보 확인");
		String sParam = null;
		List<GroupDto> lists = new ArrayList<GroupDto>();
		Map<String, List<GroupDto>> map = new HashMap<String, List<GroupDto>>();
		sParam = (String)param.get("gr_id");
		lists = service.grApplySelectGroup(sParam);
		map.put("result", lists);

		return map;
	}

	// 공지 게시판 관리 페이지 이동
	@RequestMapping(value="/sysNoticeMgr.do", method={RequestMethod.GET,RequestMethod.POST})
	public Map<String, Object> sysBoardManager(@RequestBody(required = false) Map param){
		logger.info("공지 게시판 관리 페이지 이동");
		SystemBoardDto dto = new SystemBoardDto();
		int sParam1 = (int)param.get("index");
		int sParam2 = (int)param.get("pageStartNum");
		int sParam3 = (int)param.get("listCnt");
		PagingProDto pgDto = new PagingProDto(sParam1, sParam2, sParam3);
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();

		dto.setPaging(paging);
		list = service.noticeListSelect(dto);
		pgDto.setTotal(sservice.noticeListSelectCount(dto));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result1", list);
		map.put("result2", pgDto);

		return map;
	}
	
	// 공지 게시판 게시글 검색
	@RequestMapping(value="/sysNoticeSearch.do", method=RequestMethod.POST)
	public Map<String, List<Map<String, String>>> sysNoticeSearch(@RequestBody(required = false) Map param){
		logger.info("공지 게시판 관리 페이지 이동");
		
		String sParam= (String)param.get("sbr_title");
		
		logger.info("=================== 공지 게시판 게시글 검색 =====================");
		logger.info("검색할 게시글 제목 : "+sParam);
		logger.info("=========================================================");
		
		Map<String, String> pMap = new HashMap<String, String>();
		pMap.put("sbr_title", sParam);
		
		
		Map<String, List<Map<String, String>>> map = new HashMap<String, List<Map<String,String>>>();
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		list = sservice.noticeSearchSelect(pMap);
		
		map.put("reuslt", list);
		
		return map;
	}

	// 공지 게시글 작성페이지 이동
	@RequestMapping(value="/noticeWriteForm.do", method=RequestMethod.GET)
	public String NoticeWriteForm(){
		logger.info("==================== 공지 게시글 작성 폼으로 이동 =====================");
		return "sysManage/sysNoticeWrite";
	}

	// 공지 게시글 작성(놔두기)
	@RequestMapping(value="/noticeWrite.do", method=RequestMethod.POST)
	public String NoticeWriete(@RequestBody(required = false) Map param){
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
	public Map<String, Map<String, String>> noticeEditForm(@RequestBody(required = false) Map param){
		String sParam = (String)param.get("sbr_uuid");
		
		Map<String, Map<String, String>> map = new HashMap<String, Map<String, String>>();
		
		Map<String, String> pMap1 = new HashMap<String, String>();
		pMap1.put("sbr_uuid", sParam);

		Map<String, String> pMap2 = new HashMap<String, String>();
		pMap2 = sservice.editBoardViewSelect(pMap1);
		map.put("result1", pMap2);

		Map<String, String> pMap3 = new HashMap<String, String>();
		pMap3 = sservice.sysAttachSelect(pMap1);
		map.put("result2", pMap3);

		return map;
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

	// 게시글 삭제
	@RequestMapping(value="/sysboardDelete.do", method=RequestMethod.GET)
	public String noticeDelete(HttpServletRequest request){
		String sbr_uuid = request.getParameter("sbr_uuid");
		String noticeyn = request.getParameter("noticeyn");
		
		Map<String, String> uuid = new HashMap<String, String>();
		uuid.put("sbr_uuid", sbr_uuid);

		Map<String, String> attach = null;
		attach = sservice.sysAttachSelect(uuid);

		if(attach != null){
			String savePath = ""+attach.get("SATT_PATH");
			String fileName = ""+attach.get("SATT_RNAME");

			File file = new File(savePath+fileName);

			file.delete();
		}

		boolean isc = false;
		isc = sservice.qnaBoardDelete(sbr_uuid);

		if(isc == true){
			System.out.println("문의 게시글 삭제 성공");
		} else {
			System.out.println("문의 게시글 삭제 실패");
		}
		
		if(noticeyn.equals("Y")){
			return "redirect:/sysNoticeMgr.do";
		} else {
			return "redirect:/sysQnaMgr.do";
		}

	}

	// 문의 게시판 관리 페이지 이동
	@RequestMapping(value="/sysQnaMgr.do", method={RequestMethod.GET,RequestMethod.POST})
	public String sysQnaManager(HttpServletRequest req, Model model){
		PagingProDto maPaing = new PagingProDto(req.getParameter("index"), 
													  req.getParameter("pageStartNum"), req.getParameter("listCnt"));
		
		
		logger.info("====================== 문의 게시판 관리 페이지 이동 ========================");

		List<Map<String, String>> list = new ArrayList<Map<String, String>>();

		list = sservice.qnaListSelectPaing(maPaing);
		maPaing.setTotal(sservice.qnaListSelectPaingCount());

		model.addAttribute("list", list);
		model.addAttribute("paging", maPaing);

		return "sysManage/sysQnaMgr";
	}
	
	// 문의 게시판 게시글 검색 리스트 조회
	@RequestMapping(value="/sysQnaSearch.do", method=RequestMethod.POST)
	public String sysQnaSearch(HttpServletRequest request, Model model){
		
		String sbr_title = request.getParameter("sbr_title");
		
		logger.info("==================== 문의 게시판 게시글 제목 검색 ======================");
		logger.info("검색할 게시글 제목 : "+sbr_title);
		logger.info("==============================================================");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("sbr_title", sbr_title);
		
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		list = sservice.qnaSearchSelect(map);
		
		model.addAttribute("list", list);
		
		return "sysManage/sysQnaMgr";
	}
	
	// 문의 게시판 게시글 조회
	@RequestMapping(value="/viewQna.do", method=RequestMethod.GET)
	public String sysQnaView(HttpServletRequest request, Model model){
		
		String sbr_uuid = request.getParameter("sbr_uuid");
		
		logger.info("================== 문의 게시글 보기 ==================");
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
		
		return "sysManage/sysQnaView";
	}
	
	// 답글 작성 폼으로 연결하기
	@RequestMapping(value="/writeReply.do", method=RequestMethod.GET)
	public String moveWriteRepleForm(HttpServletRequest request, Model model){
		
		String sbr_uuid = request.getParameter("sbr_uuid");
		
		logger.info("================== 문의 게시판 답글 작성 폼 ==================");
		logger.info("답글 작성할 게시글 uuid : "+sbr_uuid);
		logger.info("=====================================================");
		
		model.addAttribute("sbr_uuid", sbr_uuid);
		
		return "sysManage/sysRepleWrite";
	}
	
	// 문의 게시판 답글 작성 처리
	@RequestMapping(value="/qnaRepleWrite.do", method=RequestMethod.POST)
	public String WriteQnaReple(MultipartHttpServletRequest multiRequest){
		
		String Rsbr_uuid = multiRequest.getParameter("Rsbr_uuid");
		String sbr_title = multiRequest.getParameter("sbr_title");
		String mem_id = multiRequest.getParameter("mem_id");
		String sbr_content = multiRequest.getParameter("sbr_content");
		
		//UUID 생성 메소드
		String uuid = createUUID();
		int indexnum = uuid.lastIndexOf("-");
		String sbr_uuid = uuid.substring(indexnum+1);
		
		logger.info("===================== 문의 게시판 답글 작성 =======================");
		logger.info("작성할 게시글 uuid : "+sbr_uuid);
		logger.info("답글 작성할 게시글 uuid : "+Rsbr_uuid);
		logger.info("게시글 제목 : "+sbr_title);
		logger.info("관리자 아이디 : "+mem_id);
		logger.info("게시글 내용 : "+sbr_content);
		logger.info("===========================================================");
		
		Map<String, String> map = new HashMap<String, String>();
		
		MultipartFile file = multiRequest.getFile("satt_name");

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
		
		map.put("sbr_uuid", sbr_uuid);
		map.put("sbr_title", sbr_title);
		map.put("Rsbr_uuid", Rsbr_uuid);
		map.put("sbr_content", sbr_content);
		map.put("mem_id", mem_id);
		
		boolean isc = false;
		
		isc = service.qnaReplyInsert(map);
		
		if(isc){
			System.out.println("문의 게시판 답글 작성 성공");
		} else {
			System.out.println("문의 게시판 답글 작성 실패");
		}
		
		return "redirect:/sysQnaMgr.do";
	}
	
	// 게시글 선택 삭제
	@RequestMapping(value="/select_PostDelete.do", method=RequestMethod.POST)
	@ResponseBody
	public void select_PostDelete(HttpServletRequest request){
		
		String[] numList = (String[])request.getParameterValues("numList");
		
		logger.info("=================== 게시글 선택 삭제 ========================");
		logger.info(Arrays.toString(numList));
		logger.info("=======================================================");
		
		
		for(int i = 0; i < numList.length; i++){
			
			String sbr_uuid = numList[i];
			
			System.out.println(sbr_uuid);
			
			Map<String, String> uuid = new HashMap<String, String>();
			uuid.put("sbr_uuid", sbr_uuid);

			Map<String, String> attach = null;
			attach = sservice.sysAttachSelect(uuid);

			if(attach != null){
				String savePath = ""+attach.get("SATT_PATH");
				String fileName = ""+attach.get("SATT_RNAME");

				File file = new File(savePath+fileName);

				file.delete();
			}

			boolean isc = false;
			
			isc = sservice.qnaBoardDelete(sbr_uuid);

			if(isc == true){
				System.out.println("게시글 삭제 성공");
			} else {
				System.out.println("게시글 삭제 실패");
			}
		}
		
	}
	
	// 회원 관리 페이지 이동
	@RequestMapping(value="/sysMemMgr.do", method={RequestMethod.GET,RequestMethod.POST})
	public String sysMemberMgr(Model model , HttpServletRequest req){
		PagingProDto maPaging = new PagingProDto(req.getParameter("index"),
													   req.getParameter("pageStartNum"),
													   req.getParameter("listCnt"));
		
		logger.info("========================= 회원 관리 페이지 이동 =======================");
		
		List<MemberDto> list = new ArrayList<MemberDto>();
		
		list = service.allMemberSelect(maPaging);
		maPaging.setTotal(service.allMemberSelectCount());
		
		model.addAttribute("list", list);
		model.addAttribute("paging", maPaging);
		
		return "sysManage/sysMemMgr";
	}
	
	// 회원 검색
	@RequestMapping(value="/sysMemSearch.do", method=RequestMethod.POST)
	public String sysMemberSearch(HttpServletRequest request, Model model){
		
		String mem_name = request.getParameter("mem_name");
		
		logger.info("===================== 회원 검색 ========================");
		logger.info("검색할 내용 : "+mem_name);
		logger.info("====================================================");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_id", mem_name);
		
		List<MemberDto> list = new ArrayList<MemberDto>();
		
		list = service.allMemberSelectSearch(map);
		
		model.addAttribute("list", list);
		
		return "sysManage/sysMemMgr";
	}
	
	//회원정보조회
	@RequestMapping(value = "/sysMemView.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, MemberDto> sysMemView(String mem_id){
		logger.info("===================== 관리자 회원정보 조회 ============================");
		Map<String, MemberDto> map = new HashMap<String, MemberDto>();
		MemberDto dto = new MemberDto();
		dto = service.sysMemView(mem_id);
		map.put("info", dto);
		System.out.println(map);
		return map;
	}
	
	//회원정보 수정
	@RequestMapping(value = "/sysMemModify.do", method = RequestMethod.POST)
	public String sysMemModify(MemberDto dto){
		logger.info("===================== 관리자 회원정보 수정 ============================");
		boolean result = false;
		result = service.sysMemModify(dto);
		if(result){
			return "redirect:/sysMemMgr.do";
		}else{
			return "error/error";
		}
	}
	
	// 관리자 로그아웃
	@RequestMapping(value="/adminLogout.do", method=RequestMethod.GET)
	public String adminLogout(HttpSession session){
		
		logger.info("===================== 관리자 로그아웃 ============================");
		
		session.removeAttribute("mem_id");
		session.removeAttribute("mem_name");
		
		return "redirect:/main.do";
	}

	// UUID 생성 메소드
	public String createUUID(){
		return UUID.randomUUID().toString();
	}

}
