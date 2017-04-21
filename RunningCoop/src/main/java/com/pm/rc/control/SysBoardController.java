package com.pm.rc.control;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
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
		
		logger.info("================== 공지 게시판으로 이동 ==================");

		List<Map<String, String>> list = null;
		list = service.noticeListSelect();

		model.addAttribute("list", list);

		return "sysBoard/noticeList";
	}

	// 공지 게시글 검색 목록
	@RequestMapping(value = "/noticeSList.do", method = RequestMethod.POST)
	public String noticeSList(Model model, HttpServletRequest request){
		
		String sbr_title = request.getParameter("sbr_title");
		Map<String, String> map = new HashMap<String, String>();
		map.put("sbr_title", sbr_title);
		
		logger.info("================== 공지 게시글 검색 ==================");
		logger.info("검색할 제목 : "+sbr_title);
		logger.info("================================================");

		List<Map<String, String>> list = null;
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

		Map<String, String> map = new HashMap<String, String>();
		map.put("sbr_uuid", sbr_uuid);
		
		logger.info("================== 공지 게시글 보기 ==================");
		logger.info("현재 접속 중인 세션 : "+sessionId);
		logger.info("조회할 게시글 번호 : "+sbr_uuid);
		logger.info("================================================");

		Map<String, String> list = null;
		list = service.sysAttachSelect(map);

		model.addAttribute("view", view);
		model.addAttribute("mem_id", sessionId);

		if(list != null){
			model.addAttribute("attach", list);
		}

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
		
		logger.info("================== 공지 게시글 보기 ==================");
		logger.info("현재 접속 중인 세션 : "+sessionId);
		logger.info("조회할 게시글 번호 : "+sbr_uuid);
		logger.info("게시글 비밀번호 : "+sbr_pw);
		logger.info("================================================");

		Map<String, String> view = new HashMap<String, String>();
		view = service.sysBoardViewSelect(map);

		Map<String, String> list = null;
		list = service.sysAttachSelect(map);

		String page = "";

		if(view == null){
			page =  "sysBoard/nonCorrectPW";
		} else {
			model.addAttribute("view", view);
			model.addAttribute("mem_id", sessionId);
			if(list != null){
				model.addAttribute("attach", list);
			}
			page = "sysBoard/BoardView_scr";
		}

		return page;
	}

	// 문의 게시판 목록 출력
	@RequestMapping(value="/qnaList.do", method = RequestMethod.GET)
	public String qnaList(Model model){
		
		logger.info("================== 문의 게시판으로 이동 ==================");

		List<Map<String, String>> list = null;
		list = service.qnaListSelect();

		model.addAttribute("list", list);

		return "sysBoard/qnaList";
	}

	// 문의 게시글 검색 목록 출력
	@RequestMapping(value="/qnaSList.do", method = RequestMethod.POST)
	public String qnaSList(Model model, HttpServletRequest request){
		
		String sbr_title = request.getParameter("sbr_title");
		Map<String, String> map = new HashMap<String, String>();
		map.put("sbr_title", sbr_title);
		
		logger.info("================== 문의 게시글 검색 ==================");
		logger.info("검색할 제목 : "+sbr_title);
		logger.info("================================================");

		List<Map<String, String>> list = null;
		list = service.qnaSearchSelect(map);

		model.addAttribute("list", list);

		return "sysBoard/qnaSList";
	}

	// 게시글 작성페이지로 이동
	@RequestMapping(value="/writeForm.do", method = RequestMethod.GET)
	public String boardWrite(){
		logger.info("================== 게시글 작성 페이지 이동 ==================");
		return "sysBoard/boardWrite";
	}

	// 게시글 작성 폼
	@RequestMapping(value="/boardWrite.do", method = RequestMethod.POST)
	public String doWriteForm(HttpServletRequest request, HttpSession session){
		String mem_id = (String) session.getAttribute("mem_id");

		//UUID 생성 메소드
		String uuid = createUUID();
		int indexnum = uuid.lastIndexOf("-");
		String sbr_uuid = uuid.substring(indexnum+1);
		System.out.println(sbr_uuid);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("mem_id", mem_id);
		map.put("sbr_uuid", sbr_uuid);

		// multipartRequest 객체를 생성하기 위한 세팅
		//실제 파일이 저장될 경로
		String savePath = "C:\\Users\\fileSave\\";
		//파일 크기 제한 (5MB)
		int maxFileSize = 1024 * 1024 * 5;

		try {
			MultipartRequest multi = new MultipartRequest(request, savePath, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());

			String oldFileName = multi.getFilesystemName("satt_name");

			map.put("satt_name", oldFileName);
			
			if(oldFileName != null){

				// 새 파일 이름으로 바꾸기 위한 uuid 생성
				String fuuid = createUUID();
				String file_uuid = fuuid.substring(indexnum+1);

				String newFileName = file_uuid + oldFileName;

				// 첨부파일 실제경로 저장
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

				// 첨부파일 등록 (DB)
				map.put("satt_rname", newFileName);
				map.put("satt_size", multi.getParameter("satt_size"));
				map.put("satt_path", savePath);
			}

			// 게시글 등록 (DB)
			map.put("sbr_title", multi.getParameter("sbr_title"));
			map.put("sbr_content", multi.getParameter("sbr_content"));
			
			String scrpw = multi.getParameter("sbr_pw");

			boolean isc = false;

			// scrpw에 값이 들어오면 비밀글로 등록, 값이 없으면 공개글로 등록
			if(scrpw != null && scrpw.length() > 0){
				String sbr_scryn = "Y";
				map.put("sbr_scryn", sbr_scryn);
				map.put("sbr_pw", scrpw);
				isc = service.qnaBoardInsert(map);
			} else if (scrpw == null || scrpw.length() == 0){
				String sbr_scryn = "N";
				map.put("sbr_scryn", sbr_scryn);
				map.put("sbr_pw", scrpw);
				isc = service.qnaBoardInsert(map);
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

		Map<String, String> view = new HashMap<String, String>();
		view = service.editBoardViewSelect(map);
		
		Map<String, String> attach = null;
		attach = service.sysAttachSelect(map);

		model.addAttribute("view", view);
		model.addAttribute("attach", attach);

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

		Map<String, String> attach = null;
		attach = service.sysAttachSelect(uuid);

		String savePath = ""+attach.get("SATT_PATH");
		String fileName = ""+attach.get("SATT_RNAME");

		File file = new File(savePath+fileName);

		file.delete();

		isc = service.qnaBoardDelete(sbr_uuid);

		if (isc){
			return "redirect:/qnaList.do";
		} else {
			return "redirect:/qnaList.do";
		}
	}
	
	@RequestMapping(value="/fileDown.do", method=RequestMethod.GET)
	public void fileDownload(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String sbr_uuid = request.getParameter("sbr_uuid");
		Map<String, String> map = new HashMap<String, String>();
		map.put("sbr_uuid", sbr_uuid);
		
		Map<String, String> file = new HashMap<String, String>();
		file = service.sysAttachSelect(map);
		
		String path = file.get("SATT_PATH");
		String fileName = file.get("SATT_RNAME");
		String newFileName = file.get("SATT_NAME");
		
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

	// UUID 생성 메소드
	public String createUUID(){
		return UUID.randomUUID().toString();
	}

}
