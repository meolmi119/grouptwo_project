package com.spring.helloworld.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.helloworld.business.service.BusinessService;
import com.spring.helloworld.business.vo.BusinessVO;
import com.spring.helloworld.goods.service.GoodsService;
import com.spring.helloworld.member.service.MemberService;
import com.spring.helloworld.member.vo.MemberVO;
import com.spring.helloworld.mypage.service.MyPageService;
import com.spring.helloworld.order.service.OrderService;
import com.spring.helloworld.order.vo.OrderAirVO;
import com.spring.helloworld.order.vo.OrderStayVO;

@Controller("adminController")
public class AdminControllerImpl implements AdminController{
	private static final Logger logger = LoggerFactory.getLogger(AdminControllerImpl.class);
	@Autowired
	private MyPageService myPageService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MemberVO memberVO;
	
	@Autowired
	private BusinessVO businessVO;
	
	@Autowired
	private BusinessService businessService;
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderAirVO orderAirVO;
	@Autowired
	private OrderStayVO orderStayVO;
	//관리자 Form.do
	@RequestMapping(value = "/admin/*Form.do", method=RequestMethod.GET)
	private ModelAndView adminform(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		return mav;
	}
	//memberInfo, businessInfo 둘 다 지우기 위해 추가
	//로그아웃
	@Override
	@RequestMapping(value="/admin/logout.do" ,method = RequestMethod.GET)
	public ModelAndView logoutAdmin(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		session.setAttribute("isLogOn", false);
		session.removeAttribute("memberInfo");
		session.removeAttribute("businessInfo");
		mav.setViewName("redirect:/main.do");
		return mav;
		}
	
