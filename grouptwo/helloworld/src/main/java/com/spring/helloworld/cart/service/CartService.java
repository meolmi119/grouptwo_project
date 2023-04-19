package com.spring.helloworld.cart.service;

import java.util.List;
import java.util.Map;

import com.spring.helloworld.cart.vo.CartAirVO;
import com.spring.helloworld.cart.vo.CartStayVO;

public interface CartService {
	public boolean findCartGoodsStay(CartStayVO cartStayVO) throws Exception;
	public void addGoodsStayInCart(CartStayVO cartStayVO) throws Exception;
	public Map<String ,List> myStayCartList(CartStayVO cartStayVO) throws Exception;
	
	public void removeCartGoods(int cart_id) throws Exception;
	public void removeCartGoodsAir(int cart_id) throws Exception;
	
	public void addGoodsAirInCart(Map cartGoodsAirMap) throws Exception;
	public Map<String ,List> myAirCartList(CartAirVO cartAirVO) throws Exception;
}
