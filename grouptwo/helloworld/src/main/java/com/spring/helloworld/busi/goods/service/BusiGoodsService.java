package com.spring.helloworld.busi.goods.service;

import java.util.Map;
import java.util.HashMap;
import java.util.List;

import com.spring.helloworld.goods.vo.GoodsStayVO;
import com.spring.helloworld.goods.vo.ImageFileVO;

public interface BusiGoodsService {
	public int addNewGoodsStay(Map newGoodsStayMap) throws Exception;
	
	/* ÇÏÈñ ¼öÁ¤ 0316~ */
	public List<GoodsStayVO> listNewGoodsStay(Map condMap) throws Exception;
	public Map goodsStayDetail(int goods_id) throws Exception;
	public List goodsStayImageFile(int goods_id) throws Exception;
	public void modifyGoodsStayInfo(Map goodsMap) throws Exception;
	public void modifyGoodsStayImage(List<ImageFileVO> imageFileList) throws Exception;
	public void removeGoodsStayImage(int image_id) throws Exception;
	public void addNewGoodsStayImage(List imageFileList) throws Exception;
//	public void addNewGoodsStayImage(Map newGoodsStayMap) throws Exception;
}