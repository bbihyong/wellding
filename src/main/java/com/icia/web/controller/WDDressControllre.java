package com.icia.web.controller;

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
import com.icia.web.model.WDDress;
import com.icia.web.model.WDRez;
import com.icia.web.model.WDUser;
import com.icia.web.service.WDDressService;
import com.icia.web.service.WDRezService;
import com.icia.web.service.WDUserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("WDDressController")
public class WDDressControllre 
{
	private static Logger logger = LoggerFactory.getLogger(WDDressControllre.class);
	
	//쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//파일저장경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired
	private WDDressService wdDressService;
	
	//유저서비스
	@Autowired
	private WDUserService wdUserService;
	
    @Autowired
    private WDRezService wdRezService;
	
	private static final int LIST_COUNT = 9;
	private static final int PAGE_COUNT = 3;
	
	///화면에 뿌리기
	@RequestMapping(value="/hsdm/dress")
	public String list(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		/*********상단에 닉넴 보여주기 시작*********/
		//쿠키 확인
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		
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
		
		//조회항목(1:드레스샵명, 2:지역)
		String searchType = HttpUtil.get(request, "searchType", "");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		String year = HttpUtil.get(request, "year", "");
	    String month = HttpUtil.get(request, "month", "");
	    String day = HttpUtil.get(request, "day", "");
	    String wDate = year + month + day;
		String dcCode = HttpUtil.get(request, "dcCode", "");
		
		long totalCount = 0;
		List<WDDress> list = null;
		
		//페이징객체
		Paging paging = null;
		//조회객체
		WDDress wdDress = new WDDress();
		
		//값이 잘 넘어왔는지 체크하자
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			wdDress.setSearchType(searchType);
			wdDress.setSearchValue(searchValue);
		}
		else
		{
			//값이없으면 공백으로 넣으셔
			searchType = "";
			searchValue = "";
		}
		
		
		wdDress.setDcCode(dcCode);
		wdDress.setwDate(wDate);
		
		//wdDress.setDcCode(dcCode);
		
		//totalCount = wdDressService.dressListCount(wdDress);
		totalCount = wdDressService.dressListCount(wdDress);
		logger.debug("totalCount : " + totalCount);
		
		if(totalCount > 0)
		{
			//값이 있으면 리스트값뿌리고 페이징처리 ㄱㄱ
			paging = new Paging("/hsdm/dress", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			
			wdDress.setStartRow(paging.getStartRow());
			wdDress.setEndRow(paging.getEndRow());
			wdDress.setwDate(wDate);
			
			list = wdDressService.dressList(wdDress);
		}
		
		model.addAttribute("list", list);
	    model.addAttribute("searchType", searchType);
	    model.addAttribute("searchValue", searchValue);
	    model.addAttribute("curPage", curPage);
	    model.addAttribute("paging", paging);
	    model.addAttribute("year", year);
	    model.addAttribute("month", month);
	    model.addAttribute("day", day);
	    
		return "/hsdm/dress";
	}
	
	
	//22.01.03 상세페이지 보기
	@RequestMapping(value="/hsdm/dressView")
	public String view(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		
		/*********상단에 닉넴 보여주기 시작*********/
		//쿠키 확인
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String year = HttpUtil.get(request, "year", "");
		String month = HttpUtil.get(request, "month", "");
		String day = HttpUtil.get(request, "day", "");
		String wDate = year + month + day;
		
		
		
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
		 
		//상세페이지에 필요한거 가져오기
		String dcCode = HttpUtil.get(request, "dcCode", "");
		String dNo = HttpUtil.get(request, "dNo", ""); 
		String searchType = HttpUtil.get(request, "searchType", ""); 
		String searchValue = HttpUtil.get(request, "searchValue", ""); 
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		WDDress wdDress = null; //내가 선택한 드레스 상세보기
		List<WDDress> sameCom = null; //같은업체의 다른드레스 보기
		
		if(dNo != null)
		{
			wdDress = wdDressService.dressSelect(dNo);
		
			//의수 추가
			//같은 회사 상품 가져오기
			WDDress search = new WDDress();
			//같은 회사 코드를 조건으로 검색하기 위해서 값 세팅
			search.setDcCode(wdDress.getDcCode());
			//같은 회사지만 같은 드레스라면 검색이 안되게 하기 위한 값 세팅
			search.setdNo(wdDress.getdNo());
			
			sameCom = wdDressService.dressSameCom(search);
			//의수 추가 종료
		}
		
		model.addAttribute("dNo", dNo);
		model.addAttribute("wdDress", wdDress);
		model.addAttribute("dcCode", dcCode);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("wDate", wDate);
		
		//의수 추가
		model.addAttribute("sameCom", sameCom);
		//의수 추가 종료
		return "/hsdm/dressView";
	}
	
