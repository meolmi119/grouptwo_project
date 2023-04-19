package com.spring.helloworld.mail;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Service;
@Service("mailService")
public class MailService {
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private SimpleMailMessage preConfiguredMessage;
	
	@Async
	// 수신자, 제목, 내용
	//MimeMessage 이메일 작성 표현, JavaMailSender 이메일 보내는 api
	public void sendMail(String to, String subject, String body) {
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");
			messageHelper.setFrom("r99auto@gmail.com", "helloWorld");
			messageHelper.setSubject(subject);
			messageHelper.setTo(to);
			messageHelper.setText(body,true);
			mailSender.send(message);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
