package com.icia.web.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.WDCoupon;

@Repository("wdCouponDao")
public interface WDCouponDao {
   
   public List<WDCoupon> couponSelectList(String userId);
   
   //결제 시 , 쿠폰 정보를 가져와서 해당 유저의 해당 쿠폰 업데이트
   public int couponStatusUpdate(String userId);

	//결제 완료된 내역에서 결제중 쿠폰 정보를 가져오기 시작
	public WDCoupon couponSelectPayOk(HashMap<String, Object> map);
	
	//쿠폰 조회, 사용가능한 상태나 사용한 상태에 따라서 다르게 불러올 수 있는 쿼리(욱채꺼 수정 ㅡ_ㅡ;;)
	public List<WDCoupon> couponList(WDCoupon wdCoupon);
	
	public int couponInsert(String userId);
	
	public int QRrezNoInsert(String rezNo);
	
	public int qrCodeMPlus(String rezNo);
	
	public int qrCodeFPlus(String rezNo);
	
	public WDCoupon cntSelect(String rezNo);

	//해당 계정에 이벤트 쿠폰이 1개 이상 있는지 카운트 
	public int selectCoupon(String userId);
	
	//이벤트 쿠폰 발급하기
	public WDCoupon downloadCoupon(String userId);
	
	//결제 취소인 내역에서 결제중 쿠폰 정보를 가져오기 시작
	public WDCoupon couponSelectCancelOk(HashMap<String, Object> map);
	
}

