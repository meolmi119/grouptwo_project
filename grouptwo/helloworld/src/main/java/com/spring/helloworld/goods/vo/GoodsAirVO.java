package com.spring.helloworld.goods.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("goodsAirVO")
public class GoodsAirVO {
	/* goods_airt */
	
	private String goods_air_id;
	private String busi_id;
	private String goods_air_name;
	private String goods_air_depart1;
	private String goods_air_arrive1;
	private Date goods_air_depart_Date;
	private Date goods_air_arrive_Date;
	private String goods_air_class;
	private int goods_air_num_people;
	private int goods_air_price;
	private int goods_air_sales_price;
	private Double goods_air_discount;
	private String goods_air_discount_title;
	private String goods_air_admin_yn;
	private Date goods_air_entered_Date;
	private String air_airplane_id;
	
	public String getGoods_air_id() {
		return goods_air_id;
	}
	public void setGoods_air_id(String goods_air_id) {
		this.goods_air_id = goods_air_id;
	}
	public String getBusi_id() {
		return busi_id;
	}
	public void setBusi_id(String busi_id) {
		this.busi_id = busi_id;
	}
	public String getGoods_air_name() {
		return goods_air_name;
	}
	public void setGoods_air_name(String goods_air_name) {
		this.goods_air_name = goods_air_name;
	}
	public String getGoods_air_depart1() {
		return goods_air_depart1;
	}
	public void setGoods_air_depart1(String goods_air_depart1) {
		this.goods_air_depart1 = goods_air_depart1;
	}
	public String getGoods_air_arrive1() {
		return goods_air_arrive1;
	}
	public void setGoods_air_arrive1(String goods_air_arrive1) {
		this.goods_air_arrive1 = goods_air_arrive1;
	}
	public Date getGoods_air_depart_Date() {
		return goods_air_depart_Date;
	}
	public void setGoods_air_depart_Date(Date goods_air_depart_Date) {
		this.goods_air_depart_Date = goods_air_depart_Date;
	}
	public Date getGoods_air_arrive_Date() {
		return goods_air_arrive_Date;
	}
	public void setGoods_air_arrive_Date(Date goods_air_arrive_Date) {
		this.goods_air_arrive_Date = goods_air_arrive_Date;
	}
	public String getGoods_air_class() {
		return goods_air_class;
	}
	public void setGoods_air_class(String goods_air_class) {
		this.goods_air_class = goods_air_class;
	}
	public int getGoods_air_num_people() {
		return goods_air_num_people;
	}
	public void setGoods_air_num_people(int goods_air_num_people) {
		this.goods_air_num_people = goods_air_num_people;
	}
	public int getGoods_air_price() {
		return goods_air_price;
	}
	public void setGoods_air_price(int goods_air_price) {
		this.goods_air_price = goods_air_price;
	}
	public int getGoods_air_sales_price() {
		return goods_air_sales_price;
	}
	public void setGoods_air_sales_price(int goods_air_sales_price) {
		this.goods_air_sales_price = goods_air_sales_price;
	}
	public Double getGoods_air_discount() {
		return goods_air_discount;
	}
	public void setGoods_air_discount(Double goods_air_discount) {
		this.goods_air_discount = goods_air_discount;
	}
	public String getGoods_air_discount_title() {
		return goods_air_discount_title;
	}
	public void setGoods_air_discount_title(String goods_air_discount_title) {
		this.goods_air_discount_title = goods_air_discount_title;
	}
	public String getGoods_air_admin_yn() {
		return goods_air_admin_yn;
	}
	public void setGoods_air_admin_yn(String goods_air_admin_yn) {
		this.goods_air_admin_yn = goods_air_admin_yn;
	}
	public Date getGoods_air_entered_Date() {
		return goods_air_entered_Date;
	}
	public void setGoods_air_entered_Date(Date goods_air_entered_Date) {
		this.goods_air_entered_Date = goods_air_entered_Date;
	}
	public String getAir_airplane_id() {
		return air_airplane_id;
	}
	public void setAir_airplane_id(String air_airplane_id) {
		this.air_airplane_id = air_airplane_id;
	}	
}
