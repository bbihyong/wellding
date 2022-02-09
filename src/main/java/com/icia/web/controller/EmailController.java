package com.icia.web.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.web.model.EmailDTO;
import com.icia.web.model.Response;
import com.icia.web.model.WDExpert;
import com.icia.web.model.WDUser;
import com.icia.web.service.EmailService;
import com.icia.web.service.WDExpertService;
import com.icia.web.service.WDUserService;
import com.icia.web.util.HttpUtil;

@Controller
//@RequestMapping("/board/*")
public class EmailController 
{
	@Inject
	EmailService emailService;
	
	@Autowired
	private WDUserService wduserService;
	
	@Autowired
	private WDExpertService wdExpertService;
	
	@RequestMapping("/board/send.do")
	public String send(EmailDTO dto, Model model,HttpServletRequest request)
	{	
		
		String eCode = HttpUtil.get(request, "eCode", "");
		WDExpert wdExpert = null;
		
		wdExpert = wdExpertService.expertSelect(eCode);
		
		model.addAttribute("wdExpert",wdExpert);
		try
		{
			emailService.sendMail(dto); //이메일발송
			System.out.println("여긴타니111111111");
			model.addAttribute("message", "이메일이 발송되었습니다.");
		}
		catch(Exception e)
		{
			System.out.println("여긴타니222222222222");
			e.printStackTrace();
			model.addAttribute("message", "이메일이 발송실패,,");
		}
		
		System.out.println("여긴타니33333333");
		return "/board/gosu";
	}

	
	@RequestMapping("/board/check.do")
	@ResponseBody
	public Response<Object> emailCheck(EmailDTO dto, Model model){
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		WDUser wdUser = new WDUser();
		
		int uCheck = 0;
		
		System.out.println("==============================================");
		System.out.println("EamilDTO : " + dto );
		System.out.println("==============================================");
		
        char[] tmp = new char[10];
			for(int i=0; i<tmp.length; i++) {
				int div = (int) Math.floor( Math.random() * 2 );
				
				if(div == 0) { // 0이면 숫자로
					tmp[i] = (char) (Math.random() * 10 + '0') ;
				}else { //1이면 알파벳
					tmp[i] = (char) (Math.random() * 26 + 'A') ;
				}
			}
		String ran = new String(tmp);
		
		wdUser.setUserId(ran);
		wdUser.setUserNickname(ran);
		wdUser.setUserEmail(ran);
		
		try
		{
			uCheck = emailService.checkMail(dto); //이메일발송
			wdUser.setuCheck(uCheck);
			wduserService.checkInsert(wdUser);
			ajaxResponse.setResponse(0, "Success");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			ajaxResponse.setResponse(-1, "Fail");
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping("/board/tpwd.do")
	@ResponseBody
	public Response<Object> tpwd(EmailDTO dto, Model model,HttpServletRequest request)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userId = HttpUtil.get(request, "id","");
		String userName = HttpUtil.get(request, "name", "");
		String userEmail = HttpUtil.get(request, "email", "");
		
		WDUser wdUser = new WDUser(); 
		
		try
		{
			wdUser.setUserId(userId);;
			wdUser.setUserName(userName);
			wdUser.setUserEmail(userEmail);
			
			WDUser tempUser = null;
			tempUser = wduserService.findPwdSelectUser(wdUser);
			if(tempUser == null) {
				ajaxResponse.setResponse(400, "Bad Request");
				return ajaxResponse;
			}
			
			String pwdTemp = emailService.pwdMail(dto);
			
			wdUser.setUserPwd(pwdTemp);
			if(wduserService.findPwd(wdUser) > 0)
			{
				ajaxResponse.setResponse(0, "Success");
			}
			else {
				ajaxResponse.setResponse(-1, "Fail");
			}			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			ajaxResponse.setResponse(-1, "Fail");
		}
		
		return ajaxResponse;
	}
	
	
}
