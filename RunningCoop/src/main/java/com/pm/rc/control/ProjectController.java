package com.pm.rc.control;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.pm.rc.dto.GbAttachDto;
import com.pm.rc.dto.MemberDto;
import com.pm.rc.dto.ProjectDto;
import com.pm.rc.dto.WorkCommentDto;
import com.pm.rc.dto.WorkDetailDto;
import com.pm.rc.dto.WorkListDto;
import com.pm.rc.model.service.ProjectService;
import com.pm.rc.model.service.WorkListService;

@Controller
public class ProjectController {

	Logger logger = LoggerFactory.getLogger(ProjectController.class);

	@Autowired
	private ProjectService service;

	@Autowired
	private WorkListService wService;

	// 메인화면에서 그룹 프로젝트 선택
	@RequestMapping(value="/gProSelect.do", method=RequestMethod.GET)
	public String grProjectList(Model model, HttpServletRequest request){
		List<ProjectDto> list = null;
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_id", "user1");
		map.put("gr_id", "GR1704110001");
		list = service.groupProSelect(map);
		model.addAttribute("list", list);
		return "project/gProjectSelect";
	}

	// 메인화면에서 개인 프로젝트 선택
	@RequestMapping(value="/iProSelect.do", method=RequestMethod.GET)
	public String myProjectList(Model model, HttpServletRequest request, HttpSession session){
		List<ProjectDto> list = null;
		String mem_id = (String) session.getAttribute("mem_id");
		list = service.myProSelect(mem_id);
		model.addAttribute("list", list);
		return "project/mProjectSelect";
	}

	// 개인 프로젝트 생성화면 연결
	@RequestMapping(value="/createMPro.do", method=RequestMethod.GET)
	public String myProCreateMove(){
		return "project/mProCreate";
	}

	// 개인 프로젝트 생성 프로세스
	@RequestMapping(value="/mProCreate.do", method=RequestMethod.POST)
	public String myProCreate(HttpSession session, HttpServletRequest request){
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_id", (String) session.getAttribute("mem_id"));
		map.put("pr_name", request.getParameter("pr_name"));
		map.put("pr_startdate", request.getParameter("pr_startdate"));
		map.put("pr_enddate", request.getParameter("pr_enddate"));
		map.put("pr_goal", request.getParameter("pr_goal"));
		map.put("pr_etc", request.getParameter("pr_etc"));
		boolean isc = false;
		isc = service.iPrInsert(map);
		if(isc){
			System.out.println("개인 프로젝트 등록 성공");
			return "redirect:/iProSelect.do";
		} else {
			System.out.println("개인 프로젝트 등록 실패");
			return "redirect:/createMPro.do";
		}
	}

	// 프로젝트 정보 화면
	@RequestMapping(value="/detailPro.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> proDetail(HttpServletRequest request){
		logger.info("proDetail실행");
		String pr_id = request.getParameter("pr_id");
		Map<String, String> map = new HashMap<String, String>();
		map = service.prDetailSelect(pr_id);
		return map;
	}

	// 프로젝트 진행화면 이동
	@RequestMapping(value="/goProject.do", method=RequestMethod.GET)
	public String goToProject(Model model, HttpServletRequest request){
		String pr_id = request.getParameter("pr_id");

		logger.info("=================== 프로젝트 업무리스트 보기 =======================");
		logger.info("업무리스트를 볼 프로젝트 id :"+pr_id);
		logger.info("===========================================================");

		List<Map<String, String>> todo = null;
		List<Map<String, String>> doing = null;
		List<Map<String, String>> done = null;

		Map<String, String> map = new HashMap<String, String>();

		map.put("pr_id", pr_id);
		map.put("wk_condition", "todo");
		todo = wService.wkListSelect(map);

		model.addAttribute("todo", todo);

		map.replace("wk_condition", "doing");
		doing = wService.wkListSelect(map);

		model.addAttribute("doing", doing);

		map.replace("wk_condition", "done");
		done = wService.wkListSelect(map);

		model.addAttribute("done", done);
		
		model.addAttribute("pr_id", pr_id);
		
		MemberDto manager = new MemberDto();
		manager = service.prManagerSelect(pr_id);
		
		model.addAttribute("manager", manager.getMem_id());

		return "project/workList";
	}
	
	// 하위업무리스트 조회 메소드
	@RequestMapping(value="/detailWork.do", method=RequestMethod.POST)
	@ResponseBody
	public List<WorkDetailDto> workDetailView(Model model, HttpServletRequest request){
		String wk_id = request.getParameter("wk_id");

		logger.info("=============== 업무 상세 조회 ================");
		logger.info("조회할 업무 아이디 : "+wk_id);
		logger.info("=========================================");

		List<WorkDetailDto> dto = null;
		dto = wService.wdSelect(wk_id);

		return dto;
	}
	
