package com.spring.helloworld.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Date;
import java.io.BufferedReader;
import java.io.IOException;

import org.apache.el.parser.Node;
/* org.json depedency */
import org.json.JSONObject;
import org.json.XML;
import org.json.simple.parser.JSONParser; 

// xml to 데이터 parsing
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.helloworld.cart.service.CartService;
import com.spring.helloworld.cart.vo.CartAirVO;
import com.spring.helloworld.cart.vo.CartStayVO;
import com.spring.helloworld.goods.service.GoodsService;
import com.spring.helloworld.goods.vo.GoodsAirApiVO;
import com.spring.helloworld.member.vo.MemberVO;
import com.spring.helloworld.order.service.OrderService;

import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.io.StringReader;

import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/*양하희 변재선 공항 API*/
@Controller
public class TestController {
	// 출발공항 도착공항 Id 전역변수
	String depAirportIdGot = null;
	String arrAirportIdGot = null;
	// 출발공항 도착공항 Name 전역변수
	String depAirportNameGot = null;
	String arrAirportNameGot = null;
	// 출발 날짜 전역변수
	String depDateGot = null;
	// 항공편 데이터 갯수
	String totalCount = null;
	// 왕복 다구간일 때, 첫번쨰 항공편 데이터를 저장하기 위한 Map 전역 변수
	Map<String, Object> airMap=new HashMap<String, Object>();
	
	// 출발공항 도착공항 Id 전역변수 for 왕복/다구간
	String depAirportIdGotRnM = null;
	String arrAirportIdGotRnM = null;
	// 출발공항 도착공항 Name 전역변수 for 왕복/다구간
	String depAirportNameGotRnM = null;
	String arrAirportNameGotRnM = null;
	// 도착 날짜 전역변수(왕복)
	String arrDateGot = null;
	// 항공편 데이터 갯수
	String totalCount2 = null;
	// 왕복-다구간-편도
	String flagRadio = null;
	
	@RequestMapping(value= "/*api.do", method=RequestMethod.GET)
	private ModelAndView testform(@RequestParam(value="result", required=false) String result, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName(viewName);
		return mav;
	}
	
