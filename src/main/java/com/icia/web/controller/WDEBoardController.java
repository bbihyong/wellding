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
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.WDCoupon;
import com.icia.web.model.WDEBoard;
import com.icia.web.model.WDNBoard;
import com.icia.web.model.WDUser;
import com.icia.web.service.WDCouponService;
import com.icia.web.service.WDEBoardService;
import com.icia.web.service.WDUserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("wdEBoardController")
public class WDEBoardController
{
	private static final long LIST_COUNT = 5;
	private static final long PAGE_COUNT = 5;

	private static Logger logger = LoggerFactory.getLogger(WDEBoardController.class);
	
		//쿠키명
		@Value("#{env['auth.cookie.name']}")
		private String AUTH_COOKIE_NAME;
		
		//파일 저장경로
		/*
		 * @Value("#{env['upload.save.dir']}") private String UPLOAD_SAVE_DIR;
		 */
		
		@Autowired
		private WDEBoardService wdEBoardService;
		
		@Autowired
		private WDUserService wdUserService;
		
		@Autowired
		private WDCouponService wdCouponService;
		
		// 이벤트 게시판 리스트
		@RequestMapping(value="/board/eBoard")
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
			
			
			long totalCount = 0;
			List<WDEBoard> eBoard = null;
			long curPage = HttpUtil.get(request, "curPage", (long)1);
			String searchType = HttpUtil.get(request, "searchType", "");
			String searchValue = HttpUtil.get(request, "searchValue", "");
			
			
			Paging paging = null;
			
			WDEBoard search = new WDEBoard();
			
			if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) 
			{
				//받아온 값이 있음.
				search.setSearchType(searchType);
				search.setSearchValue(searchValue);
			}
			else 
			{
				searchType = "";
				searchValue = "";
			}
			
			totalCount = wdEBoardService.eBoardListCount(search);
			
			if(totalCount > 0 ) 
			{
				
				paging = new Paging("/mng/eBoardList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
				paging.addParam("searchType", searchType);
				paging.addParam("searchValue", searchValue);
				paging.addParam("curPage", curPage);
				
				search.setStartRow(paging.getStartRow());
				search.setEndRow(paging.getEndRow());
				
				eBoard = wdEBoardService.eBoardList(search);
			}
			
			model.addAttribute("eBoard", eBoard);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("curPage", curPage);
			model.addAttribute("paging", paging);
			
			return "/board/eBoard";
		}
		
		//이벤트 조회
		@RequestMapping(value="/board/eView")
		public String nBoardView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
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
			
			long eBSeq = HttpUtil.get(request, "eBSeq", (long)0);
			String searchType = HttpUtil.get(request, "searchType", "");
			String searchValue = HttpUtil.get(request, "searchValue", "");
			long curPage = HttpUtil.get(request, "curPage", (long)1);
			
			System.out.println("#####################sdlfjsdjkfsdlfjsjdsdljfsd #######: " + eBSeq);
			
			WDEBoard eBoard = null;
			
			if(eBSeq > 0)
			{
				eBoard = wdEBoardService.eView(eBSeq);
			}
			
			String content = eBoard.geteBContent().replaceAll("<br>", "\r\n");
			eBoard.seteBContent(content);
	
			model.addAttribute("eBSeq", eBSeq);
			model.addAttribute("eBoard", eBoard);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("curPage", curPage);
			
			return "/board/eView";
		}
		
		//쿠폰 발급 페이지
		@RequestMapping(value="/board/eBoardCoupon")
		public String eBoardCoupon(ModelMap model, HttpServletRequest request, HttpServletResponse response)
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
			
			return "/board/eBoardCoupon";
		}
		
		//쿠폰 발급 받기
		@RequestMapping(value="/board/eBoardCouponProc")
		@ResponseBody
		public Response<Object> eBoardCouponProc(HttpServletRequest request, HttpServletResponse response)
		{
			Response<Object> ajaxResponse = new Response<Object>();
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			
			WDCoupon wdCoupon = new WDCoupon();
			
			long count = 0;
			
			//로그인이 안되어 있는 경우
			if(!StringUtil.isEmpty(cookieUserId))
			{	
				count = wdCouponService.selectCoupon(cookieUserId);
				
				//이벤트 쿠폰이 0개 있을 경우
				if(count == 0)
				{
					wdCoupon = wdCouponService.downloadCoupon(cookieUserId);
					
					if(wdCouponService.selectCoupon(cookieUserId) > 0)
					{
						ajaxResponse.setResponse(0, "Success");
					}
					else
					{
						ajaxResponse.setResponse(-1, "Bad Request");
					}
				}
				else
				{
					ajaxResponse.setResponse(401, "Duplicate Coupon");
				}
			}
			else
			{
				ajaxResponse.setResponse(400, "Not Found Cookie");
			}
				
			return ajaxResponse;
		}
}
