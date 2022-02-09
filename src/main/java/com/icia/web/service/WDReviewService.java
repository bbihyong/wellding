package com.icia.web.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.common.util.FileUtil;
import com.icia.web.dao.WDReviewDao;
import com.icia.web.model.WDBoardFile;
import com.icia.web.model.WDFBoard;
import com.icia.web.model.WDReview;
import com.icia.web.model.WDReviewFile;

@Service("WDReviewService")
public class WDReviewService {
	
	private static Logger logger = LoggerFactory.getLogger(WDReviewService.class);
	
	//파일저장 디렉토리
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired
	private WDReviewDao wdReviewDao;
	//리뷰 게시글 총 수
	public long ReviewListCount(WDReview wdReview) {
		
		long count = 0;
		
		try {
			count = wdReviewDao.ReviewListCount(wdReview);
		}
		catch(Exception e) {
			logger.error("[WDReviewService] ReviewListCount Exception", e);
		}
		
		return count;
	}
	//리뷰 리스트
	public List<WDReview> ReviewList(WDReview wdReview){
		
		List<WDReview> list = null;
		
		try {
			list = wdReviewDao.ReviewList(wdReview);
		}
		catch(Exception e) {
			logger.error("[WDReviewService] ReviewList Exception", e);
		}
		
		return list;
	}
	
	//리뷰게시물 조회 , 파일 포함
	public WDReview ReviewSelect(long RSeq)
	{
		WDReview wdReview = null;
		
		try 
		{
			wdReview = wdReviewDao.ReviewSelect(RSeq);
			
			if(wdReview != null) 
			{
				wdReviewDao.ReviewReadCntPlus(RSeq);
				
				WDReviewFile wdReviewFile = wdReviewDao.ReviewFileSelect(RSeq);
				
				if(wdReviewFile != null) 
				{
					wdReview.setReviewFile(wdReviewFile);
				}
			}
		}
		catch(Exception e) 
		{
			logger.error("[WDFBoardService] wdFBoardView Exception", e);
		}
		
		return wdReview;
		}
		
	//리뷰 첨부파일 조회
	public WDReviewFile ReviewFileSelect(long RSeq) {
			
			WDReviewFile wdReviewFile = null;
		
		try {
			wdReviewFile = wdReviewDao.ReviewFileSelect(RSeq);
		}
		catch(Exception e) {
			logger.error("[WDReviewService] ReviewFileSelect Exception", e);
		}
		
		return wdReviewFile;
		
	}
	//리뷰 게시글 조회수 증가
//	public int ReviewReadCntPlus(long RSeq) {
//		
//		int count = 0;
//		
//		try {
//			count = wdReviewDao.ReviewReadCntPlus(RSeq);
//		}
//		catch(Exception e) {
//			logger.error("[WDReviewService] ReviewReadCntPlus Exception", e);
//		}
//		
//		return count;
//		
//	}

	//리뷰 작성 가능여부 조회
	public String ReviewRezCheck(String userId) {
		
		String status = "";
		try {
			status = wdReviewDao.ReviewRezCheck(userId);
		}
		catch(Exception e) {
			logger.error("[WDReviewService] ReviewRezCheck Exception", e);
		}
		
		return status;
	}	
	
//	//리뷰 작성
//	public int ReviewInsert(WDReview wdReview) {
//		
//		int count = 0;
//		try {
//			count = wdReviewDao.ReviewInsert(wdReview);
//		}
//		catch(Exception e) {
//			logger.error("[WDReviewService] ReviewInsert Exception", e);
//		}
//		
//		return count;
//		
//	}
	
	//리뷰테이블 글쓰기 버튼 클릭 시 예약여부 확인
	public WDReview rezCheck(String userId) {
		WDReview wdReview = null;
		
		try {
			wdReview = wdReviewDao.rezCheck(userId);
		}
		catch(Exception e) {
			logger.error("[WDReviewService] rezCheck Exception", e);
		}
		
		return wdReview;
		
	}
	
	//게시물 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int reviewInsert(WDReview wdReview) throws Exception
	{
		int count = 0;
		
		count = wdReviewDao.ReviewInsert(wdReview);
		System.out.println("파일전 여긴 돌아 갓꾸~");
		if(count>0 && wdReview.getReviewFile() != null) 
		{
			WDReviewFile wdReviewFile = wdReview.getReviewFile();
			
			wdReviewFile.setrSeq(wdReview.getRSeq());
			wdReviewFile.setrFileSeq((long)1);
			System.out.println("파일 후 여긴 돌아 갓꾸~ : "+wdReviewFile.getrFileSeq());
			
			wdReviewDao.reviewFileInsert(wdReviewFile);
		}
		
		return count;
	}
	
