package com.spring.helloworld.mypage.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface MyPageController {
	public ModelAndView myDetailInfo(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView myDetailBusiInfo(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ResponseEntity modifyMyInfo(@RequestParam("attribute")  String attribute,
            @RequestParam("value")  String value,
            HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ResponseEntity modifyMyBusiInfo(@RequestParam("attribute")  String attribute,
            @RequestParam("value")  String value,
            HttpServletRequest request, HttpServletResponse response)  throws Exception;
}
