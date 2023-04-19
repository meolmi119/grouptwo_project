package com.spring.helloworld.busi.goods.controller;

import java.io.File;
import java.nio.file.Files;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.helloworld.busi.goods.service.BusiGoodsService;
import com.spring.helloworld.business.vo.BusinessVO;
import com.spring.helloworld.common.base.BaseController;
import com.spring.helloworld.goods.vo.GoodsStayVO;
import com.spring.helloworld.goods.vo.ImageFileVO;

@Controller("busiGoodsController")
public class BusiGoodsControllerImpl extends BaseController implements BusiGoodsController{
	@Autowired
	private BusiGoodsService busiGoodsService;
	@Autowired
	private BusinessVO businessVO;
	@Autowired
	private GoodsStayVO goodsStayVO;
	
	Map<String,String> getImageMap=new HashMap<String,String>();
	
	private static final String CURR_IMAGE_REPO_PATH = "C:\\goodstest\\file_repo";
	
	@RequestMapping(value = "/addNewGoodsStayForm.do", method = RequestMethod.GET)
	public ModelAndView addNewGoodsStayForm(HttpServletRequest request, HttpServletResponse response) throws
	Exception {
		String viewName = (String)request.getAttribute("viewName");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		return mav;
	}
	
	@RequestMapping(value = "/addNewGoodsAirForm.do", method = RequestMethod.GET)
	public ModelAndView addNewGoodsAirForm(HttpServletRequest request, HttpServletResponse response) throws
	Exception {
		String viewName = (String)request.getAttribute("viewName");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		return mav;
	}
	
//	@RequestMapping(value = "/addNewGoodsStay.do", method = RequestMethod.POST)
//	public ModelAndView addGoodsStay(@RequestParam("goodsStayVO") GoodsStayVO _goodsStayVO,
//			HttpServletRequest request, HttpServletResponse response) throws
//	Exception {
//		response.setContentType("text/html; charset=UTF-8");
//		request.setCharacterEncoding("utf-8");
//		
//		HttpSession session = request.getSession();
//		businessVO = (BusinessVO)session.getAttribute("businessInfo");
//		String busi_id = businessVO.getBusi_id();
//		_goodsStayVO.setBusi_id(busi_id);
//		
//		
//		busiGoodsService.addGoodsStay(_goodsStayVO);
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("addNewGoodsStayForm.do");
//		return mav;
//	}
	
	@RequestMapping(value="/addNewGoodsStay.do" ,method={RequestMethod.POST})
	public ResponseEntity addNewGoodsStay(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)  throws Exception {
		System.out.println("addNewGoodsStay");
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		String imageFileName=null;
		
		Map newGoodsMap = new HashMap();
		Enumeration enu=multipartRequest.getParameterNames();
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			newGoodsMap.put(name,value);
		}
		
		HttpSession session = multipartRequest.getSession();
		BusinessVO businessVO = (BusinessVO) session.getAttribute("businessInfo");
		String reg_id = businessVO.getBusi_id();
		
		List<ImageFileVO> imageFileList =upload(multipartRequest);
		if(imageFileList!= null && imageFileList.size()!=0) {
			for(ImageFileVO imageFileVO : imageFileList) {
				imageFileVO.setReg_id(reg_id);
			}
			newGoodsMap.put("imageFileList", imageFileList);
		}
		
		newGoodsMap.put("busi_id",reg_id);
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			int goods_stay_id = busiGoodsService.addNewGoodsStay(newGoodsMap);
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
			
