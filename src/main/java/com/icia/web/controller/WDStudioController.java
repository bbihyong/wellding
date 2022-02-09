package com.icia.web.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.WDRez;
import com.icia.web.model.WDStudio;
import com.icia.web.model.WDUser;
import com.icia.web.service.WDRezService;
import com.icia.web.service.WDStudioService;
import com.icia.web.service.WDUserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("WDStudioController")
public class WDStudioController 
{
	private static Logger logger= LoggerFactory.getLogger(WDStudioController.class);

	//쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//파일저장경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired
	private WDStudioService wdStudioService;

	//유저서비스
	@Autowired
	private WDUserService wdUserService;
	
	@Autowired
	private WDRezService wdRezService;
	
	private static final int LIST_COUNT = 9;
	private static final int PAGE_COUNT = 3;
	
	///화면뿌리기
	@RequestMapping(value="/hsdm/studio")
	public String list(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		/*********상단에 닉넴 보여주기 시작*********/
		//쿠키 확인
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		String year = HttpUtil.get(request, "year", "");
	    String month = HttpUtil.get(request, "month", "");
	    String day = HttpUtil.get(request, "day", "");
	    String sDate = year + month + day;
		
		//로그인 했을 때와 안했을 때를 구분해서 페이지를 보여주려 함.
		//로그인 체크용. 0 => 로그인 x, 혹은 없는 계정; 1 => 로그인 정보 있는 계정
		int loginS = 0;
		WDUser wdUser = null;
		
		if(wdUserService.wdUserIdCount(cookieUserId) >0) 
		{
			//쿠키 아이디로 된 유저 정보가 db에 존재함.
			wdUser = wdUserService.userSelect(cookieUserId);
			if(wdUser != null) 
			{
				//객체가 비어있지 않으면 보여줄 유저의 정보를 담은 객체를 넘기고, 로그인 상태에 1을 넣어줌.
				loginS = 1;
				model.addAttribute("wdUser", wdUser);
			}
		}
		else 
		{
			loginS = 0;
		}
		/**********상단에 닉넴 보여주기 끝***********/
		
		//조회항목(1:스튜디오명, 2:지역)
		String searchType = HttpUtil.get(request, "searchType", "");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		String sCode = HttpUtil.get(request, "sCode", "");
		
		//조회 날짜
		//String wDate = HttpUtil.get(request, "wDate", "");
		
		long totalCount = 0;
		List<WDStudio> list = null;
		
		//페이징객체
		Paging paging = null;
		//조회객체
		WDStudio wdStudio = new WDStudio();
		
		//매개변수로 받은 값이 정상적으로 넘어왔는지 체크
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			//값이있으면 메소드 호출하기
			wdStudio.setSearchType(searchType);
			wdStudio.setSearchValue(searchValue);
		}
		else
		{
			//공백일때는 초기값 널로하기!
			searchType="";
			searchValue="";
		}
		
		wdStudio.setsCode(sCode);
		wdStudio.setsDate(sDate);
		
		//totalCount = wdStudioService.studioListCount(wdStudio);
		totalCount = wdStudioService.studioListSdateCount(wdStudio);
		logger.debug("totalCount : " + totalCount);
		
		if(totalCount > 0)
		{
			//리스트값 + 페이징처리
			paging = new Paging("/hsdm/studio", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");//페이징처리
			
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			
			wdStudio.setStartRow(paging.getStartRow());
			wdStudio.setEndRow(paging.getEndRow());
			wdStudio.setsDate(sDate);
			//list = wdStudioService.studioList(wdStudio);
			list = wdStudioService.studioListSdate(wdStudio);
		}
		
		model.addAttribute("list", list);
	    model.addAttribute("searchType", searchType);
	    model.addAttribute("searchValue", searchValue);
	    model.addAttribute("curPage", curPage);
	    model.addAttribute("paging", paging);
	    model.addAttribute("year", year);
	    model.addAttribute("month", month);
	    model.addAttribute("day", day);
		
	    
		return "/hsdm/studio";
	}

