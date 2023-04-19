package com.spring.helloworld.business.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("businessVO")
public class BusinessVO {
	private String busi_id;
	private String busi_pw;
	private String busi_name;
	private String busi_brn;
	private String busi_man_name;
	private String busi_tel1;
	private String busi_tel2;
	private String busi_tel3;
	private String busi_hp1;
	private String busi_hp2;
	private String busi_hp3;
	private String busi_email1;
	private String busi_email2;
	private String busi_roadAddress;
	private String busi_jibunAddress;
	private String busi_namujiAddress;
	private String busi_zipcode;
	private Date joinDate;
	private String del_yn;
	
	public BusinessVO() {
		
	}

	public String getBusi_id() {
		return busi_id;
	}

	public void setBusi_id(String busi_id) {
		this.busi_id = busi_id;
	}

	public String getBusi_pw() {
		return busi_pw;
	}

	public void setBusi_pw(String busi_pw) {
		this.busi_pw = busi_pw;
	}

	public String getBusi_name() {
		return busi_name;
	}

	public void setBusi_name(String busi_name) {
		this.busi_name = busi_name;
	}

	public String getBusi_brn() {
		return busi_brn;
	}

	public void setBusi_brn(String busi_brn) {
		this.busi_brn = busi_brn;
	}

	public String getBusi_man_name() {
		return busi_man_name;
	}

	public void setBusi_man_name(String busi_man_name) {
		this.busi_man_name = busi_man_name;
	}

	public String getBusi_tel1() {
		return busi_tel1;
	}

	public void setBusi_tel1(String busi_tel1) {
		this.busi_tel1 = busi_tel1;
	}

	public String getBusi_tel2() {
		return busi_tel2;
	}

	public void setBusi_tel2(String busi_tel2) {
		this.busi_tel2 = busi_tel2;
	}

	public String getBusi_tel3() {
		return busi_tel3;
	}

	public void setBusi_tel3(String busi_tel3) {
		this.busi_tel3 = busi_tel3;
	}

	public String getBusi_hp1() {
		return busi_hp1;
	}

	public void setBusi_hp1(String busi_hp1) {
		this.busi_hp1 = busi_hp1;
	}

	public String getBusi_hp2() {
		return busi_hp2;
	}

	public void setBusi_hp2(String busi_hp2) {
		this.busi_hp2 = busi_hp2;
	}

	public String getBusi_hp3() {
		return busi_hp3;
	}

	public void setBusi_hp3(String busi_hp3) {
		this.busi_hp3 = busi_hp3;
	}

	public String getBusi_email1() {
		return busi_email1;
	}

	public void setBusi_email1(String busi_email1) {
		this.busi_email1 = busi_email1;
	}

	public String getBusi_email2() {
		return busi_email2;
	}

	public void setBusi_email2(String busi_email2) {
		this.busi_email2 = busi_email2;
	}

	public String getBusi_roadAddress() {
		return busi_roadAddress;
	}

	public void setBusi_roadAddress(String busi_roadAddress) {
		this.busi_roadAddress = busi_roadAddress;
	}

	public String getBusi_jibunAddress() {
		return busi_jibunAddress;
	}

	public void setBusi_jibunAddress(String busi_jibunAddress) {
		this.busi_jibunAddress = busi_jibunAddress;
	}

	public String getBusi_namujiAddress() {
		return busi_namujiAddress;
	}

	public void setBusi_namujiAddress(String busi_namujiAddress) {
		this.busi_namujiAddress = busi_namujiAddress;
	}

	public String getBusi_zipcode() {
		return busi_zipcode;
	}

	public void setBusi_zipcode(String busi_zipcode) {
		this.busi_zipcode = busi_zipcode;
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
	
}