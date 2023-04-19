package com.spring.helloworld.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.helloworld.member.vo.MemberVO;

@Repository("memberDAO")
public class MemberDAOImpl implements MemberDAO{
	@Autowired
	private SqlSession sqlSession;
	//로그인
	@Override
	public MemberVO login(Map loginMap) throws DataAccessException {
		MemberVO member = (MemberVO)sqlSession.selectOne("mapper.member.login",loginMap);
		return member;
	}
	
	//회원가입
	//DataAccessException 데이터 액세스 과정에서 예외 대처
	@Override
	public void insertNewMember(MemberVO memberVO) throws DataAccessException{
		sqlSession.insert("mapper.member.insertNewMember",memberVO);
	}
	
	//아이디 중복 확인
	@Override
	public String selectOverlappedID(String id) throws DataAccessException {
		String result =  sqlSession.selectOne("mapper.member.selectOverlappedID",id);
		return result;
	}
	
	//회원탈퇴
	@Override
	public void unregister(String id) throws DataAccessException {
		sqlSession.delete("mapper.member.unregisterMember",id);
		
	}
	//회원조회(아이디찾기)
	public MemberVO selectMember(Map selectMap)throws DataAccessException{
		MemberVO memberInfo = (MemberVO)sqlSession.selectOne("mapper.member.selectMember",selectMap);
		return memberInfo;
	}
	
	//회원조회(비밀번호찾기)
	@Override
	public MemberVO selectMemberID(String id) throws DataAccessException {
		MemberVO result =  sqlSession.selectOne("mapper.member.selectMemberID",id);
		return result;
	}
	
	//관리자 회원조회(전체)
	@Override
	public List selectAllMember() throws DataAccessException{
		List<MemberVO> memList = sqlSession.selectList("mapper.member.selectAllMember");
		return memList;
	}
	//회원탈퇴
	@Override
	public int unregisterAdmin(String id) throws DataAccessException {
		int result = sqlSession.delete("mapper.member.unregisterMember",id);
		return result;
	}
	
}
