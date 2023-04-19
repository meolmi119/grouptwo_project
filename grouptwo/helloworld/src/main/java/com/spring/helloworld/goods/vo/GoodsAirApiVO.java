package com.spring.helloworld.goods.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("goodsAirApiVO")
public class GoodsAirApiVO {
	/* goods_airapit */
	
	private String goods_air_id;
	private String vihicleId;
	private String airlineNm;
	private Date depPlandTime;
	private Date arrPlandTime;
	private int economyCharge;
	private int prestigeCharge;
	private String depAirportNm;
	private String arrAirportNm;
	
	public String getGoods_air_id() {
		return goods_air_id;
	}
	public void setGoods_air_id(String goods_air_id) {
		this.goods_air_id = goods_air_id;
	}
	public String getVihicleId() {
		return vihicleId;
	}
	public void setVihicleId(String vihicleId) {
		this.vihicleId = vihicleId;
	}
	public String getAirlineNm() {
		return airlineNm;
	}
	public void setAirlineNm(String airlineNm) {
		this.airlineNm = airlineNm;
	}
	public Date getDepPlandTime() {
		return depPlandTime;
	}
	public void setDepPlandTime(Date depPlandTime) {
		this.depPlandTime = depPlandTime;
	}
	public Date getArrPlandTime() {
		return arrPlandTime;
	}
	public void setArrPlandTime(Date arrPlandTime) {
		this.arrPlandTime = arrPlandTime;
	}
	public int getEconomyCharge() {
		return economyCharge;
	}
	public void setEconomyCharge(int economyCharge) {
		this.economyCharge = economyCharge;
	}
	public int getPrestigeCharge() {
		return prestigeCharge;
	}
	public void setPrestigeCharge(int prestigeCharge) {
		this.prestigeCharge = prestigeCharge;
	}
	public String getDepAirportNm() {
		return depAirportNm;
	}
	public void setDepAirportNm(String depAirportNm) {
		this.depAirportNm = depAirportNm;
	}
	public String getArrAirportNm() {
		return arrAirportNm;
	}
	public void setArrAirportNm(String arrAirportNm) {
		this.arrAirportNm = arrAirportNm;
	}
}
