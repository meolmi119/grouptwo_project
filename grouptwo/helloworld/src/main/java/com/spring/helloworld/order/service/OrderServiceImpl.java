package com.spring.helloworld.order.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.annotation.Propagation;

import com.spring.helloworld.cart.vo.CartStayVO;
import com.spring.helloworld.goods.vo.GoodsStayVO;
import com.spring.helloworld.order.dao.OrderDAO;
import com.spring.helloworld.order.vo.OrderAirVO;
import com.spring.helloworld.order.vo.OrderStayVO;

@Service("orderService")
@Transactional(propagation=Propagation.REQUIRED)
public class OrderServiceImpl implements OrderService {
	@Autowired
	private OrderDAO orderDAO;
	
	@Autowired
	private OrderAirVO orderAirVO;
	
	@Autowired
	private OrderStayVO orderStayVO;
	
	//항공주문==============
	public List<OrderAirVO> listMyOrderGoodsAir(OrderAirVO orderVO) throws Exception {
		List<OrderAirVO> orderGoodsList;
		orderGoodsList=orderDAO.listMyOrderGoodsAir(orderVO);
		return orderGoodsList;
	}
	
	public void addNewOrderAir(List<OrderAirVO> myOrderList) throws Exception {
		orderDAO.insertNewOrderAir(myOrderList);
		//카트에서 주문 상품 제거한다.
		orderDAO.removeGoodsFromCartAir(myOrderList);
	}	
	
	public OrderAirVO findMyOrderAIr(String order_id) throws Exception {
		return orderDAO.findMyOrderAir(order_id);
	}
	
	//항공주문==============
	public List<OrderStayVO> listMyOrderGoodsStay(OrderStayVO orderVO) throws Exception {
		List<OrderStayVO> orderGoodsList;
		orderGoodsList=orderDAO.listMyOrderGoodsStay(orderVO);
		return orderGoodsList;
	}
	
	public void addNewOrderStay(List<OrderStayVO> myOrderList) throws Exception {
		orderDAO.insertNewOrderStay(myOrderList);
		//카트에서 주문 상품 제거한다.
//		orderDAO.removeGoodsFromCartAir(myOrderList);
	}	
	
	public OrderStayVO findMyOrderStay(String order_id) throws Exception {
		return orderDAO.findMyOrderStay(order_id);
	}
		
	
	//0405변재선
	public Map<String ,List> myStayCartList(CartStayVO cartStayVO) throws Exception{
		Map<String,List> cartStayMap=new HashMap<String,List>();
		List<CartStayVO> myStayCartList=orderDAO.selectStayCartList(cartStayVO);
		//?
		if(myStayCartList.size()==0){ 
			return null;
		}
		List<GoodsStayVO> myGoodsList=orderDAO.selectGoodsList(myStayCartList);
		
		cartStayMap.put("myStayCartList", myStayCartList);
		cartStayMap.put("myGoodsList",myGoodsList);
		
		return cartStayMap;
	}
	
	//0412 이건 내가했눈데
	public Map<String, List> myOrderHistoryList(String mem_id) throws Exception {
		Map<String, List> totalOrderMap = new HashMap();
		
		orderAirVO.setMem_id(mem_id);
		orderStayVO.setMem_id(mem_id);
		
		List<OrderStayVO> myOrderHistoryStayList = orderDAO.selectOrderHistoryStayList(mem_id);
		List<OrderAirVO> myOrderHistoryAirList = orderDAO.selectOrderHistoryAirList(mem_id);
		
		totalOrderMap.put("myOrderHistoryStayList", myOrderHistoryStayList);
		totalOrderMap.put("myOrderHistoryAirList", myOrderHistoryAirList);
		
		return totalOrderMap;
	}
	
	//0417
	public void modOrderStayState(OrderStayVO orderStayVO) throws Exception{
		orderDAO.updateOrderStayState(orderStayVO);
	}
	public void modOrderAirState(OrderAirVO orderAirVO) throws Exception{
		orderDAO.updateOrderAirState(orderAirVO);
	}
	
	public List<OrderStayVO> selectbusiOrderList(String busi_id) throws Exception{
		List<OrderStayVO> selectbusiOrderList = orderDAO.selectbusiOrderList(busi_id);
		return selectbusiOrderList;
	}
	
	public void permitStayState(OrderStayVO orderStayVO) throws Exception{
		orderDAO.permitOrderStayState(orderStayVO);
	}
	
	public Map<String, List> allOrder() throws Exception {
		Map<String, List> totalOrder = new HashMap();
		
		List<OrderStayVO> adminStayOrderList = orderDAO.selectAdminStayOrderList();
		List<OrderAirVO> adminAirOrderList = orderDAO.selectAdminAirOrderList();
		
		totalOrder.put("adminStayOrderList", adminStayOrderList);
		totalOrder.put("adminAirOrderList", adminAirOrderList);
		
		return totalOrder;
	}
	
	public void permitAdminStayState(OrderStayVO orderStayVO) throws Exception{
		orderDAO.updateAdminStayState(orderStayVO);
	}
	public void permitAdminAirState(OrderAirVO orderAirVO) throws Exception{
		orderDAO.updateAdminAirState(orderAirVO);
	}
	
}