	 //홀 장바구니 담기 버튼 누르면 실행되는 컨트롤러 정의
	   @RequestMapping(value="/hsdm/dressRezProc", method=RequestMethod.POST)
	   @ResponseBody
	   public Response<Object> dressRezProc(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	   {
		   Response<Object> ajaxResponse = new Response<Object>();
		   
		   String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		   String dcCode = HttpUtil.get(request, "dcCode", "");
		   String dNo = HttpUtil.get(request, "dNo", "");
		   //결혼날짜 받아오기!
		   String wDate = HttpUtil.get(request, "wDate", "");
		   
		   //존재하는 유저인지부터 체크
		   WDUser wdUser = null;
		   
		   WDRez wdRez = null;
		   
		   wdUser = wdUserService.userSelect(cookieUserId); //쿠키랑확인해야하니깡
		   
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
					   wdRez.setDcCode(dcCode);
					   wdRez.setdNo(dNo);
					   
					   //의수 추가
					   //wDate 넣어주기
					   //검색조건에 wDate를 줬다면, 그 값을, 아니면 회원가입 시 wDate로 입력
					   if(!StringUtil.equals(wDate, "") && wDate != null) 
					   {
						   wdRez.setwDate(wDate);
					   }
					   else 
					   {
						   wdRez.setwDate(wdUser.getMarrytDate());
					   }
					   
					   
					   //한번에 인서트->업데이트!
					   try 
					   {
						   System.out.println("여긴타니 44");
						   if(wdDressService.rezNoDressTotalInsert(wdRez)>0) 
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
						   logger.error("[WDHallController] hallRezProc Transactional Exception", e);
					   }
					   
				   }
				   else 
				   {
					   System.out.println("여긴타니 88");
					   //예약번호 있음
					   //예약번호는 있는데, 스드메만 예약하고 홀은 아직 예약 안 한 경우일 수도 있음.
					   //그럴 경우 홀 코드가 비어있다면 업데이트 해줘야 함.
					   //홀 코드 존재하는지 체크
					   WDRez search = new WDRez();
					   
					   search.setUserId(wdUser.getUserId());
					   search.setRezStatus("N");
					   
					   wdRez = wdRezService.rezSelect(search);
					   //search = wdRezService.rezSelect(wdUser.getUserId());
					   
					   wdRez = wdRezService.rezList(wdRez);
					   
					   if(wdRez != null) 
					   {
						   System.out.println("여긴타니 99");
						   if(StringUtil.isEmpty(wdRez.getDcCode()) && StringUtil.isEmpty(wdRez.getdNo())) 
						   {
							   System.out.println("여긴타니 10101010");
							   //홀 코드 존재하지 않음. 홀은 안담았어!!
							   //wdRez객체에 홀코드 예식장코드 담음.
							   wdRez.setDcCode(dcCode);
							   wdRez.setdNo(dNo);
							   
							   
							   //의수 추가
							   //wDate 넣어주기
							   //검색조건에 wDate를 줬다면, 그 값을, 아니면 회원가입 시 wDate로 입력
							   if(!StringUtil.equals(wDate, "") && wDate != null) 
							   {
								   wdRez.setwDate(wDate);
							   }
							   else 
							   {
								   wdRez.setwDate(wdUser.getMarrytDate());
							   }
							   
							   
							   if(wdRezService.rezDressInsert(wdRez) >0 ) 
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
	
	
}
