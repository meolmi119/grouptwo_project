package com.spring.helloworld.busi.goods.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.helloworld.busi.goods.dao.BusiGoodsDAO;
import com.spring.helloworld.goods.vo.GoodsStayVO;
import com.spring.helloworld.goods.vo.ImageFileVO;

@Service("busiGoodsService")
@Transactional(propagation = Propagation.REQUIRED)
public class BusiGoodsServiceImpl implements BusiGoodsService{
	@Autowired
	private BusiGoodsDAO busiGoodsDAO;
	
	@Override
	public int addNewGoodsStay(Map newGoodsStayMap) throws Exception{
		int goods_stay_id = busiGoodsDAO.insertNewGoodsStay(newGoodsStayMap);
		ArrayList<ImageFileVO> imageFileList = (ArrayList)newGoodsStayMap.get("imageFileList");
		for(ImageFileVO imageFileVO : imageFileList) {
			imageFileVO.setGoods_id(goods_stay_id);
		}
		busiGoodsDAO.insertGoodsImageFile(imageFileList);
		return goods_stay_id;
	}
	
	/* 숙박 수정하기 */ /* 하희 수정 0316~ */
	@Override
	public List<GoodsStayVO> listNewGoodsStay(Map condMap) throws Exception {
		return busiGoodsDAO.selectNewGoodsStayList(condMap);
	}
	@Override
	public Map goodsStayDetail(int goods_id) throws Exception {
		Map goodsMap = new HashMap();
		GoodsStayVO goodsVO=busiGoodsDAO.selectGoodsStayDetail(goods_id);
		List imageFileList =busiGoodsDAO.selectGoodsStayImageFileList(goods_id);
		goodsMap.put("goods", goodsVO);
		goodsMap.put("imageFileList", imageFileList);
		return goodsMap;
	}
	@Override
	public List goodsStayImageFile(int goods_id) throws Exception {
		List imageList =busiGoodsDAO.selectGoodsStayImageFileList(goods_id);
		return imageList;
	}
	
	@Override
	public void modifyGoodsStayInfo(Map goodsMap) throws Exception {
		busiGoodsDAO.updateGoodsStayInfo(goodsMap);
		
	}	
	@Override
	public void modifyGoodsStayImage(List<ImageFileVO> imageFileList) throws Exception {
		busiGoodsDAO.updateGoodsStayImage(imageFileList); 
	}	
	
	@Override
	public void removeGoodsStayImage(int image_id) throws Exception {
		busiGoodsDAO.deleteGoodsStayImage(image_id);
	}
	
	@Override
	public void addNewGoodsStayImage(List imageFileList) throws Exception {
		busiGoodsDAO.insertGoodsImageFile(imageFileList);
	}
	
//	@Override
//	public void addNewGoodsStayImage(Map newGoodsStayMap) throws Exception{ //(List imageFileList) throws Exception {
//		int goods_stay_id = busiGoodsDAO.insertNewGoodsStay(newGoodsStayMap);
//		ArrayList<ImageFileVO> imageFileList2 = (ArrayList)newGoodsStayMap.get("imageFileList");
//		for(ImageFileVO imageFileVO : imageFileList2) {
//			imageFileVO.setGoods_id(goods_stay_id);
//		}
//		busiGoodsDAO.insertGoodsImageFile(imageFileList2);
//	}
	
//	@Override
//	public List<OrderVO> listOrderGoods(Map condMap) throws Exception{
//		return busiGoodsDAO.selectOrderGoodsList(condMap);
//	}
//	@Override
//	public void modifyOrderGoods(Map orderMap) throws Exception{
//		busiGoodsDAO.updateOrderGoods(orderMap);
//	}
	/* 여기까지 하희 수정 0316~ */
}
