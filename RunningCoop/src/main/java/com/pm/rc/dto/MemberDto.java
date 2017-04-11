package com.pm.rc.dto;

public class MemberDto {

	private String Mem_Id;
	private String Mem_Pw;
	private String Mem_Name;
	private String Mem_Email;
	private String Mem_Phone;
	private String Mem_regdate;
	private String Mem_delYN;
	
	public MemberDto(){}

	public String getMem_Id() {
		return Mem_Id;
	}

	public void setMem_Id(String mem_Id) {
		Mem_Id = mem_Id;
	}

	public String getMem_Pw() {
		return Mem_Pw;
	}

	public void setMem_Pw(String mem_Pw) {
		Mem_Pw = mem_Pw;
	}

	public String getMem_Name() {
		return Mem_Name;
	}

	public void setMem_Name(String mem_Name) {
		Mem_Name = mem_Name;
	}

	public String getMem_Email() {
		return Mem_Email;
	}

	public void setMem_Email(String mem_Email) {
		Mem_Email = mem_Email;
	}

	public String getMem_Phone() {
		return Mem_Phone;
	}

	public void setMem_Phone(String mem_Phone) {
		Mem_Phone = mem_Phone;
	}

	public String getMem_regdate() {
		return Mem_regdate;
	}

	public void setMem_regdate(String mem_regdate) {
		Mem_regdate = mem_regdate;
	}

	public String getMem_delYN() {
		return Mem_delYN;
	}

	public void setMem_delYN(String mem_delYN) {
		Mem_delYN = mem_delYN;
	}

	@Override
	public String toString() {
		return "MemberDto [Mem_Id=" + Mem_Id + ", Mem_Pw=" + Mem_Pw
				+ ", Mem_Name=" + Mem_Name + ", Mem_Email=" + Mem_Email
				+ ", Mem_Phone=" + Mem_Phone + ", Mem_regdate=" + Mem_regdate
				+ ", Mem_delYN=" + Mem_delYN + "]";
	}
	
}
