package com.icia.web.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.dao.WDCouponDao;
import com.icia.web.model.WDCoupon;

@Service("WDCouponService")
public class WDCouponService {

	
	private static Logger logger = LoggerFactory.getLogger(WDCouponService.class);
	
	@Autowired
	private WDCouponDao wdCouponDao;
	
	public List<WDCoupon> couponSelectList(String userId) {
		
		List<WDCoupon> wdCoupon = null;
		try {
			wdCoupon = wdCouponDao.couponSelectList(userId);
		}
		catch(Exception e) {
			logger.error("[WDCouponService] couponSelect Exception", e);
		}
		
		return wdCoupon;
	}
	
	
	
	//결제 완료된 내역에서 결제중 쿠폰 정보를 가져오기 시작
	public WDCoupon couponSelectPayOk(HashMap<String, Object> map) 
	{
		WDCoupon wdCoupon = null;
		
		try 
		{
			wdCoupon = wdCouponDao.couponSelectPayOk(map);
		}
		catch(Exception e) 
		{
			logger.error("[WDCouponService] couponSelectPayOk Exception", e);
		}
		
		return wdCoupon;
	}
	
	
	//쿠폰 조회, 사용가능한 상태나 사용한 상태에 따라서 다르게 불러올 수 있는 쿼리(욱채꺼 수정 ㅡ_ㅡ;;)
	public List<WDCoupon> couponList(WDCoupon wdCoupon)
	{
		List<WDCoupon> list = null;
		
		try 
		{
			list = wdCouponDao.couponList(wdCoupon);
		}
		catch(Exception e) 
		{
			logger.error("[WDCouponService] couponList Exception", e);
		}
		
		return list;
	}
	
	//신규 회원가입 웰컴 쿠폰
	public int couponInsert(String userId)
	{
		int count = 0;
		
		try
		{
			count = wdCouponDao.couponInsert(userId);
		}
		catch(Exception e) 
		{
			logger.error("[WDCouponService] couponInsert Exception 신규회원가입 쿠폰 오류임", e);
		}
		
		return count;
	}
	
	public int qrCodeMPlus(String rezNo) {
		
		int count = 0;
		
		try {
			count = wdCouponDao.qrCodeMPlus(rezNo);
		}
		catch(Exception e) 
		{
			logger.error("[WDCouponService] qrCodeMPlus Exception", e);
		}
		return count;
	}
	
	public int qrCodeFPlus(String rezNo) {
		
		int count = 0;
		
		try {
			count = wdCouponDao.qrCodeFPlus(rezNo);
		}
		catch(Exception e) 
		{
			logger.error("[WDCouponService] qrCodeFPlus Exception", e);
		}
		return count;
	}
	
	public WDCoupon cntSelect(String rezNo) {
		
		WDCoupon wdCoupon = null;
		
		try {
			wdCoupon = wdCouponDao.cntSelect(rezNo);
		}
		catch(Exception e) 
		{
			logger.error("[WDCouponService] qrCodeFPlus Exception", e);
		}
		
		return wdCoupon;
	}
	

	//해당 계정에 이벤트 쿠폰이 1개 이상 있는지 카운트 
	public int selectCoupon(String userId)
	{
		int count = 0;
		
		try
		{
			count = wdCouponDao.selectCoupon(userId);
		}
		catch(Exception e)
		{
			logger.error("[WDCouponService] selectCoupon Exception", e);
		}
		return count;
	}
	
	//이벤트 쿠폰 발급하기
	public WDCoupon downloadCoupon(String userId)
	{
		WDCoupon wdCoupon = null;
		
		try
		{
			wdCoupon = wdCouponDao.downloadCoupon(userId);
		}
		catch(Exception e)
		{
			logger.error("[WDCouponService] downloadCoupon Exception", e);
		}
		return wdCoupon;
	}
	
	//결제 취소인 내역에서 결제중 쿠폰 정보를 가져오기 시작
	public WDCoupon couponSelectCancelOk(HashMap<String, Object> map) 
	{
		WDCoupon wdCoupon = null;
		
		try 
		{
			wdCoupon =  wdCouponDao.couponSelectCancelOk(map);
		}
		catch(Exception e) 
		{
			logger.error("[WDCouponService] couponSelectCancelOk Exception", e);
		}
		
		return wdCoupon;
	}
	
}