	//게시물 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int reviewDelete(long RSeq) throws Exception
	{
		int count = 0;
		
		WDReview wdReview = wdReviewDao.ReviewSelect(RSeq);
		
		if(wdReview != null) 
		{
			WDReviewFile wdReviewFile = wdReviewDao.ReviewFileSelect(RSeq);
			
			count = wdReviewDao.reviewDelete(RSeq);
			
			if(wdReviewFile != null) 
			{
				wdReview.setReviewFile(wdReviewFile);
				
				if(wdReviewDao.reviewDeleteFile(RSeq) > 0) 
				{
					FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator()+wdReviewFile.getrFileName());
				}
			}
			
		}
		
		return count;
	}
	
	  //게시물 첨부파일만 삭제
	   @Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	   public int reviewDeleteFile(WDReview wdReview) throws Exception
	   {
		   int count = 0;
		   

		   if(wdReview.getReviewFile() != null) 
		   {
			   WDReviewFile delWDReviewFile = wdReviewDao.ReviewFileSelect(wdReview.getRSeq());
			   
			   if(delWDReviewFile != null) 
			   {
				   //테이블 날리기
				   count = wdReviewDao.reviewDeleteFile(wdReview.getRSeq());
				   
				   //삭제할 애가 존재함, 파일 삭제
				   FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator()+delWDReviewFile.getrFileName());
			   }
		   }
		   return count;
	   }
	   
		//게시물 수정
		@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
		public int reviewUpdate(WDReview wdReview) throws Exception
		{
			int count = 0;
			
			count = wdReviewDao.reviewUpdate(wdReview);
			if(count > 0 && wdReview.getReviewFile() != null) 
			{
				WDReviewFile delWDReviewFile = wdReviewDao.ReviewFileSelect(wdReview.getRSeq());
				
				if(delWDReviewFile != null) 
				{
					wdReviewDao.reviewDeleteFile(wdReview.getRSeq());
					
					FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator()+delWDReviewFile.getrFileName());
				}
				
				WDReviewFile wdReviewFile = wdReview.getReviewFile();
				wdReviewFile.setrSeq(wdReview.getRSeq());
				wdReviewFile.setrFileSeq(1);
				
				wdReviewDao.reviewFileInsert(wdReviewFile);				
			}
			
			return count;
		}
		//리뷰 존재 확인
		public String reviewOverlapCheck(String rezNo)
		{
			String status = "";
			try
			{
				status = wdReviewDao.reviewOverlapCheck(rezNo);
			}
			catch(Exception e)
			{
				logger.error("[WDReviewService] reviewOverlapCheck Exception",e);
			}
			return status;
		}
		
		//리뷰 작성처리
		public int reviewCPT(String rezNo) 
		{
			int count = 0;
			
			try {
				count = wdReviewDao.reviewCPT(rezNo);
			}
			catch(Exception e)
			{
				logger.error("[WDReviewService] reviewCPT Exception",e);
			}
			return count;
			
		}
		
		//리뷰게시판 홀 이름 불러오기
		public ArrayList<String> hallNameList() {
			ArrayList<String> hallName = new ArrayList<String>();
			
			try {
				hallName = wdReviewDao.hallNameList();
			}
			catch(Exception e)
			{
				logger.error("[WDReviewService] hallNameList Exception",e);
			}
			
			
			return hallName;
		}
		
		//업체 불러오기전 코드 부터 불러오기
		public WDReview reviewhsdmCodeSet(WDReview wdReview) {
			
			try {
				wdReview = wdReviewDao.reviewhsdmCodeSet(wdReview);
			}
			catch(Exception e)
			{
				logger.error("[WDReviewService] reviewhsdmCodeSet Exception",e);
			}
			
			return wdReview;				
		}
		
		//업체이름 불러오기
		public WDReview reviewInfohsdmName(WDReview wdReview) {
			
			try {
				wdReview = wdReviewDao.reviewInfohsdmName(wdReview);
			}
			catch(Exception e)
			{
				logger.error("[WDReviewService] reviewInfohsdmName Exception",e);
			}
			
			return wdReview;				
		}
}
