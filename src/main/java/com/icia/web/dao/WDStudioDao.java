package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.WDStudio;
import com.icia.web.model.WDStudioFile;

@Repository("WDStudioDao")
public interface WDStudioDao 
{
	//게시물 총 수
	public long studioListCount(WDStudio wdStudio);
	
	//게시물 리스트 조회
	public List<WDStudio> studioList(WDStudio wdStudio);
	
	//상세보기
	public WDStudio studioSelect(String sCode);
	
	//스튜디오 무작위로 가져오기 4개
	public List<WDStudio> studioRandom(WDStudio wdStudio);
	
	//스튜디오 예약테이블에서 예약된 날짜 제외하고 가져오기
	public List<WDStudio> studioListSdate(WDStudio wdStudio);
	
	//게시물 총수 예약일 기준 시작
	public long studioListSdateCount(WDStudio wdStudio);
	
	//스튜디오 코드 최대값
	public String maxSCode();
	
	//스튜디오 삽입
	public int studioInsert(WDStudio wdStudio);
	
	//스튜디오 삭제
	public int studioDelete(String sCode);
	
	//스튜디오 모달?
	public int studioUpdate(WDStudio wdStudio);
	
	//스튜디오 수정
	public int studioUpdateProc(WDStudio wdStudio);
	
	public int studioFileInsert(WDStudioFile wdStudioFile);
	
	public String maxImgName();
}
