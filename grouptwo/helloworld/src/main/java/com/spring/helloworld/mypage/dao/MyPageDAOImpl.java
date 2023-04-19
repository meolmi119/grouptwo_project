package com.spring.helloworld.mypage.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.helloworld.business.vo.BusinessVO;
import com.spring.helloworld.member.vo.MemberVO;

@Repository("myPageDAO")
public class MyPageDAOImpl implements MyPageDAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void updateMyInfo(Map memberMap) throws DataAccessException{
		sqlSession.update("mapper.mypage.updateMyInfo",memberMap);
	}
	@Override
	public void updateKakaoInfo(Map memberMapKakao) throws DataAccessException{
		sqlSession.update("mapper.mypage.updateKakaoInfo",memberMapKakao);
	}
	@Override
	public MemberVO selectMyDetailInfo(String mem_id) throws DataAccessException{
		MemberVO memberVO=(MemberVO)sqlSession.selectOne("mapper.mypage.selectMyDetailInfo",mem_id);
		return memberVO;
	}
	@Override
	public void updateMyBusiInfo(Map businessMap) throws DataAccessException{
		sqlSession.update("mapper.mypage.updateMyBusiInfo",businessMap);
	}
	@Override
	public BusinessVO selectMyDetailBusiInfo(String busi_id) throws DataAccessException{
		BusinessVO businessVO=(BusinessVO)sqlSession.selectOne("mapper.mypage.selectMyDetailBusiInfo",busi_id);
		return businessVO;
	}
}
