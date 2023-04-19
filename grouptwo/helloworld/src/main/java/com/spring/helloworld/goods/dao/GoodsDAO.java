package com.spring.helloworld.goods.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.helloworld.goods.vo.GoodsAirApiVO;
import com.spring.helloworld.goods.vo.GoodsStayVO;
import com.spring.helloworld.goods.vo.ImageFileVO;

public interface GoodsDAO {
	public List goodsStayList(String keywordAddress,String keywordSort,String keywordName) throws DataAccessException;
	public List goodsAirList() throws DataAccessException;
	//0317
	public GoodsStayVO selectGoodsStayDetail(String goods_id) throws DataAccessException;
	public List<ImageFileVO> selectGoodsDetailImage(String goods_id) throws DataAccessException;
	// airapi 양하희 0328
	public List<GoodsAirApiVO>selectNewGoodsAirApiList(Map airMap) throws DataAccessException;
	//이벤트 상품 검색(관리자)
	public List selectAllStay() throws DataAccessException;
	//이벤트 상품 검색(사업자)
	public List selectAllStayBusiness(String busi_id) throws DataAccessException;
	//상품 제거(사업자)
	public void goodsUnregist(String goods_stay_id) throws DataAccessException;
	//상품 조회(특정 상품)
	public GoodsStayVO selectGoods(String goods_stay_id) throws DataAccessException;
	//상품 수정 (사업자)
	public void goodsEdit(Map goodsEditMap) throws DataAccessException;
	//이벤트 등록(사업자)
	public void goodsEventRegist(Map goodsEventMap) throws DataAccessException;
}
