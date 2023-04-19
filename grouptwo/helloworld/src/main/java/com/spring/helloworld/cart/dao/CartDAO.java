package com.spring.helloworld.cart.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.helloworld.cart.vo.CartAirVO;
import com.spring.helloworld.cart.vo.CartStayVO;
import com.spring.helloworld.goods.vo.GoodsStayVO;

public interface CartDAO {
	public boolean selectCountInCart(CartStayVO cartStayVO) throws DataAccessException;
	public void insertGoodsStayInCart(CartStayVO cartStayVO) throws DataAccessException;
	public List<CartStayVO> selectStayCartList(CartStayVO cartStayVO) throws DataAccessException;
	public List<GoodsStayVO> selectGoodsList(List<CartStayVO> cartList) throws DataAccessException;
	
	public void deleteCartGoods(int cart_id) throws DataAccessException;
	public void deleteCartGoodsAir(int cart_id) throws DataAccessException;
	
	public void insertGoodsAirInCart(Map cartGoodsAirMap) throws DataAccessException;
	public List<CartAirVO> selectAirCartList(CartAirVO cartAirVO) throws DataAccessException;
}
