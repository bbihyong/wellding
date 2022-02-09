package com.icia.web.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.WDRez;

@Repository("wdRezDao")
public interface WDRezDao {
	
	//public WDRez rezSelect(String userId);
	public WDRez rezSelect(WDRez wdRez);
	
	//예약 내역 조회를 위한 셀렉트 메소드
	public WDRez rezList(WDRez wdRez);
	
	//예약 게시물 총 수 
	public long rezListCount();
	
	//결제내역 리스트 검색값 조회
	public long rezSearchCount(WDRez wdRez);
	
	//아이디로 예약현황 확인. 1개라도 있으면 추가 예약번호 부여하지 않음.
	public int checkRez(String userId);
	
	//작성중이던 예약 기록이 없거나 예약이 결제완료 상태면 예약번호 생성
	public long rezNoInsert(WDRez wdRez);
	
	//예약번호와 아이디를 비교하여 홀 데이터 삽입 시작
	public long rezHallInsert(WDRez wdRez);
	
	public long rezStudioInsert(WDRez wdRez);
	
	public long rezDressInsert(WDRez wdRez);
	
	public long rezMakeupInsert(WDRez wdRez);
	
	public long rezWDateInsert(WDRez wdRez);
	
	public long rezFullPriceInsert(WDRez wdRez);
	
	//업데이트문은 건수로 리턴하는데 long타입은 너무 불필요하게 큰 데이터 타입이라 int로 변경합니다.
	public int rezStudioUpdate(WDRez wdRez);
	   
	public int rezDressUpdate(WDRez wdRez);
	   
	public int rezMakeupUpdate(WDRez wdRez);
	   
	public int rezHallUpdate(WDRez wdRez);
	
	//카카오페이 성공 시 업데이트 문
	public int rezUpdatePay(WDRez wdRez);
	
	//쿠폰까지 삽입되면, 그제서야 상태 Y로 변경
	public int rezUpdateStatusAfC(String userId);
	
	//결제 완료된 내역 가져오기
	public List<WDRez> rezSelectList(String userId);
	
	//결제 취소 승인
	public int rezCancelApprove(String rezNo);
		
	//관리자 페이지에서 조회하는 결제 내역 리스트
	public List<WDRez> rezAdminSelect(WDRez wdRez);
		
	//결제 후 결제 취소시 포인트로 환급
	public int rezPointReturn(HashMap<String, Object> map);
	
	//결제 후 결제 취소시 결제 총금액 삭제
	public int rezCancelComplete(WDRez wdRez);
	
	//환불요청시 상태창 변경
	public int rezCancelPayment(WDRez wdRez);
	
	//결제 취소 상태 조회
	public WDRez listSelect(String rezNo);

	//포인트 사용
	public int rezPointUpdate(WDRez wdRez);
	
	//보유 포인트 감소
	public int userPointMinus(WDRez wdRez);
	
	
	//의수 추가
	//해당 날짜에 해당 홀 예약 확인
	public int isHallRez(WDRez wdRez);
	
	//해당 날짜에 해당 스튜디오 예약 확인
	public int isStudioRez(WDRez wdRez);

	//해당 날짜에 해당 드레스 예약 확인
	public int isDressRez(WDRez wdRez);
	
	//해당 날짜에 해당 메이크업 업체 예약 확인
	public int isMakeUpRez(WDRez wdRez);
	
	//장바구니 결혼날짜 변경
	public int MarrydateUpdate(WDRez wdRez);
	
	
	//결제 취소 신청&취소완료된 내역 가져오기
	public List<WDRez> rezSelectStatusNotNY(String userId);
	
	//결제 내역 리스트에서 홀스드메 상세 보기
	public WDRez detailView(String rezNo);
	
	//회원 삭제 시 결제내역 조회, WDATE가 현재 날짜보다 큰 결제 숫자 가져오기 시작
	public int checkRezWdate(String userId);
	
	//예약날짜,스튜디오날짜 불러오기
	public String onlyWDate(String rezNo);
	public String onlySDate(String rezNo);
}
