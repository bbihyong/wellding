package com.icia.web.service;

import javax.inject.Inject;
import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.icia.web.model.EmailDTO;

@Service
public class EmailServiceImpl implements EmailService
{
	@Inject
	JavaMailSender mailSenderGoogle;
	
	//전문가에게 이메일보내기 !
	@Override
	public void sendMail(EmailDTO dto) 
	{
		try
		{
			MimeMessage msg = mailSenderGoogle.createMimeMessage(); //이메일 객체
			
			//수신자 정보
			msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiveMail()));
			//발신자 이메일주소, 이름
			msg.addFrom(new InternetAddress[] {
				new InternetAddress(dto.getSenderMail(), dto.getSenderName())
			});
			
			//메일제목
			msg.setSubject("[ "+dto.getSenderName()+" ]님의 견적요청", "utf-8"); 
			
			//메일내용
			msg.setText("[ " + dto.getReceiverName() + " ]님에게 요청하는 견적내용입니다. \r\n \r\n" + 
					"고객명 : " + dto.getSenderName() + 
					dto.getSenderName() + " 님의 연락처 : "+ dto.getSenderNumber() +
					"\n\r" + dto.getSenderName() + " 님의 메일주소 : " + dto.getSenderMail() + 
					"\n\r" + "\r\n <요청사항> \r\n" + dto.getMessage(), "utf-8");
			
			mailSenderGoogle.send(msg); //이메일 발신
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	//회원가입시 이메일인증번호 보내기!
	@Override
	public int checkMail(EmailDTO dto) {
		double randomVal = Math.random();
		int check = (int)(randomVal *999999)+100000;
		
		try
		{
			MimeMessage msg = mailSenderGoogle.createMimeMessage(); //이메일 객체
			//수신자 정보
			msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiveMail()));
			//발신자 이메일주소, 이름
			msg.addFrom(new InternetAddress[] {
				new InternetAddress(dto.getSenderMail(), dto.getSenderName())
			});
			
			msg.setSubject("웰딩(Wellding) 인증번호 입니다.", "utf-8"); //제목
			msg.setText("인증번호 [ " + check + " ]를 입력란에 입력해주세요" , "utf-8"); //텍스트
			mailSenderGoogle.send(msg); //이메일 발신
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return check;
	}

	//임시 비밀번호 보내기

	@Override
	public String pwdMail(EmailDTO dto) {

       char[] tmp = new char[8];
			for(int i=0; i<tmp.length; i++) {
				int div = (int) Math.floor( Math.random() * 2 );
				
				if(div == 0) { // 0이면 숫자로
					tmp[i] = (char) (Math.random() * 10 + '0') ;
				}else { //1이면 알파벳
					tmp[i] = (char) (Math.random() * 26 + 'A') ;
				}
			}
		
		String tpwd = new String(tmp);
			
		try
		{
			MimeMessage msg = mailSenderGoogle.createMimeMessage(); //이메일 객체
			//수신자 정보
			msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiveMail()));
			//발신자 이메일주소, 이름
			msg.addFrom(new InternetAddress[] {
				new InternetAddress(dto.getSenderMail(), dto.getSenderName())
			});
			
			msg.setSubject("웰딩(Wellding) 임시비밀번호 입니다.", "utf-8"); //제목
			msg.setText("임시비밀번호는  [ " + tpwd + " ] 입니다." , "utf-8"); //텍스트
			mailSenderGoogle.send(msg); //이메일 발신
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}	
		
		return tpwd;
	}
}
