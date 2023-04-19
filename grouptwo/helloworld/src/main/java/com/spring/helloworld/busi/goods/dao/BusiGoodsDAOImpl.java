package com.spring.helloworld.busi.goods.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.helloworld.goods.vo.GoodsStayVO;
import com.spring.helloworld.goods.vo.ImageFileVO;

@Repository("busiGoodsDAO")
public class BusiGoodsDAOImpl implements BusiGoodsDAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insertNewGoodsStay(Map newGoodsStayMap) throws DataAccessException{
		int goods_stay_id = selectGoodsStayID();
		newGoodsStayMap.put("goods_stay_id", goods_stay_id);
		sqlSession.insert("mapper.busi_goods.insertNewGoodsStay",newGoodsStayMap);
		return (Integer) newGoodsStayMap.get("goods_stay_id");
	}
	
	private int selectGoodsStayID() throws DataAccessException{
		int goods_stay_id = sqlSession.selectOne("mapper.busi_goods.selectGoodsStayID");
		return goods_stay_id;
	}
	
	@Override
	public void insertGoodsImageFile(List fileList) throws DataAccessException {
		for(int i=0; i<fileList.size();i++){
			ImageFileVO imageFileVO=(ImageFileVO)fileList.get(i);
			sqlSession.insert("mapper.busi_goods.insertGoodsImageFile",imageFileVO);
		}
	}
	

	/* º˜π⁄ ºˆ¡§«œ±‚ */ /* «œ»Ò ºˆ¡§ 0316~ */
	@Override
	public List<GoodsStayVO>selectNewGoodsStayList(Map condMap) throws DataAccessException {
		ArrayList<GoodsStayVO> goodsList=(ArrayList)sqlSession.selectList("mapper.busi_goods.selectNewGoodsStayList",condMap);
		return goodsList;
	}
	
	@Override
	public GoodsStayVO selectGoodsStayDetail(int goods_id) throws DataAccessException{
		GoodsStayVO goodsBean = new GoodsStayVO();
		goodsBean=(GoodsStayVO)sqlSession.selectOne("mapper.busi_goods.selectGoodsStayDetail",goods_id);
		return goodsBean;
	}
	
	@Override
	public List selectGoodsStayImageFileList(int goods_id) throws DataAccessException {
		List imageList=new ArrayList();
		imageList=(List)sqlSession.selectList("mapper.busi_goods.selectGoodsStayImageFileList",goods_id);
		return imageList;
	}
	
	@Override
	public void updateGoodsStayInfo(Map goodsMap) throws DataAccessException{
		sqlSession.update("mapper.busi_goods.updateGoodsStayInfo",goodsMap);
	}
	
	@Override
	public void deleteGoodsStayImage(int image_id) throws DataAccessException{
		sqlSession.delete("mapper.busi_goods.deleteGoodsStayImage",image_id);
	}
	
	@Override
	public void deleteGoodsStayImage(List fileList) throws DataAccessException{
		int image_id;
		for(int i=0; i<fileList.size();i++){
			ImageFileVO bean=(ImageFileVO) fileList.get(i);
			image_id=bean.getImage_id();
			sqlSession.delete("mapper.busi_goods.deleteGoodsStayImage",image_id);	
		}
	}

	@Override
	public void updateGoodsStayImage(List<ImageFileVO> imageFileList) throws DataAccessException {
//		int image_id;	//0323 æÁ«œ»Ò
		for(int i=0; i<imageFileList.size();i++){
			ImageFileVO imageFileVO = imageFileList.get(i);
//			image_id=imageFileVO.getImage_id();	//0323 æÁ«œ»Ò
			sqlSession.update("mapper.busi_goods.updateGoodsStayImage",imageFileVO);	
		}
	}
	
//	@Override
//	public List<OrderVO> selectOrderGoodsList(Map condMap) throws DataAccessException{
//		List<OrderVO>  orderGoodsList=(ArrayList)sqlSession.selectList("mapper.admin.selectOrderGoodsList",condMap);
//		return orderGoodsList;
//	}	
//	
//	@Override
//	public void updateOrderGoods(Map orderMap) throws DataAccessException{
//		sqlSession.update("mapper.admin.goods.updateOrderGoods",orderMap);
//		
//	}
	/* ø©±‚±Ó¡ˆ «œ»Ò ºˆ¡§ 0316~ */
}