package com.pm.rc.dto;

public class GroupDto {

	private String gr_Id;
	private String gr_name;
	private String gr_searchYN;
	private String gr_joinYN;
	private String gr_maxMem;
	private String gr_memCnt;
	private String gr_goal;
	private String gr_regdate;
	private String gr_appYn;
	private String gr_delYN;
	
	public GroupDto(){}

	public String getGr_Id() {
		return gr_Id;
	}

	public void setGr_Id(String gr_Id) {
		this.gr_Id = gr_Id;
	}

	public String getGr_name() {
		return gr_name;
	}

	public void setGr_name(String gr_name) {
		this.gr_name = gr_name;
	}

	public String getGr_searchYN() {
		return gr_searchYN;
	}

	public void setGr_searchYN(String gr_searchYN) {
		this.gr_searchYN = gr_searchYN;
	}

	public String getGr_joinYN() {
		return gr_joinYN;
	}

	public void setGr_joinYN(String gr_joinYN) {
		this.gr_joinYN = gr_joinYN;
	}

	public String getGr_maxMem() {
		return gr_maxMem;
	}

	public void setGr_maxMem(String gr_maxMem) {
		this.gr_maxMem = gr_maxMem;
	}

	public String getGr_memCnt() {
		return gr_memCnt;
	}

	public void setGr_memCnt(String gr_memCnt) {
		this.gr_memCnt = gr_memCnt;
	}

	public String getGr_goal() {
		return gr_goal;
	}

	public void setGr_goal(String gr_goal) {
		this.gr_goal = gr_goal;
	}

	public String getGr_regdate() {
		return gr_regdate;
	}

	public void setGr_regdate(String gr_regdate) {
		this.gr_regdate = gr_regdate;
	}

	public String getGr_appYn() {
		return gr_appYn;
	}

	public void setGr_appYn(String gr_appYn) {
		this.gr_appYn = gr_appYn;
	}

	public String getGr_delYN() {
		return gr_delYN;
	}

	public void setGr_delYN(String gr_delYN) {
		this.gr_delYN = gr_delYN;
	}

	@Override
	public String toString() {
		return "GroupDto [gr_Id=" + gr_Id + ", gr_name=" + gr_name
				+ ", gr_searchYN=" + gr_searchYN + ", gr_joinYN=" + gr_joinYN
				+ ", gr_maxMem=" + gr_maxMem + ", gr_memCnt=" + gr_memCnt
				+ ", gr_goal=" + gr_goal + ", gr_regdate=" + gr_regdate
				+ ", gr_appYn=" + gr_appYn + ", gr_delYN=" + gr_delYN + "]";
	}
	
}
