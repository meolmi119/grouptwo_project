package com.spring.helloworld.order.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.dao.DataAccessException;

import com.spring.helloworld.cart.vo.CartStayVO;
import com.spring.helloworld.goods.vo.GoodsStayVO;
import com.spring.helloworld.order.vo.OrderAirVO;
import com.spring.helloworld.order.vo.OrderStayVO;

public interface OrderDAO {
	public List<OrderAirVO> listMyOrderGoodsAir(OrderAirVO orderAirVO) throws DataAccessException;
	public void insertNewOrderAir(List<OrderAirVO> myOrderList) throws DataAccessException;
	public OrderAirVO findMyOrderAir(String order_id) throws DataAccessException;
	
	public List<OrderStayVO> listMyOrderGoodsStay(OrderStayVO orderStayVO) throws DataAccessException;
	public void insertNewOrderStay(List<OrderStayVO> myOrderList) throws DataAccessException;
	public OrderStayVO findMyOrderStay(String order_id) throws DataAccessException;
	
	public void removeGoodsFromCartAir(OrderAirVO orderVO)throws DataAccessException;
	public void removeGoodsFromCartAir(List<OrderAirVO> myOrderList)throws DataAccessException;
	
	public List<CartStayVO> selectStayCartList(CartStayVO cartStayVO) throws DataAccessException;
	public List<GoodsStayVO> selectGoodsList(List<CartStayVO> cartList) throws DataAccessException;
	
	//0412
	public List<OrderStayVO> selectOrderHistoryStayList(String mem_id) throws DataAccessException;
	public List<OrderAirVO> selectOrderHistoryAirList(String mem_id) throws DataAccessException;
	
	public void updateOrderStayState(OrderStayVO orderStayVO) throws DataAccessException;
	public void updateOrderAirState(OrderAirVO orderAirVO) throws DataAccessException;
	
	public List<OrderStayVO> selectbusiOrderList(String busi_id) throws DataAccessException;
	
	public void permitOrderStayState(OrderStayVO orderStayVO) throws DataAccessException;
	
	public List<OrderStayVO> selectAdminStayOrderList() throws DataAccessException;
	public List<OrderAirVO> selectAdminAirOrderList() throws DataAccessException;
	
	public void updateAdminStayState(OrderStayVO orderStayVO) throws DataAccessException;
	public void updateAdminAirState(OrderAirVO orderAirVO) throws DataAccessException;
	
}