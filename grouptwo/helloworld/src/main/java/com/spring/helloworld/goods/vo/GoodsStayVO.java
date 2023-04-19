package com.spring.helloworld.goods.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("goodsStayVO")
public class GoodsStayVO {
	private int goods_stay_id;
	private String busi_id;
	private String goods_stay_name;
	private String goods_stay_roadAddress;
	private String goods_stay_jibunAddress;
	
	private String goods_stay_namujiAddress;
	private String goods_stay_zipcode;
	private int goods_stay_num_people;
	private int goods_stay_price;
	private Double goods_stay_discount;
	
	private String goods_stay_discount_title;
	private int goods_stay_sales_price;
	private String goods_stay_admin_yn;
	private String goods_stay_room_number;
	private Date goods_stay_entered_Date;
	
	private Date goods_stay_admission_Date;
	private Date goods_stay_departure_Date;
	private String goods_stay_sort;
	
	private String goods_stay_sort_level;
	
	private String goods_stay_fileName;
	
	

	public String getGoods_stay_fileName() {
		return goods_stay_fileName;
	}

	public void setGoods_stay_fileName(String goods_stay_fileName) {
		this.goods_stay_fileName = goods_stay_fileName;
	}
	
    public String getGoods_stay_sort_level() {
		return goods_stay_sort_level;
	}

	public void setGoods_stay_sort_level(String goods_stay_sort_level) {
		this.goods_stay_sort_level = goods_stay_sort_level;
	}

	public GoodsStayVO() {
		
	}
	
	public int getGoods_stay_id() {
		return goods_stay_id;
	}
	public void setGoods_stay_id(int goods_stay_id) {
		this.goods_stay_id = goods_stay_id;
	}
	public String getBusi_id() {
		return busi_id;
	}
	public void setBusi_id(String busi_id) {
		this.busi_id = busi_id;
	}
	public String getGoods_stay_name() {
		return goods_stay_name;
	}
	public void setGoods_stay_name(String goods_stay_name) {
		this.goods_stay_name = goods_stay_name;
	}
	public String getGoods_stay_roadAddress() {
		return goods_stay_roadAddress;
	}
	public void setGoods_stay_roadAddress(String goods_stay_roadAddress) {
		this.goods_stay_roadAddress = goods_stay_roadAddress;
	}
	public String getGoods_stay_jibunAddress() {
		return goods_stay_jibunAddress;
	}
	public void setGoods_stay_jibunAddress(String goods_stay_jibunAddress) {
		this.goods_stay_jibunAddress = goods_stay_jibunAddress;
	}
	public String getGoods_stay_namujiAddress() {
		return goods_stay_namujiAddress;
	}
	public void setGoods_stay_namujiAddress(String goods_stay_namujiAddress) {
		this.goods_stay_namujiAddress = goods_stay_namujiAddress;
	}
	public String getGoods_stay_zipcode() {
		return goods_stay_zipcode;
	}
	public void setGoods_stay_zipcode(String goods_stay_zipcode) {
		this.goods_stay_zipcode = goods_stay_zipcode;
	}
	public int getGoods_stay_num_people() {
		return goods_stay_num_people;
	}
	public void setGoods_stay_num_people(int goods_stay_num_people) {
		this.goods_stay_num_people = goods_stay_num_people;
	}
	public int getGoods_stay_price() {
		return goods_stay_price;
	}
	public void setGoods_stay_price(int goods_stay_price) {
		this.goods_stay_price = goods_stay_price;
	}
	public Double getGoods_stay_discount() {
		return goods_stay_discount;
	}
	public void setGoods_stay_discount(Double goods_stay_discount) {
		this.goods_stay_discount = goods_stay_discount;
	}
	public String getGoods_stay_discount_title() {
		return goods_stay_discount_title;
	}
	public void setGoods_stay_discount_title(String goods_stay_discount_title) {
		this.goods_stay_discount_title = goods_stay_discount_title;
	}
	public int getGoods_stay_sales_price() {
		return goods_stay_sales_price;
	}
	public void setGoods_stay_sales_price(int goods_stay_sales_price) {
		this.goods_stay_sales_price = goods_stay_sales_price;
	}
	public String getGoods_stay_admin_yn() {
		return goods_stay_admin_yn;
	}
	public void setGoods_stay_admin_yn(String goods_stay_admin_yn) {
		this.goods_stay_admin_yn = goods_stay_admin_yn;
	}
	public String getGoods_stay_room_number() {
		return goods_stay_room_number;
	}
	public void setGoods_stay_room_number(String goods_stay_room_number) {
		this.goods_stay_room_number = goods_stay_room_number;
	}
	public Date getGoods_stay_entered_Date() {
		return goods_stay_entered_Date;
	}
	public void setGoods_stay_entered_Date(Date goods_stay_entered_Date) {
		this.goods_stay_entered_Date = goods_stay_entered_Date;
	}
	public Date getGoods_stay_admission_Date() {
		return goods_stay_admission_Date;
	}
	public void setGoods_stay_admission_Date(Date goods_stay_admission_Date) {
		this.goods_stay_admission_Date = goods_stay_admission_Date;
	}
	public Date getGoods_stay_departure_Date() {
		return goods_stay_departure_Date;
	}
	public void setGoods_stay_departure_Date(Date goods_stay_departure_Date) {
		this.goods_stay_departure_Date = goods_stay_departure_Date;
	}
	public String getGoods_stay_sort() {
		return goods_stay_sort;
	}
	public void setGoods_stay_sort(String goods_stay_sort) {
		this.goods_stay_sort = goods_stay_sort;
	}
	
	
}
