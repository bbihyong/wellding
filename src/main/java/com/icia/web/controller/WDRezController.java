package com.icia.web.controller;


import java.util.HashMap;
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
import com.icia.web.model.WDAdmin;
import com.icia.web.model.WDRez;
import com.icia.web.model.WDUser;
import com.icia.web.service.WDAdminService;
import com.icia.web.service.WDDressService;
import com.icia.web.service.WDHallService;
import com.icia.web.service.WDMakeUpService;
import com.icia.web.service.WDRezService;
import com.icia.web.service.WDStudioService;
import com.icia.web.service.WDUserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("wdRezController")
public class WDRezController {
   
   private static Logger logger = LoggerFactory.getLogger(WDRezController.class);

		//쿠키명
		@Value("#{env['auth.cookie.name']}")
		private String AUTH_COOKIE_NAME;
		
		//유저서비스
		@Autowired
		private WDUserService wdUserService;
		
		//홀 서비스
		@Autowired
		private WDHallService wdHallService;
		
		//스튜디오 서비스
		private WDStudioService wdStudioService;
		
		//메이크업 서비스
		@Autowired
		private WDMakeUpService wdMakeUpService;
		
		//드레스 서비스
		@Autowired
		private WDDressService wdDressService;
		
		@Autowired
		private WDAdminService wdAdminService;
		
		@Autowired
		private WDRezService wdRezService;
		
		private static final int LIST_COUNT = 10;	//한 페이지에 게시물 수
		private static final int PAGE_COUNT = 5;	//페이징 수
	
	/*@RequestMapping(value="/cart")
	public String cart(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
				
		WDRez wdRez = null;
		
		if(!StringUtil.isEmpty(cookieUserId))
		{	
			WDUser wdUser = wdUserService.userSelect(cookieUserId);
			if(StringUtil.equals(wdUser.getStatus(), "Y")) 
			{
				wdRez.setUserId(cookieUserId);
				wdRez = wdRezService.rezList(wdRez);
				model.addAttribute("wdUser", wdUser);
			}
		}
		
		model.addAttribute("wdRez", wdRez);
		
		return "/cart";
	}*/
	
	
	@RequestMapping(value="/user/wishlist")
	public String wishlist(ModelMap model, HttpServletRequest request, HttpServletResponse response) 
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		WDUser wdUser = wdUserService.userSelect(cookieUserId);
		
		WDRez wdRez = null;
		
		String wDate = null;
		
		String year = null;
		
		String month = null;
		
		String day = null;
		
		if(wdUser != null)
		{	
			if(StringUtil.equals(wdUser.getStatus(), "Y")) 
			{
				WDRez search = new WDRez();
				//search = wdRezService.rezSelect(wdUser.getUserId());
				search.setUserId(wdUser.getUserId());
				//결제상태가 N인 애들만 가져와야 하기 때문에 상태가 N인 애들만 검색할 것!
				search.setRezStatus("N");
				//유저 아이디와 N인 상태의 조건으로 검색한 결과를 wdRez에 담음
				wdRez = wdRezService.rezSelect(search);
				
				System.out.println("wdRez.getMarryDate"+wdUser.getMarrytDate());
				
				wDate = wdUser.getMarrytDate();
				year = wDate.substring(0, 4);
				month = wDate.substring(4, 6);
				day = wDate.substring(6, 8);
				
				
				
				model.addAttribute("wDate", wDate);
				model.addAttribute("year", year);
				model.addAttribute("month", month);
				model.addAttribute("day", day);
				
				if(wdRez != null) 
				{
					//다시 해당 결과를 가지고 다른 테이블과 조인한 결과를 wdRez객체에 다시 담음
					wdRez = wdRezService.rezList(wdRez);
					model.addAttribute("wdRez", wdRez);
					
					if(wdRez.getwDate() != null && wdRez.getwDate() != "") 
					{
						wDate = wdRez.getwDate();
						
						System.out.println("wDate : "+wDate);
						
						year = wDate.substring(0, 4);
						month = wDate.substring(4, 6);
						day = wDate.substring(6, 8);						
					}
					else 
					{
						wDate = wdUser.getMarrytDate();
						year = wDate.substring(0, 4);
						month = wDate.substring(4, 6);
						day = wDate.substring(6, 8);
					}
					
					model.addAttribute("wDate", wDate);
					model.addAttribute("year", year);
					model.addAttribute("month", month);
					model.addAttribute("day", day);
				}
				
			}
			else
			{
				return "/";
			}
		}
		else 
		{
			return "/";
		}
		model.addAttribute("wdRez", wdRez);
		model.addAttribute("wdUser",wdUser);
		
