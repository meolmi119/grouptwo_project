package com.spring.helloworld.goods.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.helloworld.goods.vo.GoodsStayVO;

public interface GoodsService {
	public List goodsStayList(String keywordAddress,String keywordSort,String keywordName) throws DataAccessException;
	public List goodsAirList() throws DataAccessException;
	
	//0317
	public Map goodsStayDetail(String _goods_stay_id) throws Exception;
	//airapi 양하희 0328
//	public List<GoodsAirApiVO> listNewGoodsAirApi(Map airMap) throws Exception;
	//이벤트 상품 검색(관리자)
	public List<GoodsStayVO> listStay() throws Exception;
	//이벤트 상품 검색(사업자)
	public List<GoodsStayVO> listStayBusiness(String busi_id) throws Exception;
	//상품 제거(사업자)
	public void goodsUnregist(String goods_stay_id) throws Exception;
	//상품 조회(특정 상품)
	public GoodsStayVO selectGoods(String goods_stay_id) throws Exception;
	//상품 수정(사업자)
	public void goodsEdit(Map goodsEditMap) throws Exception;
	//이벤트 등록(사업자)
	public void goodsEventRegist(Map goodsEventMap) throws Exception;
}
