package com.spring.helloworld.order.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.helloworld.cart.vo.CartStayVO;
import com.spring.helloworld.goods.vo.GoodsStayVO;
import com.spring.helloworld.order.vo.OrderAirVO;
import com.spring.helloworld.order.vo.OrderStayVO;

@Repository("orderDAO")
public class OrderDAOImpl implements OrderDAO {
	@Autowired
	private SqlSession sqlSession;
	
	// 항공 결제==================
	public List<OrderAirVO> listMyOrderGoodsAir(OrderAirVO orderAirVO) throws DataAccessException {
		List<OrderAirVO> orderGoodsList=new ArrayList<OrderAirVO>();
		orderGoodsList=(ArrayList)sqlSession.selectList("mapper.order.selectMyOrderAirList",orderAirVO);
		return orderGoodsList;
	}
	public void insertNewOrderAir(List<OrderAirVO> myOrderList) throws DataAccessException {
		int order_group_id=selectOrderGroupId();

		for(int i=0; i<myOrderList.size();i++){
			int order_id=selectOrderAirID();
			OrderAirVO orderAirVO =(OrderAirVO)myOrderList.get(i);
			orderAirVO.setAir_order_id(order_group_id);
			orderAirVO.setAir_seq_num(order_id);
			sqlSession.insert("mapper.order.insertNewOrderAir", orderAirVO);
		}
	}		
	private int selectOrderAirID() throws DataAccessException {
		return sqlSession.selectOne("mapper.order.selectOrderAirID");
	}
	public OrderAirVO findMyOrderAir(String order_id) throws DataAccessException {
		OrderAirVO orderVO=(OrderAirVO)sqlSession.selectOne("mapper.order.selectMyOrderAir",order_id);		
		return orderVO;
	}

	private int selectOrderGroupId() throws DataAccessException {
		return sqlSession.selectOne("mapper.order.selectOrderGroupId");
	}
	
	// 숙박 결제==================
	public List<OrderStayVO> listMyOrderGoodsStay(OrderStayVO orderStayVO) throws DataAccessException {
		List<OrderStayVO> orderGoodsList=new ArrayList<OrderStayVO>();
		orderGoodsList=(ArrayList)sqlSession.selectList("mapper.order.selectMyOrderStayList",orderStayVO);
		return orderGoodsList;
	}
	public void insertNewOrderStay(List<OrderStayVO> myOrderList) throws DataAccessException {
		int order_group_id=selectOrderGroupId();

		for(int i=0; i<myOrderList.size();i++){
			int order_id=selectOrderStayID();
			OrderStayVO orderStayVO =(OrderStayVO)myOrderList.get(i);
			orderStayVO.setStay_order_id(order_group_id);
			orderStayVO.setStay_seq_num(order_id);
			sqlSession.insert("mapper.order.insertNewOrderStay", orderStayVO);
		}
	}		
	private int selectOrderStayID() throws DataAccessException {
		return sqlSession.selectOne("mapper.order.selectOrderAirID");
	}
	public OrderStayVO findMyOrderStay(String order_id) throws DataAccessException {
		OrderStayVO orderVO=(OrderStayVO)sqlSession.selectOne("mapper.order.selectMyOrderStay",order_id);		
		return orderVO;
	}

	// 장바구니==================
	public void removeGoodsFromCartAir(OrderAirVO orderVO)throws DataAccessException{
		sqlSession.delete("mapper.order.deleteGoodsFromCartAir",orderVO);
	}
	public void removeGoodsFromCartAir(List<OrderAirVO> myOrderList)throws DataAccessException {
		for(int i=0; i<myOrderList.size();i++){
			OrderAirVO orderVO =(OrderAirVO)myOrderList.get(i);
			sqlSession.delete("mapper.order.deleteGoodsFromCartAir",orderVO);		
		}
	}
	
	//0405변재선
	public List<CartStayVO> selectStayCartList(CartStayVO cartStayVO) throws DataAccessException {
		List<CartStayVO> cartList =(List)sqlSession.selectList("mapper.order.selectStayCartList",cartStayVO);
		
		return cartList;
	}

	public List<GoodsStayVO> selectGoodsList(List<CartStayVO> cartList) throws DataAccessException {
		List<GoodsStayVO> myGoodsList;
		myGoodsList = sqlSession.selectList("mapper.order.selectGoodsList",cartList);
		return myGoodsList;
	}
	
	
	//0412 회원 예약확인을 위한 건데 위에는 진짜 모름 뭐임
	public List<OrderStayVO> selectOrderHistoryStayList(String mem_id) throws DataAccessException {
		List<OrderStayVO> myOrderHistoryStayList = sqlSession.selectList("mapper.order.selectOrderHistoryStayList", mem_id); 
		return myOrderHistoryStayList;
	}
	
	public List<OrderAirVO> selectOrderHistoryAirList(String mem_id) throws DataAccessException {
		List<OrderAirVO> myOrderHistoryAirList = sqlSession.selectList("mapper.order.selectOrderHistoryAirList", mem_id); 
		return myOrderHistoryAirList;
	}
	
	public void updateOrderStayState(OrderStayVO orderStayVO) throws DataAccessException{
		sqlSession.update("mapper.order.updateOrderStayState", orderStayVO);
	}
	public void updateOrderAirState(OrderAirVO orderAirVO) throws DataAccessException{
		sqlSession.update("mapper.order.updateOrderAirState", orderAirVO);
	}
	
	public List<OrderStayVO> selectbusiOrderList(String busi_id) throws DataAccessException{
		
		List<GoodsStayVO> busiGoodsList = sqlSession.selectList("mapper.order.selectBusiGoodsList", busi_id);
		
		List<OrderStayVO> busiOrderList = sqlSession.selectList("mapper.order.selectBusiOrderList", busiGoodsList);
		
		return busiOrderList;
	}
	
	public void permitOrderStayState(OrderStayVO orderStayVO) throws DataAccessException {
		sqlSession.update("mapper.order.permitOrderStayState", orderStayVO);
	}
	
	
	
	public List<OrderStayVO> selectAdminStayOrderList() throws DataAccessException{
		List<OrderStayVO> adminStayOrderList = sqlSession.selectList("mapper.order.selectAllOrderStayList");
		return adminStayOrderList;
	}
	public List<OrderAirVO> selectAdminAirOrderList() throws DataAccessException{
		List<OrderAirVO> adminAirOrderList = sqlSession.selectList("mapper.order.selectAllOrderAirList");
		return adminAirOrderList;
	}
	
	public void updateAdminStayState(OrderStayVO orderStayVO) throws DataAccessException{
		sqlSession.update("mapper.order.updateAdminStayState", orderStayVO);
	}
	
	public void updateAdminAirState(OrderAirVO orderAirVO) throws DataAccessException{
		sqlSession.update("mapper.order.updateAdminAirState", orderAirVO);
	}
	
}