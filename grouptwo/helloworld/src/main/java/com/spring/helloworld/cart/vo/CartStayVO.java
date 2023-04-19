package com.spring.helloworld.cart.vo;






import java.util.Date;

import org.springframework.stereotype.Component;

@Component("cartStayVO")
public class CartStayVO {
	private int cart_stay_id;
	private int cart_stay_room_number;
	private Date cart_stay_creDate;
	private String mem_id;
	private int goods_stay_id;
	
	private Date startD;
	private Date endD;
	
	
	
	public Date getStartD() {
		return startD;
	}
	public void setStartD(Date startD) {
		this.startD = startD;
	}
	public Date getEndD() {
		return endD;
	}
	public void setEndD(Date endD) {
		this.endD = endD;
	}
	public int getCart_stay_id() {
		return cart_stay_id;
	}
	public void setCart_stay_id(int cart_stay_id) {
		this.cart_stay_id = cart_stay_id;
	}
	public int getCart_stay_room_number() {
		return cart_stay_room_number;
	}
	public void setCart_stay_room_number(int cart_stay_room_number) {
		this.cart_stay_room_number = cart_stay_room_number;
	}
	public Date getCart_stay_creDate() {
		return cart_stay_creDate;
	}
	public void setCart_stay_creDate(Date cart_stay_creDate) {
		this.cart_stay_creDate = cart_stay_creDate;
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
	
	
}