		return "/user/wishlist";
	}

	//장바구니에서 홀 제거
	@RequestMapping(value="/user/updateHproc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> updateHproc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String rezNo = HttpUtil.get(request, "rezNo", "");
		
		WDUser wdUser = wdUserService.userSelect(cookieUserId);
		
		
		if(wdUser != null) 
		{
			if(rezNo != "" && rezNo != null) 
			{
				WDRez wdRez = new WDRez();
				
				wdRez.setUserId(wdUser.getUserId());
				wdRez.setRezNo(rezNo);
				
				if(wdRezService.rezHallUpdate(wdRez) > 0) 
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else 
				{
					ajaxResponse.setResponse(501, "internal server error");
				}
			}
			else 
			{
				ajaxResponse.setResponse(502, "bad request");
			}
		}
		else 
		{
			ajaxResponse.setResponse(500, "not yours");
		}
		
		return ajaxResponse;
	}
	
	
	//장바구니에서 스튜디오 제거
	@RequestMapping(value="/user/updateSproc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> updateSproc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String rezNo = HttpUtil.get(request, "rezNo", "");
		
		WDUser wdUser = wdUserService.userSelect(cookieUserId);
		
		
		if(wdUser != null) 
		{
			if(rezNo != "" && rezNo != null) 
			{
				WDRez wdRez = new WDRez();
				
				wdRez.setUserId(wdUser.getUserId());
				wdRez.setRezNo(rezNo);
				
				if(wdRezService.rezStudioUpdate(wdRez) > 0) 
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else 
				{
					ajaxResponse.setResponse(501, "internal server error");
				}
			}
			else 
			{
				ajaxResponse.setResponse(502, "bad request");
			}
		}
		else 
		{
			ajaxResponse.setResponse(500, "not yours");
		}
		
		return ajaxResponse;
	}
	
	
	//장바구니에서 드레스 제거
	@RequestMapping(value="/user/updateDproc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> updateDproc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String rezNo = HttpUtil.get(request, "rezNo", "");
		
		WDUser wdUser = wdUserService.userSelect(cookieUserId);
		
		
		if(wdUser != null) 
		{
			if(rezNo != "" && rezNo != null) 
			{
				WDRez wdRez = new WDRez();
				
				wdRez.setUserId(wdUser.getUserId());
				wdRez.setRezNo(rezNo);
				
				if(wdRezService.rezDressUpdate(wdRez) > 0) 
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else 
				{
					ajaxResponse.setResponse(501, "internal server error");
				}
			}
			else 
			{
				ajaxResponse.setResponse(502, "bad request");
			}
		}
		else 
		{
			ajaxResponse.setResponse(500, "not yours");
		}
		
		return ajaxResponse;		
	}
	
	//장바구니에서 메이크업 제거
	@RequestMapping(value="/user/updateMproc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> updateMproc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String rezNo = HttpUtil.get(request, "rezNo", "");
		
		WDUser wdUser = wdUserService.userSelect(cookieUserId);
		
		
		if(wdUser != null) 
		{
			if(rezNo != "" && rezNo != null) 
			{
				WDRez wdRez = new WDRez();
				
				wdRez.setUserId(wdUser.getUserId());
				wdRez.setRezNo(rezNo);
				
				if(wdRezService.rezMakeupUpdate(wdRez) > 0) 
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else 
				{
					ajaxResponse.setResponse(501, "internal server error");
				}
			}
			else 
			{
				ajaxResponse.setResponse(502, "bad request");
			}
		}
		else 
		{
			ajaxResponse.setResponse(500, "not yours");
		}
		
		return ajaxResponse;		
	}
	
	//결제 취소 리스트 불러오기(관리자) 
	@RequestMapping(value="/mng/payMentList")
	public String payMentList(ModelMap model, HttpServletRequest request, HttpServletResponse response) 
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		String rezNo = HttpUtil.get(request, "rezNo"); 
		String rezStatus = HttpUtil.get(request, "rezStatus");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		long totalCount = 0;
		long count = 0;
		
		WDAdmin wdAdmin = wdAdminService.wdAdminSelect(cookieUserId);
		
		List<WDRez> list = null;
		//페이징 객체
		Paging paging = null;
		
		WDRez search = new WDRez();
		
		//예약 번호가 있을 경우
		if(rezNo != null && rezNo != "")
		{
				search = wdRezService.listSelect(rezNo);
				
				//총 결제금액을 마이포인트로 전환
				if(search != null)
				{
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("userId", search.getUserId());
		            map.put("rezNo", search.getRezNo());
		            
		            System.out.println("userId = "+search.getUserId());
		            System.out.println("rezNo = "+search.getRezNo());
		            
		            //총 결제금액이 마이 포인트로 전환
		            count = wdRezService.rezPointReturn(map);
		            
		            System.out.println("count : " + count);
		            
		            	//결제 취소 신청 상태일 경우
						if(count > 0)
						{
							//결제 상태 C -> D로 변경
						    wdRezService.rezCancelApprove(rezNo);
						}
						else
						{
							return "/";
						}
		            
				}
				else
				{
					return "/";
				}	 
		}
		
		WDRez wdRez = new WDRez();
		
		wdRez.setRezStatus(rezStatus);
		
		//결제내역 관리 searchType은 1개 밖에 없기 때문에 searchType eq 생략
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) 
		{
			wdRez.setSearchType(searchType);
			wdRez.setSearchValue(searchValue);
		}
		else 
		{
			searchType = "";
			searchValue = "";
		}
		
		//총 게시물 수
		totalCount = wdRezService.rezSearchCount(wdRez);
		
		System.out.println("searchType = "+ wdRez.getSearchType());
        System.out.println("searchValue = "+ wdRez.getSearchValue());
		
		logger.debug("[totalCount] = "+ totalCount);
		
		if(totalCount > 0)
		{
			paging = new Paging("/mng/payMentList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			paging.addParam("rezStatus", rezStatus);
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			
			System.out.println("======================================================================");
			System.out.println("problem : " + paging.getEndPage());
			System.out.println("======================================================================");
			
			wdRez.setStartRow(paging.getStartRow());
			wdRez.setEndRow(paging.getEndRow());
			
			list = wdRezService.rezAdminSelect(wdRez);
			
		}
		
		model.addAttribute("list", list);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("rezStatus", rezStatus);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		model.addAttribute("wdAdmin", wdAdmin);
		
		return	"/mng/payMentList";
	}
	

	@RequestMapping(value="/user/marryUpdate")
	@ResponseBody
	public Response<Object> MarrydateUpdate(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		WDUser wdUser = wdUserService.userSelect(cookieUserId);
		
		
		String rezNo = HttpUtil.get(request, "rezNo","");
		String year = HttpUtil.get(request, "year", "");
		String month = HttpUtil.get(request, "month", "");
		String day = HttpUtil.get(request, "day", "");
		String marry = year + month + day;

		
		if(StringUtil.isEmpty(rezNo))
		{
			wdUser.setMarrytDate(marry);
			if(marry.length() == 8)
			{
				if(wdUserService.nonRezNumberMarrydateUpdate(wdUser) > 0)
				{
					ajaxResponse.setResponse(0, "success");
				}
				else
				{
					ajaxResponse.setResponse(-1, "fail");
				}				
			}
			else
			{
				ajaxResponse.setResponse(500, "bad request");
			}
		}
		else
		{
			WDRez wdRez = new WDRez();
			wdRez.setwDate(marry);
			wdRez.setRezNo(rezNo);
			wdRez.setUserId(cookieUserId);
			
			if(marry.length() == 8)
			{
				if(wdRezService.MarrydateUpdate(wdRez) > 0)
				{
					ajaxResponse.setResponse(0, "success");
				}
				else
				{
					ajaxResponse.setResponse(-1, "fail");
				}	
			}
			else {
				ajaxResponse.setResponse(500, "bad request");
			}
		}
		return ajaxResponse;
	}
	
	//결제 취소 리스트에 상세내역 불러오기
	@RequestMapping(value ="/mng/detailView")
	public String detailView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//예약번호 불러오기
		String rezNo = HttpUtil.get(request, "rezNo", "");
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		System.out.println("======================================================================");
		System.out.println("rezNo : " + rezNo);
		System.out.println("======================================================================");
		

		WDRez wdRez = new WDRez();
		
		
		String wdDate = wdRezService.onlyWDate(rezNo);

		String wYear = wdDate.substring(0,4);
		String wMonth = wdDate.substring(4,6);
		String wDay = wdDate.substring(6);
		wdDate = wYear + "년 " + wMonth + "월 " + wDay + "일";

		System.out.println("======================================================================");
		System.out.println("wdDate************* : " + wdDate);
		System.out.println("======================================================================");
		
			//예약 번호가 있는 경우
			if(rezNo != null)
			{
				//쿼리문 if절 비교할 파라미터 삽입
				wdRez = wdRezService.listSelect(rezNo);
				
				//쿼리문 if절 비교해서 예약한 상품들만 가져오기
				wdRez = wdRezService.rezList(wdRez);
				
				//결혼날짜 셋팅,,
				wdRez.setwDate(wdDate);
				
				//스튜디오 있으면 스튜디오 날짜셋팅
				if(wdRez.getsCode() != null && wdRez.getsCode() != "")
				{
					String stDate = wdRezService.onlySDate(rezNo);
					
					String sYear = stDate.substring(0,4);
					String sMonth = stDate.substring(4,6);
					String sDay = stDate.substring(6);
					stDate = sYear + "년 " + sMonth + "월 " + sDay + "일";
					
					System.out.println("======================================================================");
					System.out.println("stDate************* : " + stDate);
					System.out.println("======================================================================");
					
					wdRez.setsDate(stDate);
					
					model.addAttribute("stDate", stDate);
				}

				
			}
			else
			{
				return "/";
			}
		
			
		model.addAttribute("wdRez", wdRez);
		model.addAttribute("wdDate", wdDate);
		
		
		return "/mng/detailView";
	}
	
}
