package com.pm.rc.dto;

public class MemberDto {

	private String mem_id;
	private String mem_pw;
	private String mem_pame;
	private String mem_email;
	private String mem_phone;
	private String mem_regdate;
	private String mem_delYN;
	
	public MemberDto(){}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getMem_pw() {
		return mem_pw;
	}

	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}

	public String getMem_pame() {
		return mem_pame;
	}

	public void setMem_pame(String mem_pame) {
		this.mem_pame = mem_pame;
	}

	public String getMem_email() {
		return mem_email;
	}

	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}

	public String getMem_phone() {
		return mem_phone;
	}

	public void setMem_phone(String mem_phone) {
		this.mem_phone = mem_phone;
	}

	public String getMem_regdate() {
		return mem_regdate;
	}

	public void setMem_regdate(String mem_regdate) {
		this.mem_regdate = mem_regdate;
	}

	public String getMem_delYN() {
		return mem_delYN;
	}

	public void setMem_delYN(String mem_delYN) {
		this.mem_delYN = mem_delYN;
	}

	@Override
	public String toString() {
		return "MemberDto [mem_id=" + mem_id + ", mem_pw=" + mem_pw
				+ ", mem_pame=" + mem_pame + ", mem_email=" + mem_email
				+ ", mem_phone=" + mem_phone + ", mem_regdate=" + mem_regdate
				+ ", mem_delYN=" + mem_delYN + "]";
	}

}