	//22.01.04 상세페이지 보기
	@RequestMapping(value="/hsdm/studioView")
	public String view(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		/*********상단에 닉넴 보여주기 시작*********/
		//쿠키 확인
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		//결혼날짜 폼 데이터 가져오기
	    String year = HttpUtil.get(request, "year", "");
	    String month = HttpUtil.get(request, "month", "");
	    String day = HttpUtil.get(request, "day", "");
		
		//로그인 했을 때와 안했을 때를 구분해서 페이지를 보여주려 함.
		//로그인 체크용. 0 => 로그인 x, 혹은 없는 계정; 1 => 로그인 정보 있는 계정
		int loginS = 0;
		WDUser wdUser = null;
		
		if(wdUserService.wdUserIdCount(cookieUserId) >0) 
		{
			//쿠키 아이디로 된 유저 정보가 db에 존재함.
			wdUser = wdUserService.userSelect(cookieUserId);
			if(wdUser != null) 
			{
				//객체가 비어있지 않으면 보여줄 유저의 정보를 담은 객체를 넘기고, 로그인 상태에 1을 넣어줌.
				loginS = 1;
				model.addAttribute("wdUser", wdUser);
			}
		}
		else 
		{
			loginS = 0;
		}
		/**********상단에 닉넴 보여주기 끝***********/
		
		//상세페이지 필요한거 가져오기
		String sCode = HttpUtil.get(request, "sCode", "");
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		WDStudio wdStudio = null;
		
		if(sCode != null)
		{
			wdStudio = wdStudioService.studioSelect(sCode);
		}
		
		String imgName = wdStudio.getsImgname();
		imgName = imgName.replace(".jpg", "");
		imgName = imgName.replace(".png", "");
		
		ArrayList<String> subImg = new ArrayList<String>();
		for(int i=0;i<wdStudio.getsSubImg();i++) 
		{
			subImg.add(imgName + "_" + (i+1)+".jpg");
		}
		model.addAttribute("subImg",subImg);
		
		model.addAttribute("sCode", sCode);
		model.addAttribute("wdStudio", wdStudio);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("year", year);
	    model.addAttribute("month", month);
	    model.addAttribute("day", day);
		model.addAttribute("curPage", curPage);
		
		return "/hsdm/studioView";
	}
	
