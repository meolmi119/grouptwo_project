package com.spring.helloworld.member.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("memberVO")
public class MemberVO {
	private String mem_id;
	private String mem_pw;
	private String mem_name;
	private String mem_rrn;
	private String mem_tel1;
	private String mem_tel2;
	private String mem_tel3;
	private String mem_email1;
	private String mem_email2;
	private String mem_roadAddress;
	private String mem_jibunAddress;
	private String mem_namujiAddress;
	private String mem_zipcode;
	private Date joinDate;
	private String del_yn;
	private int mem_point;
	
	public MemberVO() {
		//System.out.println("MemberVO 积己磊 龋免(按眉 积己)");
	}

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

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

	public String getMem_rrn() {
		return mem_rrn;
	}

	public void setMem_rrn(String mem_rrn) {
		this.mem_rrn = mem_rrn;
	}

	public String getMem_tel1() {
		return mem_tel1;
	}

	public void setMem_tel1(String mem_tel1) {
		this.mem_tel1 = mem_tel1;
	}

	public String getMem_tel2() {
		return mem_tel2;
	}

	public void setMem_tel2(String mem_tel2) {
		this.mem_tel2 = mem_tel2;
	}

	public String getMem_tel3() {
		return mem_tel3;
	}

	public void setMem_tel3(String mem_tel3) {
		this.mem_tel3 = mem_tel3;
	}

	public String getMem_email1() {
		return mem_email1;
	}

	public void setMem_email1(String mem_email1) {
		this.mem_email1 = mem_email1;
	}

	public String getMem_email2() {
		return mem_email2;
	}

	public void setMem_email2(String mem_email2) {
		this.mem_email2 = mem_email2;
	}

	public String getMem_roadAddress() {
		return mem_roadAddress;
	}

	public void setMem_roadAddress(String mem_roadAddress) {
		this.mem_roadAddress = mem_roadAddress;
	}

	public String getMem_jibunAddress() {
		return mem_jibunAddress;
	}

	public void setMem_jibunAddress(String mem_jibunAddress) {
		this.mem_jibunAddress = mem_jibunAddress;
	}

	public String getMem_namujiAddress() {
		return mem_namujiAddress;
	}

	public void setMem_namujiAddress(String mem_namujiAddress) {
		this.mem_namujiAddress = mem_namujiAddress;
	}

	public String getMem_zipcode() {
		return mem_zipcode;
	}

	public void setMem_zipcode(String mem_zipcode) {
		this.mem_zipcode = mem_zipcode;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}

	public String getDel_yn() {
		return del_yn;
	}

	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}

	public int getMem_point() {
		return mem_point;
	}

	public void setMem_point(int mem_point) {
		this.mem_point = mem_point;
	}
	
}
