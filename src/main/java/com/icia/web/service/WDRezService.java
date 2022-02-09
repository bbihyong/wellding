package com.icia.web.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.web.dao.WDCouponDao;
import com.icia.web.dao.WDRezDao;
import com.icia.web.model.WDRez;

@Service ("wdRezService")
public class WDRezService {

	private static Logger logger = LoggerFactory.getLogger(WDRezService.class);
	
	@Autowired
	private WDRezDao wdRezDao;
	
	@Autowired
	private WDCouponDao wdCouponDao;
	
	//예약 테이블 값 가져오기
	/*
	public WDRez rezSelect(String userId) 
	{
		WDRez wdRez = null;
		
		try 
		{
			wdRez = wdRezDao.rezSelect(userId);
		}
		catch(Exception e) 
		{
			logger.error("[WDRezService] rezSelect Exception", e);
		}
		
		return wdRez;
	}
	*/
	public WDRez rezSelect(WDRez wdRez) 
	{
		try 
		{
			wdRez = wdRezDao.rezSelect(wdRez);
		}
		catch(Exception e) 
		{
			logger.error("[WDRezService] rezSelect Exception", e);
		}
		
		return wdRez;
	}
	
	
	//예약 게시물 총 수 
	public long rezListCount(WDRez wdRez)
	{
		long count = 0;
		
		try
		{
			count = wdRezDao.rezListCount();
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] rezListCount Exception", e);
		}
		return count;
	}
	
	//결제내역 리스트 검색값 조회
	public long rezSearchCount(WDRez wdRez)
	{
		long count = 0;
		
		try
		{
			count = wdRezDao.rezSearchCount(wdRez);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] rezSearchCount Exception", e);
		}
		
		return count;
	}
	
	//아이디를 통해 예약건수가 있는지 확인
	public int checkRez(String userId) 
	{
		int count = 0;
		
		try 
		{
			count = wdRezDao.checkRez(userId);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] checkRez");
		}
		
		return count;
	}
	
	//예약 번호를 부여함.
	public long rezNoInsert(WDRez wdRez) 
	{
		long cnt = 0;
		
		try 
		{
			cnt = wdRezDao.rezNoInsert(wdRez);
		}
		catch(Exception e) 
		{
			logger.error("[WDRezService] rezNoInsert Exception", e);
		}
		
		return cnt;
	}
	
	//예약 현황 조회
	public WDRez rezList(WDRez wdRez)
	{
		
		try
		{
			wdRez = wdRezDao.rezList(wdRez);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] rezList Exception", e);
		}
		return wdRez;
	}
	
	//홀 예약 추가
	public long rezHallInsert(WDRez wdRez)
	{
		long count = 0;
		
		try
		{
			count = wdRezDao.rezHallInsert(wdRez);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] rezHallInsert Exception", e);
		}
		
		return count;
	}
	
	//스튜디오 예약 추가
	public long rezStudioInsert(WDRez wdRez)
	{
		long count = 0;
		
		try
		{
			count = wdRezDao.rezStudioInsert(wdRez);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] rezHallInsert Exception", e);
		}
		
		return count;
	}
	
	//드레스 예약 추가
	public long rezDressInsert(WDRez wdRez)
	{
		long count = 0;
		
		try
		{
			count = wdRezDao.rezDressInsert(wdRez);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] rezHallInsert Exception", e);
		}
		
		return count;
	}
	
	//메이크업 예약 추가
	public long rezMakeupInsert(WDRez wdRez)
	{
		long count = 0;
		
		try
		{
			count = wdRezDao.rezMakeupInsert(wdRez);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] rezHallInsert Exception", e);
		}
		
		return count;
	}
	
	//예약날짜 추가
	public long rezWDateInsert(WDRez wdRez)
	{
			long count = 0;
		
		try
		{
			count = wdRezDao.rezWDateInsert(wdRez);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] rezHallInsert Exception", e);
		}
		
		return count;
	}
	
	//예약 총 가격 
	public long rezFullPriceInsert(WDRez wdRez)
	{
		long count = 0;
		
		try
		{
			count = wdRezDao.rezFullPriceInsert(wdRez);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] rezHallInsert Exception", e);
		}
		
		return count;
	}
	
	//장바구니에서 홀 제거
	public int rezHallUpdate(WDRez wdRez) 
	{
		int cnt = 0;
		
		try 
		{
			cnt = wdRezDao.rezHallUpdate(wdRez);
		}
		catch(Exception e) 
		{
			logger.error("[WDRezService] rezHallUpdate Exception", e);			
		}
		
		return cnt;
	}
	
	//장바구니에서 스튜디오 제거
	public int rezStudioUpdate(WDRez wdRez) 
	{
		int cnt = 0;
		
		try 
		{
			cnt = wdRezDao.rezStudioUpdate(wdRez);
		}
		catch(Exception e) 
		{
			logger.error("[WDRezService] rezStudioUpdate Exception", e);
		}
		
		return cnt;
	}
	
	//장바구니에서 드레스 제거
	public int rezDressUpdate(WDRez wdRez) 
	{
		int cnt = 0;
		
		try 
		{
			cnt = wdRezDao.rezDressUpdate(wdRez);
		}
		catch(Exception e) 
		{
			logger.error("[WDRezService] rezDressUpdate Exception", e);
		}
		
		return cnt;
	}
	
	//장바구니에서 메이크업 제거
	public int rezMakeupUpdate(WDRez wdRez) 
	{
		int cnt = 0;
		
		try 
		{
			cnt = wdRezDao.rezMakeupUpdate(wdRez);
		}
		catch(Exception e) 
		{
			logger.error("[WDRezService] rezMakeupUpdate Exception", e);
		}
		
		return cnt;
	}
	
	
	//카카오페이 성공 시 업데이트 문, 쿠폰까지 넣어주고, 사용한 쿠폰도 업데이트 해야 함.
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int rezUpdatePay(WDRez wdRez) throws Exception
	{
		int count = 0;

		count = wdRezDao.rezUpdatePay(wdRez);
		
		wdCouponDao.QRrezNoInsert(wdRez.getRezNo());
		
		if(count > 0) 
		{
			logger.debug("[여긴타니!!!!!1????]");
			int cnt = wdCouponDao.couponStatusUpdate(wdRez.getUserId());
			
			if(cnt <= 0) 
			{
				count = 0;
			}
			else 
			{
				int x = wdRezDao.rezUpdateStatusAfC(wdRez.getUserId());
				if( x <= 0) 
				{
					count = 0;
				}
			}
		}
		return count;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int rezUpdatePayNoC(WDRez wdRez) throws Exception
	{
		int count = 0;
		
		count = wdRezDao.rezUpdatePay(wdRez);
		
		wdCouponDao.QRrezNoInsert(wdRez.getRezNo());
		
		if(count > 0) 
		{
			int x = wdRezDao.rezUpdateStatusAfC(wdRez.getUserId());
			if(x <= 0) 
			{
				count = 0;
			}
		}
		
		return count;
	}
	
	//결제 리스트 페이지
		public List<WDRez> rezSelectList(String userId)
		{
			List<WDRez> list = null;
			
			try 
			{
				list = wdRezDao.rezSelectList(userId);
			}
			catch(Exception e) 
			{
				logger.error("[WDRezService] rezSelectList Exception", e);

			}
			
			return list;
		}
	
	//결제 취소 신청 승인
    public int rezCancelApprove(String rezNo) {
			
		int count = 0;
		
		try
		{
			count = wdRezDao.rezCancelApprove(rezNo);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] rezCancelApprove", e);
		}
		
		return count;
	}
	
	// 관리자 사이트에서 결제 내역 리스트 조회하기
	public List<WDRez> rezAdminSelect (WDRez wdRez)
	{
		List<WDRez> list = null;
		
		try
		{
			list = wdRezDao.rezAdminSelect(wdRez);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] rezAdminSelect Exception", e);
		}	
		
			return list;
		}	
	
	
	//결제 취소시 포인트 환불
	public int rezPointReturn(HashMap<String, Object> map) {
	
		int count = 0;
		
		try
		{
			count = wdRezDao.rezPointReturn(map);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] rezPointReturn", e);
		}
		
		return count;
	}
	
	//환불 요청 수락 후 결제금액 삭제
	public int rezCancelComplete(WDRez wdRez)
	{
		int count = 0;
		
		try
		{
			count = wdRezDao.rezCancelComplete(wdRez);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] rezCancelComplete", e);
		}
		return count;
	}
	
	//환불요청시 상태창 변경
	public int rezCancelPayment(WDRez wdRez)
	{
		int count = 0;
		
		try
		{
			count = wdRezDao.rezCancelPayment(wdRez);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] rezCancelPayment Exception", e);
		}
		
		return count;
	}
	
	public WDRez listSelect(String rezNo)
	{
		WDRez wdRez = null;
		
		try
		{
			wdRez = wdRezDao.listSelect(rezNo);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] listSelect Exception", e);
		}
		
		return wdRez;
	}

	/*	밑에 트랜젝션 오류나면 이걸로 해야겟어용
	//포인트 사용시 결제테이블 포인트 추가
	public int rezPointUpdate(WDRez wdRez)
	{
		int count = 0;
		
		try
		{
			count = wdRezDao.rezPointUpdate(wdRez);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] rezPointUpdate Exception", e);
		}
		
		return count;
	}
	
	//유저테이블 보유 포인트 감소
	public int userPointMinus(WDRez wdRez)
	{
		int count = 0;
		
		try
		{
			count = wdRezDao.userPointMinus(wdRez);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] userPointMinus Exception", e);
		}
		
		return count;
	}
	*/
	//포인트 사용시 업데이트문, 결제 테이블 포인트 추가, 보유포인트 감소
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int rezPointUpdate(WDRez wdRez) throws Exception
	{
		int count = 0;
		
		count = wdRezDao.rezPointUpdate(wdRez);
		
		if(count > 0)
		{
			int cnt = wdRezDao.userPointMinus(wdRez);
		}
		
		return count;
	}
	
	
	//의수 추가
	//해당 날짜에 해당 홀 예약 확인
	public int isHallRez(WDRez wdRez) 
	{
		int count = 0;
		
		try 
		{
			count = wdRezDao.isHallRez(wdRez);
		}
		catch(Exception e) 
		{
			logger.error("[WDRezService] isHallRez Exception", e);
		}
		
		return count;
	}
	
	//해당 날짜에 해당 스튜디오 예약되어있는지 확인
	public int isStudioRez(WDRez wdRez) 
	{
		int count = 0;
		
		try 
		{
			count = wdRezDao.isStudioRez(wdRez);
		}
		catch(Exception e) 
		{
			logger.error("[WDRezService] isStudioRez Exception", e);
		}
		
		return count;
	}
	
	
	//해당 날짜에 해당 드레스 예약되어있는지 확인
	//해당 날짜에 해당 드레스 예약 확인
	public int isDressRez(WDRez wdRez) 
	{
		int count = 0;
		
		try 
		{
			count = wdRezDao.isDressRez(wdRez);
		}
		catch(Exception e) 
		{
			logger.error("[WDRezService] isDressRez Exception", e);
		}
		
		return count;
	}
	
	
	//해당 날짜에 해당 메이크업 업체 예약되어 있는지 확인
	//해당 날짜에 해당 메이크업 업체 예약 확인
	public int isMakeUpRez(WDRez wdRez) 
	{
		int count = 0;
		
		try 
		{
			count = wdRezDao.isMakeUpRez(wdRez);
		}
		catch(Exception e) 
		{
			logger.error("[WDRezService] isMakeUpRez Exception", e);
		}
		
		return count;
	}
	//장바구니 결혼날짜
	public int MarrydateUpdate(WDRez wdRez) {
		int count = 0;
		
		try 
		{
			count = wdRezDao.MarrydateUpdate(wdRez);
		}
		catch(Exception e) 
		{
			logger.error("[WDRezService] MarrydateUpdate Exception", e);
		}
		
		return count;
	}
	
	
	//결제 취소 신청&취소완료된 내역 가져오기
	public List<WDRez> rezSelectStatusNotNY(String userId)
	{
		List<WDRez> list = null;
		
		try 
		{
			list = wdRezDao.rezSelectStatusNotNY(userId);
		}
		catch(Exception e) 
		{
			logger.error("[WDRezService] rezSelectStatusNotNY Exception", e);
		}
		
		return list;
	}
	
	//결제 취소 리스트에서 홀스드메 내역 가져오기
	public WDRez detailView(String rezNo)
	{
		WDRez wdRez = null;

		try
		{
			wdRez = wdRezDao.detailView(rezNo);
		}
		catch(Exception e)
		{
			logger.error("[WDRezService] detailView Exception", e);
		}
		
		return wdRez;
	}
	
	//회원 삭제 시 결제내역 조회, WDATE가 현재 날짜보다 큰 결제 숫자 가져오기 시작
	public int checkRezWdate(String userId) 
	{
		int count = 0;
		
		try 
		{
			count = wdRezDao.checkRezWdate(userId);
		}
		catch(Exception e) 
		{
			logger.error("[WDRezService] checkRezWdate Exception", e);
		}
		
		return count;
	}
	
   	////예약날짜 불러오기
   	public String onlyWDate(String rezNo) 
   	{
   		String wDate = "";
   		
   		try 
   		{
   			wDate = wdRezDao.onlyWDate(rezNo);
   		}
		catch(Exception e)
		{
			logger.error("[WDRezService] onlyWDate Exception", e);
		}
   		
   		return wDate;
   	}
   	
   	////스튜디오날짜 불러오기
   	public String onlySDate(String rezNo) 
   	{
   		String sDate = "";
   		
   		try 
   		{
   			sDate = wdRezDao.onlySDate(rezNo);
   		}
		catch(Exception e)
		{
			logger.error("[WDRezService] onlySDate Exception", e);
		}
   		
   		return sDate;
   	}
	
	
}
