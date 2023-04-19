package com.spring.helloworld.goods.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public interface GoodsController {
	public ModelAndView goodsStayList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView goodsAirList(HttpServletRequest request, HttpServletResponse response) throws Exception;	
}
