package com.spring.helloworld.business.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.helloworld.business.vo.BusinessVO;

@Repository("businessDAO")
public class BusinessDAOImpl implements BusinessDAO{
	@Autowired
	private SqlSession sqlSession;	
	//로그인
	@Override
	public BusinessVO login(Map loginMap) throws DataAccessException{
		BusinessVO member=(BusinessVO)sqlSession.selectOne("mapper.business.busilogin",loginMap);
	   return member;
	}
	//회원가입
	@Override
	public void insertNewMember(BusinessVO businessVO) throws DataAccessException{
		sqlSession.insert("mapper.business.insertNewBusi",businessVO);
	}
	//아이디 중복검사
	@Override
	public String selectOverlappedID(String id) throws DataAccessException {
		String result =  sqlSession.selectOne("mapper.business.selectOverlappedbusiID",id);
		return result;
	}
	//회원탈퇴
	@Override
	public void unregister(String id) throws DataAccessException {
		sqlSession.delete("mapper.business.unregisterBusiness",id);
	}
	//회원조회(아이디찾기)
	@Override
	public BusinessVO selectMember(Map selectMap) throws DataAccessException{
		BusinessVO memberInfo = (BusinessVO)sqlSession.selectOne("mapper.business.selectMember",selectMap);
		return memberInfo;
	}
	//회원조회(비밀번호찾기)
	@Override
	public BusinessVO selectMemberID(String id) throws DataAccessException {
		BusinessVO result =  sqlSession.selectOne("mapper.business.selectMemberID",id);
		return result;
	}
	//관리자 사업자조회(전체)
		@Override
		public List selectAllBusiness() throws DataAccessException{
			List<BusinessVO> busiList = sqlSession.selectList("mapper.business.selectAllBusiness");
			return busiList;
		}

}
