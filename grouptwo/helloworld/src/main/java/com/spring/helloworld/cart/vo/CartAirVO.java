package com.spring.helloworld.cart.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("cartAirVO")
public class CartAirVO {
	private int cart_air_id;
	private int cart_air_qty_people;
	private Date cart_air_creDate;
	private String air_airplane_id;
	private String mem_id;
	
	private String cart_vihicleId;
	private String cart_airlineNm;
	private String cart_depPlandTime;
	private String cart_arrPlandTime;
	private String cart_depAirportNm;
	
	private String cart_arrAirportNm;
	private int cart_economyCharge;
	private int cart_prestigeCharge;
	
	
	public int getCart_prestigeCharge() {
		return cart_prestigeCharge;
	}
	public void setCart_prestigeCharge(int cart_prestigeCharge) {
		this.cart_prestigeCharge = cart_prestigeCharge;
	}
	public String getCart_vihicleId() {
		return cart_vihicleId;
	}
	public void setCart_vihicleId(String cart_vihicleId) {
		this.cart_vihicleId = cart_vihicleId;
	}
	public String getCart_airlineNm() {
		return cart_airlineNm;
	}
	public void setCart_airlineNm(String cart_airlineNm) {
		this.cart_airlineNm = cart_airlineNm;
	}
	public String getCart_depPlandTime() {
		return cart_depPlandTime;
	}
	public void setCart_depPlandTime(String cart_depPlandTime) {
		this.cart_depPlandTime = cart_depPlandTime;
	}
	public String getCart_arrPlandTime() {
		return cart_arrPlandTime;
	}
	public void setCart_arrPlandTime(String cart_arrPlandTime) {
		this.cart_arrPlandTime = cart_arrPlandTime;
	}
	public String getCart_depAirportNm() {
		return cart_depAirportNm;
	}
	public void setCart_depAirportNm(String cart_depAirportNm) {
		this.cart_depAirportNm = cart_depAirportNm;
	}
	public String getCart_arrAirportNm() {
		return cart_arrAirportNm;
	}
	public void setCart_arrAirportNm(String cart_arrAirportNm) {
		this.cart_arrAirportNm = cart_arrAirportNm;
	}
	public int getCart_economyCharge() {
		return cart_economyCharge;
	}
	public void setCart_economyCharge(int cart_economyCharge) {
		this.cart_economyCharge = cart_economyCharge;
	}
	public int getCart_air_id() {
		return cart_air_id;
	}
	public void setCart_air_id(int cart_air_id) {
		this.cart_air_id = cart_air_id;
	}
	public int getCart_air_qty_people() {
		return cart_air_qty_people;
	}
	public void setCart_air_qty_people(int cart_air_qty_people) {
		this.cart_air_qty_people = cart_air_qty_people;
	}
	public Date getCart_air_creDate() {
		return cart_air_creDate;
	}
	public void setCart_air_creDate(Date cart_air_creDate) {
		this.cart_air_creDate = cart_air_creDate;
	}
	public String getAir_airplane_id() {
		return air_airplane_id;
	}
	public void setAir_airplane_id(String air_airplane_id) {
		this.air_airplane_id = air_airplane_id;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	
	
}