	// 국토교통부_(TAGO)_국내항공운항정보	https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15098526
	@RequestMapping(value="/airapiTago.do", method=RequestMethod.GET)
	public ModelAndView FlightOperateInfoApiTAGO(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName=(String)request.getAttribute("searchGoodsAir.do");
		HttpSession session = request.getSession();
		ModelAndView mav = new ModelAndView(viewName);
		
		// 불러올 데이터 갯수
		String numOfData = "1000";
		
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getFlightOpratInfoList"); /*URL*/
		// 양하희 앱키
		urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=ZLRsuVs6duAB7q1FfN1oa5pEqA5WZHjva1IubQsMcphCTkoaEGgniTY6ReB%2BWvl6fwjL8f7lMZP3Bd3FgMSWcA%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(numOfData, "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); /*데이터 타입(xml, json)*/
        
        // 공항 목록 조회
        String getDepAirportId; // = getKoreaAirportList("김포");
        String getDepAirportName;
        if(depAirportIdGot != null) {
        	getDepAirportId = depAirportIdGot;
        	depAirportNameGot = getAirportNamebyId(depAirportIdGot);
        	getDepAirportName = depAirportNameGot;
        } else {
        	getDepAirportId = getKoreaAirportList("부산");
        	depAirportNameGot = getAirportNamebyId(depAirportIdGot);
        	getDepAirportName = "";
        }
        String getArrAirportId; // = getKoreaAirportList("김포");
        String getArrAirportName;
        if(arrAirportIdGot != null) {
        	getArrAirportId = arrAirportIdGot;
        	arrAirportNameGot = getAirportNamebyId(getArrAirportId);
        	getArrAirportName = arrAirportNameGot;
        } else {
        	getArrAirportId = getKoreaAirportList("김포");
        	arrAirportNameGot = getAirportNamebyId(getArrAirportId);
        	getArrAirportName = "";
        }
        // 날짜 조회
	        // 출발날짜 가지고오기
	        String getDepTime; // = "20230401";
        getDepTime = depDateGot;
        
        //항공사 목록 조회
        String getAirlineId = getAirCompanyList("티웨이항공");

        // 필수 요청 데이터 1.출발공항ID 2.도착공항ID 3.출발일(YYYYMMDD)
        urlBuilder.append("&" + URLEncoder.encode("depAirportId","UTF-8") + "=" + URLEncoder.encode(getDepAirportId, "UTF-8")); /*출발공항ID*/
        urlBuilder.append("&" + URLEncoder.encode("arrAirportId","UTF-8") + "=" + URLEncoder.encode(getArrAirportId, "UTF-8")); /*도착공항ID*/
        urlBuilder.append("&" + URLEncoder.encode("depPlandTime","UTF-8") + "=" + URLEncoder.encode(getDepTime, "UTF-8")); /*출발일(YYYYMMDD)*/
        //urlBuilder.append("&" + URLEncoder.encode("airlineId","UTF-8") + "=" + URLEncoder.encode(getAirlineId, "UTF-8")); /*항공사ID*/
      
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("\nairapiTago Response code: " + conn.getResponseCode());
        
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
        }
        
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        //System.out.println("국토교통부_(TAGO)_국내항공운항정보");
        //System.out.println(sb.toString());	
        rd.close();
        conn.disconnect();	
        
        // 데이터 추출 형식 설명
        //String airportNmCode = document
        //        .getElementsByTagName("airportNm")//태그명 추출
        //        .item(i)//추출한 태그명중 첫번째꺼 추출
        //        .getChildNodes()//태그 안에 있는 값 추출
        //		.item(0)//값중첫번째추출                
        //        .getNodeValue();//값추출
        //-------------------------------------------------------------------------------------------
        // 필요 데이터 추출해서 Map에 넣기
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document document = builder.parse(new InputSource(new StringReader(sb.toString())));
        
        // 필요 데이터의 총 갯수 totalCount 얻기
        totalCount = document.getElementsByTagName("totalCount").item(0).getChildNodes().item(0).getNodeValue();
        System.out.println("가는 항공편 검색의 totalCount는 : " + totalCount +" 개");
        int totalCountInt = Integer.parseInt(totalCount);
        
        // xml 코드 맵에 넣어보자!
        //Map<String, Object> airMap=new HashMap<String, Object>();	// 전역변수 (맨 위)로 변경
        
        // 배열 생성
        String[] vihicleIdArray 	= new String[totalCountInt];
        String[] airlineNmArray 	= new String[totalCountInt];
        String[] depPlandTimeArray 	= new String[totalCountInt];
        String[] arrPlandTimeArray 	= new String[totalCountInt];
        String[] economyChargeArray = new String[totalCountInt];
        String[] prestigeChargeArray= new String[totalCountInt];
        String[] depAirportNmArray 	= new String[totalCountInt];
        String[] arrAirportNmArray 	= new String[totalCountInt];
        
        NodeList items = document.getElementsByTagName("item");
    	
        for(int i=0; i<totalCountInt; i++) {
        	String vihicleId = document.getElementsByTagName("vihicleId").item(i).getChildNodes().item(0).getNodeValue();
        	vihicleIdArray[i] = vihicleId;
        	String airlineNm = document.getElementsByTagName("airlineNm").item(i).getChildNodes().item(0).getNodeValue();
        	airlineNmArray[i] = airlineNm;
        	
        	String depPlandTime = document.getElementsByTagName("depPlandTime").item(i).getChildNodes().item(0).getNodeValue();
        	depPlandTimeArray[i] = dateFormatChange(depPlandTime);
        	String arrPlandTime = document.getElementsByTagName("arrPlandTime").item(i).getChildNodes().item(0).getNodeValue();
        	arrPlandTimeArray[i] = dateFormatChange(arrPlandTime);
        	
        	Element item = (Element) items.item(i);
    	    NodeList economyChargeList = item.getElementsByTagName("economyCharge");
    	    if (economyChargeList.getLength() > 0) {
    	        String economyCharge = economyChargeList.item(0).getChildNodes().item(0).getNodeValue();
    	        economyChargeArray[i] = economyCharge;
    	    } else { economyChargeArray[i] = "98420"; }
    	    NodeList prestigeChargeList = item.getElementsByTagName("prestigeCharge");
    	    if (prestigeChargeList.getLength() > 0) {
    	        String prestigeCharge = prestigeChargeList.item(0).getChildNodes().item(0).getNodeValue();
    	        if(prestigeCharge.equals("0")) {
    	        	prestigeChargeArray[i] = "해당없음";
    	        } else {
    	        	prestigeChargeArray[i] = prestigeCharge;
    	        }
    	    } else { prestigeChargeArray[i] = "150000"; }
        	
        	String depAirportNm = document.getElementsByTagName("depAirportNm").item(i).getChildNodes().item(0).getNodeValue();
        	depAirportNmArray[i] = depAirportNm;	
        	String arrAirportNm = document.getElementsByTagName("arrAirportNm").item(i).getChildNodes().item(0).getNodeValue();
        	arrAirportNmArray[i] = arrAirportNm;
        }
        
        // Map에 배열 저장
    	airMap.put("vihicleId", vihicleIdArray);
        airMap.put("airlineNm", airlineNmArray);
        airMap.put("depPlandTime", depPlandTimeArray);
        airMap.put("arrPlandTime", arrPlandTimeArray);
        airMap.put("economyCharge", economyChargeArray);
        airMap.put("prestigeCharge", prestigeChargeArray);
        airMap.put("depAirportNm", depAirportNmArray);
        airMap.put("arrAirportNm", arrAirportNmArray);
        
        mav.addObject("airMap", airMap);
        mav.addObject("getDepAirportId", getDepAirportId);
        mav.addObject("getArrAirportId", getArrAirportId);
        mav.addObject("depAirportNameGot", depAirportNameGot);
        mav.addObject("arrAirportNameGot", arrAirportNameGot);
        mav.addObject("depDateGot", depDateGot);
        mav.addObject("totalCount", totalCount);
		mav.addObject("flagRadio", flagRadio);
		return mav;
	}
	
