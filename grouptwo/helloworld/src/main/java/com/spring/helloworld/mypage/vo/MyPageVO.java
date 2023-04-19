package com.spring.helloworld.mypage.vo;

import org.springframework.stereotype.Component;

@Component("mypageVO")
public class MyPageVO {
	private String mem_id;

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	
}