	//관리자 회원조회(전체)
	@Override
	@RequestMapping(value = "/admin/listMember.do", method =RequestMethod.GET)
	public ModelAndView listMember(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String)request.getAttribute("viewName");
		List MemList = memberService.listMember();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("MemList",MemList);
		return mav;
	}
		
	//관리자 사업자조회(전체)
	@Override
	@RequestMapping(value = "/admin/listBusiness.do", method =RequestMethod.GET)
	public ModelAndView listBusiness(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String)request.getAttribute("viewName");
		List busiList = businessService.listBusiness();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("BusiList",busiList);
		return mav;
	}
	
	//관리자 회원탈퇴
	@Override
	@RequestMapping(value="/admin/unregister.do" ,method = RequestMethod.POST)
	public void unregisterAdmin(@RequestParam("mem_id") String mem_id,
        HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		
		memberService.unregister(mem_id);
		
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('회원 탈퇴가 완료되었습니다.');");
		out.println("location.href='" + request.getContextPath() + "/admin/listMember.do';");
		out.println("</script>");
		out.flush();
		
	}
	
	//관리자 사업자탈퇴
		@RequestMapping(value="/admin/unregisterBusi.do" ,method = RequestMethod.POST)
		public void unregisterBusinessAdmin(@RequestParam("busi_id") String busi_id,
	        HttpServletRequest request, HttpServletResponse response) throws Exception {
			response.setContentType("text/html; charset=UTF-8");
			request.setCharacterEncoding("utf-8");
			HttpSession session=request.getSession();
			
			businessService.unregister(busi_id);
			
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원 탈퇴가 완료되었습니다.');");
			out.println("location.href='" + request.getContextPath() + "/admin/listBusiness.do';");
			out.println("</script>");
			out.flush();
			
		}
	//관리자 회원수정 페이지 이동
	@Override
	@RequestMapping(value="/admin/memberEditAdmin.do" ,method = RequestMethod.POST)
	public ModelAndView adminEdit(@RequestParam("mem_id") String mem_id, HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		MemberVO vo = memberService.selectMemberID(mem_id);
		HttpSession session = request.getSession();
		session = request.getSession();
		session.setAttribute("memberInfoAd", vo);
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	//관리자 사업자수정 페이지 이동
		@RequestMapping(value="/admin/businessEditAdmin.do" ,method = RequestMethod.POST)
		public ModelAndView adminBusiEdit(@RequestParam("busi_id") String busi_id, HttpServletRequest request, HttpServletResponse response)  throws Exception {
			String viewName=(String)request.getAttribute("viewName");
			BusinessVO vo = businessService.selectMemberID(busi_id);
			HttpSession session = request.getSession();
			session = request.getSession();
			session.setAttribute("BusinessInfoAd", vo);
			ModelAndView mav = new ModelAndView(viewName);
			return mav;
		}
	//관리자 회원수정
	@Override
	@RequestMapping(value="/mypage/modifyMyInfoAdmin.do" ,method = RequestMethod.POST)
	public ResponseEntity modifyMyInfoAdmin(@RequestParam("attribute")  String attribute,
		@RequestParam("value")  String value, HttpServletRequest request, HttpServletResponse response)  throws Exception {
		Map<String,String> memberMap=new HashMap<String,String>();
		String val[]=null;
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfoAd");
		//값을 수정
		String mem_id=memberVO.getMem_id();
		if(attribute.equals("mem_tel")){
			val=value.split(",");
			memberMap.put("mem_tel1",val[0]);
			memberMap.put("mem_tel2",val[1]);
			memberMap.put("mem_tel3",val[2]);
		}else if(attribute.equals("mem_email")){
			val=value.split(",");
			memberMap.put("mem_email1",val[0]);
			memberMap.put("mem_email2",val[1]);
		}else if(attribute.equals("mem_address")){
			val=value.split(",");
			memberMap.put("mem_zipcode",val[0]);
			memberMap.put("mem_roadAddress",val[1]);
			memberMap.put("mem_jibunAddress", val[2]);
			memberMap.put("mem_namujiAddress", val[3]);
		}else {
			memberMap.put(attribute,value);	
		}
		
		memberMap.put("mem_id", mem_id);
		
		//수정된 회원 정보를 다시 세션에 저장한다.
		memberVO=(MemberVO)myPageService.modifyMyInfo(memberMap);
		session.removeAttribute("memberInfoAd");
		session.setAttribute("memberInfoAd", memberVO);
		
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		message  = "mod_success";
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	//관리자 사업자수정
		@RequestMapping(value="/mypage/modifyBusinessInfoAdmin.do" ,method = RequestMethod.POST)
		public ResponseEntity modifyBusinessInfoAdmin(@RequestParam("attribute")  String attribute,
			@RequestParam("value")  String value, HttpServletRequest request, HttpServletResponse response)  throws Exception {
			Map<String,String> memberMap=new HashMap<String,String>();
			String val[]=null;
			HttpSession session=request.getSession();
			businessVO=(BusinessVO)session.getAttribute("BusinessInfoAd");
			//값을 수정
			String busi_id=businessVO.getBusi_id();
			if(attribute.equals("busi_tel")){
				val=value.split(",");
				memberMap.put("busi_tel1",val[0]);
				memberMap.put("busi_tel2",val[1]);
				memberMap.put("busi_tel3",val[2]);
			}else if(attribute.equals("busi_hp")){
				val=value.split(",");
				memberMap.put("busi_hp1",val[0]);
				memberMap.put("busi_hp2",val[1]);
				memberMap.put("busi_hp3",val[2]);
			}
			else if(attribute.equals("busi_email")){
				val=value.split(",");
				memberMap.put("busi_email1",val[0]);
				memberMap.put("busi_email2",val[1]);
			}else if(attribute.equals("busi_address")){
				val=value.split(",");
				memberMap.put("busi_zipcode",val[0]);
				memberMap.put("busi_roadAddress",val[1]);
				memberMap.put("busi_jibunAddress", val[2]);
				memberMap.put("busi_namujiAddress", val[3]);
			}else {
				memberMap.put(attribute,value);	
			}
			
			memberMap.put("busi_id", busi_id);
			
			//수정된 회원 정보를 다시 세션에 저장한다.
			businessVO=(BusinessVO)myPageService.modifyMyBusiInfo(memberMap);
			session.removeAttribute("BusinessInfoAd");
			session.setAttribute("BusinessInfoAd", businessVO);
			
			String message = null;
			ResponseEntity resEntity = null;
			HttpHeaders responseHeaders = new HttpHeaders();
			message  = "mod_success";
			resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
			return resEntity;
		}
		
	//이벤트 상품 검색(관리자)
	@RequestMapping(value = "/admin/eventListAll.do", method =RequestMethod.GET)
	public ModelAndView listStayAll(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String)request.getAttribute("viewName");
		List stayList = goodsService.listStay();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("stayList",stayList);
		return mav;
	}
	
	@RequestMapping(value="/admin/adminOrderList.do")
	public ModelAndView adminOrderList(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();

		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		
		try {
			Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
			String adminID = memberVO.getMem_id();
			System.out.println(isLogOn);
			//isLogOn이 null이면 true false가 안먹어서 catch로 감 ㅎㅎ
			if((isLogOn == false || isLogOn == null) && adminID != "hwAdmin") {
				mav.addObject("isLogOn", isLogOn);
			} else {
				
				Map<String, List> totalOrderMap = new HashMap<String, List>();
				
				totalOrderMap = orderService.allOrder();
				
				mav.addObject("totalOrderMap", totalOrderMap);
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
	
	@RequestMapping(value="/admin/adminPermitState.do")
	public ModelAndView adminPermitState(@RequestParam("stay_seq_num")int stay_seq_num,
			@RequestParam("air_seq_num")int air_seq_num,
			HttpServletRequest request, HttpServletResponse response)  throws Exception {
		
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		ModelAndView mav = new ModelAndView();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
		
		try {					
			String adminID = memberVO.getMem_id();
			if(adminID != null && isLogOn == true && adminID != "hwAdmin") {
				if(stay_seq_num != 0) {
					
					orderStayVO.setStay_seq_num(stay_seq_num);
					orderStayVO.setStay_order_state("취소승인완료");
					orderService.permitAdminStayState(orderStayVO);
				} else {
					
					orderAirVO.setAir_seq_num(air_seq_num);
					orderAirVO.setAir_order_state("취소승인완료");
					orderService.permitAdminAirState(orderAirVO);
				}
			}
		} catch (Exception e) {
				// TODO: handle exception
		}
		
		mav.setViewName("redirect:/admin/adminOrderList.do");
		return mav;
	}
}
