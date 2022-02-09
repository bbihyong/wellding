package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.web.dao.WDDressDao;
import com.icia.web.dao.WDRezDao;
import com.icia.web.model.WDDress;
import com.icia.web.model.WDDressFile;
import com.icia.web.model.WDHall;
import com.icia.web.model.WDRez;

@Service("WDDressService")
public class WDDressService 
{
	private static Logger logger = LoggerFactory.getLogger(WDDressService.class);
	
	@Autowired
	private WDDressDao wdDressDao;
	
    @Autowired
    private WDRezDao wdRezDao;
	
	//파일저장 디렉토리
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	//총 게시물 수
	public long dressListCount(WDDress wdDress)
	{
		long count = 0;
		
		try
		{
			count = wdDressDao.dressListCount(wdDress);
		}
		catch(Exception e)
		{
			logger.error("[WDDressService] dressListCount Exception", e);
		}
		
		return count;
	}
	
	//리스트
	public List<WDDress> dressList(WDDress wdDress)
	{
		List<WDDress> list = null;
		
		try
		{
			list = wdDressDao.dressList(wdDress);
		}
		catch(Exception e)
		{
			logger.error("[WDDressService] studioList Exception", e);
		}
		
		return list;
	}
	
	//22.01.03 게시물 조회 = 상세보기
	public WDDress dressSelect(String dNo)
	{
		WDDress wdDress = null;
		
		try
		{
			wdDress = wdDressDao.dressSelect(dNo);
		}
		catch(Exception e)
		{
			logger.error("[WDDressService] dressSelect Exception", e);
		}
		
		return wdDress;
	}
	
	
	//동일 업체 드레스 정보 가져오기.
	public List<WDDress> dressSameCom(WDDress wdDress)
	{
		List<WDDress> sameCom = null;
	
		try 
		{
			sameCom = wdDressDao.dressSameCom(wdDress);
		}
		catch(Exception e)
		{
			logger.error("[WDDressService] dressSameCom Exception", e);
		}
		
		return sameCom;
	}
	
	//드레스 랜덤 가져오기
	
	public List<WDDress> dressRandom(WDDress wdDress)
	{
		List<WDDress> dressRandom = null;
		
		try 
		{
			dressRandom = wdDressDao.dressRandom(wdDress);
		}
		catch(Exception e)
		{
			logger.error("[WDDressService] dressRandom Exception", e);
		}
		
		return dressRandom;
	}
	
   	//아이디로 조회했는데, 예약번호도 없고, 홀 코드도 없음. 트랜잭션으로 인서트 업데이트 한번에 진행
   	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
   	public long rezNoDressTotalInsert(WDRez wdRez) throws Exception
   	{
   		long cnt = 0;
   		//인서트
   		if( wdRezDao.rezNoInsert(wdRez) > 0) 
   		{
   			//예약번호 부여됨.
   			//홀 업데이트
   			cnt = wdRezDao.rezDressInsert(wdRez);
   		}
   		return cnt;
   	}
   	
   	//예약된곳 제외
   	public List<WDDress> dressRez(WDDress wdDress)
   	{
   		List<WDDress> list = null;
   		
   		try
   		{
   			list= wdDressDao.dressRez(wdDress);
   		}
   		catch(Exception e) 
		{
			logger.error("[WDDressService] dressRez Exception", e);
		}
   		return list;
   	}
	
   	
   	//드레스샵 추가 쿼리문
   	public int dressComInsert(WDDress wdDress) 
   	{
   		int count = 0;
   		
   		try 
   		{
   			count = wdDressDao.dressComInsert(wdDress);
   			
   		}
		catch(Exception e)
		{
			logger.error("[WDDressService] dressComInsert Exception", e);
		}
   		
   		return count;
   	}
   	
   	//드레스업체 마지막 코드 불러오기
   	public String maxDCCode() 
   	{
   		
   		String dcCode = "";
   		
   		try 
   		{
   			dcCode = wdDressDao.maxDCCode();
   		}
		catch(Exception e)
		{
			logger.error("[WDDressService] maxDCCode Exception", e);
		}
   		
   		return dcCode;
   	}
   	
   	//드레스 추가 쿼리문
   	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
   	public int dressInsert(WDDress wdDress) throws Exception
   	{
   		int count = 0;
   	
   		count = wdDressDao.dressInsert(wdDress);
   		
   		if(count > 0 && wdDress.getWdDressFile() != null)
   		{
   			WDDressFile wdDressFile = wdDress.getWdDressFile();
   			
   			wdDressDao.dressFileInsert(wdDressFile);
   		}
   		
   		return count;
   	}
   	
   	//드레스업체 마지막 코드 불러오기
   	public String maxDCode() 
   	{
   		
   		String dCode = "";
   		
   		try 
   		{
   			dCode = wdDressDao.maxDCode();
   		}
		catch(Exception e)
		{
			logger.error("[WDDressService] maxDCode Exception", e);
		}
   		
   		return dCode;
   	}
   	
   	//드레스 업체 조회
   	public String selectDressCom(WDDress wdDress)
   	{
   		String dcCode = "";
   		
   		try
   		{
   			dcCode = wdDressDao.selectDressCom(wdDress);
   		}
		catch(Exception e)
		{
			logger.error("[WDDressService] selectDressCom Exception", e);
		}
   		
   		return dcCode;
   	}
   	
	//드레스코드 이름 조회
	public List<WDDress> dNoAndName()
	{
		List<WDDress> dNoName = null;
		
		try 
		{
			dNoName = wdDressDao.dNoAndName();
		}
		catch(Exception e)
		{
			logger.error("[WDDressService] dNoAndName Exception", e);
		}
		
		return dNoName;
	}
	
	//드레스 업체만!! 조회
	public WDDress onlyDressComSelect(String dcCode)
	{
		WDDress wdDress = null;
		
		try
		{
			wdDress = wdDressDao.onlyDressComSelect(dcCode);
		}
		catch(Exception e)
		{
			logger.error("[WDDressService] onlyDressComSelect Exception", e);
		}
		
		return wdDress;
	}
	
	//드레스 업체 삭제
	public int onlyDressComDelete(String dcCode)
	{
		int count = 0;
		
		try
		{
			count = wdDressDao.onlyDressComDelete(dcCode);
		}
		catch(Exception e)
		{
			logger.error("[WDDressService] onlyDressComDelete Exception", e);
		}
		
		return count;
	}
	
	//드레스삭제
	public int onlyDressDelete(WDDress wdDress)
	{
		int count = 0;
		
		try
		{
			count = wdDressDao.onlyDressDelete(wdDress);
		}
		catch(Exception e)
		{
			logger.error("[WDDressService] onlyDressDelete Exception", e);
		}
		
		return count;
	}
	
	
	//드레스 업체 수정
	public int dressComUpdate(WDDress wdDress)
	{
		int count = 0;
		
		try
		{
			count = wdDressDao.dressComUpdate(wdDress);
		}
		catch(Exception e)
		{
			logger.error("[WDDressService] dressComUpdate Exception", e);
		}
		
		return count;
	}
	
	//드레스 업체 수정
	public int dressUpdate(WDDress wdDress)
	{
		int count = 0;
		
		try
		{
			count = wdDressDao.dressUpdate(wdDress);
		}
		catch(Exception e)
		{
			logger.error("[WDDressService] dressUpdate Exception", e);
		}
		
		return count;
	}
	
	public String maxImgName() {
		String imgName = "";
		
		try {
			imgName = wdDressDao.maxImgName();
		}
		catch(Exception e)
		{
			logger.error("[WDDressService] maxImgName Exception", e);
		}
		
		return imgName;
	}
	
}
