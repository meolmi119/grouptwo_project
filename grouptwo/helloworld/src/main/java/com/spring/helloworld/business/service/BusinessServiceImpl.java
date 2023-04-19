package com.spring.helloworld.business.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.helloworld.business.dao.BusinessDAO;
import com.spring.helloworld.business.vo.BusinessVO;

@Service("businessService")
@Transactional(propagation = Propagation.REQUIRED)
public class BusinessServiceImpl implements BusinessService{
	@Autowired
	private BusinessDAO businessDAO;
	//로그인
	@Override
	public BusinessVO login(Map loginMap) throws Exception {
		return businessDAO.login(loginMap);
	}
	//회원가입
	@Override
	public void addMember(BusinessVO businessVO) throws Exception{
		businessDAO.insertNewMember(businessVO);
	}
	//아이디 중복검사
	@Override
	public String overlapped(String id) throws Exception{
		return businessDAO.selectOverlappedID(id);
	}
	//회원탈퇴
	@Override
	public void unregister(String id) throws Exception {
		businessDAO.unregister(id);
	}
	//회원조회(아이디찾기)
	@Override
	public BusinessVO selectMember(Map selectMap)throws Exception{
		return businessDAO.selectMember(selectMap);
	}
	
	//회원조회(비밀번호 찾기)
	@Override
	public BusinessVO selectMemberID(String id) throws Exception{
		return businessDAO.selectMemberID(id);
	}
	//관리자 사업자조회(전체)
	@Override
	public List<BusinessVO> listBusiness()throws Exception{
		List<BusinessVO> busiList =  businessDAO.selectAllBusiness();
		return busiList;
	}
}
