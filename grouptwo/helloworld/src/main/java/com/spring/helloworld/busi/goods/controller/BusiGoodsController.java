package com.spring.helloworld.busi.goods.controller;

import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.helloworld.goods.vo.GoodsStayVO;
import com.spring.helloworld.goods.vo.ImageFileVO;

public interface BusiGoodsController {
	public ModelAndView addNewGoodsStayForm(HttpServletRequest request, HttpServletResponse response) throws
	Exception;
//	public ModelAndView addGoodsStay(@RequestParam("goodsStayVO") GoodsStayVO _goodsStayVO,
//			HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	/* ÇÏÈñ ¼öÁ¤ 0316~ */
	public ModelAndView busiGoodsMain(@RequestParam Map<String, String> dateMap,
            HttpServletRequest request, HttpServletResponse response)  throws Exception;
//	public ModelAndView modifyGoodsStayForm(@RequestParam("goods_id") int goods_id,
//			                            HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ResponseEntity modifyGoodsStayInfo( @RequestParam("goods_stay_id") String goods_id,
			                     @RequestParam("attribute") String attribute,
			                     @RequestParam("value") String value, HttpServletRequest request, HttpServletResponse response)  throws Exception;

//	public void modifyGoodsStayImageInfo(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)  throws Exception;
	public void modifyGoodsStayImageInfo(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)  throws Exception;
	public void modifyGetInfo(@RequestParam("goods_id") int goods_id2,
					             @RequestParam("image_id") int image_id2,
					             @RequestParam("fileType") String fileType2, 
					             @RequestParam("imageFileName") String imageFileName2,
					             HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	public void addNewGoodsStayImage(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception;
	public void removeGoodsStayImage(@RequestParam("goods_id") int goods_id,
			                      @RequestParam("image_id") int image_id,
			                      @RequestParam("imageFileName") String imageFileName,
			                      HttpServletRequest request, HttpServletResponse response)  throws Exception;

}
