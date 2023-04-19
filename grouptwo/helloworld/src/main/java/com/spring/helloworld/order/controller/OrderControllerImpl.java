package com.spring.helloworld.order.controller;

import java.sql.Date;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.helloworld.business.vo.BusinessVO;
import com.spring.helloworld.cart.vo.CartAirVO;
import com.spring.helloworld.common.base.BaseController;
import com.spring.helloworld.goods.service.GoodsService;
import com.spring.helloworld.goods.vo.GoodsAirApiVO;
import com.spring.helloworld.goods.vo.GoodsAirVO;
import com.spring.helloworld.goods.vo.GoodsStayVO;
import com.spring.helloworld.member.vo.MemberVO;
import com.spring.helloworld.order.service.OrderService;
import com.spring.helloworld.order.vo.OrderAirVO;
import com.spring.helloworld.order.vo.OrderStayVO;

@Controller("orderController")
@RequestMapping(value="/order")
public class OrderControllerImpl extends BaseController implements OrderController {
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderAirVO orderAirVO;
	@Autowired
	private OrderStayVO orderStayVO;
	@Autowired
	private CartAirVO cartAirVO;
	@Autowired
	private GoodsStayVO goodsStayVO;
	@Autowired
	private GoodsService goodsService;
	
	// getDataForEachPaymentAir 전역변수
	String flightNameGot = null;
	String airlineNameGot = null;
	String departureTimeGot = null; 
	String arrivalTimeGot = null; 
	String departureAirportGot = null; 
	String arrivalAirportGot = null; 
	String economyChargeGot = null;
	String qtyGot = null;
	
	// getDataForEachPaymentStay 전역변수
	String checkInDateGot = null;
	String checkOutDateGot = null;
	String stayDays = null;
	String stayIdEachGot = null;
	
	int roomCount = 0;

	// 숙박/항공 구분 flag
	String flagAirStay = null;
	
	@RequestMapping(value="/orderEachGoodsStay.do" ,method = RequestMethod.POST)
	public ModelAndView orderEachGoodsStay(@ModelAttribute("orderStayVO") OrderStayVO _orderVO,
									@ModelAttribute("goods_stay_id") String goods_stay_id,
			                        HttpServletRequest request, HttpServletResponse response)  throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		session=request.getSession();
		String viewName=(String)request.getAttribute("viewName");
		Boolean isLogOn=(Boolean)session.getAttribute("isLogOn");
		String action=(String)session.getAttribute("action");
		
		Map goodsStayMap = goodsService.goodsStayDetail(goods_stay_id);
		stayIdEachGot = goods_stay_id;
		System.out.println("stayIdEachGot==============================================" + stayIdEachGot);
		
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("goodsStayMap", goodsStayMap);
//		GoodsVO goodsVO=(GoodsVO)goodsStayMap.get("goodsVO");
//		addGoodsInQuick(goods_id,goodsVO,session); 퀵메뉴 관련 무언가
		
		goodsStayVO = (GoodsStayVO) goodsStayMap.get("goodsStayVO");
		System.out.println("goodsStayMap 테스트 : " + goodsStayVO.getBusi_id());
		System.out.println("goodsStayMap 테스트 : " + goodsStayVO.getGoods_stay_id());
		System.out.println("goodsStayMap 테스트 : " + goodsStayVO.getGoods_stay_name());
		
		
		if(isLogOn==null || isLogOn==false){
			session.setAttribute("orderInfoStay", goodsStayMap);
			session.setAttribute("action", "/order/orderEachGoodsStay.do");
			return new ModelAndView("redirect:/member/loginForm.do");
		}else{
			 if(action!=null && action.equals("/order/orderEachGoodsStay.do")){
				 goodsStayVO=(GoodsStayVO)session.getAttribute("orderInfoStay");
				session.removeAttribute("action");
			 }else {
				 GoodsStayVO a = (GoodsStayVO) goodsStayMap.get("goodsStayVO");
				 goodsStayVO= a;
				 orderStayVO = _orderVO;
			 }
		 }
		MemberVO memberInfo=(MemberVO)session.getAttribute("memberInfo");
		List myOrderListStay=new ArrayList<OrderStayVO>();
		myOrderListStay.add(orderStayVO);
		
		session.setAttribute("myOrderListStay", myOrderListStay);
		session.setAttribute("orderer", memberInfo);

