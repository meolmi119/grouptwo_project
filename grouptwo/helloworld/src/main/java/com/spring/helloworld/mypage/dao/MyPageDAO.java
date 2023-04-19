package com.spring.helloworld.mypage.dao;

import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.helloworld.business.vo.BusinessVO;
import com.spring.helloworld.member.vo.MemberVO;

public interface MyPageDAO {
	public void updateMyInfo(Map memberMap) throws DataAccessException;
	public void updateKakaoInfo(Map memberMapKakao) throws DataAccessException;
	public MemberVO selectMyDetailInfo(String mem_id) throws DataAccessException;
	public void updateMyBusiInfo(Map businessMap) throws DataAccessException;
	public BusinessVO selectMyDetailBusiInfo(String busi_id) throws DataAccessException;
}
