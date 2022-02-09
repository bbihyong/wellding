package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.WDDress;
import com.icia.web.model.WDDressFile;

@Repository("WDDressDao")
public interface WDDressDao 
{
	//리스트 조회
	public List<WDDress> dressList(WDDress wdDress);
	
	//게시물 총 수
	public long dressListCount(WDDress wdDress);
	
	//조회
	public WDDress dressSelect(String dNo);
	
	//동일 회사 드레스 조회, 동일제품은 제외
	public List<WDDress> dressSameCom(WDDress wdDress);
	
	//드레스 랜덤가져오기
	public List<WDDress> dressRandom(WDDress wdDress);
	
	//드레스 예약내역 제외
	public List<WDDress> dressRez(WDDress wdDress);
	
	//드레스업체 마지막코드 불러오기
	public String maxDCCode();
	
	//드레스 마지막코드 불러오기
	public String maxDCode();
	
	//드레스업체 추가
	public int dressComInsert(WDDress wdDress);
	
	//드레스 추가
	public int dressInsert(WDDress wdDress);
	
	//드레스업체 조회
	public String selectDressCom(WDDress wdDress);
	
	//드레스업체 이름 조회
	public List<WDDress> dNoAndName();
	
	//드레스업체만! 조회
	public WDDress onlyDressComSelect(String dcCode);
	
	//드레스 업체 삭제
	public int onlyDressComDelete(String dcCode);
	
	//드레스 삭제
	public int onlyDressDelete(WDDress wdDress);
	
	//드레스업체 수정
	public int dressComUpdate(WDDress wdDress);
	
	//드레스 수정
	public int dressUpdate(WDDress wdDress);
	
	public String maxImgName();
	
	public int dressFileInsert(WDDressFile wdDressFile);
}
