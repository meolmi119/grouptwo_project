package com.spring.helloworld.member.service;

import java.util.List;
import java.util.Map;

import com.spring.helloworld.member.vo.MemberVO;

public interface MemberService {
	public MemberVO login(Map loginMap) throws Exception;
	public void addMember(MemberVO memberVO) throws Exception;
	public String overlapped(String id) throws Exception;
	public void unregister(String id) throws Exception;
	public int unregisterAdmin(String id) throws Exception;
	public MemberVO selectMember(Map selectMap)throws Exception;
	public MemberVO selectMemberID(String id) throws Exception;
	public List<MemberVO> listMember() throws Exception;
}