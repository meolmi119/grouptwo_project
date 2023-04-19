package com.spring.helloworld.mypage.controller;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.helloworld.business.vo.BusinessVO;
import com.spring.helloworld.member.service.MemberService;
import com.spring.helloworld.member.vo.MemberVO;
import com.spring.helloworld.mypage.service.MyPageService;

@Controller("myPageController")
public class MyPageControllerImpl implements MyPageController{
	private static final Logger logger = LoggerFactory.getLogger(MyPageControllerImpl.class);
	@Autowired
	private MyPageService myPageService;
	
	@Autowired
	private MemberVO memberVO;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BusinessVO businessVO;
	
	//회원 수정 페이지 이동
	@Override
	@RequestMapping(value="/mypage/memberEdit.do" ,method = RequestMethod.GET)
	public ModelAndView myDetailInfo(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
		
	//회원 수정
	@Override
	@RequestMapping(value="/mypage/modifyMyInfo.do" ,method = RequestMethod.POST)
	public ResponseEntity modifyMyInfo(@RequestParam("attribute")  String attribute,
			                 @RequestParam("value")  String value,
			               HttpServletRequest request, HttpServletResponse response)  throws Exception {
		Map<String,String> memberMap=new HashMap<String,String>();
		String val[]=null;
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
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
		session.removeAttribute("memberInfo");
		session.setAttribute("memberInfo", memberVO);
		
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		message  = "mod_success";
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	//사업자 정보 수정 페이지로 이동
	@RequestMapping(value="/mypage/businessEdit.do" ,method = RequestMethod.GET)
	public ModelAndView myDetailBusiInfo(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	//사업자 정보 수정
	@Override
	@RequestMapping(value="/mypage/modifyMyBusiInfo.do" ,method = RequestMethod.POST)
	public ResponseEntity modifyMyBusiInfo(@RequestParam("attribute")  String attribute,
			                 @RequestParam("value")  String value,
			               HttpServletRequest request, HttpServletResponse response)  throws Exception {
		Map<String,String> businessMap=new HashMap<String,String>();
		String val[]=null;
		HttpSession session=request.getSession();
		businessVO=(BusinessVO)session.getAttribute("businessInfo");
		String busi_id=businessVO.getBusi_id();
		if(attribute.equals("busi_tel")){
			val=value.split(",");
			businessMap.put("busi_tel1",val[0]);
			businessMap.put("busi_tel2",val[1]);
			businessMap.put("busi_tel3",val[2]);
		}else if(attribute.equals("busi_hp")){
			val=value.split(",");
			businessMap.put("busi_hp1",val[0]);
			businessMap.put("busi_hp2",val[1]);
			businessMap.put("busi_hp3",val[2]);
		}else if(attribute.equals("busi_email")){
			val=value.split(",");
			businessMap.put("busi_email1",val[0]);
			businessMap.put("busi_email2",val[1]);
		}else if(attribute.equals("busi_address")){
			val=value.split(",");
			businessMap.put("busi_zipcode",val[0]);
			businessMap.put("busi_roadAddress",val[1]);
			businessMap.put("busi_jibunAddress", val[2]);
			businessMap.put("busi_namujiAddress", val[3]);
		}else {
			businessMap.put(attribute,value);	
		}
		
		businessMap.put("busi_id", busi_id);
		
		//수정된 회원 정보를 다시 세션에 저장한다.
		businessVO=(BusinessVO)myPageService.modifyMyBusiInfo(businessMap);
		session.removeAttribute("businessInfo");
		session.setAttribute("businessInfo", businessVO);
		
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		message  = "mod_success";
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
}