	// yyyyMMddHHmm to yyyy년mm월dd일 hh시mm분
	private String dateFormatChange(String dateNeedChangeType) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmm");
        LocalDateTime dateTime = LocalDateTime.parse(dateNeedChangeType, formatter);
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy년MM월dd일 HH시mm분");
        String formattedDateTime = dateTime.format(outputFormatter);
        
        return formattedDateTime;
	}
	//----------------------------------------------------------------------------------------------------------------------------------
	// 국토교통부_(TAGO)_국내항공운항정보	https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15098526
	@RequestMapping(value="/airapiTagoRnM.do", method=RequestMethod.GET)
	public ModelAndView FlightOperateInfoApiTAGOforRnM(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName=(String)request.getAttribute("searchGoodsAir.do");
		HttpSession session = request.getSession();
		ModelAndView mav = new ModelAndView(viewName);
		
		// 불러올 데이터 갯수
		String numOfData = "1000";
		
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getFlightOpratInfoList"); /*URL*/
		// 양하희 앱키
		urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=ZLRsuVs6duAB7q1FfN1oa5pEqA5WZHjva1IubQsMcphCTkoaEGgniTY6ReB%2BWvl6fwjL8f7lMZP3Bd3FgMSWcA%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(numOfData, "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); /*데이터 타입(xml, json)*/
        
        String getDepAirportId; // = getKoreaAirportList("김포");
        String getDepAirportName;
        if(arrAirportIdGot != null) {
        	getDepAirportId = arrAirportIdGot;
        	arrAirportNameGot = getAirportNamebyId(getDepAirportId);
        	getDepAirportName = arrAirportNameGot;
        	// RnM전역변수에 값 넣기
        	depAirportIdGotRnM = arrAirportIdGot;
        	depAirportNameGotRnM = arrAirportNameGot;
        } else {
        	getDepAirportId = getKoreaAirportList("김포");
        	arrAirportNameGot = getAirportNamebyId(getDepAirportId);
        	getDepAirportName = "";
        }
        
        String getArrAirportId; // = getKoreaAirportList("김포");
        String getArrAirportName;
        if(depAirportIdGot != null) {
        	getArrAirportId = depAirportIdGot;
        	depAirportNameGot = getAirportNamebyId(getArrAirportId);
        	getArrAirportName = depAirportNameGot;
        	// RnM전역변수에 값 넣기
        	arrAirportIdGotRnM = depAirportIdGot;
        	arrAirportNameGotRnM = depAirportNameGot;
        } else {
        	getArrAirportId = getKoreaAirportList("부산");
        	depAirportNameGot = getAirportNamebyId(depAirportIdGot);
        	getArrAirportName = "";
        }
        // 날짜 조회
        // 출발날짜 가지고오기
        String getDepTime; // = "20230401";
        getDepTime = arrDateGot;
        // 출발날짜 가지고오기
        
        // 필수 요청 데이터 1.출발공항ID 2.도착공항ID 3.출발일(YYYYMMDD)
        urlBuilder.append("&" + URLEncoder.encode("depAirportId","UTF-8") + "=" + URLEncoder.encode(getDepAirportId, "UTF-8")); /*출발공항ID*/
        urlBuilder.append("&" + URLEncoder.encode("arrAirportId","UTF-8") + "=" + URLEncoder.encode(getArrAirportId, "UTF-8")); /*도착공항ID*/
        urlBuilder.append("&" + URLEncoder.encode("depPlandTime","UTF-8") + "=" + URLEncoder.encode(getDepTime, "UTF-8")); /*출발일(YYYYMMDD)*/
        //urlBuilder.append("&" + URLEncoder.encode("airlineId","UTF-8") + "=" + URLEncoder.encode(getAirlineId, "UTF-8")); /*항공사ID*/
      
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("\nairapiTagoRnM Response code: " + conn.getResponseCode());
        
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
        }
        
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        //System.out.println("국토교통부_(TAGO)_국내항공운항정보");
        //System.out.println(sb.toString());	
        rd.close();
        conn.disconnect();	
        
        // 필요 데이터 추출해서 Map에 넣기
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document document = builder.parse(new InputSource(new StringReader(sb.toString())));
        
        // 필요 데이터의 총 갯수 totalCount 얻기
        totalCount2 = document.getElementsByTagName("totalCount").item(0).getChildNodes().item(0).getNodeValue();
        System.out.println("오는 항공편 검색의 totalCount2(왕복/다구간 ver)는 : " + totalCount2 +" 개");
        int totalCountInt = Integer.parseInt(totalCount2);
        
        // xml 코드 맵에 넣어보자!
        Map<String, Object> airMap2=new HashMap<String, Object>();
        
        // 배열 생성
        String[] vihicleIdArray 	= new String[totalCountInt];
        String[] airlineNmArray 	= new String[totalCountInt];
        String[] depPlandTimeArray 	= new String[totalCountInt];
        String[] arrPlandTimeArray 	= new String[totalCountInt];
        String[] economyChargeArray = new String[totalCountInt];
        String[] prestigeChargeArray= new String[totalCountInt];
        String[] depAirportNmArray 	= new String[totalCountInt];
        String[] arrAirportNmArray 	= new String[totalCountInt];
        
        NodeList items = document.getElementsByTagName("item");
    	
        for(int i=0; i<totalCountInt; i++) {
        	String vihicleId = document.getElementsByTagName("vihicleId").item(i).getChildNodes().item(0).getNodeValue();
        	vihicleIdArray[i] = vihicleId;
        	String airlineNm = document.getElementsByTagName("airlineNm").item(i).getChildNodes().item(0).getNodeValue();
        	airlineNmArray[i] = airlineNm;
        	
        	String depPlandTime = document.getElementsByTagName("depPlandTime").item(i).getChildNodes().item(0).getNodeValue();
        	depPlandTimeArray[i] = dateFormatChange(depPlandTime);
        	String arrPlandTime = document.getElementsByTagName("arrPlandTime").item(i).getChildNodes().item(0).getNodeValue();
        	arrPlandTimeArray[i] = dateFormatChange(arrPlandTime);
        	
        	Element item = (Element) items.item(i);
    	    NodeList economyChargeList = item.getElementsByTagName("economyCharge");
    	    if (economyChargeList.getLength() > 0) {
    	        String economyCharge = economyChargeList.item(0).getChildNodes().item(0).getNodeValue();
    	        economyChargeArray[i] = economyCharge;
    	    } else { economyChargeArray[i] = "98420"; }
    	    NodeList prestigeChargeList = item.getElementsByTagName("prestigeCharge");
    	    if (prestigeChargeList.getLength() > 0) {
    	        String prestigeCharge = prestigeChargeList.item(0).getChildNodes().item(0).getNodeValue();
    	        if(prestigeCharge.equals("0")) {
    	        	prestigeChargeArray[i] = "해당없음";
    	        } else {
    	        	prestigeChargeArray[i] = prestigeCharge;
    	        }
    	    } else { prestigeChargeArray[i] = "150000"; }
        	
        	String depAirportNm = document.getElementsByTagName("depAirportNm").item(i).getChildNodes().item(0).getNodeValue();
        	depAirportNmArray[i] = depAirportNm;	
        	String arrAirportNm = document.getElementsByTagName("arrAirportNm").item(i).getChildNodes().item(0).getNodeValue();
        	arrAirportNmArray[i] = arrAirportNm;
        }
        
        // 기존(편도, 가는) 항공권 Map에 배열 저장
        mav.addObject("airMap", airMap);
        mav.addObject("getDepAirportId", depAirportIdGot);
        mav.addObject("getArrAirportId", arrAirportIdGot);
        mav.addObject("depAirportNameGot", depAirportNameGot);
        mav.addObject("arrAirportNameGot", arrAirportNameGot);
        mav.addObject("depDateGot", depDateGot);
        mav.addObject("totalCount", totalCount);
        
        // Map에 배열 저장
    	airMap2.put("vihicleId", vihicleIdArray);
        airMap2.put("airlineNm", airlineNmArray);
        airMap2.put("depPlandTime", depPlandTimeArray);
        airMap2.put("arrPlandTime", arrPlandTimeArray);
        airMap2.put("economyCharge", economyChargeArray);
        airMap2.put("prestigeCharge", prestigeChargeArray);
        airMap2.put("depAirportNm", depAirportNmArray);
        airMap2.put("arrAirportNm", arrAirportNmArray);
        
        mav.addObject("airMap2", airMap2);
        mav.addObject("getDepAirportIdRnM", depAirportIdGotRnM);
        mav.addObject("getArrAirportIdRnM", arrAirportIdGotRnM);
        mav.addObject("depAirportNameGotRnM", depAirportNameGotRnM);
        mav.addObject("arrAirportNameGotRnM", arrAirportNameGotRnM);
        mav.addObject("arrDateGot", arrDateGot);
        mav.addObject("totalCount2", totalCount2);
		mav.addObject("flagRadio", flagRadio);
		return mav;
	}
	
	//----------------------------------------------------------------------------------------------------------------------------------
	
	
	// 문자열에서 문자열 찾는 함수
	public static int countString(String text, String strToFind) {
	    int count = 0;
	    int index = 0;
	    while ((index = text.indexOf(strToFind, index)) != -1) {
	        count++;
	        index += strToFind.length();
	    }
	    return count;
	}
	// 국토교통부_(TAGO)_국내항공운항정보 - 공항 목록 조회
	private String getKoreaAirportList(String airportName) throws Exception {
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getArprtList"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=ZLRsuVs6duAB7q1FfN1oa5pEqA5WZHjva1IubQsMcphCTkoaEGgniTY6ReB%2BWvl6fwjL8f7lMZP3Bd3FgMSWcA%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); /*데이터 타입(xml, json)*/

        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        //System.out.println("\n\nResponse code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();

        //System.out.println("공항 갯수 : " + countString(sb.toString(), "<item>"));
        //System.out.println("공항 목록 조회");
        //System.out.println(sb.toString());
        
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document document = builder.parse(new InputSource(new StringReader(sb.toString())));
        
        for(int i=0; i<countString(sb.toString(), "<item>"); i++) {
        	String airportNmCode = document
                    .getElementsByTagName("airportNm")//태그명 추출
                    .item(i)//추출한 태그명중 첫번째꺼 추출
                    .getChildNodes()//태그 안에 있는 값 추출
    				.item(0)//값중첫번째추출                
                    .getNodeValue();//값추출
        	if(airportNmCode.equals(airportName)) { 
        		String resultCode = document
                        .getElementsByTagName("airportId")//태그명 추출
                        .item(i)//추출한 태그명중 첫번째꺼 추출
                        .getChildNodes()//태그 안에 있는 값 추출
        				.item(0)//값중첫번째추출                
                        .getNodeValue();//값추출
                //System.out.println("airportId -> " + resultCode); 
                return resultCode;
                //break;
        	}
        }
        return null;
    }
	// 국토교통부_(TAGO)_국내항공운항정보 - 공항 아이디로 공항 이름 조회
	private String getAirportNamebyId(String airportId) throws Exception {
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getArprtList"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=ZLRsuVs6duAB7q1FfN1oa5pEqA5WZHjva1IubQsMcphCTkoaEGgniTY6ReB%2BWvl6fwjL8f7lMZP3Bd3FgMSWcA%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); /*데이터 타입(xml, json)*/

        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        //System.out.println("\n\nResponse code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document document = builder.parse(new InputSource(new StringReader(sb.toString())));
        
        for(int i=0; i<countString(sb.toString(), "<item>"); i++) {
        	String airportNmCode = document
                    .getElementsByTagName("airportId")//태그명 추출
                    .item(i)//추출한 태그명중 첫번째꺼 추출
                    .getChildNodes()//태그 안에 있는 값 추출
    				.item(0)//값중첫번째추출                
                    .getNodeValue();//값추출
        	if(airportNmCode.equals(airportId)) { 
        		String resultCode = document
                        .getElementsByTagName("airportNm")//태그명 추출
                        .item(i)//추출한 태그명중 첫번째꺼 추출
                        .getChildNodes()//태그 안에 있는 값 추출
        				.item(0)//값중첫번째추출                
                        .getNodeValue();//값추출
                //System.out.println(airportId + "의 airportName -> " + resultCode); 
                return resultCode;
                //break;
        	}
        }
        return null;
    }
	// 국토교통부_(TAGO)_국내항공운항정보 - 항공사 목록 조회
	private String getAirCompanyList(String airlineName) throws Exception {

        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getAirmanList"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=ZLRsuVs6duAB7q1FfN1oa5pEqA5WZHjva1IubQsMcphCTkoaEGgniTY6ReB%2BWvl6fwjL8f7lMZP3Bd3FgMSWcA%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); /*데이터 타입(xml, json)*/
        
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        //System.out.println("\n\nResponse code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        
        //System.out.println("항공사 갯수 : " + countString(sb.toString(), "<item>"));
        //System.out.println("항공사 목록 조회");
        //System.out.println(sb.toString());
        
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document document = builder.parse(new InputSource(new StringReader(sb.toString())));
        
        for(int i=0; i<countString(sb.toString(), "<item>"); i++) {
        	String airlineNmCode = document
                    .getElementsByTagName("airlineNm")//태그명 추출
                    .item(i)//추출한 태그명중 첫번째꺼 추출
                    .getChildNodes()//태그 안에 있는 값 추출
    				.item(0)//값중첫번째추출                
                    .getNodeValue();//값추출
        	if(airlineNmCode.equals(airlineName)) { 
        		String resultCode = document
                        .getElementsByTagName("airlineId")//태그명 추출
                        .item(i)//추출한 태그명중 첫번째꺼 추출
                        .getChildNodes()//태그 안에 있는 값 추출
        				.item(0)//값중첫번째추출                
                        .getNodeValue();//값추출
                //System.out.println("airlineId -> " + resultCode); 
                return resultCode;
                //break;
	      	}
	      }
	      return null;
    }
	@RequestMapping(value="/getDataForSearchAir.do" ,method={RequestMethod.POST})
	public void getDepAirportId(@RequestParam("airportDepId") String airportDepId,
								@RequestParam("airportDepName") String airportDepName,
								@RequestParam("airportArrId") String airportArrId,
								@RequestParam("airportArrName") String airportArrName,
								@RequestParam("depDate") String depDate,
            HttpServletRequest request, HttpServletResponse response)  throws Exception {
		try {
			System.out.println("******************검색 조건 데이터********************");
			System.out.println("출발 지역 : " + airportDepId);
			System.out.println("출발 지역 : " + airportDepName);
			System.out.println("도착 지역 : " + airportArrId);
			System.out.println("도착 지역 : " + airportArrName);
			System.out.println("출발 날짜 : " + depDate);
			
			depAirportIdGot = airportDepId;
			depAirportNameGot = airportDepName;
			arrAirportIdGot = airportArrId;
			arrAirportNameGot = airportArrName;
			depDateGot = depDate;
			flagRadio = "o";
			System.out.println("flagRadio : " + flagRadio);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value="/getDataForSearchAirRnM.do" ,method={RequestMethod.POST})
	public void getDepAirportId(@RequestParam("arrDate") String arrDate,
            HttpServletRequest request, HttpServletResponse response)  throws Exception {
		try {
			System.out.println("#################검색 조건 추가 데이터###################");
			//System.out.println("도착 날짜 : " + arrDate);
			
			arrDateGot = arrDate;
			// 왕복일 경우, 출발-도착 지역 change
			arrAirportIdGotRnM = depAirportIdGot;
			arrAirportNameGotRnM = depAirportNameGot;
			depAirportIdGotRnM = arrAirportIdGot;
			depAirportNameGotRnM = arrAirportNameGot;
			flagRadio = "r";
			System.out.println("flagRadio : " + flagRadio);
			System.out.println("출발 지역 : " + depAirportIdGotRnM);
			System.out.println("출발 지역 : " + depAirportNameGotRnM);
			System.out.println("도착 지역 : " + arrAirportIdGotRnM);
			System.out.println("도착 지역 : " + arrAirportNameGotRnM);
			System.out.println("출발 날짜 : " + depDateGot);
			System.out.println("도착 날짜 : " + arrDate);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Autowired
	private CartStayVO cartStayVO;
	@Autowired
	private CartAirVO cartAirVO;
	@Autowired
	private CartService cartService;
	@Autowired
	private OrderService orderService;
	
	@RequestMapping(value="/test0404.do", method=RequestMethod.POST)
	public @ResponseBody ModelAndView test0404(@RequestParam("stay_values") List stay_values, @RequestParam("air_values") List air_values,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName = (String)request.getAttribute("viewName");
		response.setContentType("text/html; charset=UTF-8");
		System.out.println(stay_values);
		System.out.println(air_values);
		
		int count = 0;
		Map stayMap = new HashMap();
		
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		String _mem_id = memberVO.getMem_id();
		
		cartStayVO.setMem_id(_mem_id);
		cartAirVO.setMem_id(_mem_id);
		ModelAndView mav = new ModelAndView();
		if(stay_values != null) {
		for (Object value : stay_values) {
		    System.out.println(value);
		    System.out.println(value.getClass());
		    int _stay_id = Integer.parseInt((String) value);
		    
		    cartStayVO.setCart_stay_id(_stay_id);
		    Map<String ,List> cartStayMap=orderService.myStayCartList(cartStayVO);
		    stayMap.put("stayMap"+count, cartStayMap);
		    mav.addObject("stayMap"+count, cartStayMap);
		    count++;
			}
		}
		System.out.println(stayMap);
		
		System.out.println(count);
		
		mav.addObject("stayMap", stayMap);
		
		System.out.println(stayMap.get("stayMap0"));
		Map test = (Map) stayMap.get("stayMap0");
		System.out.println();
		System.out.println(test);
		
		List testList = (List) test.get("myGoodsList");
		System.out.println(test.get("myGoodsList"));
		
		testList.get(0);
		
		mav.setViewName("main");
		return mav;
	}
}