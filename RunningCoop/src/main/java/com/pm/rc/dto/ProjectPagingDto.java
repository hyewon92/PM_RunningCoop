package com.pm.rc.dto;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

// 1. PagingDto
public class ProjectPagingDto {
	
	Logger logger = LoggerFactory.getLogger(ProjectPagingDto.class);

	private int pageCnt;		// 출력할 페이지번호 갯수
	private int index;			// 출력할 페이지번호
	private int pageStartNum;	// 출력할 페이지 시작 번호
	private int listCnt;		// 출력할 리스트 갯수
	private int total;			// 리스트 총 갯수
	private String mem_id; 	// 그룹,개인 프로젝트 검색할때 사용
	private String pr_name; // 프로젝트 검색할때 사용

	

	{
		logger.info("========================================================페이징DTO 초기화블럭 실행 시간 : "+(new Date())+"========================================================");
		pageCnt = 5;
		index = 0;
		pageStartNum = 1;
		listCnt = 5;
	}

	//	public PagingDto(String string, String string2, String string3, String string4) {}
	public ProjectPagingDto(String index, String pageStartNum, String listCnt , String mem_id, String pr_name) {
		logger.info("========================================================페이징DTO 생성자 호출 시간 : "+(new Date())+"========================================================");
		if(index != null){
			this.index = Integer.parseInt(index);
		}
		if(pageStartNum != null){
			this.pageStartNum = Integer.parseInt(pageStartNum);
		}
		if(listCnt != null){
			this.listCnt = Integer.parseInt(listCnt);
		}
		if(mem_id != null){
			this.mem_id = mem_id;
		}
		if(pr_name != null){
			this.pr_name = pr_name;
		}
	}
	
	public int getStart() {
		logger.info("========================================================페이징DTO getStart() 호출 시간 : "+(new Date())+"========================================================");
		return index*listCnt+1;
	}
	public int getLast() {
		logger.info("========================================================페이징DTO getLast() 호출 시간 : "+(new Date())+"========================================================");
		return (index*listCnt)+listCnt;
	}
	public int getPageLastNum() {
		logger.info("========================================================페이징DTO getPageLastNum() 호출 시간 : "+(new Date())+"========================================================");
		int remainListCnt = total-listCnt*(pageStartNum-1);
		int remainPageCnt = remainListCnt/listCnt;
		if(remainListCnt%listCnt != 0) {
			remainPageCnt++;
		}
		int pageLastNum = 0;
		if(remainListCnt <= listCnt) {
			pageLastNum = pageStartNum;
		}else if(remainPageCnt <= pageCnt) {
			pageLastNum = remainPageCnt+pageStartNum-1;
		}else {
			pageLastNum = pageCnt+pageStartNum-1;
		}
		return pageLastNum;
	}
	
	public int getPageCnt() {
		logger.info("========================================================페이징DTO getPageCnt() 호출 시간 : "+(new Date())+"========================================================");
		return pageCnt;
	}
	public void setPageCnt(int pageCnt) {
		this.pageCnt = pageCnt;
	}
	public int getIndex() {
		logger.info("========================================================페이징DTO getIndex() 호출 시간 : "+(new Date())+"========================================================");
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	public int getPageStartNum() {
		logger.info("========================================================페이징DTO getPageStartNum() 호출 시간 : "+(new Date())+"========================================================");
		return pageStartNum;
	}
	public void setPageStartNum(int pageStartNum) {
		this.pageStartNum = pageStartNum;
	}
	public int getListCnt() {
		logger.info("========================================================페이징DTO getListCnt() 호출 시간 : "+(new Date())+"========================================================");
		return listCnt;
	}
	public void setListCnt(int listCnt) {
		this.listCnt = listCnt;
	}
	public int getTotal() {
		logger.info("========================================================페이징DTO getTotal() 호출 시간 : "+(new Date())+"========================================================");
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}

	public String getMem_id() {
		return mem_id;
	}
	
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getPr_name() {
		return pr_name;
	}

	public void setPr_name(String pr_name) {
		this.pr_name = pr_name;
	}

	@Override
	public String toString() {
		return "ProjectPagingDto [logger=" + logger + ", pageCnt=" + pageCnt
				+ ", index=" + index + ", pageStartNum=" + pageStartNum
				+ ", listCnt=" + listCnt + ", total=" + total + ", mem_id="
				+ mem_id + ", pr_name=" + pr_name + "]";
	}
	
}
