package com.spring.helloworld.business.dao;

import java.util.List;
import java.util.Map;
import org.springframework.dao.DataAccessException;
import com.spring.helloworld.business.vo.BusinessVO;
import com.spring.helloworld.member.vo.MemberVO;

public interface BusinessDAO {
	
	//로그인
	public BusinessVO login(Map loginMap) throws DataAccessException;
	
	//사업자가입
	public void insertNewMember(BusinessVO biBusinessVO) throws DataAccessException;
	
	//아이디 중복검사
	public String selectOverlappedID(String id) throws DataAccessException;
	
	//탈퇴
	public void unregister(String id) throws DataAccessException;
	
	//사업자조회(아이디 찾기)
	public BusinessVO selectMember(Map selectMap)throws DataAccessException;
	
	//사업자조회(비밀번호 찾기)
	public BusinessVO selectMemberID(String id) throws DataAccessException;
	
	//관리자 사업자조회(전체)
	public List selectAllBusiness() throws DataAccessException;
}
