package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.WDReview;
import com.icia.web.model.WDReviewFile;

@Repository("wdReviewDao")
public interface WDReviewDao {
	
	//리뷰 게시글 총 수
	public long ReviewListCount(WDReview wdReview);
	
	//리뷰 리스트
	public List<WDReview> ReviewList(WDReview wdReview);
	
	//리뷰 게시글 조회
	public WDReview ReviewSelect(long RSeq);
	
	//리뷰 게시글 조회수 증가
	public int ReviewReadCntPlus(long RSeq);
	
	//리뷰 첨부파일 조회
	public WDReviewFile ReviewFileSelect(long RSeq);
	
	//리뷰 작성 가능여부 조회
	public String ReviewRezCheck(String userId);
	
	//리뷰 작성
	public int ReviewInsert(WDReview wdReview);
	
	public WDReview rezCheck(String userId);
	
	//리뷰 파일 등록
	public int reviewFileInsert(WDReviewFile wdReviewFile);
	
	//리뷰 게시물 삭제
	public int reviewDelete(long RSeq);
	
	//리뷰 첨부파일 삭제
	public int reviewDeleteFile(long RSeq);
	
	//리뷰 업데이트
	public int reviewUpdate(WDReview wdReview);
	

}
