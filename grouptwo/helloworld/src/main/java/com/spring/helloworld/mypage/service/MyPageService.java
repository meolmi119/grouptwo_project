package com.spring.helloworld.mypage.service;

import java.util.Map;

import com.spring.helloworld.business.vo.BusinessVO;
import com.spring.helloworld.member.vo.MemberVO;

public interface MyPageService {
	public MemberVO modifyMyInfo(Map memberMap) throws Exception;
	public MemberVO modifyKakaoInfo(Map memberMapKakao) throws Exception;
	public BusinessVO modifyMyBusiInfo(Map businessMap) throws Exception;
}
