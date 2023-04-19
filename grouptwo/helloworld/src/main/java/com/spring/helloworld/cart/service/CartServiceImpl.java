package com.spring.helloworld.cart.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.helloworld.cart.dao.CartDAO;
import com.spring.helloworld.cart.vo.CartAirVO;
import com.spring.helloworld.cart.vo.CartStayVO;
import com.spring.helloworld.goods.vo.GoodsStayVO;

@Service("cartService")
@Transactional(propagation = Propagation.REQUIRED)
public class CartServiceImpl implements CartService{
	@Autowired
	private CartDAO cartDAO;
	
	@Override
	public boolean findCartGoodsStay(CartStayVO cartStayVO) throws Exception{
		 return cartDAO.selectCountInCart(cartStayVO);
		
	}	
	
	@Override
	public void addGoodsStayInCart(CartStayVO cartStayVO) throws Exception{
		cartDAO.insertGoodsStayInCart(cartStayVO);
	}
	
	public Map<String ,List> myStayCartList(CartStayVO cartStayVO) throws Exception{
		Map<String,List> cartStayMap=new HashMap<String,List>();
		List<CartStayVO> myStayCartList=cartDAO.selectStayCartList(cartStayVO);
		//?
		if(myStayCartList.size()==0){ 
			return null;
		}
		List<GoodsStayVO> myGoodsList=cartDAO.selectGoodsList(myStayCartList);
		
		cartStayMap.put("myStayCartList", myStayCartList);
		cartStayMap.put("myGoodsList",myGoodsList);
		
		return cartStayMap;
	}
	
	public void removeCartGoods(int cart_id) throws Exception{
		cartDAO.deleteCartGoods(cart_id);
	}
	
	public void removeCartGoodsAir(int cart_id) throws Exception{
		cartDAO.deleteCartGoodsAir(cart_id);
	}
	
	@Override
	public void addGoodsAirInCart(Map cartGoodsAirMap) throws Exception{
		cartDAO.insertGoodsAirInCart(cartGoodsAirMap);
	}
	
	@Override
	public Map<String ,List> myAirCartList(CartAirVO cartAirVO) throws Exception{
		Map<String ,List> cartAirMap = new HashMap<String,List>();
		List<CartAirVO> myAirCartList = cartDAO.selectAirCartList(cartAirVO);
		cartAirMap.put("myAirCartList", myAirCartList);
		
		return cartAirMap;
	}
}
