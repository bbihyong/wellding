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
import com.icia.web.model.WDHall;
import com.icia.web.model.WDRez;
import com.icia.web.model.WDUser;
import com.icia.web.service.WDHallService;
import com.icia.web.service.WDRezService;
import com.icia.web.service.WDUserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("WDHallController")
public class WDHallController {
   
   private static Logger logger= LoggerFactory.getLogger(WDHallController.class);
   
      //쿠키명
      @Value("#{env['auth.cookie.name']}")
      private String AUTH_COOKIE_NAME;
      
      @Autowired
      private WDUserService wdUserService;
      
      //파일저장경로
      @Value("#{env['upload.save.dir']}")
      private String UPLOAD_SAVE_DIR; 
      
      @Autowired
      private WDHallService wdHallService;
      
      @Autowired
      private WDRezService wdRezService;
      
      private static final int LIST_COUNT = 9; //한 페이지의 게시물 수
      private static final int PAGE_COUNT = 3; //페이징 수
      
      @RequestMapping(value="/hsdm/halllist")
      public String list(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
         
         String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
         
         //조회항목(1:웨딩홀 이름, 2: 홀 이름)
         String searchType = HttpUtil.get(request, "searchType", "");
         //조회값
         String searchValue = HttpUtil.get(request, "searchValue", "");
         //현재 페이지
         long curPage = HttpUtil.get(request, "curPage", (long)1);
          String whCode = HttpUtil.get(request, "WHCode", "");
          String hCode = HttpUtil.get(request, "HCode", "");
          
          //결혼날짜 폼 데이터 가져오기
          String year = HttpUtil.get(request, "year", "");
          String month = HttpUtil.get(request, "month", "");
          String day = HttpUtil.get(request, "day", "");
          //결혼날짜 합치기
          String wDate = year+month+day;
         
         
         WDUser wdUser = null;
         wdUser = wdUserService.userSelect(cookieUserId);
         
         if(wdUser != null) {
            model.addAttribute("wdUser",wdUser);
         }
         
         long totalCount = 0;
         List<WDHall> list = null;
         
         
         Paging paging = null;
         WDHall wdHall = new WDHall();
         
         System.out.println("서치 타입 : "+ searchType);
         System.out.println("서치 밸류 : "+ searchValue);
         
         if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
         {
            wdHall.setSearchType(searchType);
            wdHall.setSearchValue(searchValue);
            System.out.println("들어갔음");
         }
         else
         {
            searchType = "";
            searchValue = "";
         }
         //결혼날짜 객체에 세팅
         if(!StringUtil.isEmpty(wDate)) {
            wdHall.setwDate(wDate);
         }
         else {
            wDate = "";
         }
         
         wdHall.setWHCode(whCode);
         
         totalCount = wdHallService.WDHallListCount(wdHall);
         
         logger.debug("totalCount : " + totalCount);
         
         if(totalCount > 0) {
            paging = new Paging("/hsdm/halllist", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage"); //페이징처리 : 인수값이 있다 = 생성자가 있다
            
            paging.addParam("searchType", searchType);
            paging.addParam("searchValue", searchValue);
            paging.addParam("curPage", curPage);
            
            wdHall.setStartRow(paging.getStartRow());
            wdHall.setEndRow(paging.getEndRow());
            
            list = wdHallService.WDHallList(wdHall);
         }
            
          model.addAttribute("year",year);
          model.addAttribute("month",month);
          model.addAttribute("day",day);
         model.addAttribute("list", list);
         model.addAttribute("searchType", searchType);
         model.addAttribute("searchValue", searchValue);
         model.addAttribute("curPage", curPage);
         model.addAttribute("paging",paging);
         
         return "/hsdm/halllist";
      }
      
      @RequestMapping(value="/hsdm/HallView")
      public String hallView(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
         
         //조회항목(1:웨딩홀 이름, 2: 홀 이름)
         String searchType = HttpUtil.get(request, "searchType", "");
         //조회값
         String searchValue = HttpUtil.get(request, "searchValue", "");
         //현재 페이지
         long curPage = HttpUtil.get(request, "curPage", (long)1);

		   String whCode = HttpUtil.get(request, "WHCode", "");
		   String hCode = HttpUtil.get(request, "HCode", "");
		   
		   //의수 추가
		   //검색 조건에 날짜가 있으면 받아야 함
		   String year = HttpUtil.get(request, "year", "");
		   String month = HttpUtil.get(request, "month", "");
		   String day = HttpUtil.get(request, "day", "");
		   
		   String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		   
			WDUser wdUser = null;
			wdUser = wdUserService.userSelect(cookieUserId);
			
			if(wdUser != null) {
				model.addAttribute("wdUser",wdUser);
			}
		   
		   WDHall wdHall = new WDHall();
		   
		   List<WDHall> sameCom = null;
		   
		   if(!StringUtil.isEmpty(whCode) && !StringUtil.isEmpty(hCode)) {
			   
			   wdHall.setWHCode(whCode);
			   wdHall.setHCode(hCode);
			   
			   wdHall = wdHallService.WDHallSelect(wdHall);
			   
			   model.addAttribute("wdHall",wdHall);
			   
			   sameCom = wdHallService.hallSameCom(wdHall);
			   
			   model.addAttribute("sameCom", sameCom);
			   
			   String imgName = wdHall.getHImgName();
			   imgName = imgName.replace(".jpg", "");
			   imgName = imgName.replace(".png", "");
			   
			   //String[] subImg = new String[wdHall.gethSubImg()];
			   
			   ArrayList<String> subImg = new ArrayList<String>();
			   for(int i=0;i<wdHall.gethSubImg();i++) {
				 //  subImg[i] = imgName + "_" + (i+1)+".jpg";
				   subImg.add(imgName + "_" + (i+1)+".jpg");
			   }			   			
			   
			   model.addAttribute("subImg",subImg);
			   model.addAttribute("searchType", searchType);
			   model.addAttribute("searchValue", searchValue);
			   model.addAttribute("year", year);
			   model.addAttribute("month", month);
			   model.addAttribute("day", day);
			   model.addAttribute("curPage", curPage);
		   }		   
		   
		   return "/hsdm/HallView";
	   }
	   
	   
	   
	   //홀 장바구니 담기 버튼 누르면 실행되는 컨트롤러 정의
	   @RequestMapping(value="/hsdm/hallRezProc", method=RequestMethod.POST)
	   @ResponseBody
	   public Response<Object> hallRezProc(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	   {
		   Response<Object> ajaxResponse = new Response<Object>();
		   
		   String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		   String whCode = HttpUtil.get(request, "whCode", "");
		   String hCode = HttpUtil.get(request, "hCode", "");
		   
		    //결혼날짜 폼 데이터 가져오기
		    String year = HttpUtil.get(request, "year", "");
		    String month = HttpUtil.get(request, "month", "");
		    String day = HttpUtil.get(request, "day", "");
		    //결혼날짜 합치기
		    String wDate = year+month+day;
		   
		    System.out.println("==================================wDate : "+wDate+"year "+year+" month "+month+" day "+ day);
		   
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
					   wdRez.sethCode(hCode);
					   wdRez.setWhCode(whCode);
					   
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
						   if(wdHallService.rezNoHallTotalInsert(wdRez)>0) 
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
					   
					   //search = wdRezService.rezSelect(wdUser.getUserId());
					   wdRez = wdRezService.rezSelect(search);
					   wdRez = wdRezService.rezList(wdRez);
					   
					   if(wdRez != null) 
					   {
						   System.out.println("여긴타니 99");
						   if(StringUtil.isEmpty(wdRez.gethCode()) && StringUtil.isEmpty(wdRez.getWhCode())) 
						   {
							   System.out.println("여긴타니 10101010");
							   //홀 코드 존재하지 않음. 홀은 안담았어!!
							   //wdRez객체에 홀코드 예식장코드 담음.
							   wdRez.sethCode(hCode);
							   wdRez.setWhCode(whCode);
							   
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
							   System.out.println("=======================이거 몇뜨니??? 몇뜰까??"+wdRez.getwDate());
							   
							   if(wdRezService.rezHallInsert(wdRez) >0 ) 
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

