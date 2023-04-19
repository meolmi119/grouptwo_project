package com.spring.helloworld.order.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("orderAirVO")
public class OrderAirVO {
	
	private int air_seq_num;
	private int air_order_id;
	private String mem_id;
	private int air_order_qty_people;
	private String air_order_pay_method;
	private String air_order_card_name;
	private String air_order_pay_month;
	private String air_order_state;
	private Date air_order_date;
	
	private String air_order_vihicleId;
	private String air_order_airlineNm;
	private String air_order_depPlandTime;
	private String air_order_arrPlandTime;
	private String air_order_depAirportNm;
	private String air_order_arrAirportNm;
	private int air_order_Charge;
	
	public int getAir_seq_num() {
		return air_seq_num;
	}
	public void setAir_seq_num(int air_seq_num) {
		this.air_seq_num = air_seq_num;
	}
	public int getAir_order_id() {
		return air_order_id;
	}
	public void setAir_order_id(int air_order_id) {
		this.air_order_id = air_order_id;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public int getAir_order_qty_people() {
		return air_order_qty_people;
	}
	public void setAir_order_qty_people(int air_order_qty_people) {
		this.air_order_qty_people = air_order_qty_people;
	}
	public String getAir_order_pay_method() {
		return air_order_pay_method;
	}
	public void setAir_order_pay_method(String air_order_pay_method) {
		this.air_order_pay_method = air_order_pay_method;
	}
	public String getAir_order_card_name() {
		return air_order_card_name;
	}
	public void setAir_order_card_name(String air_order_card_name) {
		this.air_order_card_name = air_order_card_name;
	}
	public String getAir_order_pay_month() {
		return air_order_pay_month;
	}
	public void setAir_order_pay_month(String air_order_pay_month) {
		this.air_order_pay_month = air_order_pay_month;
	}
	public String getAir_order_state() {
		return air_order_state;
	}
	public void setAir_order_state(String air_order_state) {
		this.air_order_state = air_order_state;
	}
	public Date getAir_order_date() {
		return air_order_date;
	}
	public void setAir_order_date(Date air_order_date) {
		this.air_order_date = air_order_date;
	}
	
	public String getAir_order_vihicleId() {
		return air_order_vihicleId;
	}
	public void setAir_order_vihicleId(String air_order_vihicleId) {
		this.air_order_vihicleId = air_order_vihicleId;
	}
	public String getAir_order_airlineNm() {
		return air_order_airlineNm;
	}
	public void setAir_order_airlineNm(String air_order_airlineNm) {
		this.air_order_airlineNm = air_order_airlineNm;
	}
	public String getAir_order_depPlandTime() {
		return air_order_depPlandTime;
	}
	public void setAir_order_depPlandTime(String air_order_depPlandTime) {
		this.air_order_depPlandTime = air_order_depPlandTime;
	}
	public String getAir_order_arrPlandTime() {
		return air_order_arrPlandTime;
	}
	public void setAir_order_arrPlandTime(String air_order_arrPlandTime) {
		this.air_order_arrPlandTime = air_order_arrPlandTime;
	}
	public String getAir_order_depAirportNm() {
		return air_order_depAirportNm;
	}
	public void setAir_order_depAirportNm(String air_order_depAirportNm) {
		this.air_order_depAirportNm = air_order_depAirportNm;
	}
	public String getAir_order_arrAirportNm() {
		return air_order_arrAirportNm;
	}
	public void setAir_order_arrAirportNm(String air_order_arrAirportNm) {
		this.air_order_arrAirportNm = air_order_arrAirportNm;
	}
	public int getAir_order_Charge() {
		return air_order_Charge;
	}
	public void setAir_order_Charge(int air_order_Charge) {
		this.air_order_Charge = air_order_Charge;
	}
}