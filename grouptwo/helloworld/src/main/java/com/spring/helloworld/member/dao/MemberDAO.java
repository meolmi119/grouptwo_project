package com.spring.helloworld.member.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.helloworld.member.vo.MemberVO;

public interface MemberDAO {
	
	//로그인
	public MemberVO login(Map loginMap) throws DataAccessException;
	
	//회원가입
	public void insertNewMember(MemberVO memberVO) throws DataAccessException;
	
	//아이디 중복검사
	public String selectOverlappedID(String id) throws DataAccessException;
	
	//탈퇴
	public void unregister(String id) throws DataAccessException;
	
	//회원조회(아이디 찾기)
	public MemberVO selectMember(Map selectMap)throws DataAccessException;
	
	//회원조회(비밀번호 찾기)
	public MemberVO selectMemberID(String id) throws DataAccessException;
	
	//관리자 회원조회(전체)
	public List selectAllMember() throws DataAccessException;
	
	//관리자 탈퇴
	public int unregisterAdmin(String id) throws DataAccessException;
}
