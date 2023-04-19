package com.spring.helloworld.business.controller;

import java.io.PrintWriter;
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

import com.spring.helloworld.business.service.BusinessService;
import com.spring.helloworld.business.vo.BusinessVO;
import com.spring.helloworld.goods.service.GoodsService;

@Controller("businessController")
public class BusinessControllerImpl implements BusinessController{
	private static final Logger logger = LoggerFactory.getLogger(BusinessController.class);
	@Autowired
	private BusinessService businessService;
	@Autowired
	private BusinessVO businessVO;
	@Autowired
	private GoodsService goodsService;
	//form.do 페이지 이동
	@RequestMapping(value= "/business/*Form.do", method=RequestMethod.GET)
	private ModelAndView form(@RequestParam(value="result", required=false) String result, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName(viewName);
		return mav;
	}
	//로그인
	@Override
	@RequestMapping(value = "/business/login.do",method = RequestMethod.POST)
	public ModelAndView login(@RequestParam Map<String, String>loginMap,
			HttpServletRequest request, HttpServletResponse response)throws Exception{
		ModelAndView mav = new ModelAndView();
		businessVO = businessService.login(loginMap);
		if(businessVO!=null && businessVO.getBusi_id()!=null) {
			HttpSession session = request.getSession();
			session = request.getSession();
			session.setAttribute("isLogOn", true);
			session.setAttribute("businessInfo", businessVO);
			
			String action = (String)session.getAttribute("action");
			if(action!=null && action.equals("/order/orderEachGoods.do")) {
				mav.setViewName("forward:"+action);
			}else {
				mav.setViewName("redirect:/main.do");
			}
			
		}else {
			String message = "아이디나 비밀번호가 틀립니다. 다시 로그인해주세요";
			mav.addObject("message",message);
			mav.setViewName("/member/loginForm");
		}
		return mav;
	}

	//로그아웃
	@Override
	@RequestMapping(value="/business/logout.do" ,method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		session.setAttribute("isLogOn", false);
		session.removeAttribute("businessInfo");
		mav.setViewName("redirect:/main.do");
		return mav;
	}
	//회원가입(사업자)
	@Override
	@RequestMapping(value="/business/addMember.do" ,method = RequestMethod.POST)
	public ResponseEntity addMember(@ModelAttribute("businessVO") BusinessVO _businessVO,
			                HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
		    businessService.addMember(_businessVO);
		    message  = "<script>";
		    message +=" alert('회원 가입을 마쳤습니다.로그인창으로 이동합니다.');";
		    message += " location.href='"+request.getContextPath()+"/member/loginForm.do';";
		    message += " </script>";
		    
		}catch(Exception e) {
			message  = "<script>";
		    message +=" alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요');";
		    message += " location.href='"+request.getContextPath()+"/member/businessForm.do';";
		    message += " </script>";
			e.printStackTrace();
		}
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	//아이디 중복확인(사업자)
	@Override
	@RequestMapping(value="/business/overlapped.do" ,method = RequestMethod.POST)
	public ResponseEntity overlapped(@RequestParam("id") String id,HttpServletRequest request, HttpServletResponse response) throws Exception{
		ResponseEntity resEntity = null; 
		String result = businessService.overlapped(id);
		resEntity =new ResponseEntity(result, HttpStatus.OK);
		return resEntity;
	}
	//회원탈퇴(사업자)
	@Override
	@RequestMapping(value="/business/unregister.do" ,method = RequestMethod.POST)
	public void unregister(@RequestParam("busi_id") String busi_id,
        HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		session.setAttribute("isLogOn", false);
		session.removeAttribute("businessInfo");
	
		businessService.unregister(busi_id);
		
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("location.href='" + request.getContextPath() + "/member/unregistEndForm.do';");
		out.println("</script>");
		out.flush();
	}
	//회원 조회(아이디 찾기)
	@RequestMapping(value = "/business/selectMember.do",method = RequestMethod.POST)
	public ModelAndView selectMember(@RequestParam Map<String, String>selectMap,
	    HttpServletRequest request, HttpServletResponse response)throws Exception{
		ModelAndView mav = new ModelAndView();
		businessVO = businessService.selectMember(selectMap);
		if(businessVO!=null && businessVO.getBusi_name()!=null && businessVO.getBusi_id()!=null && businessVO.getBusi_email1()!=null && businessVO.getBusi_email2()!=null){
			HttpSession session = request.getSession();
			session = request.getSession();
			session.setAttribute("memberInfo", businessVO);
			BusinessVO memberInfo = (BusinessVO) session.getAttribute("memberInfo");
			String message = "회원님의 아이디는 "+memberInfo.getBusi_id()+" 입니다.";
			mav.addObject("message",message);
			mav.setViewName("/member/findIDForm");
			
		}else {
			String message = "회사명 또는 이메일이 일치하지 않습니다. 다시 입력해 주세요";
			mav.addObject("message",message);
			mav.setViewName("/member/findIDForm");
		}
		return mav;
	}
	
	//이벤트 상품 검색(사업자)
	@RequestMapping(value = "/business/listAll.do", method =RequestMethod.GET)
	public ModelAndView listStayAll(HttpServletRequest request, HttpServletResponse response) throws Exception{
		try {
		HttpSession session = request.getSession();
		BusinessVO businessVO = (BusinessVO) session.getAttribute("businessInfo");
		String busi_id = businessVO.getBusi_id();
		String viewName = (String)request.getAttribute("viewName");
		List stayList = goodsService.listStayBusiness(busi_id);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("stayList",stayList);
		return mav;
		} catch (Exception e) {
			ModelAndView mav = new ModelAndView("/member/loginForm");
			String message = "로그아웃 상태입니다. 로그인 해주세요";
			mav.addObject("message",message);
			return mav;
		}
		
	}
}
