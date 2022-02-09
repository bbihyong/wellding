package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.web.dao.WDRezDao;
import com.icia.web.dao.WDStudioDao;
import com.icia.web.model.WDHall;
import com.icia.web.model.WDHallFile;
import com.icia.web.model.WDRez;
import com.icia.web.model.WDStudio;
import com.icia.web.model.WDStudioFile;

@Service("WDStudioService")
public class WDStudioService 
{
	private static Logger logger = LoggerFactory.getLogger(WDStudioService.class);

	@Autowired
	private WDStudioDao wdStudioDao;
	
	@Autowired
	private WDRezDao wdRezDao;
	
	//파일저장 디렉토리
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	//총 게시물 수
	public long studioListCount(WDStudio wdStudio)
	{
		long count = 0;
		
		try
		{
			count = wdStudioDao.studioListCount(wdStudio);
		}
		catch(Exception e)
		{
			logger.error("[WDStudioService] studioListCount Exception", e);
		}
		
		return count;
	}
	
	//게시물 리스트
	public List<WDStudio> studioList(WDStudio wdStudio)
	{
		List<WDStudio> list = null;
		
		try
		{
			list = wdStudioDao.studioList(wdStudio);
		}
		catch(Exception e)
		{
			logger.error("[WDStudioService] studioList Exception", e);
		}
		
		return list;
	}
	
	//뷰 상세보기 페이지
	public WDStudio studioSelect(String sCode)
	{
		WDStudio wdStudio = null;
		
		try
		{
			wdStudio = wdStudioDao.studioSelect(sCode);
		}
		catch(Exception e)
		{
			logger.error("[WDStudioService] studioSelect Exception", e);
		}
		
		return wdStudio;
	}
	
	//업체 랜덤으로 불러오기
	public List<WDStudio> studioRandom(WDStudio wdStudio)
	{
		List<WDStudio> studioRandom = null;
		
		try
		{
			studioRandom = wdStudioDao.studioRandom(wdStudio);
		}
		catch(Exception e)
		{
			logger.error("[WDStudioService] studioRandom Exception", e);
		}
		
		return studioRandom;
	}
	
	//아이디로 조회했는데, 예약번호도 없고, 홀 코드도 없음. 트랜잭션으로 인서트 업데이트 한번에 진행
   	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
   	public long rezStudioTotalInsert(WDRez wdRez) throws Exception
   	{
   		long cnt = 0;
   		//인서트
   		if( wdRezDao.rezNoInsert(wdRez) > 0) 
   		{
   			//예약번호 부여됨.
   			//홀 업데이트
   			cnt = wdRezDao.rezStudioInsert(wdRez);
   		}
   		return cnt;
   	}
	
   	
   	//스튜디오 예약테이블에서 예약된 날짜 제외하고 가져오기
  	public List<WDStudio> studioListSdate(WDStudio wdStudio)
  	{
  		List<WDStudio> list = null;
  		
  		try 
  		{
  			list = wdStudioDao.studioListSdate(wdStudio);
  		}
  		catch(Exception e) 
  		{
			logger.error("[WDStudioService] studioListWdate Exception", e);
  		}
  		
  		return list;
  	}
  	
  	//게시물 총수 예약일 기준 시작
  	public long studioListSdateCount(WDStudio wdStudio) 
  	{
  		long cnt = 0;
  		
  		try 
  		{
  			cnt = wdStudioDao.studioListSdateCount(wdStudio);
  		}
  		catch(Exception e) 
  		{
			logger.error("[WDStudioService] studioListWdateCount Exception", e);
  		}
  		
  		return cnt;
  	}
  	
  	//스튜디오 코드 최대값
  	public String maxSCode() {
  		String sCode = "";
  		
  		try {
  			sCode = wdStudioDao.maxSCode();
  		}
  		catch(Exception e) 
  		{
			logger.error("[WDStudioService] maxSCode Exception", e);
  		}
  		
  		return sCode;
  	}
  	
	//스튜디오 삽입
   	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
   	public int studioInsert(WDStudio wdStudio) throws Exception
   	{
   		int count = 0;
   		
   		count = wdStudioDao.studioInsert(wdStudio);

   		if(count > 0 && wdStudio.getWdStudoiFile() != null)
   		{
   			WDStudioFile wdStudioFile = wdStudio.getWdStudoiFile();
   			
   			wdStudioDao.studioFileInsert(wdStudioFile);
   		}
   		
   		return count;
   	}
	
	//스튜디오 삭제
	public int studioDelete(String sCode)
	{
		int count = 0;
		
		try
		{
			count = wdStudioDao.studioDelete(sCode);
		}
		catch(Exception e)
		{
			logger.error("[WDStudioService] studioDelete Exception", e);
		}
		
		return count;
	}
  	
	//스튜디오 모달창?
	public int studioUpdate(WDStudio wdStudio)
	{
		int count = 0;
		
		try
		{
			count = wdStudioDao.studioUpdate(wdStudio);
		}
		catch(Exception e)
		{
			logger.error("[WDStudioService] studioUpdate Exception", e);
		}
		
		return count;
	}
	
	//스튜디오 수정
	public int studioUpdateProc(WDStudio wdStudio)
	{
		int count = 0;
		
		try
		{
			count = wdStudioDao.studioUpdateProc(wdStudio);
		}
		catch(Exception e)
		{
			logger.error("[WDStudioService] studioUpdateProc Exception", e);
		}
		
		return count;
	}
	
	public String maxImgName() {
		
		String maxName = "";
		try {
			maxName = wdStudioDao.maxImgName();
		}
		catch(Exception e)
		{
			logger.error("[WDStudioService] maxImgName Exception", e);
		}
		return maxName;
	}
	
}
