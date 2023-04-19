package com.spring.helloworld.member.controller;

import org.springframework.http.MediaType;
import java.io.IOException;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.helloworld.goods.service.GoodsService;
import com.spring.helloworld.goods.vo.GoodsStayVO;
import com.spring.helloworld.member.service.MemberService;
import com.spring.helloworld.member.vo.MemberVO;

@Controller("memberController")
public class MemberControllerImpl implements MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberControllerImpl.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MemberVO memberVO;
	
	@Autowired
	private GoodsStayVO goodsStayVO;
	
	@Autowired
	private GoodsService goodsService;
	
	//메인페이지
	@RequestMapping(value= {"/main.do"}, method=RequestMethod.GET) 
	private ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		return mav;
	}
	
	//Form.do 페이지 이동
	@RequestMapping(value= "/member/*Form.do", method=RequestMethod.GET)
	private ModelAndView form(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		return mav;
	}
		
	//로그인
	@Override
	@RequestMapping(value = "/member/login.do",method = RequestMethod.POST)
	public ModelAndView login(@RequestParam Map<String, String>loginMap,
		HttpServletRequest request, HttpServletResponse response)throws Exception{
		ModelAndView mav = new ModelAndView();
		memberVO = memberService.login(loginMap);
		if(memberVO!=null && memberVO.getMem_id()!=null) {
			HttpSession session = request.getSession();
			session = request.getSession();
			session.setAttribute("isLogOn", true);
			session.setAttribute("memberInfo", memberVO);
			
			//아직은 사용하지 않는 코드(메인페이지가 아닌 다른페이지에서 로그인 창으로 이동해 로그인 하는 경우)
			String action = (String)session.getAttribute("action");
			if(action!=null && action.equals("/order/orderEachGoods.do")) {
				mav.setViewName("forward:"+action);
			} else {
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
	@RequestMapping(value="/member/logout.do" ,method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		session.setAttribute("isLogOn", false);
		session.removeAttribute("memberInfo");
		mav.setViewName("redirect:/main.do");
		return mav;
	}
	
	//회원가입
	//@ModelAttribute 어노테이션은 폼의 데이터를 자동으로 바인딩할 때 사용됨(Form에 값을 vo에 바인딩)
	@Override
	@RequestMapping(value="/member/addMember.do" ,method = RequestMethod.POST)
	public ResponseEntity addMember(@ModelAttribute("memberVO") MemberVO _memberVO,
			                HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
		    memberService.addMember(_memberVO);
		    message  = "<script>";
		    message +=" alert('회원 가입을 마쳤습니다.로그인창으로 이동합니다.');";
		    message += " location.href='"+request.getContextPath()+"/member/loginForm.do';";
		    message += " </script>";
		    
		}catch(Exception e) {
			message  = "<script>";
		    message +=" alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요');";
		    message += " location.href='"+request.getContextPath()+"/member/memberForm.do';";
		    message += " </script>";
			e.printStackTrace();
		}
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	//회원탈퇴
	@Override
	@RequestMapping(value="/member/unregister.do" ,method = RequestMethod.POST)
	public void unregister(@RequestParam("mem_id") String mem_id,
        HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		session.setAttribute("isLogOn", false);
		session.removeAttribute("memberInfo");
		
		memberService.unregister(mem_id);
		
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("location.href='" + request.getContextPath() + "/member/unregistEndForm.do';");
		out.println("</script>");
		out.flush();	
	}

	//아이디 중복확인
	//ResponseEntity 객체를 반환하면 http응답으로 변환하여 전송
	//HttpStatus.OK 성공적으로 반환 했을때 사용(200코드)
	@Override
	@RequestMapping(value="/member/overlapped.do" ,method = RequestMethod.POST)
	public ResponseEntity overlapped(@RequestParam("id") String id,HttpServletRequest request, HttpServletResponse response) throws Exception{
		ResponseEntity resEntity = null; 
		String result = memberService.overlapped(id);
		resEntity =new ResponseEntity(result, HttpStatus.OK);
		return resEntity;
	}
	
	//회원 조회(아이디 찾기)
	@RequestMapping(value = "/member/selectMember.do",method = RequestMethod.POST)
	public ModelAndView selectMember(@RequestParam Map<String, String>selectMap,
	    HttpServletRequest request, HttpServletResponse response)throws Exception{
		ModelAndView mav = new ModelAndView();
		memberVO = memberService.selectMember(selectMap);
		if(memberVO!=null && memberVO.getMem_name()!=null && memberVO.getMem_id()!=null && memberVO.getMem_email1()!=null && memberVO.getMem_email2()!=null){
			HttpSession session = request.getSession();
			session = request.getSession();
			session.setAttribute("memberIDFind", memberVO);
			MemberVO memberInfo = (MemberVO) session.getAttribute("memberIDFind");
			String message = "회원님의 아이디는 "+memberInfo.getMem_id()+" 입니다.";
			mav.addObject("message",message);
			mav.setViewName("/member/loginForm");
			
		}else {
			String message = "이름 또는 이메일이 일치하지 않습니다. 다시 입력해 주세요";
			mav.addObject("message",message);
			mav.setViewName("/member/findIDForm");
		}
		return mav;
	}
	
	//비밀번호찾기 인증번호(전달) 
	@RequestMapping(value= "/member/findCerti.do", method=RequestMethod.POST)
	private ModelAndView findCerti(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer numObject = (Integer) session.getAttribute("num");
		int num = numObject.intValue();
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		mav.addObject("num",num);
		mav.setViewName(viewName);
		return mav;
	}
}