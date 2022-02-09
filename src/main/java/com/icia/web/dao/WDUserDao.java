
package com.icia.web.dao;

import java.util.List;

import com.icia.web.model.WDUser;


public interface WDUserDao
{

	public int userInsert(WDUser wduser);

	public int userUpdate(WDUser wduser);

	public WDUser userSelect(String userId);
	
	public int wdUserIdCount(String userId);
	
	public int checkInsert(WDUser wduser);
	
	public WDUser checkSelect(int uCheck);
	
	public int userDrop(WDUser wduser);
	
	//장바구니 예약번호가 없는 상태에서 결혼예정일 업데이트
	public int nonRezNumberMarrydateUpdate(WDUser wduser);
	
	//이메일로 아이디 찾기
	public List<WDUser> findId(String userEmail);
	
	//비밀번호찾기
	public int findPwd(WDUser wduser);
	
	public WDUser findPwdSelectUser(WDUser wdUser);
	
}
