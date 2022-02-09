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
import com.icia.web.model.WDExpert;
import com.icia.web.model.WDUser;
import com.icia.web.service.WDExpertService;
import com.icia.web.service.WDUserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("wdExpertContrller")
public class WDExpertController 
{
	private static Logger logger = LoggerFactory.getLogger(WDExpertController.class);
	
	//쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//파일저장경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired
	private WDExpertService wdExpertService;
	
	//유저서비스
	@Autowired
	private WDUserService wdUserService;
	
	private static final int LIST_COUNT = 12;
	private static final int PAGE_COUNT = 10;
	
	//업체 불러와서 화면에 보여주기
	@RequestMapping(value="/board/specialist")
	public String expertList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
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
		
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		String eCode = HttpUtil.get(request, "eCode", "");
		
		long totalCount = 0;
		
		List<WDExpert> list = null;
		
		Paging paging = null;
		
		WDExpert search = new WDExpert();
		
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
		
		totalCount = wdExpertService.expertListCount(search);
		
		if(totalCount > 0)
		{
			paging = new Paging("/board/specialist", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);

			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = wdExpertService.expertList(search);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		
		return "/board/specialist";
		
	}
	
	//상세페이지 보기
	@RequestMapping(value="/board/gosu")
	public String expertView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//상세페이지에 필요한거 가져오기
		String eCode = HttpUtil.get(request, "eCode", "");
		
		//List<WDExpert> list = null;
		
		WDExpert wdExpert = null;
		
		System.out.println("이거다 : "+eCode);
		
		if(eCode != "")
		{
			
			wdExpert = wdExpertService.expertSelect(eCode);
			System.out.println("qhgusqkqh"+wdExpert.geteEmail());
			
			model.addAttribute("wdExpert", wdExpert);
			
			String eImgname = wdExpert.geteImgname();
		}
		
		model.addAttribute("eCode", eCode);
		model.addAttribute("wdExpert", wdExpert);
		
		return "/board/gosu";
	}
}
