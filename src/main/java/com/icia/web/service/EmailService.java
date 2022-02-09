package com.icia.web.service;

import com.icia.web.model.EmailDTO;

public interface EmailService
{
	public void sendMail(EmailDTO dto);
	
	public int checkMail(EmailDTO dto);
	
	public String pwdMail(EmailDTO dto);
}
