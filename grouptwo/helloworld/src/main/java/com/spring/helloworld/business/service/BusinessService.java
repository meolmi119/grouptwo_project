package com.spring.helloworld.business.service;

import java.util.List;
import java.util.Map;

import com.spring.helloworld.business.vo.BusinessVO;
import com.spring.helloworld.member.vo.MemberVO;

public interface BusinessService {
	public BusinessVO login(Map loginMap) throws Exception;
	public void addMember(BusinessVO businessVO) throws Exception;
	public String overlapped(String id) throws Exception;
	public void unregister(String id) throws Exception;
	public BusinessVO selectMember(Map selectMap)throws Exception;
	public BusinessVO selectMemberID(String id) throws Exception;
	public List<BusinessVO> listBusiness() throws Exception;
}