		System.out.println("goods_stay_id  : " + goods_stay_id);
		System.out.println("checkInDate : " + checkInDateGot);
		System.out.println("checkOutDate : " + checkOutDateGot);
		
		flagAirStay = "stay";
		mav.addObject("flagAirStay", flagAirStay);
		mav.addObject("checkInDate", checkInDateGot);
		mav.addObject("checkOutDate", checkOutDateGot);
		mav.addObject("stayDays", stayDays);
		mav.addObject("goodsStayMap", goodsStayMap);
		
		mav.addObject("roomCount", roomCount);
		
		return mav;
	}
	
	@RequestMapping(value="/orderEachGoodsAir.do" ,method = RequestMethod.POST)
	public ModelAndView orderEachGoodsAir(@ModelAttribute("orderAirVO") OrderAirVO _orderVO,
			                       HttpServletRequest request, HttpServletResponse response)  throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		session=request.getSession();
		
		Boolean isLogOn=(Boolean)session.getAttribute("isLogOn");
		String action=(String)session.getAttribute("action");
		//로그인 여부 체크
		//이전에 로그인 상태인 경우는 주문과정 진행
		//로그아웃 상태인 경우 로그인 화면으로 이동
		if(isLogOn==null || isLogOn==false){
			session.setAttribute("orderInfoAir", _orderVO);
			session.setAttribute("action", "/order/orderEachGoodsAir.do");
			return new ModelAndView("redirect:/member/loginForm.do");
		} else{
			 if(action!=null && action.equals("/order/orderEachGoodsAir.do")){
				 orderAirVO=(OrderAirVO)session.getAttribute("orderInfoAir");
				session.removeAttribute("action");
			 } else {
				 orderAirVO=_orderVO;
			 }
		 }
		
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		List myOrderList=new ArrayList<OrderAirVO>();
		myOrderList.add(orderAirVO);

		System.out.println("myOrderList확인하기");
		OrderAirVO getData = (OrderAirVO)myOrderList.get(0);
		getData.setAir_order_vihicleId(flightNameGot);
		getData.setAir_order_airlineNm(airlineNameGot);
		getData.setAir_order_depPlandTime(departureTimeGot);
		getData.setAir_order_arrPlandTime(arrivalTimeGot);
		getData.setAir_order_depAirportNm(departureAirportGot);
		getData.setAir_order_arrAirportNm(arrivalAirportGot);
		if (Double.isNaN(Double.parseDouble(qtyGot))) {
		    qtyGot = "1";
		}
		getData.setAir_order_qty_people(Integer.parseInt(qtyGot));
		
		System.out.println(getData.getAir_order_vihicleId());
		System.out.println(getData.getAir_order_airlineNm());
		System.out.println(getData.getAir_order_depPlandTime());
		System.out.println(getData.getAir_order_arrPlandTime());
		System.out.println(getData.getAir_order_depAirportNm());
		System.out.println(getData.getAir_order_arrAirportNm());
		System.out.println(getData.getAir_order_qty_people());
		
		MemberVO memberInfo=(MemberVO)session.getAttribute("memberInfo");
		
		session.setAttribute("myOrderList", myOrderList);
		session.setAttribute("orderer", memberInfo);
		
		Map<String, Object> airEachDataMap = new HashMap<String, Object>();
		airEachDataMap.put("flightName", flightNameGot);
		airEachDataMap.put("airlineName", airlineNameGot);
		airEachDataMap.put("departureTime", departureTimeGot);
		airEachDataMap.put("arrivalTime", arrivalTimeGot);
		airEachDataMap.put("departureAirport", departureAirportGot);
		airEachDataMap.put("arrivalAirport", arrivalAirportGot);
		String[] charge = splitCharge(economyChargeGot);
		if(charge[1] == "0") {
			airEachDataMap.put("economyCharge", charge[0]);
			airEachDataMap.put("prestigeCharge", charge[1]);
			System.out.println("charge[1] == \"-\" 해당없음이라는 말!");
		} else {
			airEachDataMap.put("economyCharge", charge[0]);
			airEachDataMap.put("prestigeCharge", charge[1]);
		} 
		airEachDataMap.put("qty", qtyGot);
		
		flagAirStay = "air";
		mav.addObject("flagAirStay", flagAirStay);
		mav.addObject("airEachDataMap", airEachDataMap);
		
		return mav;
	}
	
	@RequestMapping(value="/orderGoodsAir.do" ,method = RequestMethod.POST)
	public ModelAndView orderGoodsAir(@ModelAttribute("orderAirVO") OrderAirVO _orderVO,
			                      HttpServletRequest request, HttpServletResponse response)  throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		session=request.getSession();
		
		Boolean isLogOn=(Boolean)session.getAttribute("isLogOn");
		String action=(String)session.getAttribute("action");
		//로그인 여부 체크
		//이전에 로그인 상태인 경우는 주문과정 진행
		//로그아웃 상태인 경우 로그인 화면으로 이동
		if(isLogOn==null || isLogOn==false){
			session.setAttribute("orderInfoAir", _orderVO);
			session.setAttribute("action", "/order/orderGoodsAir.do");
			return new ModelAndView("redirect:/member/loginForm.do");
		} else{
			 if(action!=null && action.equals("/order/orderGoodsAir.do")){
				 orderAirVO=(OrderAirVO)session.getAttribute("orderInfoAir");
				session.removeAttribute("action");
			 } else {
				 orderAirVO=_orderVO;
			 }
		 }
		
		Map orderAirRnMMap = new HashMap();
		Enumeration enu=request.getParameterNames();
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=request.getParameter(name);
			orderAirRnMMap.put(name,value);
		}
		System.out.println("////////////////////////////////////////////////////////////////////////");
		System.out.println(orderAirRnMMap.get("price1"));
		System.out.println(orderAirRnMMap.get("price2"));
		
		String[] charge = splitCharge((String) orderAirRnMMap.get("price1"));
		if(charge[1] == "0") {
			orderAirRnMMap.put("economyCharge1", charge[0]);
			orderAirRnMMap.put("prestigeCharge1", charge[1]);
			System.out.println("charge[1] == \"-\" 해당없음이라는 말!");
		} else {
			orderAirRnMMap.put("economyCharge1", charge[0]);
			orderAirRnMMap.put("prestigeCharge1", charge[1]);
		} 
		String[] charge2 = splitCharge((String) orderAirRnMMap.get("price2"));
		if(charge2[1] == "0") {
			orderAirRnMMap.put("economyCharge2", charge2[0]);
			orderAirRnMMap.put("prestigeCharge2", charge2[1]);
			System.out.println("charge2[1] == \"-\" 해당없음이라는 말!");
		} else {
			orderAirRnMMap.put("economyCharge2", charge2[0]);
			orderAirRnMMap.put("prestigeCharge2", charge2[1]);
		} 
		
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		MemberVO memberInfo=(MemberVO)session.getAttribute("memberInfo");
		
		session.setAttribute("orderer", memberInfo);
		
		flagAirStay = "airRnM";
		mav.addObject("flagAirStay", flagAirStay);
		mav.addObject("orderAirRnMMap", orderAirRnMMap);
		
		return mav;
	}
	
	// 항공 economyChargeGot 일반석/비즈니스석 가격 문자열 나누기
	private String[] splitCharge(String charge) {
	    String[] splitCharges = new String[2]; // 배열 초기화

	    if (charge.contains("(해당없음)")) { // (해당없음)이 포함된 경우
	        String[] tokens = charge.split("원");
	        String economyCharge = tokens[0];
	        splitCharges[0] = economyCharge;
	        splitCharges[1] = "0";
	        System.out.println("economyCharge: " + economyCharge + "\n\tprestigeCharge 없음");
	    } else { // (해당없음)이 포함되지 않은 경우
	        int index1 = charge.indexOf("원");
	        int index2 = charge.indexOf("(");
	        int index3 = charge.indexOf(")");
	        String economyCharge = charge.substring(0, index1);
	        String prestigeCharge = charge.substring(index2+1, index3-1);
	        
	        splitCharges[0] = economyCharge;
	        splitCharges[1] = prestigeCharge;
	        System.out.println("economyCharge: " + splitCharges[0]);
	        System.out.println("prestigeCharge: " + splitCharges[1]);
	    }
	    return splitCharges;
	}
	
	@RequestMapping(value="/getDataForEachPaymentAir.do" ,method={RequestMethod.POST})
	public void getDepAirportId(/* @RequestParam("rowData") String[] rowData, */
								@RequestParam("flightName") String flightName,
								@RequestParam("airlineName") String airlineName,
								@RequestParam("departureTime") String departureTime,
								@RequestParam("arrivalTime") String arrivalTime,
								@RequestParam("departureAirport") String departureAirport,
								@RequestParam("arrivalAirport") String arrivalAirport,
								@RequestParam("economyCharge") String economyCharge,
								@RequestParam("qty") String qty, 
								HttpServletRequest request, HttpServletResponse response)  throws Exception {
		try {
			System.out.println("******************getDataForEachPaymentAir Data********************");
			System.out.println("flightName : " 		+ flightName);
			System.out.println("airlineName : " 	+ airlineName);
			System.out.println("departureTime : " 	+ departureTime);
			System.out.println("arrivalTime : " 	+ arrivalTime);
			System.out.println("departureAirport : " + departureAirport);
			System.out.println("arrivalAirport : " 	+ arrivalAirport);
			System.out.println("economyCharge : " 	+ economyCharge);
			System.out.println("qty : " 			+ qty);

			flightNameGot = flightName;
			airlineNameGot = airlineName;
			departureTimeGot = departureTime;
			arrivalTimeGot = arrivalTime;
			departureAirportGot = departureAirport;
			arrivalAirportGot = arrivalAirport;
			economyChargeGot = economyCharge;
			qtyGot = qty;
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/getDataForEachPaymentStay.do" ,method={RequestMethod.POST})
	public void getDateforOrder(@RequestParam("startD") String checkInDate,
								@RequestParam("endD") String checkOutDate,
								@RequestParam("room_count") int room_count,
								HttpServletRequest request, HttpServletResponse response)  throws Exception {
		try {
			System.out.println("******************getDataForEachPaymentStay Data********************");

			// LocalDate로 변환
			LocalDate checkInDateL = LocalDate.parse(checkInDate, DateTimeFormatter.ISO_LOCAL_DATE);
			LocalDate checkOutDateL = LocalDate.parse(checkOutDate, DateTimeFormatter.ISO_LOCAL_DATE);
			long diff = ChronoUnit.DAYS.between(checkInDateL, checkOutDateL);
			
			// JSP에서 사용할 수 있는 형식으로 변환
			checkInDateGot = checkInDateL.format(DateTimeFormatter.ofPattern("yyyy년MM월dd일"));
			checkOutDateGot = checkOutDateL.format(DateTimeFormatter.ofPattern("yyyy년MM월dd일"));
			roomCount = room_count;
			
			stayDays = Long.toString(diff);
					
			System.out.println("checkInDate : " 	+ checkInDate + "-> " + checkInDateGot);
			System.out.println("checkOutDate : " 	+ checkOutDate + "-> " + checkOutDateGot);
			System.out.println("총 : " 	+ stayDays + "일 선택");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/getDataForEachPaymentStayCart.do" ,method={RequestMethod.POST})
	public void getDateforOrderCart(@RequestParam("startD") String checkInDate,
								@RequestParam("endD") String checkOutDate,
								@RequestParam("room_count") int room_count,
								HttpServletRequest request, HttpServletResponse response)  throws Exception {
		try {
			System.out.println("******************getDataForEachPaymentStay Data********************");

			// LocalDate로 변환
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년MM월dd일");
			LocalDate checkInDateL = LocalDate.parse(checkInDate, formatter);
			LocalDate checkOutDateL = LocalDate.parse(checkOutDate, formatter);
			long diff = ChronoUnit.DAYS.between(checkInDateL, checkOutDateL);
			
			// JSP에서 사용할 수 있는 형식으로 변환
			checkInDateGot = checkInDateL.format(DateTimeFormatter.ofPattern("yyyy년MM월dd일"));
			checkOutDateGot = checkOutDateL.format(DateTimeFormatter.ofPattern("yyyy년MM월dd일"));
			roomCount = room_count;
			stayDays = Long.toString(diff);
					
			System.out.println("checkInDate : " 	+ checkInDate + "-> " + checkInDateGot);
			System.out.println("checkOutDate : " 	+ checkOutDate + "-> " + checkOutDateGot);
			System.out.println("총 : " 	+ stayDays + "일 선택");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/payToOrderGoodsAir.do" ,method = RequestMethod.POST)
	public ModelAndView payToOrderGoodsAir(@RequestParam Map<String, String> orderAirMap,
			                       HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session=request.getSession();
		MemberVO memberVO=(MemberVO)session.getAttribute("orderer");
		String member_id=memberVO.getMem_id();
		String member_name=memberVO.getMem_name();
		String orderer_name=memberVO.getMem_name();
		String orderer_hp = memberVO.getMem_tel1()+"-"+memberVO.getMem_tel2()+"-"+memberVO.getMem_tel3();
		List<OrderAirVO> myOrderList=(List<OrderAirVO>)session.getAttribute("myOrderList");
		
		System.out.println("myOrderList.size();" + myOrderList.size());
		
		for(int i=0; i<myOrderList.size();i++){
			OrderAirVO orderVO=(OrderAirVO)myOrderList.get(i);
			orderVO.setMem_id(member_id);
			
			orderVO.setAir_order_Charge(Integer.parseInt(orderAirMap.get("air_order_ChargeSS")));
			orderVO.setAir_order_pay_method(orderAirMap.get("pay_method"));
			orderVO.setAir_order_card_name(orderAirMap.get("card_com_name"));
			orderVO.setAir_order_pay_month(orderAirMap.get("card_pay_month"));
			myOrderList.set(i, orderVO); //각 orderVO에 주문자 정보를 세팅한 후 다시 myOrderList에 저장한다.
		}//end for
		
	    orderService.addNewOrderAir(myOrderList);
	    flagAirStay = "air";
		mav.addObject("flagAirStay", flagAirStay);
		mav.addObject("myOrderInfo",orderAirMap);//OrderVO로 주문결과 페이지에  주문자 정보를 표시한다.
		mav.addObject("myOrderList", myOrderList);
		return mav;
	}
	
	@RequestMapping(value="/payToOrderGoodsAirRnM.do" ,method = RequestMethod.POST)
	public ModelAndView payToOrderGoodsAirRnM(@RequestParam Map<String, String> orderAirMap,
			                       HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session=request.getSession();
		MemberVO memberVO=(MemberVO)session.getAttribute("orderer");
		String member_id=memberVO.getMem_id();
		String member_name=memberVO.getMem_name();
		String orderer_name=memberVO.getMem_name();
		String orderer_hp = memberVO.getMem_tel1()+"-"+memberVO.getMem_tel2()+"-"+memberVO.getMem_tel3();
		List<OrderAirVO> myOrderList= new ArrayList<OrderAirVO>();//(List<OrderAirVO>)session.getAttribute("myOrderList");
		myOrderList.add(0, orderAirVO);
		myOrderList.add(1, orderAirVO);
		
			OrderAirVO orderVO = new OrderAirVO();
			orderVO.setMem_id(member_id);
			
			orderVO.setAir_order_vihicleId(orderAirMap.get("p_flightName"));
			orderVO.setAir_order_airlineNm(orderAirMap.get("p_airlineName"));
			orderVO.setAir_order_depAirportNm(orderAirMap.get("p_departureAirport"));
			orderVO.setAir_order_depPlandTime(orderAirMap.get("p_departureTime"));
			orderVO.setAir_order_arrAirportNm(orderAirMap.get("p_arrivalAirport"));
			orderVO.setAir_order_arrPlandTime(orderAirMap.get("p_arrivalTime"));
			
			orderVO.setAir_order_Charge(Integer.parseInt(orderAirMap.get("air_order_ChargeSS")));
			orderVO.setAir_order_pay_method(orderAirMap.get("pay_method"));
			orderVO.setAir_order_card_name(orderAirMap.get("card_com_name"));
			orderVO.setAir_order_pay_month(orderAirMap.get("card_pay_month"));
			orderVO.setAir_order_qty_people(Integer.parseInt(orderAirMap.get("qtyqty")));
			
			myOrderList.set(0, orderVO); //각 orderVO에 주문자 정보를 세팅한 후 다시 myOrderList에 저장한다.

			OrderAirVO orderVO2 = new OrderAirVO();
			orderVO2.setMem_id(member_id);
			
			orderVO2.setAir_order_vihicleId(orderAirMap.get("p_flightName2"));
			orderVO2.setAir_order_airlineNm(orderAirMap.get("p_airlineName2"));
			orderVO2.setAir_order_depAirportNm(orderAirMap.get("p_departureAirport2"));
			orderVO2.setAir_order_depPlandTime(orderAirMap.get("p_departureTime2"));
			orderVO2.setAir_order_arrAirportNm(orderAirMap.get("p_arrivalAirport2"));
			orderVO2.setAir_order_arrPlandTime(orderAirMap.get("p_arrivalTime2"));
			
			orderVO2.setAir_order_Charge(Integer.parseInt(orderAirMap.get("air_order_ChargeSS")));
			orderVO2.setAir_order_pay_method(orderAirMap.get("pay_method"));
			orderVO2.setAir_order_card_name(orderAirMap.get("card_com_name"));
			orderVO2.setAir_order_pay_month(orderAirMap.get("card_pay_month"));
			orderVO2.setAir_order_qty_people(Integer.parseInt(orderAirMap.get("qtyqty")));
			
			myOrderList.set(1, orderVO2); //각 orderVO에 주문자 정보를 세팅한 후 다시 myOrderList에 저장한다.
		
	    orderService.addNewOrderAir(myOrderList);
	    flagAirStay = "air";
		mav.addObject("flagAirStay", flagAirStay);
		mav.addObject("myOrderInfo",orderAirMap);//OrderVO로 주문결과 페이지에  주문자 정보를 표시한다.
		mav.addObject("myOrderList", myOrderList);
		return mav;
	}
	
	@RequestMapping(value="/payToOrderGoodsStay.do" ,method = RequestMethod.POST)
	public ModelAndView payToOrderGoodsStay(@RequestParam Map<String, String> orderStayMap,
			                       HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session=request.getSession();
		MemberVO memberVO=(MemberVO)session.getAttribute("orderer");
		String member_id=memberVO.getMem_id();
		String member_name=memberVO.getMem_name();
		String orderer_name=memberVO.getMem_name();
		String orderer_hp = memberVO.getMem_tel1()+"-"+memberVO.getMem_tel2()+"-"+memberVO.getMem_tel3();
		List<OrderStayVO> myOrderList=(List<OrderStayVO>)session.getAttribute("myOrderListStay");
		
		System.out.println("myOrderList.size();" + myOrderList.size());
		
		Map goodsStayMap = goodsService.goodsStayDetail(stayIdEachGot);
		goodsStayVO = (GoodsStayVO) goodsStayMap.get("goodsStayVO");
		
		for(int i=0; i<myOrderList.size();i++){
			OrderStayVO orderVO=(OrderStayVO)myOrderList.get(i);
			orderVO.setMem_id(member_id);
			
			orderVO.setStay_price(orderStayMap.get("stay_order_ChargeSS"));
			orderVO.setStay_order_pay_method(orderStayMap.get("pay_method"));
			orderVO.setStay_order_card_name(orderStayMap.get("card_com_name"));
			orderVO.setStay_order_pay_month(orderStayMap.get("card_pay_month"));
			
			orderVO.setStay_name(goodsStayVO.getGoods_stay_name());
			orderVO.setBusi_id(goodsStayVO.getBusi_id());
			orderVO.setStay_sort(goodsStayVO.getGoods_stay_sort());
			orderVO.setStay_address(goodsStayVO.getGoods_stay_roadAddress());
			orderVO.setStay_admissionDate(checkInDateGot);
			orderVO.setStay_departureDate(checkOutDateGot);
			orderVO.setStay_num_people(Integer.toString(goodsStayVO.getGoods_stay_num_people()));
			
			orderVO.setStay_order_qty_people(roomCount);
			
			myOrderList.set(i, orderVO); //각 orderVO에 주문자 정보를 세팅한 후 다시 myOrderList에 저장한다.
		}//end for
		
	    orderService.addNewOrderStay(myOrderList);
	    flagAirStay = "stay";
		mav.addObject("flagAirStay", flagAirStay);
		mav.addObject("myOrderInfo",orderStayMap);//OrderVO로 주문결과 페이지에  주문자 정보를 표시한다.
		mav.addObject("myOrderList", myOrderList);
		return mav;
	}
	
	//회원의 예약 확인(결제확인)
		@RequestMapping(value="/myOrderHistory.do")
		public ModelAndView myOrderHistory(HttpServletRequest request, HttpServletResponse response)  throws Exception {
			//로그인할 때 session에 저장한 회원의 정보값/로그인상태 가져오기
			request.setCharacterEncoding("utf-8");
			HttpSession session = request.getSession();
			String viewName=(String)request.getAttribute("viewName");
			ModelAndView mav = new ModelAndView(viewName);
			Map totalOrder = new HashMap();
			
			MemberVO memberVO =	(MemberVO) session.getAttribute("memberInfo");
			try {
				Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
				System.out.println(isLogOn);
				if(isLogOn == false || isLogOn == null) {
					mav.addObject("isLogOn", isLogOn);
				} else {
					String mem_id = memberVO.getMem_id();
					//로그인 상태면 true
					totalOrder = orderService.myOrderHistoryList(mem_id);
					
					mav.addObject("totalOrder", totalOrder);
					mav.addObject("isLogOn", isLogOn);
					/* mav.addObject(viewName, mem_id); 테스트용*/
				}
			} catch (Exception e) {
				System.out.println("오류!오류!오류!");
				mav.addObject("isLogOn", "null");
				// TODO: handle exception
			}
			
			return mav;
		}
		
		
		//0417 변재선 - 결제 취소 하기 종합
		@RequestMapping(value="/modifyOrderState.do")
		public ModelAndView modifyOrderState(@RequestParam("stay_seq_num")int stay_seq_num, @RequestParam("air_seq_num")int air_seq_num,
				HttpServletRequest request, HttpServletResponse response)  throws Exception {
			request.setCharacterEncoding("utf-8");
			HttpSession session = request.getSession();
			ModelAndView mav = new ModelAndView();
			
			MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
			
			try {					
				String mem_id = memberVO.getMem_id();				
				// stay air 구분하기 아닌쪽은 0을 집어넣었음
				if(stay_seq_num != 0) {
					orderStayVO.setMem_id(mem_id);
					orderStayVO.setStay_seq_num(stay_seq_num);
					orderStayVO.setStay_order_state("취소처리중");
					orderService.modOrderStayState(orderStayVO);
				} else {
					orderAirVO.setMem_id(mem_id);
					orderAirVO.setAir_seq_num(air_seq_num);
					orderAirVO.setAir_order_state("취소처리중");
					orderService.modOrderAirState(orderAirVO);
				}
			} catch (Exception e) {
					// TODO: handle exception
			}
			
			mav.setViewName("redirect:/order/myOrderHistory.do");
			return mav;
		}
		
		
		@RequestMapping(value="/busiOrderList.do")
		public ModelAndView busiOrderList(HttpServletRequest request, HttpServletResponse response)  throws Exception {
			request.setCharacterEncoding("utf-8");
			HttpSession session = request.getSession();

			String viewName=(String)request.getAttribute("viewName");
			ModelAndView mav = new ModelAndView(viewName);
			
			BusinessVO businessVO = (BusinessVO) session.getAttribute("businessInfo");
			
			try {
				Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
				System.out.println(isLogOn);
				//isLogOn이 null이면 true false가 안먹어서 catch로 감 ㅎㅎ
				if(isLogOn == false || isLogOn == null) {
					mav.addObject("isLogOn", isLogOn);
				} else {
					String busi_id = businessVO.getBusi_id();
					
					List<OrderStayVO> busiOrderList = orderService.selectbusiOrderList(busi_id);
					
					mav.addObject("busiOrderList", busiOrderList);
					//로그인 상태면 true
					
					mav.addObject("isLogOn", isLogOn);
				}
			} catch (Exception e) {
				System.out.println("오류!오류!오류!");
				mav.addObject("isLogOn", "null");
				// TODO: handle exception
			}
			
			return mav;
		}
		
		@RequestMapping(value="/busiPermitStayState.do")
		public ModelAndView busiPermitStayState(@RequestParam("stay_seq_num")int stay_seq_num,
				HttpServletRequest request, HttpServletResponse response)  throws Exception {
			request.setCharacterEncoding("utf-8");
			HttpSession session = request.getSession();
			ModelAndView mav = new ModelAndView();
			
			BusinessVO businessVO = (BusinessVO) session.getAttribute("businessInfo");
			Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
			
			try {					
				String busi_id = businessVO.getBusi_id();
				if(busi_id != null && isLogOn == true) {
					orderStayVO.setStay_seq_num(stay_seq_num);
					orderStayVO.setStay_order_state("취소승인완료");
					orderService.permitStayState(orderStayVO);
				}
			} catch (Exception e) {
					// TODO: handle exception
			}
			
			mav.setViewName("redirect:/order/busiOrderList.do");
			return mav;
		}
}