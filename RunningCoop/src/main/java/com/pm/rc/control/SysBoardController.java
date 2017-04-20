package com.pm.rc.control;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
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

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.pm.rc.dto.SbAttachDto;
import com.pm.rc.dto.SystemBoardDto;
import com.pm.rc.model.service.UserSysBoardService;

@Controller
public class SysBoardController {
	
	Logger logger = LoggerFactory.getLogger(SysBoardController.class);
	
	@Autowired
	private UserSysBoardService service;
	
	// 에디터 이동
	@RequestMapping(value = "/editor.do", method = RequestMethod.GET)
	public String editorMove(){
		return "sysBoard/daumOpenEditor";
	}
	
	// 공지 게시글 목록
	@RequestMapping(value = "/noticeList.do", method = RequestMethod.GET)
	public String noticeList(Model model, HttpSession session){
		List<Map<String, String>> list = null;
			list = service.noticeListSelect();
			model.addAttribute("list", list);
		return "sysBoard/noticeList";
	}
	
	// 공지 게시글 검색 목록
	@RequestMapping(value = "/noticeSList.do", method = RequestMethod.POST)
	public String noticeSList(Model model, HttpServletRequest request){
		String sbr_title = request.getParameter("sbr_title");
		List<Map<String, String>> list = null;
		Map<String, String> map = new HashMap<String, String>();
		map.put("sbr_title", sbr_title);
		list = service.noticeSearchSelect(map);
		model.addAttribute("slist", list);
		return "sysBoard/noticeSList";
	}
	
	// 공개 게시글 보기 페이지
	@RequestMapping(value="/boardView.do", method = RequestMethod.GET)
	public String boardView(Model model, HttpServletRequest request, HttpSession session){
		String sbr_uuid = request.getParameter("sbr_uuid");
		String sessionId = (String) session.getAttribute("mem_id");
		Map<String, String> uuid = new HashMap<String, String>();
		uuid.put("sbr_uuid", sbr_uuid);
		Map<String, String> view = new HashMap<String, String>();
		view = service.sysBoardViewSelect(uuid);
		model.addAttribute("view", view);
		model.addAttribute("mem_id", sessionId);
		return "sysBoard/boardView";
	}
	
	// 비밀 게시글 보기 페이지
	@RequestMapping(value="/scrBoardView.do", method = RequestMethod.POST)
	public String scrBoardView(Model model, HttpServletRequest request, HttpSession session){
		String sbr_uuid = request.getParameter("sbr_uuid");
		String sbr_pw = request.getParameter("sbr_pw");
		String sessionId = (String) session.getAttribute("mem_id");
		Map<String, String> map = new HashMap<String, String>();
		map.put("sbr_uuid", sbr_uuid);
		map.put("sbr_pw", sbr_pw);
		Map<String, String> view = new HashMap<String, String>();
		view = service.sysBoardViewSelect(map);
		String page = "";
		if(view == null){
			page =  "sysBoard/nonCorrectPW";
		} else {
			model.addAttribute("view", view);
			model.addAttribute("mem_id", sessionId);
			page = "sysBoard/scrBoardView";
		}
		return page;
	}
	
	// 문의 게시판 목록 출력
	@RequestMapping(value="/qnaList.do", method = RequestMethod.GET)
	public String qnaList(Model model){
		List<Map<String, String>> list = null;
		list = service.qnaListSelect();
		model.addAttribute("list", list);
		return "sysBoard/qnaList";
	}
	
	// 문의 게시글 검색 목록 출력
	@RequestMapping(value="/qnaSList.do", method = RequestMethod.POST)
	public String qnaSList(Model model, HttpServletRequest request){
		String sbr_title = request.getParameter("sbr_title");
		List<Map<String, String>> list = null;
		Map<String, String> map = new HashMap<String, String>();
		map.put("sbr_title", sbr_title);
		list = service.qnaSearchSelect(map);
		model.addAttribute("list", list);
		return "sysBoard/qnaSList";
	}
	
	// 게시글 작성페이지로 이동
	@RequestMapping(value="/writeForm.do", method = RequestMethod.GET)
	public String boardWrite(){
		return "sysBoard/boardWrite";
	}
	
