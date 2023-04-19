package com.spring.helloworld.order.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("orderStayVO")
public class OrderStayVO {
	private int stay_seq_num;
	private int stay_order_id;
	private String mem_id;
	private int goods_stay_id;
	private int stay_order_qty_people;
	private String stay_order_pay_method;
	private String stay_order_card_name;
	private String stay_order_pay_month;
	
	private String stay_order_state;
	private String stay_order_date;
	private String stay_name;
	private String busi_id;
	private String stay_sort;
	private String stay_address;
	private String stay_admissionDate;
	private String stay_departureDate;
	private String stay_price;
	private String stay_num_people;
	
	public int getStay_seq_num() {
		return stay_seq_num;
	}
	public void setStay_seq_num(int stay_seq_num) {
		this.stay_seq_num = stay_seq_num;
	}
	public int getStay_order_id() {
		return stay_order_id;
	}
	public void setStay_order_id(int stay_order_id) {
		this.stay_order_id = stay_order_id;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getGoods_stay_id() {
		return goods_stay_id;
	}
	public void setGoods_stay_id(int goods_stay_id) {
		this.goods_stay_id = goods_stay_id;
	}
	public int getStay_order_qty_people() {
		return stay_order_qty_people;
	}
	public void setStay_order_qty_people(int stay_order_qty_people) {
		this.stay_order_qty_people = stay_order_qty_people;
	}
	public String getStay_order_pay_method() {
		return stay_order_pay_method;
	}
	public void setStay_order_pay_method(String stay_order_pay_method) {
		this.stay_order_pay_method = stay_order_pay_method;
	}
	public String getStay_order_card_name() {
		return stay_order_card_name;
	}
	public void setStay_order_card_name(String stay_order_card_name) {
		this.stay_order_card_name = stay_order_card_name;
	}
	public String getStay_order_pay_month() {
		return stay_order_pay_month;
	}
	public void setStay_order_pay_month(String stay_order_pay_month) {
		this.stay_order_pay_month = stay_order_pay_month;
	}
	public String getStay_order_state() {
		return stay_order_state;
	}
	public void setStay_order_state(String stay_order_state) {
		this.stay_order_state = stay_order_state;
	}
	public String getStay_order_date() {
		return stay_order_date;
	}
	public void setStay_order_date(String stay_order_date) {
		this.stay_order_date = stay_order_date;
	}
	public String getStay_name() {
		return stay_name;
	}
	public void setStay_name(String stay_name) {
		this.stay_name = stay_name;
	}
	public String getBusi_id() {
		return busi_id;
	}
	public void setBusi_id(String busi_id) {
		this.busi_id = busi_id;
	}
	public String getStay_sort() {
		return stay_sort;
	}
	public void setStay_sort(String stay_sort) {
		this.stay_sort = stay_sort;
	}
	public String getStay_address() {
		return stay_address;
	}
	public void setStay_address(String stay_address) {
		this.stay_address = stay_address;
	}
	public String getStay_admissionDate() {
		return stay_admissionDate;
	}
	public void setStay_admissionDate(String stay_admissionDate) {
		this.stay_admissionDate = stay_admissionDate;
	}
	public String getStay_departureDate() {
		return stay_departureDate;
	}
	public void setStay_departureDate(String stay_departureDate) {
		this.stay_departureDate = stay_departureDate;
	}
	public String getStay_price() {
		return stay_price;
	}
	public void setStay_price(String stay_price) {
		this.stay_price = stay_price;
	}
	public String getStay_num_people() {
		return stay_num_people;
	}
	public void setStay_num_people(String stay_num_people) {
		this.stay_num_people = stay_num_people;
	}
}