					File destDir = new File(CURR_IMAGE_REPO_PATH+"\\"+goods_stay_id);
					FileUtils.moveFileToDirectory(srcFile, destDir,true);
				}
			}
			message= "<script>";
			message += " alert('상품이 정상적으로 등록되었습니다. 관리자의 검토 및 승인 완료 후에 상품 검색이 가능합니다.');";
			message +=" location.href='"+multipartRequest.getContextPath()+"/addNewGoodsStayForm.do';";
			message +=("</script>");
		} catch(Exception e) {
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
					srcFile.delete();
					File newfile = new File("C:\\goodstest\\file_repo\\temp");
					Files.createDirectories(newfile.toPath());
				}
			}
			message= "<script>";
			message += " alert('오류가 발생되었습니다. 관리자에게 문의해주세요');";
			message +=" location.href='"+multipartRequest.getContextPath()+"/addNewGoodsStayForm.do';";
			message +=("</script>");
			e.printStackTrace();
		}
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}

	/* 사업자 상품 리스트(메인) 페이지 *//* 하희 수정 0327~ */
	@RequestMapping(value="/busiGoodsMain.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView busiGoodsMain(@RequestParam Map<String, String> dateMap,
			                           HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		session=request.getSession();
//		session.setAttribute("side_menu", "admin_mode"); //마이페이지 사이드 메뉴로 설정한다.
		
		String fixedSearchPeriod = dateMap.get("fixedSearchPeriod");
		String section = dateMap.get("section");
		String pageNum = dateMap.get("pageNum");
		String beginDate=null,endDate=null;
		
		String [] tempDate=calcSearchPeriod(fixedSearchPeriod).split(",");
		beginDate=tempDate[0];
		endDate=tempDate[1];
//		dateMap.put("beginDate", beginDate);
//		dateMap.put("endDate", endDate);
//		
		Map<String,Object> condMap=new HashMap<String,Object>();
		if(section== null) {
			section = "1";
		}
		condMap.put("section",section);
		if(pageNum== null) {
			pageNum = "1";
		}
//		condMap.put("pageNum",pageNum);
//		condMap.put("beginDate",beginDate);
//		condMap.put("endDate", endDate);
		List<GoodsStayVO> newGoodsList=busiGoodsService.listNewGoodsStay(condMap);
		mav.addObject("newGoodsList", newGoodsList);
		
		String beginDate1[]=beginDate.split("-");
		String endDate2[]=endDate.split("-");
//		mav.addObject("beginYear",beginDate1[0]);
//		mav.addObject("beginMonth",beginDate1[1]);
//		mav.addObject("beginDay",beginDate1[2]);
//		mav.addObject("endYear",endDate2[0]);
//		mav.addObject("endMonth",endDate2[1]);
//		mav.addObject("endDay",endDate2[2]);
		
		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);
		return mav;
		
	}
	
	/* 숙박 상품 수정하기(사업자, 관리자) *//* 하희 수정 0316~ */
	@RequestMapping(value="/modifyGoodsStayForm.do" ,method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView modifyGoodsStayForm(@RequestParam("goods_id") int goods_id,
			                            HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		Map goodsMap=busiGoodsService.goodsStayDetail(goods_id);
		mav.addObject("goodsMap",goodsMap);
		
		return mav;
	}
	
	/* 숙박 상품 수정하기(사업자, 관리자) */
	@RequestMapping(value="/modifyGoodsStayInfo.do" ,method={RequestMethod.POST})
	public ResponseEntity modifyGoodsStayInfo( @RequestParam("goods_stay_id") String goods_id,
			                     @RequestParam("attribute") String attribute,
			                     @RequestParam("value") String value,
			HttpServletRequest request, HttpServletResponse response)  throws Exception {
		System.out.println("modifyGoodsStayInfo");
		
		Map<String,String> goodsMap=new HashMap<String,String>();
		goodsMap.put("goods_stay_id", goods_id);
		goodsMap.put(attribute, value);
		busiGoodsService.modifyGoodsStayInfo(goodsMap);
		
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		message  = "mod_success";
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	/* 숙박 상품 이미지 수정하기(사업자, 관리자) 메인이미지 */
	/*@RequestMapping(value="/modifyGoodsStayImageInfo.do" ,method={RequestMethod.POST})
	public void modifyGoodsStayImageInfo(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)  throws Exception {
		System.out.println("(Main)modifyGoodsStayImageInfo");
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String imageFileName=null;
		
		Map goodsMap = new HashMap();
		Enumeration enu=multipartRequest.getParameterNames();
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			System.out.println("\t\t" + name + "\t\t" + value);
			goodsMap.put(name,value);
		}
		
		HttpSession session = multipartRequest.getSession();
		BusinessVO businessVO = (BusinessVO) session.getAttribute("businessInfo");
		String reg_id = businessVO.getBusi_id();
		
		List<ImageFileVO> imageFileList=null;
		int goods_id=0;
		int image_id=0;
		try {
			imageFileList =upload(multipartRequest);
			if(imageFileList!= null && imageFileList.size()!=0) {
				for(ImageFileVO imageFileVO : imageFileList) {
					goods_id = Integer.parseInt((String)goodsMap.get("goods_id"));
					image_id = Integer.parseInt((String)goodsMap.get("image_id"));
					imageFileVO.setGoods_id(goods_id);
					imageFileVO.setImage_id(image_id);
					imageFileVO.setReg_id(reg_id);
				}
				
				busiGoodsService.modifyGoodsStayImage(imageFileList);
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
					File destDir = new File(CURR_IMAGE_REPO_PATH+"\\"+goods_id);
					FileUtils.moveFileToDirectory(srcFile, destDir,true);
				}
				System.out.println(goods_id + "\t\t" + image_id + "\t\t" + imageFileName);
			}
		} catch(Exception e) {
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
					srcFile.delete();
					
					File newfile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp");
					Files.createDirectories(newfile.toPath());
					System.out.println("(detail)modifyGoodsStayImageInfo catch exception " + goods_id + "\t\t" + image_id + "\t\t" + imageFileName);
				}
			}
			e.printStackTrace();
		}
		File beforeFile = new File(CURR_IMAGE_REPO_PATH+"\\"+getImageMap.get("goods_id")+"\\"+getImageMap.get("imageFileName"));
		beforeFile.delete();
	}/*
	
	/* 숙박 상품 이미지 수정하기(사업자, 관리자) */
	@RequestMapping(value="/modifyGoodsStayImageInfo.do" ,method={RequestMethod.POST})
	public void modifyGoodsStayImageInfo(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)  throws Exception {
		System.out.println("(detail)modifyGoodsStayImageInfo2--Detail");
		
//		System.out.println("000000000000000000000000000000000000000000000000000000000000000000000");
//		System.out.println("000000000000000000000000000000000000000000000000000000000000000000000");
//		System.out.println("goods_id\t\t" 		+ getImageMap.get("goods_id"));
//		System.out.println("image_id\t\t"		+ getImageMap.get("image_id"));
//		System.out.println("imageFileName\t\t"	+ getImageMap.get("imageFileName"));
//		System.out.println("fileType\t\t" 		+ getImageMap.get("fileType"));
//		System.out.println("000000000000000000000000000000000000000000000000000000000000000000000");
//		System.out.println("000000000000000000000000000000000000000000000000000000000000000000000");
		
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String imageFileName=null;
		
		Map goodsMap = new HashMap();
		Enumeration enu=multipartRequest.getParameterNames();
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			System.out.println("\t\t" + name + "\t\t" + value);
			goodsMap.put(name, value);
		}
		
		HttpSession session = multipartRequest.getSession();
		BusinessVO businessVO = (BusinessVO) session.getAttribute("businessInfo");
		String reg_id = businessVO.getBusi_id();
		
		List<ImageFileVO> imageFileList=null;
		int goods_id=0;
		int image_id=0;
		String fileType = null;	// 변재선
		
		try {
			imageFileList =upload(multipartRequest);
			if(imageFileList!= null && imageFileList.size()!=0) {
				for(ImageFileVO imageFileVO : imageFileList) {
					goods_id = Integer.parseInt((String)goodsMap.get("goods_id"));
					image_id = Integer.parseInt((String)goodsMap.get("image_id"));
					//image_id = Integer.parseInt(getImageMap.get("image_id"));//Integer.parseInt((String)goodsMap.get("image_id"));
					imageFileVO.setGoods_id(goods_id);
					imageFileVO.setImage_id(image_id);
					imageFileVO.setReg_id(reg_id);
					
					fileType = (String)goodsMap.get("fileType");	//변재선
					imageFileVO.setFileType(fileType);				//변재선
					System.out.println("(detail)처음 try for문\t goods_id : " + goods_id + "\t image_id : " + image_id );
				}
				
				busiGoodsService.modifyGoodsStayImage(imageFileList);
				System.out.println("(detail)service 실행됨");
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFileName();
					System.out.println("imageFileName " + imageFileName);
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
					File destDir = new File(CURR_IMAGE_REPO_PATH+"\\"+goods_id);
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
					System.out.println(goods_id + "\t\t" + image_id + "\t\t" + imageFileName);
				}
			}
		} catch(Exception e) {
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
					srcFile.delete();
					File newfile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp");
					Files.createDirectories(newfile.toPath());
					System.out.println("(detail)modifyGoodsStayImageInfo catch exception " + goods_id + "\t\t" + image_id + "\t\t" + imageFileName);
				}
			}
			e.printStackTrace();
		}
		File beforeFile = new File(CURR_IMAGE_REPO_PATH+"\\"+getImageMap.get("goods_id")+"\\"+getImageMap.get("imageFileName"));
		beforeFile.delete();
	}
	
	@Override
	@RequestMapping(value="/modifyGetInfo.do" ,method={RequestMethod.POST})
	public void modifyGetInfo(@RequestParam("goods_id") int goods_id2,
            @RequestParam("image_id") int image_id2,
            @RequestParam("fileType") String fileType2, 
            @RequestParam("imageFileName") String imageFileName2,
            HttpServletRequest request, HttpServletResponse response)  throws Exception {
		Map<String,String> imageMap=new HashMap<String,String>();
		try {
			System.out.println("********************modifyGetInfo**********************");
			System.out.println(goods_id2);
			System.out.println(image_id2);
			System.out.println(fileType2);
			System.out.println(imageFileName2);
			System.out.println("*******************************************************");
			
			imageMap.put("goods_id", Integer.toString(goods_id2));
			imageMap.put("image_id", Integer.toString(image_id2));
			imageMap.put("fileType", fileType2);
			imageMap.put("imageFileName", imageFileName2);
			
			getImageMap = imageMap;
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 숙박 상품 이미지 추가하기(사업자, 관리자) */
	@Override
	@RequestMapping(value="/addNewGoodsStayImage.do" ,method={RequestMethod.POST})
	public void addNewGoodsStayImage(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		System.out.println("addNewGoodsStayImage");
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String imageFileName=null;
		
		Map goodsMap = new HashMap();
		Enumeration enu=multipartRequest.getParameterNames();
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			goodsMap.put(name,value);
		}
		
		System.out.println(goodsMap.values());
		HttpSession session = multipartRequest.getSession();
		BusinessVO businessVO = (BusinessVO) session.getAttribute("businessInfo");
		String reg_id = businessVO.getBusi_id();
		
		List<ImageFileVO> imageFileList=null;
		int goods_id=0;
		try {
			imageFileList =upload(multipartRequest);
			if(imageFileList!= null && imageFileList.size()!=0) {
				for(ImageFileVO imageFileVO : imageFileList) {
					goods_id = Integer.parseInt((String)goodsMap.get("goods_id"));
					imageFileVO.setGoods_id(goods_id);
					imageFileVO.setReg_id(reg_id);
				}
				busiGoodsService.addNewGoodsStayImage(imageFileList);
//				busiGoodsService.addNewGoodsStayImage(goodsMap);
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
					File destDir = new File(CURR_IMAGE_REPO_PATH+"\\"+goods_id);
					FileUtils.moveFileToDirectory(srcFile, destDir,true);
				}
			}
		} catch(Exception e) {
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
					srcFile.delete();
					File newfile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp");
					Files.createDirectories(newfile.toPath());
				}
			}
			e.printStackTrace();
		}
		File beforeFile = new File(CURR_IMAGE_REPO_PATH+"\\"+getImageMap.get("goods_id")+"\\"+getImageMap.get("imageFileName"));
		beforeFile.delete();
	}
	
	/* 숙박 상품 이미지 삭제하기(사업자, 관리자) */
	@Override
	@RequestMapping(value="/removeGoodsStayImage.do" ,method={RequestMethod.POST})
	public void removeGoodsStayImage(@RequestParam("goods_id") int goods_id,
			                      @RequestParam("image_id") int image_id,
			                      @RequestParam("imageFileName") String imageFileName,
			                      HttpServletRequest request, HttpServletResponse response)  throws Exception {
		busiGoodsService.removeGoodsStayImage(image_id);
		try{
			System.out.println("removeGoodsStayImage");
			System.out.println("goods_id" + goods_id + "\t\timage_id" + image_id + "\t\timageFileName" + imageFileName) ;
			
			File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+goods_id+"\\"+imageFileName);
			srcFile.delete();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
