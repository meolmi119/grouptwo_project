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
import com.spring.helloworld.business.vo.BusinessVO;
import com.spring.helloworld.member.service.MemberService;
import com.spring.helloworld.member.vo.MemberVO;
import com.spring.helloworld.mypage.service.MyPageService;

public interface AdminController {
	public ModelAndView logoutAdmin(
			HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView listMember(
			HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView listBusiness(
			HttpServletRequest request, HttpServletResponse response) throws Exception;
	public void unregisterAdmin(@RequestParam("mem_id") String mem_id,
			HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView adminEdit(@RequestParam("mem_id") String mem_id,
			HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity modifyMyInfoAdmin(@RequestParam("attribute")  String attribute,
			@RequestParam("value")  String value,
			HttpServletRequest request, HttpServletResponse response) throws Exception;
}
