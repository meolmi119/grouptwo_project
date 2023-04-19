package com.spring.helloworld.order.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.helloworld.goods.vo.GoodsAirApiVO;
import com.spring.helloworld.member.vo.MemberVO;
import com.spring.helloworld.order.vo.OrderAirVO;

public interface OrderController {
	public ModelAndView orderEachGoodsAir(@ModelAttribute("orderAirVO") OrderAirVO _orderVO,
            HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView payToOrderGoodsAir(@RequestParam Map<String, String> orderAirMap,
	        HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public void getDepAirportId(/* @RequestParam("rowData") String[] rowData, */
			@RequestParam("flightName") String flightName,
			@RequestParam("airlineName") String airlineName,
			@RequestParam("departureTime") String departureTime,
			@RequestParam("arrivalTime") String arrivalTime,
			@RequestParam("departureAirport") String departureAirport,
			@RequestParam("arrivalAirport") String arrivalAirport,
			@RequestParam("economyCharge") String economyCharge,
			@RequestParam("qty") String qty, 
			HttpServletRequest request, HttpServletResponse response)  throws Exception;
}