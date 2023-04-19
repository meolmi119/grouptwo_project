package com.spring.helloworld.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.helloworld.member.dao.MemberDAO;
import com.spring.helloworld.member.vo.MemberVO;

@Service("memberService")
@Transactional(propagation = Propagation.REQUIRED)
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDAO memberDAO;
	
	//로그인
	@Override
	public MemberVO login(Map loginMap) throws Exception {
		return memberDAO.login(loginMap);
	}
	
	//회원가입
	@Override
	public void addMember(MemberVO memberVO) throws Exception{
		memberDAO.insertNewMember(memberVO);
	}
	
	//아이디 중복 확인
	@Override
	public String overlapped(String id) throws Exception{
		return memberDAO.selectOverlappedID(id);
	}
	
	//회원탈퇴
	@Override
	public void unregister(String id) throws Exception {
		memberDAO.unregister(id);
		
	}
	
	//회원조회(아이디 찾기)
	@Override
	public MemberVO selectMember(Map selectMap)throws Exception{
		return memberDAO.selectMember(selectMap);
	}
	
	//회원조회(비밀번호 찾기)
	@Override
	public MemberVO selectMemberID(String id) throws Exception{
		return memberDAO.selectMemberID(id);
	}
	//관리자 회원조회(전체)
	@Override
	public List<MemberVO> listMember()throws Exception{
		List<MemberVO> memList =  memberDAO.selectAllMember();
		return memList;
	}
	//관리자 회원탈퇴
	@Override
	public int unregisterAdmin(String id) throws Exception {
		int result = memberDAO.unregisterAdmin(id);
		return result;
		
	}
	
}