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

import com.icia.common.util.StringUtil;
import com.icia.web.model.Paging;
import com.icia.web.model.WDNBoard;
import com.icia.web.model.WDUser;
import com.icia.web.service.WDNBoardService;
import com.icia.web.service.WDUserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("wdnBoardController")
public class WDNBoardController 
{
	private static Logger logger = LoggerFactory.getLogger(WDNBoardController.class);
	
   //쿠키명
   @Value("#{env['auth.cookie.name']}")
   private String AUTH_COOKIE_NAME;
	
	@Autowired
	private WDNBoardService wdNBoardService;
	
	@Autowired
	private WDUserService wdUserService;
	
	private static final int LIST_COUNT = 10;		//한 페이지의 게시물 수
	private static final int PAGE_COUNT = 3;		//페이징 수
	
	@RequestMapping(value="/board/nBoard")
	public String nBoard(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{	
		//조회항목(1: 제목)
		String searchType = HttpUtil.get(request, "searchType", "");
		//조회 값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		WDUser wdUser = wdUserService.userSelect(cookieUserId);
		
		long totalCount = 0;
		List<WDNBoard> list = null;
		//페이징 객체															-- 나중에 페이징 처리 하기
		Paging paging = null;
		//조회 객체
		WDNBoard search = new WDNBoard();
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
		}
		else
		{
			searchType = "";
			searchValue = "";
		}
		
		totalCount = wdNBoardService.nBoardListCount(search);
		
		logger.debug("totalCount : " + totalCount);
		
		if(totalCount > 0)
		{//검색 결과가 있음
			//페이징 처리 추가
			paging = new Paging("/board/nBoard", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = wdNBoardService.nBoardList(search);			
		}
		
		logger.debug("list.size() : "+list.size());
		
		model.addAttribute("list", list);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		model.addAttribute("wdUser", wdUser);
		
		return "/board/nBoard";
	}
	
	//공지사항 조회
	@RequestMapping(value="/board/nBoardView")
	public String nBoardView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//상세페이지에 필요한거 : bbsSeq, curPage, 써치타입, 써치밸유 받아오기
		long bSeq = HttpUtil.get(request, "bSeq", (long)0);
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		WDUser wdUser = wdUserService.userSelect(cookieUserId);
		
		WDNBoard nBoard = null;
		
		if(bSeq > 0)
		{
			nBoard = wdNBoardService.boardView(bSeq);
			//하이보드객체에다가 방금 한 하이보드서비스에 있는 보드뷰 받아올거야 ~!
		}
		
		String content = nBoard.getbContent().replaceAll("<br>", "\r\n");
	    nBoard.setbContent(content);
		
		model.addAttribute("bSeq", bSeq);
		model.addAttribute("nBoard", nBoard);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("wdUser", wdUser);
		
		return "/board/nBoardView";
	}
	
	//코로나 공지사항
	@RequestMapping(value="/board/covid")
	public String covid(ModelMap model, HttpServletRequest request, HttpServletResponse response)
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
		
		return "/board/covid";
	}
	
}
