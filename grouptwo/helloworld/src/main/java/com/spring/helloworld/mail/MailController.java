package com.spring.helloworld.mail;

import java.io.PrintWriter;
import java.security.SecureRandom;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.helloworld.business.service.BusinessService;
import com.spring.helloworld.business.vo.BusinessVO;
import com.spring.helloworld.member.service.MemberService;
import com.spring.helloworld.member.vo.MemberVO;

@Controller
@EnableAsync
public class MailController {
	@Autowired
	private MailService mailService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BusinessService businessService;
	
	//메일 보내기(일반 회원가입)
		@RequestMapping(value = "/sendMemberMail.do", method = RequestMethod.POST)
		public ResponseEntity<Void> sendMemberMail(@RequestParam("mem_email1") String mem_email1, @RequestParam("mem_email2") String mem_email2, @RequestParam("certi_num")
		String num, HttpServletRequest request, HttpServletResponse response)throws Exception{
			
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
				
				StringBuffer sb = new StringBuffer();
					sb.append("<html><body>");
						sb.append("<meta http-equiv='Content-Type' content='text/html;charset=euc-kr'>");
						sb.append("<h1>"+"회원가입"+"</h1><br>");
						sb.append("회원가입(이메일) 인증번호는"+num+"입니다.<br><br>");
						sb.append("만약 이메일인증을 요청하지 않으셨다면 즉시 <br>고객센터에 문의하여 무단 회원가입을 방지해 주세요.");
						sb.append("</body></html>");
						String str = sb.toString();
				//수신자, 제목, 내용
				mailService.sendMail(mem_email1+"@"+mem_email2, "[helloWorld]회원가입 인증번호", str);
				//성공 적인 요청이라는 상태를 응답해줌 (200ok)
	     		return ResponseEntity.ok().build();
		}
		
		//메일 보내기(사업자 회원가입)
				@RequestMapping(value = "/sendBusinessMail.do", method = RequestMethod.POST)
				public ResponseEntity<Void> sendBusinessMail(@RequestParam("busi_email1") String busi_email1, @RequestParam("busi_email2") String busi_email2, @RequestParam("certi_num")
				String num, HttpServletRequest request, HttpServletResponse response)throws Exception{
					
					request.setCharacterEncoding("utf-8");
					response.setContentType("text/html;charset=utf-8");
						
						StringBuffer sb = new StringBuffer();
							sb.append("<html><body>");
								sb.append("<meta http-equiv='Content-Type' content='text/html;charset=euc-kr'>");
								sb.append("<h1>"+"회원가입"+"</h1><br>");
								sb.append("회원가입(이메일) 인증번호는"+num+"입니다.<br><br>");
								sb.append("만약 이메일인증을 요청하지 않으셨다면 즉시 <br>고객센터에 문의하여 무단 회원가입을 방지해 주세요.");
								sb.append("</body></html>");
								String str = sb.toString();
						//수신자, 제목, 내용
						mailService.sendMail(busi_email1+"@"+busi_email2, "[helloWorld]회원가입 인증번호", str);
						//성공 적인 요청이라는 상태를 응답해줌 (200ok)
			     		return ResponseEntity.ok().build();
				}
				
	//메일 보내기(일반회원 비밀번호 찾기)
	@RequestMapping(value = "/sendMail.do", method = RequestMethod.POST)
	public ModelAndView sendMemberMail(HttpServletRequest request, HttpServletResponse response)throws Exception{
		String mem_id = (String)request.getParameter("mem_id");
		String mem_email1 = (String)request.getParameter("mem_email1");
		String mem_email2 = (String)request.getParameter("mem_email2");


		MemberVO vo = memberService.selectMemberID(mem_id);
		String email1 = vo.getMem_email1();
		String email2 = vo.getMem_email2();
		if(vo != null && email1.equals(mem_email1) && email2.equals(mem_email2)) {
			SecureRandom r = new SecureRandom();
			int num = r.nextInt(888888)+111111; // 랜덤난수설정
			
	
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			
			StringBuffer sb = new StringBuffer();
				sb.append("<html><body>");
					sb.append("<meta http-equiv='Content-Type' content='text/html;charset=euc-kr'>");
					sb.append("<h1>"+"비밀번호찾기"+"</h1><br>");
					sb.append("비밀번호찾기(변경) 인증번호는"+num+"입니다.<br><br>");
					sb.append("만약 비밀번호찾기 코드를 요청하지 않으셨다면 즉시 <br>비밀번호를 변경하여 무단 로그인을 방지해 주세요.");
					sb.append("</body></html>");
					String str = sb.toString();
			//수신자, 제목, 내용
			mailService.sendMail(email1+"@"+email2, "[helloWorld]비밀번호찾기 인증번호", str);
			ModelAndView mav = new ModelAndView();
			HttpSession session = request.getSession();
			session = request.getSession();
			session.setAttribute("memberPwFind", vo);
			session.setAttribute("num", num);
			mav.setViewName("forward:/member/findCerti.do");
     		return mav;
		}else {
			ModelAndView mav = new ModelAndView();
			String message = "아이디 또는 이메일이 일치하지 않습니다. 다시 입력해 주세요";
			mav.addObject("message",message);
			mav.setViewName("/member/findPwForm");
			return mav;
		}
	}
	
	//메일 보내기(사업자 비밀번호 찾기)
		@RequestMapping(value = "/sendBusiMail.do", method = RequestMethod.POST)
		public ModelAndView sendBusiMail(HttpServletRequest request, HttpServletResponse response)throws Exception{
			String busi_id = (String)request.getParameter("busi_id");
			String busi_email1 = (String)request.getParameter("busi_email1");
			String busi_email2 = (String)request.getParameter("busi_email2");
			String busi_brn = (String)request.getParameter("busi_brn");


			BusinessVO vo = businessService.selectMemberID(busi_id);
			String email1 = vo.getBusi_email1();
			String email2 = vo.getBusi_email2();
			String brn = vo.getBusi_brn();
			if(vo != null && email1.equals(busi_email1) && email2.equals(busi_email2) && brn.equals(busi_brn)) {
				SecureRandom r = new SecureRandom();
				int num = r.nextInt(888888)+111111; // 랜덤난수설정
				
		
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
				PrintWriter out = response.getWriter();
				
				StringBuffer sb = new StringBuffer();
					sb.append("<html><body>");
						sb.append("<meta http-equiv='Content-Type' content='text/html;charset=euc-kr'>");
						sb.append("<h1>"+"비밀번호찾기"+"</h1><br>");
						sb.append("비밀번호찾기(변경) 인증번호는"+num+"입니다.<br><br>");
						sb.append("만약 비밀번호찾기 코드를 요청하지 않으셨다면 즉시 <br>비밀번호를 변경하여 무단 로그인을 방지해 주세요.");
						sb.append("</body></html>");
						String str = sb.toString();
				//수신자, 제목, 내용
				mailService.sendMail(email1+"@"+email2, "[helloWorld]비밀번호찾기 인증번호", str);
				ModelAndView mav = new ModelAndView();
				HttpSession session = request.getSession();
				session = request.getSession();
				session.setAttribute("businessPwFind", vo);
				session.setAttribute("num", num);
				mav.setViewName("forward:/member/findCerti.do");
	     		return mav;
			}else {
				ModelAndView mav = new ModelAndView();
				String message = "아이디 또는 이메일 또는 사업자번호가 일치하지 않습니다. 다시 입력해 주세요";
				mav.addObject("message",message);
				mav.setViewName("/member/findPwForm");
				return mav;
			}
		}
	
}

