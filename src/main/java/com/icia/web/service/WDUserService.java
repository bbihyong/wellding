package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.dao.WDUserDao;
import com.icia.web.model.WDUser;


@Service("WDUserService")
public class WDUserService 
{
	private static Logger logger = LoggerFactory.getLogger(WDUserService.class);

	
	@Autowired
	private WDUserDao wdUserDao;
	
	//유저 정보 가져오기.
	public WDUser userSelect(String userId)
	{
		WDUser wduser = null;
		
		try
		{
			wduser = wdUserDao.userSelect(userId);
		}
		catch(Exception e)
		{
			logger.error("[WDUserService] 오류 userSelect Exception", e );
		}
		
		return wduser;
		
	}
	
	//사용자 등록
	public int userInsert(WDUser wduser)
	{
		int count = 0;
		
		try
		{
			count = wdUserDao.userInsert(wduser);
		}
		catch(Exception e)
		{
			logger.error("[WDUserService] 오류 userInsert Exception", e );
		}
		
		return count;
	}
	
	//사용자 수정
	public int userUpdate(WDUser wduser)
	{
		int count = 0;
		
		try
		{
			count = wdUserDao.userUpdate(wduser);
		}
		catch(Exception e)
		{
			logger.error("[WDUserService] 오류 userUpdate Exception", e );
		}
		
		return count;
	}
	
	//아이디 존재 여부 확인
	public int wdUserIdCount(String userId) 
	{
		int count = 0;
		
		try 
		{
			count = wdUserDao.wdUserIdCount(userId);
		}
		catch(Exception e) 
		{
			logger.error("[WDUserService] wdUserIdCount Exception",e);
		}
		
		return count;
	}
	
	//가입전 이메일 인증을 위한 임시 값 삽입
	public int checkInsert(WDUser wduser) {
		
		int count = 0;
		
		try {
			count = wdUserDao.checkInsert(wduser);
		}
		catch(Exception e) 
		{
			logger.error("[WDUserService] checkInsert Exception",e);
		}
		
		return count;
	}
	
	//아이디 인증번호 체크
	public WDUser checkSelect(int uCheck) {
		
		WDUser wduser = null;
		
		try {
			wduser = wdUserDao.checkSelect(uCheck);
		}
		catch(Exception e) 
		{
			logger.error("[WDUserService] checkSelect Exception",e);
		}
		
		return wduser;
	}
	
	//회원탈퇴
	public int userDrop(WDUser wduser) {
		int count = 0;
		
		try {
			count = wdUserDao.userDrop(wduser);
		}
		catch(Exception e) 
		{
			logger.error("[WDUserService] userDrop Exception",e);
		}
		
		return count;
	}
	
	//예약번호없을때 결혼날짜 변경
	
	public int nonRezNumberMarrydateUpdate(WDUser wduser)
	{
		int count = 0;
		
		try
		{
			count = wdUserDao.nonRezNumberMarrydateUpdate(wduser);
		}
		catch(Exception e) 
		{
			logger.error("[WDUserService] nonRezNumberMarrydateUpdate Exception",e);
		}
		return count;
	}
	
	//이메일로 아이디 찾기
	public List<WDUser> findId(String userEmail)
	{
		List<WDUser> wduser = null;
		
		try
		{
			wduser = wdUserDao.findId(userEmail);
		}
		catch(Exception e) 
		{
			logger.error("[WDUserService] findId Exception",e);
		}
		return wduser;
	}
	
	//비밀번호 찾기
	public int findPwd(WDUser wduser)
	{		
		int count = 0;
		
		try {
			count = wdUserDao.findPwd(wduser);
		}
		catch(Exception e) 
		{
			logger.error("[WDUserService] findPwd Exception",e);
		}
		
		return count;
	}
	
	public WDUser findPwdSelectUser(WDUser wdUser) {
		WDUser tempUser = null; 		
		try {
			tempUser = wdUserDao.findPwdSelectUser(wdUser);
		}
		catch(Exception e) 
		{
			logger.error("[WDUserService] findPwdSelectUser Exception",e);
		}
		return tempUser;
	}
}
