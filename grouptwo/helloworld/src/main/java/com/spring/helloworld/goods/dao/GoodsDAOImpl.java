package com.spring.helloworld.goods.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.helloworld.goods.vo.GoodsAirApiVO;
import com.spring.helloworld.goods.vo.GoodsAirVO;
import com.spring.helloworld.goods.vo.GoodsStayVO;
import com.spring.helloworld.goods.vo.ImageFileVO;


@Repository("goodsDAO")
public class GoodsDAOImpl implements GoodsDAO {
	@Autowired
	private SqlSession sqlSession;
	
//	@Override
//	public List<GoodsVO> selectGoodsStayList(String goodsStatus ) throws DataAccessException {
//		List<GoodsVO> goodsStayList=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsStayList",goodsStatus);
//		return goodsStayList;
//	}
	
	@Override
	public List goodsStayList(String keywordAddress,String keywordSort,String keywordName) throws DataAccessException {
		List<GoodsStayVO> goodsStayList = null;
		Map<String, Object> totalKeyword = new HashMap();
		totalKeyword.put("keywordAddress", keywordAddress);
		totalKeyword.put("keywordSort", keywordSort);
		totalKeyword.put("keywordName", keywordName);
		goodsStayList = sqlSession.selectList("mapper.goods.selectGoodsStayList",totalKeyword);
		return goodsStayList;
	}
	
	@Override
	public List goodsAirList() throws DataAccessException {
		List<GoodsAirVO> goodsAirList = null;
		goodsAirList = sqlSession.selectList("mapper.goods.selectGoodsAirList");
		return goodsAirList;
	}
	
	//0317 상세
	@Override
	public GoodsStayVO selectGoodsStayDetail(String goods_stay_id) throws DataAccessException {
		GoodsStayVO goodsStayVO=(GoodsStayVO)sqlSession.selectOne("mapper.goods.selectGoodsStayDetail",goods_stay_id);
		return goodsStayVO;
	}
	
	@Override
	public List<ImageFileVO> selectGoodsDetailImage(String goods_stay_id) throws DataAccessException {
		List<ImageFileVO> imageList=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsDetailImage",goods_stay_id);
		return imageList;
	}
	
	// airapi 양하희 0328
	@Override
	public List<GoodsAirApiVO>selectNewGoodsAirApiList(Map airMap) throws DataAccessException {
		ArrayList<GoodsAirApiVO> goodsList=(ArrayList)sqlSession.selectList("mapper.goods.selectNewGoodsAirApiList",airMap);
		return goodsList;
	}
	//이벤트 상품 조회(관리자)
	@Override
	public List selectAllStay() throws DataAccessException{
		List<GoodsStayVO> stayList = sqlSession.selectList("mapper.goods.selectAllStay");
		return stayList;
	}
	
	//이벤트 상품 조회(사업자)
	@Override
	public List selectAllStayBusiness(String busi_id) throws DataAccessException{
		List<GoodsStayVO> stayList = sqlSession.selectList("mapper.goods.selectAllStayBusiness",busi_id);
		return stayList;
	}
	//상품 조회
	@Override
	public GoodsStayVO selectGoods(String goods_stay_id) throws DataAccessException{
		GoodsStayVO result = sqlSession.selectOne("mapper.goods.selectGoods",goods_stay_id);
		return result;
	}
	//상품 제거(사업자)
	@Override
	public void  goodsUnregist(String goods_stay_id) throws DataAccessException {
		sqlSession.delete("mapper.goods.goodsUnregist", goods_stay_id);
	}
	//상품 수정(사업자)
	@Override
	public void goodsEdit(Map goodsEditMap) throws DataAccessException{
		sqlSession.update("mapper.goods.goodsEdit", goodsEditMap);
	}
	
	//이벤트 등록(사업자)
	@Override
	public void goodsEventRegist(Map goodsEventMap) throws DataAccessException{
		sqlSession.update("mapper.goods.goodsEventRegist", goodsEventMap);
	}
}
