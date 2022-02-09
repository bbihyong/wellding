package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.common.util.FileUtil;
import com.icia.web.dao.WDEBoardDao;
import com.icia.web.model.WDBoardFile;
import com.icia.web.model.WDEBoard;
import com.icia.web.model.WDEBoardFile;

@Service("wdEBoardService")
public class WDEBoardService 
{
	private static Logger logger = LoggerFactory.getLogger(WDEBoardService.class);
	
	@Autowired
	private WDEBoardDao wdEBoardDao;
	
	//파일 저장경로
	@Value("#{env['upload.save.event']}") 
	private String UPLOAD_SAVE_EVENT;
	
	//총 게시물 수
	public long eBoardListCount(WDEBoard wdEBoard)
	{
		long count = 0;
		
		  try
	      {
	        count = wdEBoardDao.eBoardListCount(wdEBoard);
	      }
	      catch(Exception e)
	      {
	         logger.error("[WDEBoardService] eBoardListCount Exception", e);
	      }
		
		return count;
	}
	
	//게시물 리스트
	public List<WDEBoard> eBoardList(WDEBoard wdEBoard)
	{
		List<WDEBoard> list = null;
		
		try
	      {
	         list = wdEBoardDao.eBoardList(wdEBoard);
	      }
	      catch(Exception e)
	      {
	         logger.error("[WDEBoardService] eBoardList Exception", e);
	      }
	      
	      return list;
	}
	//이벤트 글 등록(관리자)
	public int eBoardInsert(WDEBoard wdEBoard) throws Exception
	 {
		 int count = 0;
		 
		 try
		 {
			 count = wdEBoardDao.eBoardInsert(wdEBoard);
		 }
		 catch(Exception e)
		 {
			 logger.error("[WDNBoardService] nBoardInsert Exception", e);
		 }
		 return count;
	 }
		 
	 //이벤트 글쓰기 수정(관리자) 
	 public int eBoardUpdate(WDEBoard wdEBoard) 
	 {
		 int count = 0;
		 
		 try 
		 {
		 count = wdEBoardDao.eBoardUpdate(wdEBoard);
		 }
		 catch(Exception e)
		 {
			 logger.error("[WDEBoardService] eBoardUpdate Exception", e);
		 }
		 return count;
	 }
	 
	 //이벤트 글쓰기 삭제(관리자)
	 public int eBoardDelete(long bSeq)
	 {
		 int count = 0;
		 try 
		 {
			 count = wdEBoardDao.eBoardDelete(bSeq);
		 	 
		 }
		 catch(Exception e)
		 {
			 logger.error("[WDEBoardService] eBoardDelete Exception", e);
		 }
		 return count;
	 }
	
	 //이벤트 글(eBoard) 첨부파일 삭제(관리자)
	 	public int eBoardFileDelete(long bSeq)
		{
			int count = 0;
			
			try
			{
				count = wdEBoardDao.eBoardFileDelete(bSeq);
			}
			catch(Exception e)
			{
				logger.error("[WDEBoardService] eBoardFileDelete Exception", e);
			}
			
			return count;
		}
	 	
	 	//이벤트 글(eventFile) 첨부파일 삭제(관리자)
	 	public int eventFileDelete(String fileName)
		{
			int count = 0;
			
			try
			{
				count = wdEBoardDao.eventFileDelete(fileName);
			}
			catch(Exception e)
			{
				logger.error("[WDEBoardService] eventFileDelete Exception", e);
			}
			
			return count;
		}
	
	//이벤트 글 첨부파일 조회(관리자)
	public WDEBoardFile eBoardFileSelect(long eBSeq)
	{
		WDEBoardFile wdEBoardFile = null;
		
		try
		{
			wdEBoardFile = wdEBoardDao.eBoardFileSelect(eBSeq);
		}
		catch(Exception e)
		{
			logger.error("[WDEBoardService] eBoardFileSelect Exception", e);
		}
		
		return wdEBoardFile;
	}
	
	//이벤트 글 첨부파일 삽입(관리자)
	public int eBoardFileInsert(WDEBoardFile wdEBoardFile)
	{
		int count = 0;
		
		try
		{
			count = wdEBoardDao.eBoardFileInsert(wdEBoardFile);
		}
		catch(Exception e)
		{
			logger.error("[WDEBoardService] eBoardFileInsert Exception", e);
		}
		
		return count;
	}
	
	//이벤트 글 첨부파일 DB삽입(관리자)
		public int eBoardFileUpdate(WDEBoard wdEBoard)
		{
			int count = 0;
			
			try
			{
				count = wdEBoardDao.eBoardFileUpdate(wdEBoard);
			}
			catch(Exception e)
			{
				logger.error("[WDEBoardService] eBoardFileInsert Exception", e);
			}
			
			return count;
		}
	
	//게시물 조회
	   public WDEBoard eBoardSelect(long eBSeq) 
	   {
		   WDEBoard wdEBoard = null;
		   
		   try 
		   {
			   wdEBoard = wdEBoardDao.eBoardSelect(eBSeq);
		   }
		   catch(Exception e) 
		   {
			   logger.error("[WDEBoardService] eBoardList Exception", e);
		   }
		   
		   return wdEBoard;
	   }
	   
	 //게시물 조회 view 페이지
	   public WDEBoard eView(long eBSeq) 
	   {
		   WDEBoard wdEBoard = null;
		   
		   try 
		   {
			   wdEBoard = wdEBoardDao.eBoardSelect(eBSeq);
			   
			   if(wdEBoard != null) 
			   {
				   //조회수 증가, 근데 처리할 게 없으니까 따로 어디다 담을 필요가 없음
				   wdEBoardDao.eBoardReadCntPlus(eBSeq);
			   }		   
		   }
		   catch(Exception e) 
		   {
			   logger.error("[WDEBoardService] eView Exception", e);
		   }
		   
		   return wdEBoard;
	   }
	   
	 //이벤트 이미지 가장 넘버링
		public String maxImgName() {
		
		String maxName = "";
			
		try 
		{
			maxName = wdEBoardDao.maxImgName();
		}
		catch(Exception e) 
		{
			logger.error("[WDEBoardService] maxImgName Exception", e);
		}
			return maxName;
		}
		
		 //이벤트 이미지 넘버 조회
		public String searchImgName(long eBSeq) {
		
		String imgName = "";
			
		try 
		{
			imgName = wdEBoardDao.searchImgName(eBSeq);
		}
		catch(Exception e) 
		{
			logger.error("[WDEBoardService] searchImgName Exception", e);
		}
			return imgName;
		}	

}
	

