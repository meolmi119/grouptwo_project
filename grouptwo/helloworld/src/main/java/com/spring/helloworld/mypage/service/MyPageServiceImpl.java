package com.spring.helloworld.mypage.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.helloworld.business.vo.BusinessVO;
import com.spring.helloworld.member.vo.MemberVO;
import com.spring.helloworld.mypage.dao.MyPageDAO;
@Service("myPageService")
@Transactional(propagation = Propagation.REQUIRED)
public class MyPageServiceImpl implements MyPageService{
	@Autowired
	private MyPageDAO myPageDAO;
	
	@Override
	public MemberVO  modifyMyInfo(Map memberMap) throws Exception{
		 String mem_id=(String)memberMap.get("mem_id");
		 myPageDAO.updateMyInfo(memberMap);
		 return myPageDAO.selectMyDetailInfo(mem_id);
	}
	
	@Override
	public MemberVO  modifyKakaoInfo(Map memberMapKakao) throws Exception{
		 String mem_id=(String)memberMapKakao.get("mem_id");
		 myPageDAO.updateKakaoInfo(memberMapKakao);
		 return myPageDAO.selectMyDetailInfo(mem_id);
	}
	
	@Override
	public BusinessVO  modifyMyBusiInfo(Map businessMap) throws Exception{
		 String busi_id=(String)businessMap.get("busi_id");
		 myPageDAO.updateMyBusiInfo(businessMap);
		 return myPageDAO.selectMyDetailBusiInfo(busi_id);
	}
}