	// 하위 업무 추가 후 출력 메소드
	@RequestMapping(value="/wdInsert.do", method=RequestMethod.POST)
	@ResponseBody
	public List<WorkDetailDto> workDetailInset(Model model, HttpServletRequest request){
		String wd_title = request.getParameter("wd_title");
		String wd_endDate = request.getParameter("wd_endDate");
		String wk_id = request.getParameter("wk_id");

		logger.info("=============== 하위 업무 추가 ================");
		logger.info("상위 업무 id :"+wk_id);
		logger.info("추가할 하위 업무 내용 : "+wd_title);
		logger.info("추가할 하위 업무 마감기한 : "+wd_endDate);
		logger.info("==========================================");

		WorkDetailDto dto = new WorkDetailDto();
		dto.setWk_id(wk_id);
		dto.setWd_title(wd_title);
		dto.setWd_endDate(wd_endDate);

		boolean isc = false;
		isc = wService.wdInsert(dto);
		
		boolean isc2 = false;
		isc2 = wService.wkRateModify(wk_id);

		if (isc && isc2){
			System.out.println("하위 업무 추가 성공");
		} else {
			System.out.println("하위 업무 추가 실패");
		}

		List<WorkDetailDto> list = null;
		list = wService.wdSelect(wk_id);

		return list;
	}

	//하위 업무 수정
	@RequestMapping(value="/wdEdit.do", method=RequestMethod.POST)
	@ResponseBody
	public List<WorkDetailDto> workDetailEdit(HttpServletRequest request){
		String wd_id = request.getParameter("wd_id");
		String wd_title = request.getParameter("wd_title");
		String wd_endDate = request.getParameter("wd_endDate");
		String wk_id = request.getParameter("wk_id");
		
		logger.info("=============== 하위 업무 수정 ================");
		logger.info("수정할 하위업무 id :"+wd_id);
		logger.info("수정할 하위 업무 내용 : "+wd_title);
		logger.info("수정할 하위 업무 마감기한 : "+wd_endDate);
		logger.info("==========================================");
		
		WorkDetailDto dto = new WorkDetailDto();
		dto.setWd_id(wd_id);
		dto.setWd_title(wd_title);
		dto.setWd_endDate(wd_endDate);
		
		boolean isc = false;
		isc = wService.wdModify(dto);
		
		if(isc){
			System.out.println("하위 업무 수정 성공");
		} else {
			System.out.println("하위 업무 수정 실패");
		}
		
		List<WorkDetailDto> list = null;
		list = wService.wdSelect(wk_id);
		
		return list;
	}
	
	//하위 업무 완료 처리
	@RequestMapping(value="/wdComplete.do", method=RequestMethod.POST)
	@ResponseBody
	public List<WorkDetailDto> workDetailComplete(HttpServletRequest request){
		String wd_id = request.getParameter("wd_id");
		String wk_id = request.getParameter("wk_id");
		
		logger.info("=============== 하위 업무 완료 처리 ===============");
		logger.info("완료할 하위 업무 id : "+wd_id);
		logger.info("============================================");
		
		boolean isc = false;
		isc = wService.wdComplModify(wd_id);
		
		boolean isc2 = false;
		isc2 = wService.wkRateModify(wk_id);
		
		if(isc && isc2){
			System.out.println("하위 업무 완료 수정 성공");
		} else {
			System.out.println("하위 업무 완료 수정 실패");
		}
		
		List<WorkDetailDto> list = null;
		list = wService.wdSelect(wk_id);
		
		return list;
	}
	
	//하위 업무 애로사항 표시
	@RequestMapping(value="/wdError.do", method=RequestMethod.POST)
	@ResponseBody
	public List<WorkDetailDto> workDetailError(HttpServletRequest request){
		String wd_id = request.getParameter("wd_id");
		String wk_id = request.getParameter("wk_id");
		
		logger.info("=============== 하위 업무 애로사항 표시 처리 =================");
		logger.info("애로사항 표시할 하위 업무 id :"+wd_id);
		logger.info("====================================================");
		
		boolean isc = false;
		isc = wService.wdErrorChk(wd_id);
		
		if(isc){
			System.out.println("하위 업무 애로사항 표시 성공");
		} else {
			System.out.println("하위 업무 애로사항 표시 실패");
		}
		
		List<WorkDetailDto> list = null;
		list = wService.wdSelect(wk_id);
		
		return list;
	}
	
