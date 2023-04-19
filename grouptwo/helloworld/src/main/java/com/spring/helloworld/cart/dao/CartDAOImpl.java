package com.spring.helloworld.cart.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.helloworld.cart.vo.CartAirVO;
import com.spring.helloworld.cart.vo.CartStayVO;
import com.spring.helloworld.goods.vo.GoodsStayVO;

@Repository("cartDAO")
public class CartDAOImpl implements CartDAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public boolean selectCountInCart(CartStayVO cartStayVO) throws DataAccessException {
		String  result =sqlSession.selectOne("mapper.cart.selectCountInCart",cartStayVO);
		return Boolean.parseBoolean(result);
	}
	
	@Override
	public void insertGoodsStayInCart(CartStayVO cartStayVO) throws DataAccessException{
		int cart_stay_id = selectMaxStayCartId();
		cartStayVO.setCart_stay_id(cart_stay_id);
		sqlSession.insert("mapper.cart.insertGoodsInCart",cartStayVO);
	}
	
	private int selectMaxStayCartId() throws DataAccessException{
		int cart_stay_id =sqlSession.selectOne("mapper.cart.selectMaxStayCartId");
		return cart_stay_id;
	}
	
	public List<CartStayVO> selectStayCartList(CartStayVO cartStayVO) throws DataAccessException {
		List<CartStayVO> cartList =(List)sqlSession.selectList("mapper.cart.selectStayCartList",cartStayVO);
		
		return cartList;
	}

	public List<GoodsStayVO> selectGoodsList(List<CartStayVO> cartList) throws DataAccessException {
		List<GoodsStayVO> myGoodsList;
		myGoodsList = sqlSession.selectList("mapper.cart.selectGoodsList",cartList);
		return myGoodsList;
	}
	
	public void deleteCartGoods(int cart_id) throws DataAccessException{
		sqlSession.delete("mapper.cart.deleteCartGoods",cart_id);
	}
	
	public void deleteCartGoodsAir(int cart_id) throws DataAccessException{
		sqlSession.delete("mapper.cart.deleteCartGoodsAir",cart_id);
	}
	
	@Override
	public void insertGoodsAirInCart(Map cartGoodsAirMap) throws DataAccessException{
		int cart_air_id = selectMaxAirCartId();
		cartGoodsAirMap.put("cart_air_id", cart_air_id);
		sqlSession.insert("mapper.cart.insertGoodsAirInCart",cartGoodsAirMap);
	}
	
	private int selectMaxAirCartId() throws DataAccessException{
		int cart_air_id =sqlSession.selectOne("mapper.cart.selectMaxAirCartId");
		return cart_air_id;
	}
	
	public List<CartAirVO> selectAirCartList(CartAirVO cartAirVO) throws DataAccessException{
		List<CartAirVO> cartAirList =(List)sqlSession.selectList("mapper.cart.selectAirCartList", cartAirVO);
		return cartAirList;
	}
}