	// 게시글 작성 폼
	@RequestMapping(value="/boardWrite.do", method = RequestMethod.POST)
	public String test05(HttpServletRequest request){
		SystemBoardDto board = new SystemBoardDto();
		String mem_id = "user1";
		
		//UUID 생성 메소드
		String uuid = createUUID();
		int indexnum = uuid.lastIndexOf("-");
		String sbr_uuid = uuid.substring(indexnum+1);
		
		// multipartRequest 객체를 생성하기 위한 세팅
		//실제 파일이 저장될 경로
		String savePath = "C:\\Users\\bin\\git\\PM_RunningCoop\\RunningCoop\\src\\main\\webapp\\WEB-INF\\files\\";
		//파일 크기 제한 (5MB)
		int maxFileSize = 1024 * 1024 * 5;
		
		
		try {
			MultipartRequest multi = new MultipartRequest(request, savePath, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
			
			// 첨부파일 실제경로 저장
			String fuuid = createUUID();
			String file_uuid = fuuid.substring(indexnum+1);
			String oldFileName = multi.getFilesystemName("satt_name");
			
			String newFileName = file_uuid + oldFileName;
			
			File OldFile = new File(savePath + oldFileName);
			File NewFile = new File(savePath + newFileName);
			
			byte[] buf = new byte[1024];
			FileInputStream fin = null;
			FileOutputStream fot = null;
			int read = 0;
			
			if( !OldFile.renameTo(NewFile)){
				buf = new byte[1024];
				read = 0;
				fin = new FileInputStream(OldFile);
				fot = new FileOutputStream(NewFile);
				
				while((read=fin.read(buf, 0, buf.length))!=1){
					fot.write(buf, 0, buf.length);
				}
				
				fin.close();
				fot.close();
				
				OldFile.delete();
			}
			
			// 게시글 등록 + 첨부파일 등록(DB)
			board.setSbr_uuid(sbr_uuid);
			board.setmem_id(mem_id);
			board.setSbr_title(multi.getParameter("sbr_title"));
			board.setSbr_content(multi.getParameter("sbr_content"));
			
			String scrpw = multi.getParameter("sbr_pw");
			
			SbAttachDto attach = new SbAttachDto();
			attach.setSbr_uuid(sbr_uuid);
			attach.setSatt_name(oldFileName);
			attach.setSatt_rname(newFileName);
			attach.setSatt_size(multi.getParameter("satt_size"));
			attach.setSatt_path(savePath);
			
			boolean isc = false;
			
			// scrpw에 값이 들어오면 비밀글로 등록, 값이 없으면 공개글로 등록
			if(scrpw != null && scrpw.length() > 0){
				String sbr_scryn = "Y";
				board.setSbr_scrYN(sbr_scryn);
				board.setSbr_pw(scrpw);
				isc = service.qnaBoardInsert(board, attach);
			} else if (scrpw == null || scrpw.length() == 0){
				String sbr_scryn = "N";
				board.setSbr_scrYN(sbr_scryn);
				board.setSbr_pw(scrpw);
				isc = service.qnaBoardInsert(board, attach);
			}
			
			if(isc == true){
				System.out.println("문의게시판 게시글 등록 성공");
			} else {
				System.out.println("문의게시판 게시글 등록 실패");
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "redirect:/qnaList.do";
	}
	
	// 수정페이지 이동
	@RequestMapping(value="/boardEditMove.do", method = RequestMethod.GET)
	public String boardEditPageMove(HttpServletRequest request, Model model){
		String sbr_uuid = request.getParameter("sbr_uuid");
		Map<String, String> map = new HashMap<String, String>();
		map.put("sbr_uuid", sbr_uuid);
		Map<String, String> view = service.editBoardViewSelect(map);
		model.addAttribute("view", view);
		return "sysBoard/boardEdit";
	}
	
	// 게시글 수정
	@RequestMapping(value="/boardEdit.do", method = RequestMethod.POST)
	public String BoardEdit(Model model){
		
		return null;
	}
	
	// 게시글 삭제
	@RequestMapping(value="/boardDelete.do", method = RequestMethod.GET)
	public String BoardDelete(HttpServletRequest request){
		boolean isc = false;
		String sbr_uuid = request.getParameter("sbr_uuid");
		Map<String, String> uuid = new HashMap<String, String>();
		uuid.put("sbr_uuid", sbr_uuid);
		Map<String, SbAttachDto> attach = new HashMap<String, SbAttachDto>();
		attach = service.sysAttachSelect(uuid);
		if(attach != null){
			String savePath = ""+attach.get("SATT_PATH");
			String fileName = ""+attach.get("SATT_RNAME");
			
			File file = new File(savePath+fileName);
			
			file.delete();
		}
		isc = service.qnaBoardDelete(sbr_uuid);
		if (isc){
			return "redirect:/qnaList.do";
		} else {
			return "redirect:/qnaList.do";
		}
	}
	
	// UUID 생성 메소드
	public String createUUID(){
		return UUID.randomUUID().toString();
	}

}
