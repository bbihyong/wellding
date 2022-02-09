package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.WDHall;
import com.icia.web.model.WDHallFile;

@Repository("wdHallDao")
public interface WDHallDao {																																										

	//홀 랭킹 조회
	public List<WDHall> WDHallRanking();
	
	//홀 조회
	public WDHall WDHallSelect(WDHall wdHall);
	
	//홀 첨부파일 조회
	public WDHallFile WDHallFileSelect(WDHallFile wdHallFile);
	
	//홀 리스트
	public List<WDHall> WDHallList(WDHall wdHall);
	
	//홀 개수 체크
	public long WDHallListCount(WDHall wdHall);
	
	//동일회사 홀 리스트 조회 선택된 홀 제외
	public List<WDHall> hallSameCom(WDHall wdHall);
	
	//웨딩홀 추가
	public int weddinghallInsert(WDHall wdHall);
	
	//웨딩홀 마지막 wh코드 불러오기
	public String maxWHCode();
	
	//홀 마지막 h코드 불러오기
	public long maxHCode(String whCode);
	
	//홀 추가 인서트
	public int hallInsert(WDHall wdHall);
	
	//홀 코드 이름 조회
	public List<WDHall> whNameAndCode();
																																																																																																																																													
	//예약 성공 시 해당 예약번호의 홀 REZCOUNT +1해주기
	public int rezCountPlus(String rezNo);
	
	public WDHall onlyWeddingHall(String whCode);
	
	public int weddingHallDelete(String whCode);
	
	public int hallDelete(WDHall wdHall);
	
	public int weddinghallUpdate(WDHall wdHall);
	
	public int hallUpdate(WDHall wdHall);
	
	public String maxImgName();
	
	//홀 파일 삽입
	public int hallFileInsert(WDHallFile wdHallFile);
}