	//하위 업무 삭제
	@RequestMapping(value="/wdDelete.do", method=RequestMethod.POST)
	@ResponseBody
	public List<WorkDetailDto> workDetailDelete(HttpServletRequest request){
		String wd_id = request.getParameter("wd_id");
		String wk_id = request.getParameter("wk_id");
		
		logger.info("=============== 하위 업무 삭제 ===================");
		logger.info("삭제할 하위 업무 아이디 : "+wd_id);
		logger.info("=============================================");
		
		boolean isc = false;
		isc = wService.wdDelete(wd_id);
		
		boolean isc2 = false;
		isc2 = wService.wkRateModify(wk_id);
		
		if(isc && isc2){
			System.out.println("하위 업무 삭제 성공");
		} else {
			System.out.println("하위 업무 삭제 실패");
		}
		
		List<WorkDetailDto> list = null;
		list = wService.wdSelect(wk_id);
		
		return list;
	}
	
	//프로젝트 멤버 조회
	@RequestMapping(value="/searchmem.do", method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String, String>> promemSelect(HttpServletRequest request){
		String pr_id = request.getParameter("pr_id");
		
		logger.info("=============== 프로젝트 참여 멤버 조회 ===================");
		logger.info("멤버 조회할 프로젝트 아이디 : "+pr_id);
		logger.info("==================================================");
		
		List<Map<String, String>> list = null;
		list = service.prMemListSelect(pr_id);
		
		return list;
	}
	
	// 업무 수정
	@RequestMapping(value="/workEdit.do", method=RequestMethod.POST)
	public String work_Edit(HttpServletRequest request){
		String pr_id = request.getParameter("pr_id");
		String wk_id = request.getParameter("wk_id");
		String wk_title = request.getParameter("wk_title");
		String wk_endDate = request.getParameter("wk_endDate");
		String mem_id = request.getParameter("mem_id");
		
		logger.info("=============== 업무 정보 변경 ===================");
		logger.info("수정 할 업무 아이디 : "+wk_id);
		logger.info("수정할 업무 내용 : "+wk_title);
		logger.info("수정할 업무 마감기한 : "+wk_endDate);
		logger.info("수정할 업무 담당자  : "+mem_id);
		logger.info("=============================================");
		
		WorkListDto dto = new WorkListDto();
		dto.setWk_id(wk_id);
		dto.setMem_id(mem_id);
		dto.setWk_title(wk_title);
		dto.setWk_endDate(wk_endDate);
		
		boolean isc = false;
		isc = wService.wkListModify(dto);

		if(isc){
			System.out.println("업무 정보 변경 성공");
		} else {
			System.out.println("업무 정보 변경 실패");
		}
		return "redirect:/goProject.do?pr_id="+pr_id;
	}
	
	// 업무 추가
	@RequestMapping(value="/workInsert.do", method=RequestMethod.POST)
	public String work_Insert(HttpServletRequest request){
		String pr_id = request.getParameter("pr_id");
		String wk_title = request.getParameter("wk_title");
		String wk_endDate = request.getParameter("wk_endDate");
		String mem_id = request.getParameter("mem_id");
		
		logger.info("================= 업무 추가 =====================");
		logger.info("업무 추가할 프로젝트 : "+pr_id);
		logger.info("추가할 업무 내용 : "+wk_title);
		logger.info("추가할 업무 마감기한 : "+wk_endDate);
		logger.info("추가할 업무 담당자 : "+mem_id);
		logger.info("=============================================");
		
		WorkListDto dto = new WorkListDto();
		dto.setWk_title(wk_title);
		dto.setWk_endDate(wk_endDate);
		dto.setMem_id(mem_id);
		dto.setPr_id(pr_id);
		
		boolean isc = false;
		isc = wService.wkListInsert(dto);
		
		if(isc){
			System.out.println("업무 등록 성공");
		} else {
			System.out.println("업무 등록 실패");
		}
		
		return "redirect:/goProject.do?pr_id="+pr_id;
	}
	
	//업무 삭제
	@RequestMapping(value="/workDelete.do", method=RequestMethod.GET)
	public String work_Delete(HttpServletRequest request){
		String pr_id = request.getParameter("pr_id");
		String wk_id = request.getParameter("wk_id");
		
		logger.info("=============== 업무 정보 삭제 ===================");
		logger.info("업무를 삭제할 프로젝트아이디 : "+pr_id);
		logger.info("삭제할 업무 아이디 : "+wk_id);
		logger.info("=============================================");
		
		boolean isc = false;
		isc = wService.wkListDelete(wk_id);
		
		if(isc){
			System.out.println("업무 삭제 성공");
		} else {
			System.out.println("업무 삭제 실패");
		}
		return "redirect:/goProject.do?pr_id="+pr_id;
	}
	
	//업무 코멘트 출력
	@RequestMapping(value="/wcomlist.do", method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String, String>> work_Comment_View(HttpServletRequest request){
		String wk_id = request.getParameter("wk_id");
		
		logger.info("=============== 업무 코멘트 출력 ===================");
		logger.info("코멘트 출력할 업무 아이디 : "+wk_id);
		logger.info("=============================================");
		
		List<Map<String, String>> list = null;
		
		list = wService.wCommListSelect(wk_id);
		
		return list;
	}
	
	//업무 코멘트 추가
	@RequestMapping(value="/wcominsert.do", method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String, String>> work_Comment_Insert(HttpServletRequest request, HttpSession session){
		String wk_id = request.getParameter("wk_id");
		String wcom_content = request.getParameter("wcom_content");
		String mem_id = (String)session.getAttribute("mem_id");
		
		logger.info("=============== 업무 코멘트 추가 ===================");
		logger.info("코멘트 추가할 업무 아이디 : "+wk_id);
		logger.info("코멘트 다는 회원 아이디 : "+mem_id);
		logger.info("추가할 업무 코멘트 내용 : "+wcom_content);
		logger.info("=============================================");
		
		WorkCommentDto dto = new WorkCommentDto();
		dto.setMem_id(mem_id);
		dto.setWcom_content(wcom_content);
		dto.setWk_id(wk_id);
		
		boolean isc = false;
		isc = wService.wCommentInsert(dto);
		
		if(isc){
			System.out.println("업무 코멘트 추가 성공");
		} else {
			System.out.println("업무 코멘트 추가 실패");
		}
		
		List<Map<String, String>> list = null;
		
		list = wService.wCommListSelect(wk_id);
		
		return list;
	}
	
	// 업무 코멘트 수정 기능
	@RequestMapping(value="/wcomEdit.do", method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String, String>> work_Comment_Edit(HttpServletRequest request){
		String wk_id = request.getParameter("wk_id");
		String wcom_id = request.getParameter("wcom_id");
		String wcom_content = request.getParameter("wcom_content");
		
		logger.info("=============== 업무 코멘트 수정 ===================");
		logger.info("코멘트가 포함된 업무 아이디 : "+wk_id);
		logger.info("수정할 코멘트 아이디 : "+wcom_id);
		logger.info("수정할 코멘트 내용 : "+wcom_content);
		logger.info("=============================================");
		
		WorkCommentDto dto = new WorkCommentDto();
		dto.setWcom_id(wcom_id);
		dto.setWcom_content(wcom_content);
		
		boolean isc = false;
		isc = wService.wCommentModify(dto);
		
		if(isc){
			System.out.println("업무 코멘트 수정 성공");
		} else {
			System.out.println("업무 코멘트 수정 실패");
		}
		
		List<Map<String, String>> list = null;
		list = wService.wCommListSelect(wk_id);
		
		return list;
	}
	
	// 업무 코멘트 삭제 기능
	@RequestMapping(value="/wcomDelete.do", method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String, String>> work_Comment_Delete(HttpServletRequest request){
		String wk_id = request.getParameter("wk_id");
		String wcom_id = request.getParameter("wcom_id");
		
		logger.info("=============== 업무 코멘트 삭제 ===================");
		logger.info("코멘트가 포함된 업무 아이디 : "+wk_id);
		logger.info("삭제할 코멘트 아이디 : "+wcom_id);
		logger.info("=============================================");
		
		boolean isc = false;
		isc = wService.wCommentDelete(wcom_id);
		
		if(isc){
			System.out.println("업무 코멘트 삭제 성공");
		} else {
			System.out.println("업무 코멘트 삭제 실패");
		}
		
		List<Map<String, String>> list = null;
		list = wService.wCommListSelect(wk_id);
		
		return list;
	}
	
	// 업무 첨부파일 목록 조회 및 출력 기능
	@RequestMapping(value="/attachlist.do", method=RequestMethod.POST)
	@ResponseBody
	public List<GbAttachDto> work_Attach_View(HttpServletRequest request){
		String wk_id = request.getParameter("wk_id");
		
		logger.info("=============== 업무 첨부파일 조회 ===================");
		logger.info("첨부파일 조회할 업무 아이디 : "+wk_id);
		logger.info("===============================================");
		
		List<GbAttachDto> list = null;
		list = wService.gbAttachSelect(wk_id);
		
		return list;
	}
	
	// 업무 첨부파일 추가 기능
	@RequestMapping(value="/attachInsert.do", method=RequestMethod.POST)
	@ResponseBody
	public List<GbAttachDto> work_Attach_Insert(HttpServletRequest request, MultipartHttpServletRequest multipartRequest){
		
		String wk_id = multipartRequest.getParameter("wk_id");
		
		MultipartFile file = multipartRequest.getFile("gatt_name");
		
		String savePath = "C:\\RC_fileSave\\";
		
		String uuid = createUUID();
		int indexNum = uuid.lastIndexOf("-");
		
		String oldFileName = file.getOriginalFilename();
		String gatt_size = ""+file.getSize();
		
		String newFileName = uuid.substring(indexNum+1) + oldFileName;
		
		// 첨부파일 실제경로 저장
		try {
			file.transferTo(new File(savePath + newFileName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		logger.info("=============== 업무 첨부파일 추가 ===================");
		logger.info("첨부파일 추가할 업무 아이디 : "+wk_id);
		logger.info("첨부파일 명 : "+oldFileName);
		logger.info("첨부파일 크기 : "+gatt_size);
		logger.info("첨부파일 경로 : "+savePath);
		logger.info("첨부파일 실제이름 : "+newFileName);
		logger.info("===============================================");
		
		GbAttachDto dto = new GbAttachDto();
		dto.setWk_id(wk_id);
		dto.setGatt_name(oldFileName);
		dto.setGatt_rname(newFileName);
		dto.setGatt_size(gatt_size);
		dto.setGatt_path(savePath);
		
		boolean isc = false;
		isc = wService.gbAttachInsert(dto);
		
		if(isc){
			System.out.println("파일 추가 성공");
		} else {
			System.out.println("파일 추가 실패");
		}
		
		List<GbAttachDto> list = null;
		
		list = wService.gbAttachSelect(wk_id);
		
		return list;
	}
	
	//파일 다운로드
	@RequestMapping(value="/gbfileDown.do", method=RequestMethod.GET)
	public void fileDownload(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String gatt_seq = request.getParameter("gatt_seq");
		
		GbAttachDto file = new GbAttachDto();
		file = wService.attachDownSelect(gatt_seq);
		
		String path = file.getGatt_path();
		String fileName = file.getGatt_rname();
		String newFileName = file.getGatt_name();
		
		String filePath = path + fileName;
		
		logger.info("================== 파일 다운로드  ==================");
		logger.info("다운로드할 파일명 :"+fileName);
		logger.info("파일 경로 :"+path);
		logger.info("반환할 파일 명 :"+newFileName);
		logger.info("===============================================");
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(filePath));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(newFileName, "UTF-8")+"\";");
		response.setHeader("Content-Transfer_Encoding", "binary");
		
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
	
	// 첨부파일 삭제
	@RequestMapping(value="/attachdelete.do", method=RequestMethod.POST)
	@ResponseBody
	public List<GbAttachDto> attach_Delete(HttpServletRequest request){
		String gatt_seq = request.getParameter("gatt_seq");
		String wk_id = request.getParameter("wk_id");
		
		logger.info("================== 파일 삭제  ==================");
		logger.info("삭제할 파일이 포함된 업무 아이디 : "+wk_id);
		logger.info("삭제할 파일 번호 :"+gatt_seq);
		logger.info("============================================");
		
		GbAttachDto file = new GbAttachDto();
		file = wService.attachDownSelect(gatt_seq);
		
		String fileName = file.getGatt_rname();
		String savePath = file.getGatt_path();
		
		File dFile = new File(savePath + fileName);
		dFile.delete();
		
		boolean isc = false;
		isc = wService.gbAttachDelete(gatt_seq);
		
		if(isc){
			System.out.println("파일 삭제 성공");
		} else {
			System.out.println("파일 삭제 실패");
		}
		
		List<GbAttachDto> list = null;
		list = wService.gbAttachSelect(wk_id);
		
		return list;
	}
	
	// 프로젝트 관리 페이지 이동
	@RequestMapping(value="/goProManage.do", method=RequestMethod.GET)
	public String goProject_Manager(Model model, HttpServletRequest request){
		String pr_id = request.getParameter("pr_id");
		model.addAttribute("pr_id", pr_id);
		return "project/mProjectManager";
	}
	
	// UUID 생성 메소드
	public String createUUID(){
		return UUID.randomUUID().toString();
	}



}