	//스튜디오 장바구니 담기 버튼 누르면 실행되는 컨트롤러 정의
	   @RequestMapping(value="/hsdm/studioRezProc", method=RequestMethod.POST)
	   @ResponseBody
	   public Response<Object> studioRezProc(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	   {
		   Response<Object> ajaxResponse = new Response<Object>();
		   
		   String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		   String sCode = HttpUtil.get(request, "sCode");
		   String year = HttpUtil.get(request, "year", "");
		   String month = HttpUtil.get(request, "month", "");
		   String day = HttpUtil.get(request, "day", "");
		   String sDate = year + month + day;
		   
		   //존재하는 유저인지부터 체크
		   WDUser wdUser = null;
		   
		   WDRez wdRez = null;
		   
		   wdUser = wdUserService.userSelect(cookieUserId);
		   
		   if(wdUser != null) 
		   {
			   System.out.println("여긴타니 11");
			   //유저 정보 존재함
			   if(StringUtil.equals(wdUser.getStatus(), "Y")) 
			   {
				   System.out.println("여긴타니 22");
				   //유저 상태 정상
				   //유저 아이디를 통해 예약번호가 있는지 확인
				   if(wdRezService.checkRez(wdUser.getUserId()) <= 0) 
				   {
					   System.out.println("여긴타니 33");
					   //예약번호 없음.
					   //예약번호 부여와 홀코드 부여를 한번에 해야 함. 트랜젝션을 서비스단에서 구현
					   wdRez = new WDRez();
					   wdRez.setUserId(wdUser.getUserId());
					   wdRez.setsCode(sCode);
					   wdRez.setsDate(sDate);
					
					   //한번에 인서트->업데이트!
					   try 
					   {
						   System.out.println("여긴타니 44");
						   if(wdStudioService.rezStudioTotalInsert(wdRez)>0) 
						   {
							   System.out.println("여긴타니 55");
							   ajaxResponse.setResponse(0, "Success");
						   }
						   else 
						   {
							   System.out.println("여긴타니 66");
							   ajaxResponse.setResponse(403, "Internal server Error");
						   }
					   }
					   catch(Exception e) 
					   {
						   System.out.println("여긴타니 77");
						   ajaxResponse.setResponse(403, "Internal server Error");
						   logger.error("[WDStudioController] studioRezProc Transactional Exception", e);
					   }
					   
				   }
				   else 
				   {
					   System.out.println("여긴타니 88");
					   
					   WDRez search = new WDRez();
					   search.setUserId(wdUser.getUserId());
					   search.setRezStatus("N");
					   
					   //search = wdRezService.rezSelect(wdUser.getUserId());
					   wdRez = wdRezService.rezSelect(search);
					   wdRez = wdRezService.rezList(wdRez);
					   
					   if(wdRez != null) 
					   {
						   System.out.println("여긴타니 99");
						   if(StringUtil.isEmpty(wdRez.getsCode())) 
						   {
							   System.out.println("여긴타니 10101010");
							   wdRez.setsCode(sCode);
							   wdRez.setsDate(sDate);
							   if(wdRezService.rezStudioInsert(wdRez) > 0 ) 
							   {
								   System.out.println("여긴타니 11,11,11,11");
								   //업데이트! 0보다 크면 성공!
								   ajaxResponse.setResponse(0, "Success");
							   }
							   else 
							   {
								   System.out.println("여긴타니 12,12,12,12");
								   //업데이트문 실행 안됨.
								   ajaxResponse.setResponse(403, "Internal server Error");
							   }
						   }
						   else 
						   {
							   System.out.println("여긴타니 13,13,13,13");
							   //아니 저기요. 홀 이미 담으셨잖아요. 예약 한 번에 예식 두 번 뛰실라고 하시네 이분...
							   ajaxResponse.setResponse(502, "Stupid");
						   }	   
					   }
					   
				   }
				   
			   }
			   else 
			   {
				   System.out.println("여긴타니 14,14,14,14");
				   ajaxResponse.setResponse(501, "Banned User");
			   }
		   }
		   else 
		   {
			   System.out.println("여긴타니 15,15,15,15");
			   ajaxResponse.setResponse(500, "User Not Exist");
		   }
		   
		   return ajaxResponse;
	   }
	   
	   //스튜디오 삭제
	   @RequestMapping(value="/mng/studioDelete", method=RequestMethod.POST)
	   @ResponseBody
	   public Response<Object> studioDelete(HttpServletRequest request, HttpServletResponse response)
	   {
		   Response<Object> ajaxResponse = new Response<Object>();
		   
		   String sCode = HttpUtil.get(request, "sCode", "");
		   
		   System.out.println("DGFGDFGRgrgdfgafdgafd : "+ sCode);
		   
		   if(!StringUtil.isEmpty(sCode))
		   {
			   WDStudio wdStudio = wdStudioService.studioSelect(sCode);
			   
			   if(wdStudio != null)
			   {
				   if(wdStudioService.studioDelete(wdStudio.getsCode()) > 0)
				   {
					   ajaxResponse.setResponse(0, "Success");
				   }
				   else
				   {
					   ajaxResponse.setResponse(500, "Internal Server Error");
				   }
			   }
			   else
			   {
				   ajaxResponse.setResponse(404, "Not Found");
			   }
		   }
		   else
		   {
			   ajaxResponse.setResponse(400, "Bad Request");
		   }
		   
		   return ajaxResponse;
		   
	   }
	   
	   //스튜디오 모달
	   @RequestMapping(value="/mng/updateStudio", method=RequestMethod.GET)
	   public String updateStudio(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	   {
		   String sCode = HttpUtil.get(request, "sCode", "");
		   
		   WDStudio wdStudio = null;
		   
		   wdStudio = wdStudioService.studioSelect(sCode);
		   
		   model.addAttribute("wdStudio",wdStudio);
		   
		   return "/mng/updateStudio";
	   }
	   
	   //스튜디오 수정
	   @RequestMapping(value="/mng/studioUpdateProc", method=RequestMethod.POST)
	   @ResponseBody
	   public Response<Object> studioUpdateProc(HttpServletRequest request, HttpServletResponse response)
	   {
		   Response<Object> ajaxResponse = new Response<Object>();
		   
		   String sName = HttpUtil.get(request, "sName", "");
		   long sPrice = HttpUtil.get(request, "sPrice", (long)0);
		   String sLocation = HttpUtil.get(request, "sLocation", "");
		   String sNumber = HttpUtil.get(request, "sNumber", "");
		   String sContent = HttpUtil.get(request, "sContent", "");
		   long sDiscount = HttpUtil.get(request, "sDiscount", (long)0);
		   String sCode = HttpUtil.get(request, "sCode", "");
		   String adminId = HttpUtil.get(request, "adminId", "");
		   
		   if(!StringUtil.isEmpty(sCode))
		   {
			   WDStudio wdStudio = new WDStudio();
			   
			   if(wdStudio != null)
			   {
				   wdStudio.setsName(sName);
				   wdStudio.setsPrice(sPrice);
				   wdStudio.setsLocation(sLocation);
				   wdStudio.setsNumber(sNumber);
				   wdStudio.setsContent(sContent);
				   wdStudio.setsDiscount(sDiscount);
				   wdStudio.setsCode(sCode);
				   
				   if(wdStudioService.studioUpdateProc(wdStudio) > 0)
				   {
					   ajaxResponse.setResponse(0, "Success");
				   }
				   else
				   {
					   ajaxResponse.setResponse(-1, "Fail");
				   }
			   }
			   else
			   {
				   ajaxResponse.setResponse(404, "Not Found");
			   }
		   }
		   else
		   {
			   ajaxResponse.setResponse(400, "Bad Request");
		   }
		   
		   
		   return ajaxResponse;
	   }
}
