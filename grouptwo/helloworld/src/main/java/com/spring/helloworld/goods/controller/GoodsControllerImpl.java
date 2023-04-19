package com.spring.helloworld.goods.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.helloworld.business.vo.BusinessVO;
import com.spring.helloworld.goods.service.GoodsService;
import com.spring.helloworld.goods.vo.GoodsStayVO;

@Controller("goodsController")

public class GoodsControllerImpl implements GoodsController{
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private GoodsStayVO goodsVO;
	
	@Override
	@RequestMapping(value = "/searchGoodsStay.do", method = RequestMethod.GET)
	public ModelAndView goodsStayList(HttpServletRequest request, HttpServletResponse response) throws
	Exception {
		String viewName = (String)request.getAttribute("viewName");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		
		//숙박 상품 조회에서 사용하는 검색 키워드
		String keywordAddress = request.getParameter("keywordAddress");
	    String keywordSort = request.getParameter("keywordSort");
	    String keywordName = request.getParameter("keywordName");
	    //키워드 값이 없는 경우 null로 나옴
	    
		Map<String, Object> totalKeyword = new HashMap();
		totalKeyword.put("keywordAddress", keywordAddress);
		totalKeyword.put("keywordSort", keywordSort);
		totalKeyword.put("keywordName", keywordName);
	    
		List goodsStayList = goodsService.goodsStayList(keywordAddress,keywordSort,keywordName);
		ModelAndView mav = new ModelAndView();
		
//		System.out.println(goodsStayList.get(0));
//		GoodsStayVO test = (GoodsStayVO) goodsStayList.get(0);
//		System.out.println(test);
//		System.out.println(test.getGoods_stay_name());
		
		
		mav.addObject("goodsStayList", goodsStayList);
		mav.addObject("totalKeyword", totalKeyword);
		mav.setViewName(viewName);
		return mav;
		
	}
	
	@RequestMapping(value = "/searchGoodsAir.do", method = RequestMethod.GET)
	public ModelAndView goodsAirList(HttpServletRequest request, HttpServletResponse response) throws
	Exception {
		String viewName = (String)request.getAttribute("viewName");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		
		List goodsAirList = goodsService.goodsAirList();
		ModelAndView mav = new ModelAndView();
		mav.addObject("goodsAirList", goodsAirList);
		mav.setViewName(viewName);
		return mav;
	}
	//0317 상세
	@RequestMapping(value="/goodsStayDetail.do" ,method = RequestMethod.GET)
	public ModelAndView goodsStayDetail(@RequestParam("goods_stay_id") String goods_stay_id,
			                       HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		HttpSession session = request.getSession();
		
		
		Map goodsStayMap = goodsService.goodsStayDetail(goods_stay_id);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("goodsStayMap", goodsStayMap);
		
//		GoodsVO goodsVO=(GoodsVO)goodsStayMap.get("goodsVO");
//		addGoodsInQuick(goods_id,goodsVO,session); 퀵메뉴 관련 무언가
		
		return mav;
	}
	//상품 삭제(사업자)
	@RequestMapping(value = "/goods/goodsUnregist.do",method = RequestMethod.POST)
	public ModelAndView goodsUnregist(@RequestParam("goods_stay_id") String goods_stay_id,HttpServletRequest request, HttpServletResponse response)throws Exception{
		goodsService.goodsUnregist(goods_stay_id);
		ModelAndView mav = new ModelAndView("redirect:/business/listAll.do");
		return mav;
	}
	
	//상품 수정페이지 이동(사업자)
	@RequestMapping(value ="/goods/goodsEditForm.do",method = RequestMethod.GET)
	public ModelAndView goodsEditForm(@RequestParam("goods_stay_id") String goods_stay_id,HttpServletRequest request, HttpServletResponse response)throws Exception{
		String viewName = (String)request.getAttribute("viewName");
		goodsVO = goodsService.selectGoods(goods_stay_id);
		ModelAndView mav = new ModelAndView();
		mav.addObject("goodsItems", goodsVO);
		mav.setViewName(viewName);
		return mav;
	}
	
	//상품 수정(사업자)
	@RequestMapping(value = "/goods/goodsEdit.do",method = RequestMethod.POST)
	public ModelAndView goodsEdit(@RequestParam Map goodsEditMap,HttpServletRequest request, HttpServletResponse response)throws Exception{
		goodsService.goodsEdit(goodsEditMap);
		ModelAndView mav = new ModelAndView("redirect:/business/listAll.do");
		return mav;
	}
	
	//이벤트 등록(사업자)
	@RequestMapping(value="/goods/goodsEventRegist.do",method = RequestMethod.POST)
	public ModelAndView goodsEventRegist(@RequestParam Map<String, String> goodsEventMap,
								  HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session = request.getSession();
		BusinessVO businessVO = (BusinessVO) session.getAttribute("businessInfo");
		String id = businessVO.getBusi_id();
		goodsEventMap.put("busi_id", id);
		goodsService.goodsEventRegist(goodsEventMap);
		ModelAndView mav = new ModelAndView("redirect:/business/listAll.do");
		return mav;
	}
	
//	private void addGoodsInQuick(String goods_id,GoodsVO goodsVO,HttpSession session){
//		boolean already_existed=false;
//		List<GoodsVO> quickGoodsList; //�ֱ� �� ��ǰ ���� ArrayList
//		quickGoodsList=(ArrayList<GoodsVO>)session.getAttribute("quickGoodsList");
//		
//		if(quickGoodsList!=null){
//			if(quickGoodsList.size() < 4){ //�̸��� ��ǰ ����Ʈ�� ��ǰ������ ���� ������ ���
//				for(int i=0; i<quickGoodsList.size();i++){
//					GoodsVO _goodsBean=(GoodsVO)quickGoodsList.get(i);
//					if(goods_id.equals(_goodsBean.getGoods_id())){
//						already_existed=true;
//						break;
//					}
//				}
//				if(already_existed==false){
//					quickGoodsList.add(goodsVO);
//				}
//			}
//			
//		}else{
//			quickGoodsList =new ArrayList<GoodsVO>();
//			quickGoodsList.add(goodsVO);
//			
//		}
//		session.setAttribute("quickGoodsList",quickGoodsList);
//		session.setAttribute("quickGoodsListNum", quickGoodsList.size());
//	}
}
