package com.spring.helloworld.busi.goods.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.helloworld.goods.vo.GoodsStayVO;
import com.spring.helloworld.goods.vo.ImageFileVO;

public interface BusiGoodsDAO {
	public int insertNewGoodsStay(Map newGoodsStayMap) throws DataAccessException;
	public void insertGoodsImageFile(List fileList)  throws DataAccessException;
	
	/* ÇÏÈñ ¼öÁ¤ 0316~ */
	public List<GoodsStayVO>selectNewGoodsStayList(Map condMap) throws DataAccessException;
	public GoodsStayVO selectGoodsStayDetail(int goods_id) throws DataAccessException;
	public List selectGoodsStayImageFileList(int goods_id) throws DataAccessException;
	public void updateGoodsStayInfo(Map goodsMap) throws DataAccessException;
	public void deleteGoodsStayImage(int image_id) throws DataAccessException;
	public void deleteGoodsStayImage(List fileList) throws DataAccessException;
	public void updateGoodsStayImage(List<ImageFileVO> imageFileList) throws DataAccessException;
}
