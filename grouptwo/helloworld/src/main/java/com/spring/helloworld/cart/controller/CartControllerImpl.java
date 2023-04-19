package com.spring.helloworld.cart.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.Formatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.helloworld.cart.service.CartService;
import com.spring.helloworld.cart.vo.CartAirVO;
import com.spring.helloworld.cart.vo.CartStayVO;
import com.spring.helloworld.member.vo.MemberVO;
import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

@Controller("cartController")
public class CartControllerImpl implements CartController{
	@Autowired
	private CartService cartService;
	@Autowired
	private CartStayVO cartStayVO;
	@Autowired
	private CartAirVO cartAirVO;
	@Autowired
	private MemberVO memberVO;
	
	@RequestMapping(value="/myCartList.do" ,method = RequestMethod.GET)
	public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		String mem_id = memberVO.getMem_id();
		cartStayVO.setMem_id(mem_id);
		cartAirVO.setMem_id(mem_id);
		
		Map<String ,List> cartStayMap=cartService.myStayCartList(cartStayVO);
		
		SimpleDateFormat newFormat = new SimpleDateFormat("yyyy년MM월dd일");
		SimpleDateFormat calcFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		
		if(cartStayMap != null) {
		List<CartStayVO> myStayCartList = cartStayMap.get("myStayCartList");
		
		System.out.println("이것은 맵에서 꺼내온 카트리스트"+myStayCartList);
		
		for(CartStayVO testList : myStayCartList) {
			
			System.out.println("이것은 리스트를 확장으로 돌린값"+testList);
			System.out.println(testList.getStartD());
			
			Date _startD = testList.getStartD();
			Date _endD = testList.getEndD();
			
			try {
	            String startD = newFormat.format(_startD);
	            String endD = newFormat.format(_endD);
	            
	            String _calcDate1 = calcFormat.format(_startD);
	            String _calcDate2 = calcFormat.format(_endD);
	            
	            long diff = calcFormat.parse(_calcDate2).getTime() - calcFormat.parse(_calcDate1).getTime(); // 시간 차이 계산
	            long diffDays = diff / (24 * 60 * 60 * 1000); // 일 단위로 변환
	            System.out.println(diffDays);
	            
	            System.out.println("startD : "+startD + "endD :" + endD);
	            String startDate = null;
	            String endDate = null;
	            startDate = startD;
	            endDate = endD;
	            mav.addObject("startDate", startDate);
	            mav.addObject("endDate", endDate);
	            mav.addObject("diffDays", diffDays);
//	            testList.setStartD(_startD);
//	            testList.setStartD(_startD);
	        } catch (ParseException e) {
	            e.printStackTrace();
	        }
		}
		
		}
		
		Map<String ,List> cartAirMap=cartService.myAirCartList(cartAirVO);
		
		
		session.setAttribute("cartStayMap", cartStayMap); //
		session.setAttribute("cartAirMap", cartAirMap);
		mav.addObject("cartStayMap", cartStayMap);
		mav.addObject("cartAirMap", cartAirMap);
		System.out.println(cartStayMap);
		
		return mav;
	}
	
	@RequestMapping(value="/addGoodsStayInCart.do" ,method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public  @ResponseBody String addGoodsStayInCart(@RequestParam("goods_stay_id") int goods_stay_id, @RequestParam("goods_stay_room_number") int cart_stay_room_number,
								@RequestParam("startD") String _startD, @RequestParam("endD") String _endD,
			                    HttpServletRequest request, HttpServletResponse response)  throws Exception{
		HttpSession session=request.getSession();
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date startD = formatter.parse(_startD);
		Date endD = formatter.parse(_endD);
		
		cartStayVO.setCart_stay_room_number(cart_stay_room_number);
		cartStayVO.setStartD(startD);
		cartStayVO.setEndD(endD);
		cartStayVO.setGoods_stay_id(goods_stay_id);
		
		try {
			memberVO = (MemberVO)session.getAttribute("memberInfo");
			String mem_id = memberVO.getMem_id();
			cartStayVO.setMem_id(mem_id);
			//
			boolean isAreadyExisted = cartService.findCartGoodsStay(cartStayVO);
			
			System.out.println("isAreadyExisted:"+isAreadyExisted);
			System.out.println("방개수 : "
					+ cartStayVO.getCart_stay_room_number()
					+"아이디 : "
					+ cartStayVO.getMem_id());
			if(isAreadyExisted==true){
				return "already_existed";
			}else{
				cartService.addGoodsStayInCart(cartStayVO);
				return "add_success";
			}
		} catch (Exception e) {
			return "null_mem_id";
			// TODO: handle exception
		}	
	}
	
	@RequestMapping(value="/addGoodsAirInCart.do" ,method={RequestMethod.POST})
	public ResponseEntity addNewGoodsStay(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)  throws Exception {
		
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		Map cartGoodsAirMap = new HashMap();
		Enumeration enu=multipartRequest.getParameterNames();
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			cartGoodsAirMap.put(name,value);
		}
		
		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		String reg_id = memberVO.getMem_id();
		
		cartGoodsAirMap.put("mem_id",reg_id);
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			
			cartService.addGoodsAirInCart(cartGoodsAirMap);
			
			message= "<script>";
			message += " alert('리스트로 이동.');";
			message +=" location.href='"+multipartRequest.getContextPath()+"/myCartList.do';";
			message +=("</script>");
		} catch(Exception e) {
			
			message= "<script>";
			message += " alert('오류가 발생되었습니다. 관리자에게 문의해주세요');";
			message +=" location.href='"+multipartRequest.getContextPath()+"/main.do';";
			message +=("</script>");
			e.printStackTrace();
		}
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	
	// 숙박 장바구니 삭제하기
	@RequestMapping(value="/removeCartGoods.do" ,method = RequestMethod.POST)
	public ModelAndView removeCartGoods(@RequestParam("cart_stay_id") int cart_stay_id,
			                          HttpServletRequest request, HttpServletResponse response)  throws Exception{
		ModelAndView mav=new ModelAndView();
		cartService.removeCartGoods(cart_stay_id);
		
		mav.setViewName("redirect:/myCartList.do");
		return mav;
	}
	// 항공 장바구니 삭제하기
	@RequestMapping(value="/removeCartGoodsAir.do" ,method = RequestMethod.POST)
	public ModelAndView removeCartGoodsAir(@RequestParam("cart_air_id") int cart_air_id,
			                          HttpServletRequest request, HttpServletResponse response)  throws Exception{
		ModelAndView mav=new ModelAndView();
		cartService.removeCartGoodsAir(cart_air_id);
		
		mav.setViewName("redirect:/myCartList.do");
		return mav;
	}
}
