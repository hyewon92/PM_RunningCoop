package com.pm.rc.dto;

public class GroupDto {
	
	 private String gr_id;  
	 private String gr_name;     
	 private String gr_searchyn; 
	 private String gr_joinyn;   
	 private int gr_memcnt;   
	 private String gr_goal;     
	 private String gr_regdate;  
	 private String gr_appyn;
	 private String gr_delyn;   
	 
	 public GroupDto(){}
	 
	 @Override
	 public String toString() {
		 return "GroupDto [gr_id=" + gr_id + ", gr_name=" + gr_name
				 + ", gr_searchyn=" + gr_searchyn + ", gr_joinyn=" + gr_joinyn
				 + ", gr_memcnt=" + gr_memcnt + ", gr_goal=" + gr_goal
				 + ", gr_regdate=" + gr_regdate + ", gr_appyn=" + gr_appyn
				 + ", gr_delyn=" + gr_delyn + "]";
	 }
	 
	 public String getGr_id() {
		return gr_id;
	}


	public void setGr_id(String gr_id) {
		this.gr_id = gr_id;
	}


	public String getGr_name() {
		return gr_name;
	}


	public void setGr_name(String gr_name) {
		this.gr_name = gr_name;
	}


	public String getGr_searchyn() {
		return gr_searchyn;
	}


	public void setGr_searchyn(String gr_searchyn) {
		this.gr_searchyn = gr_searchyn;
	}


	public String getGr_joinyn() {
		return gr_joinyn;
	}


	public void setGr_joinyn(String gr_joinyn) {
		this.gr_joinyn = gr_joinyn;
	}


	public int getGr_memcnt() {
		return gr_memcnt;
	}


	public void setGr_memcnt(int gr_memcnt) {
		this.gr_memcnt = gr_memcnt;
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


	public String getGr_appyn() {
		return gr_appyn;
	}


	public void setGr_appyn(String gr_appyn) {
		this.gr_appyn = gr_appyn;
	}


	public String getGr_delyn() {
		return gr_delyn;
	}


	public void setGr_delyn(String gr_delyn) {
		this.gr_delyn = gr_delyn;
	}




	

	

}
