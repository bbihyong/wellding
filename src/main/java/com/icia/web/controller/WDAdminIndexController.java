package com.icia.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.WDAdmin;
import com.icia.web.model.WDAdminUser;
import com.icia.web.model.WDDress;
import com.icia.web.model.WDDressFile;
import com.icia.web.model.WDEBoard;
import com.icia.web.model.WDHall;
import com.icia.web.model.WDHallFile;
import com.icia.web.model.WDMakeUp;
import com.icia.web.model.WDMakeUpFile;
import com.icia.web.model.WDNBoard;
import com.icia.web.model.WDStudio;
import com.icia.web.model.WDStudioFile;
import com.icia.web.model.WDUser;
import com.icia.web.service.WDAdminService;
import com.icia.web.service.WDAdminUserService;
import com.icia.web.service.WDDressService;
import com.icia.web.service.WDEBoardService;
import com.icia.web.service.WDHallService;
import com.icia.web.service.WDMakeUpService;
import com.icia.web.service.WDNBoardService;
import com.icia.web.service.WDRezService;
import com.icia.web.service.WDStudioService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;

@Controller("wdAdminIndexController")
public class WDAdminIndexController 
{
   private static Logger logger = LoggerFactory.getLogger(WDAdminIndexController.class);
   
   @Autowired
   private WDAdminService wdAdminService;
   
   @Autowired
   private WDAdminUserService wdAdminUserService;
   
    @Autowired
    private WDHallService wdHallService;
   
    @Autowired
    private WDRezService wdRezService;
    
    @Autowired
   private WDStudioService wdStudioService;
    
    @Autowired
   private WDDressService wdDressService;
    
    @Autowired
   private WDMakeUpService wdMakeUpService;
    
    @Autowired
    private WDNBoardService wdNBoardService;
    
    @Autowired
    private WDEBoardService wdEboardService;
    
    
   @Value("#{env['upload.save.dir']}")
   private String UPLOAD_SAVE_DIR;
   
   //홀파일저장경로
   @Value("#{env['upload.save.hall']}")
   private String UPLOAD_SAVE_HALL;
   
   //홀파일저장경로
   @Value("#{env['upload.save.hallsub']}")
   private String UPLOAD_SAVE_HALLSUB;
   
   //스튜디오 저장경로
   @Value("#{env['upload.save.studio']}")
   private String UPLOAD_SAVE_STUDIO;
   
   //드레스 저장경로
   @Value("#{env['upload.save.dress']}")
   private String UPLOAD_SAVE_DRESS;
   
   //메이크업 저장경로
   @Value("#{env['upload.save.makeup']}")
   private String UPLOAD_SAVE_MAKEUP;

   //쿠키명
   @Value("#{env['auth.cookie.name']}")
   private String AUTH_COOKIE_NAME;
   
   private static final int LIST_COUNT = 10;
   private static final int PAGE_COUNT = 5;
   
   @RequestMapping(value="/mng/login") ///manager/index =>>로그인페이지!!
   @ResponseBody
   public Response<Object> mngIndex(HttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> ajaxResponse = new Response<Object>();
      String adminId = HttpUtil.get(request, "userId");
      String admPwd = HttpUtil.get(request, "userPwd");
      System.out.println("탓어용~~~~~~~~~~~~~~");
      if(!StringUtil.isEmpty(adminId) && !StringUtil.isEmpty(admPwd)) 
      {
         WDAdmin admin = wdAdminService.wdAdminSelect(adminId);
         
         if(admin != null)
         {
            if(StringUtil.equals(admin.getAdmPwd(), admPwd))
            {
               if(StringUtil.equals(admin.getStatus(), "Y"))
               {
                  CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME, CookieUtil.stringToHex(adminId));
                  System.out.println("쿠키"+CookieUtil.stringToHex(adminId));
                  ajaxResponse.setResponse(0, "Success"); // 로그인 성공
               }
               else
               {
                  ajaxResponse.setResponse(403, "Not Found"); // 정지된 아이디!
               }
            }
            else
            {
               ajaxResponse.setResponse(-1, "Passwords do not match"); // 비밀번호 불일치
            }
         }
         else
         {
            ajaxResponse.setResponse(404, "Not Found"); // 사용자 정보 없음 (Not Found)
         }
      }
      else
      {
         ajaxResponse.setResponse(400, "Bad Request"); // 파라미터가 올바르지 않음 (Bad Request)
      }
      
      if(logger.isDebugEnabled())
      {
         logger.debug("[WDAdminIndexController]/mng/login \n" + JsonUtil.toJsonPretty(ajaxResponse));
      }
      
      return ajaxResponse;
   }
   
   @RequestMapping(value="/mng/userList")
   public String userList(Model model,HttpServletRequest request, HttpServletResponse response)
   {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      
      String status = HttpUtil.get(request, "status"); //변수명에 대한 값을 읽어오기!
      //검색타입 (1:회원아이디, 2:회원명)
      String searchType = HttpUtil.get(request, "searchType");
      String searchValue = HttpUtil.get(request, "searchValue");
      
      //이건 유저테이블 유저 객체
      WDAdminUser wdAdminUser = new WDAdminUser();
      //이건 리스트 객체
      List<WDAdminUser> userList = null;
      
      //닉네임 달려구
      WDAdmin wdAdmin = wdAdminService.wdAdminSelect(cookieUserId);
      
      //현재페이지
      long curPage = HttpUtil.get(request, "curPage", (long)1);
      
      //총 게시물 수
      long totalCount = 0;
      //페이징객체
      Paging paging = null;
      
      //매개변수로 받은 status 먼저 셋팅
      wdAdminUser.setStatus(status);
      
      //서치타입과 서치밸유 값이 비어있는지 체크
      if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
      {
         if(StringUtil.equals(searchType, "1"))
         {
            wdAdminUser.setUserId(searchValue);
         }
         else if(StringUtil.equals(searchType, "2"))
         {
            wdAdminUser.setUserName(searchValue);
         }
         else
         {
            searchType = "";
            searchValue = "";
         }
      }
      else
      {
         searchType = "";
         searchValue = "";
      }
      
      totalCount = wdAdminUserService.wdAdmUserListCount(wdAdminUser);
      
      if(totalCount > 0) {
         paging = new Paging("/mng/userList", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
         
         paging.addParam("status", status);
         paging.addParam("searchType", searchType);
         paging.addParam("searchValue", searchValue);
         paging.addParam("curPage", curPage);
         
         //User객체에 스타트로우,엔드로우 보내기
         wdAdminUser.setStartRow(paging.getStartRow());
         wdAdminUser.setEndRow(paging.getEndRow());
         
         //유저 리스트 가져옴 (검색했으면 검색된 값을만)
         userList = wdAdminUserService.wdAdmUserList(wdAdminUser);
         //System.out.println("이거다 : "+userList.get(0).getUserName());
      }
      //list객체에 넣을거! 모델객체사용
      model.addAttribute("userList", userList);
      model.addAttribute("wdAdmin",wdAdmin);
      model.addAttribute("searchType", searchType);
      model.addAttribute("searchValue", searchValue);
      model.addAttribute("status", status);
      model.addAttribute("curPage", curPage);
      model.addAttribute("paging", paging);
      
      
      return "/mng/userList";
   }
   
   @RequestMapping(value="/mng/MngUserUpdate")
   public String userUpdate(Model model,HttpServletRequest request, HttpServletResponse response)
   {
      
      //jps에 뿌려야하니까 Model 매개변수를 받음. 화면에서 보면 유저아이디만 처리하므로 유저아이디만 가져옴
      String userId = HttpUtil.get(request, "userId");
      
      if(!StringUtil.isEmpty(userId))
      {
         //user정보조회
         WDAdminUser wdAdminUser = wdAdminUserService.wdAdminUserSelect(userId);
         
         if(wdAdminUser != null)
         {
            //널이 아니면 써야하니까
            model.addAttribute("wdAdminUser", wdAdminUser); //앞은 jsp에 사용할 이름, 뒤는 메소드내에 있는 메소드변수명
         }
      }
      
      return "/mng/MngUserUpdate";
   }
   
   //회원정보 수정
      @RequestMapping(value="/mng/userupdateProc", method=RequestMethod.POST)
      @ResponseBody
      public Response<Object> updateProc(HttpServletRequest request, HttpServletResponse response)
      {
         Response<Object> res = new Response<Object>();
         
         //관리가가 새로 입력한 정보들 받기
         String userId = HttpUtil.get(request, "userId");
         String userPwd = HttpUtil.get(request, "userPwd");
         String userName = HttpUtil.get(request, "userName");
         String userEmail = HttpUtil.get(request, "userEmail");
         String userNickname = HttpUtil.get(request, "userNickname");
         String status = HttpUtil.get(request, "status");
         String uPoint = HttpUtil.get(request, "userPoint");
         int userPoint = Integer.parseInt(uPoint);
         
         if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userName) && 
               !StringUtil.isEmpty(userNickname) && !StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(status)
            && !StringUtil.isEmpty(userPoint)
        		 )
         {
            //500번 오류 막기위한 처리 (주소치고오는 애들 막아주기)
            WDAdminUser wdAdminUser = wdAdminUserService.wdAdminUserSelect(userId);
            
            if(wdAdminUser != null)
            {
               //원래 있던 유저의 정보를 새로받은걸로 값 넣어주기
               wdAdminUser.setUserPwd(userPwd);
               wdAdminUser.setUserName(userName);
               wdAdminUser.setUserEmail(userEmail);
               wdAdminUser.setUserNickname(userNickname);
               wdAdminUser.setStatus(status);
               wdAdminUser.setUserPoint(userPoint);
               
               if(wdAdminUserService.wdAdmUserUpdate(wdAdminUser) > 0)
               {
                  //성공
                  res.setResponse(0, "Success");
               }
               else
               {
                  res.setResponse(-1, "Fail");
               }
            }
            else
            {
               //정보가 없음
               res.setResponse(404, "Not Found");
            }
         }
         else
         {
            //값이 하나라도 없으면 파라미터 오류
            res.setResponse(400, "Bad Request");
         }
         
         return res;
      }
      
      //메이크업 수정
      @RequestMapping(value="/mng/makeupupdateProc", method=RequestMethod.POST)
      @ResponseBody
      public Response<Object> makeupupdateProc(HttpServletRequest request, HttpServletResponse response)
      {
    	  Response<Object> res = new Response<Object>();
    	  
    	  //관리가가 새로 입력한 정보들 받기
    	  String mCode = HttpUtil.get(request, "mCode", "");
    	  String mkName = HttpUtil.get(request, "makeupName", "");
          String mkLocation = HttpUtil.get(request, "makeupLocation", "");
          String mkNumber = HttpUtil.get(request, "makeupnumber", "");
          long mkPrice = HttpUtil.get(request, "makeupprice",(long)0);
          String mkContent = HttpUtil.get(request,"makeupContent", "");
          long mkPlus = HttpUtil.get(request, "makeupPlus",(long)0);
          long mkDiscount = HttpUtil.get(request, "makeupdiscount",(long)0);
      
          
          if(!StringUtil.isEmpty(mCode) && !StringUtil.isEmpty(mkName) &&
                  !StringUtil.isEmpty(mkLocation) && !StringUtil.isEmpty(mkNumber) && !StringUtil.isEmpty(mkPrice) &&
                  !StringUtil.isEmpty(mkContent) && !StringUtil.isEmpty(mkDiscount))
          {
        	  WDMakeUp wdmakeup = new WDMakeUp();
        	  System.out.println("여기까지오냐111111111");
        	  
	         if(wdmakeup != null)
	         {
	            //새로받은걸로 값 넣어주기
	        	 wdmakeup.setmCode(mCode);
	        	 wdmakeup.setmName(mkName);
	             wdmakeup.setmLocation(mkLocation);
	             wdmakeup.setmNumber(mkNumber);
	             wdmakeup.setmPrice(mkPrice);
	             wdmakeup.setmContent(mkContent);
	             wdmakeup.setmPlus(mkPlus);
	             wdmakeup.setmDiscount(mkDiscount);
	             
	             System.out.println("여기까지오냐22222222222");
	            
	            
	            if(wdMakeUpService.makeupUpdate(wdmakeup) > 0)
	            {
	               //성공
	               res.setResponse(0, "Success");
	               System.out.println("여기까지오냐33333333333");
	            }
	            else
	            {
	               res.setResponse(-1, "Fail");
	               System.out.println("여기까지오냐44444444444");
	            }
	         }
	         else
	         {
	            //정보가 없음
	            res.setResponse(404, "Not Found");
	            System.out.println("여기까지오냐555555555");
	         }
      }
      else
      {
         //값이 하나라도 없으면 파라미터 오류
         res.setResponse(400, "Bad Request");
         System.out.println("여기까지오냐666666666666");
      }
      
      return res;
   }
      
    //메이크업 삭제하기
      @RequestMapping(value="/mng/makeupComDelete")
      @ResponseBody
      public Response<Object> makeupComDelete(HttpServletRequest request, HttpServletResponse response)
      {
      	Response<Object> res = new Response<Object>();
      	
      	String mCode = HttpUtil.get(request, "mCode", "");
      	
     
      	
      	if(!StringUtil.isEmpty(mCode))
    	   {
      		WDMakeUp wdmakeup = wdMakeUpService.onlyMakeupComSelect(mCode);
     		   
     		   if(wdmakeup != null) 
     		   {
     			   //널이 아닐때
				   if(wdMakeUpService.onlyMakeupComDelete(wdmakeup.getmCode()) > 0)
					
				   {
					   //0보다 크면 정상적으로 삭제됬따
					   res.setResponse(0, "Success");
				   }
				   else
				   {
					   //아니야. 삭제못했어
					   res.setResponse(500, "Internal Server Error");
				   }
     		   }
     		   else
     		   {
     			   //널일때 = 게시물이 없다
     			  res.setResponse(404, "Not Found");
     		   }
     	   }
     	   else
     	   {
     		   //0이거나 0보다 작을때는 안넘어온거임
     		  res.setResponse(400, "Bad Request");
     	   }
      	
      	return res;
      }
      
      @RequestMapping(value="/mng/hsdmList")
      public String hsdmList(Model model,HttpServletRequest request, HttpServletResponse response)
      {
         //홀스드메 리스트 페이징 처리를 위한 개수 체크 변수
         long hTotalCount = 0;
         long sTotalCount = 0;
         long dTotalCount = 0;
         long mTotalCount = 0;
         
         //홀스드메 리스트를 조회 할때 쓸 객체 선언 (검색기능도 이 객체에서 처리함)
         WDHall wdHall = new WDHall();
         WDStudio wdStudio = new WDStudio();
         WDDress wdDress = new WDDress();
         WDMakeUp wdMakeUp = new WDMakeUp();
         
         //홀스드메 정보가 담길 리스트 객체 선언
         List<WDHall> hList = null;
         List<WDStudio> sList = null;
         List<WDDress> dList = null;
         List<WDMakeUp> mList = null;
         
         //페이징 처리시 어디서 했는지 확인용
         int hsdmCheck = HttpUtil.get(request, "hsdmCheck", 1);
         model.addAttribute("hsdmCheck",hsdmCheck);
         
         //쿠키 조회
          String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
         //닉네임 달거야
          WDAdmin wdAdmin = wdAdminService.wdAdminSelect(cookieUserId);
         //조회항목
         String searchType = HttpUtil.get(request, "searchType", "");
         //조회값
         String searchValue = HttpUtil.get(request, "searchValue", "");
         //현재 페이지
         long curPage = HttpUtil.get(request, "curPage", (long)1);
         
         //홀스드메 코드 조회
          String whCode = HttpUtil.get(request, "WHCode", "");
          String hCode = HttpUtil.get(request, "HCode", "");
         String sCode = HttpUtil.get(request, "sCode", "");
         String dcCode = HttpUtil.get(request, "dcCode", "");
         String dNo = HttpUtil.get(request, "dNo", ""); 
         String mCode = HttpUtil.get(request, "mCode", "");
         
         //홀스드메 페이징 처리 객체
         Paging hPaging = null;
         Paging sPaging = null;
         Paging dPaging = null;
         Paging mPaging = null;
         
         //각 홀스드메 객체마다 코드값 삽입
         wdHall.setWHCode(whCode);
         wdHall.setHCode(hCode);
         wdStudio.setsCode(sCode);
         wdDress.setDcCode(dcCode);
         wdDress.setdNo(dNo);
         wdMakeUp.setmCode(mCode);
         
         //홀스드메 각각 리스트가 총 몇개인지 개수 체크
         hTotalCount = wdHallService.WDHallListCount(wdHall);
         sTotalCount = wdStudioService.studioListCount(wdStudio);
         dTotalCount = wdDressService.dressListCount(wdDress);
         mTotalCount = wdMakeUpService.makeUpListCount(wdMakeUp);
         ////mTotalCount = wdMakeUpService.makeUpListCountmr(wdMakeUp); //이거아니래 마이너스필요업쪄
         
         //홀 페이징 처리
         if(hTotalCount > 0)
         {
            hPaging = new Paging("/mng/hsdmList", hTotalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage"); //페이징처리 : 인수값이 있다 = 생성자가 있다
            
            hPaging.addParam("searchType", searchType);
            hPaging.addParam("searchValue", searchValue);
            hPaging.addParam("curPage", curPage);
            
            wdHall.setStartRow(hPaging.getStartRow());
            wdHall.setEndRow(hPaging.getEndRow());
            
            hList = wdHallService.WDHallList(wdHall);
         }
         //스튜디오 페이징 처리
         if(sTotalCount > 0)
         {
            sPaging = new Paging("/mng/hsdmList", sTotalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage"); //페이징처리 : 인수값이 있다 = 생성자가 있다
            
            sPaging.addParam("searchType", searchType);
            sPaging.addParam("searchValue", searchValue);
            sPaging.addParam("curPage", curPage);
            
            wdStudio.setStartRow(sPaging.getStartRow());
            wdStudio.setEndRow(sPaging.getEndRow());
            
            sList = wdStudioService.studioList(wdStudio);
         }
         //드레스 페이징 처리
         if(dTotalCount > 0)
         {
            dPaging = new Paging("/mng/hsdmList", dTotalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage"); //페이징처리 : 인수값이 있다 = 생성자가 있다
            
            dPaging.addParam("searchType", searchType);
            dPaging.addParam("searchValue", searchValue);
            dPaging.addParam("curPage", curPage);
            
            wdDress.setStartRow(dPaging.getStartRow());
            wdDress.setEndRow(dPaging.getEndRow());
            
            dList = wdDressService.dressList(wdDress);
         }
         //메이크업 페이징 처리
         if(mTotalCount > 0)
         {
            mPaging = new Paging("/mng/hsdmList", mTotalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage"); //페이징처리 : 인수값이 있다 = 생성자가 있다
            
            mPaging.addParam("searchType", searchType);
            mPaging.addParam("searchValue", searchValue);
            mPaging.addParam("curPage", curPage);
            
            wdMakeUp.setStartRow(mPaging.getStartRow());
            wdMakeUp.setEndRow(mPaging.getEndRow());
            
            mList = wdMakeUpService.makeUpList(wdMakeUp);
            //mList = wdMakeUpService.makeUpListMinusRez(wdMakeUp); //이거아니래 마이너스필요없쪄,,
         }
         
         model.addAttribute("wdAdmin",wdAdmin);
         model.addAttribute("hList", hList);
         model.addAttribute("hPaging",hPaging);
         model.addAttribute("sList", sList);
         model.addAttribute("sPaging",sPaging);
         model.addAttribute("dList", dList);
         model.addAttribute("dPaging",dPaging);
         model.addAttribute("mList", mList);
         model.addAttribute("mPaging",mPaging);
         model.addAttribute("searchType", searchType);
         model.addAttribute("searchValue", searchValue);
         model.addAttribute("curPage", curPage);      
         
         return "/mng/hsdmList";
      }

      @RequestMapping(value="/mng/plusWHall")
      public String plusWHall(Model model,HttpServletRequest request, HttpServletResponse response) 
      {   
         return "/mng/plusWHall";
      }
      
      @RequestMapping(value="/mng/weddinghallWrite")
      @ResponseBody
      public Response<Object> weddinghallWrite(HttpServletRequest request, HttpServletResponse response)
      {
         
         Response<Object> ajaxResponse = new Response<Object>();
         
         //가장 큰 웨딩홀 코드를 받아와서 W제거
         String maxWHCode = wdHallService.maxWHCode();
         maxWHCode = maxWHCode.replace("W", "");      
         //W 제거 후 남은 숫자를 int 형으로 바꿔서 1을 더해줌
         int whCodePlus = Integer.parseInt(maxWHCode)+1;
         //해당 숫자앞에 다시 W를 추가하여 숫자와 붙여서 문자열로 만듬
         maxWHCode = "W"+whCodePlus;
         
         String whName = HttpUtil.get(request, "weddinghallName", "");
         String WHLocation = HttpUtil.get(request, "weddinghallLocation", "");
         String whNumber = HttpUtil.get(request, "weddinghallNumber", "");
         String whContent = HttpUtil.get(request, "weddinghallContent", "");
         
         WDHall wdHall = new WDHall();
         wdHall.setWHCode(maxWHCode);
         wdHall.setWhName(whName);
         wdHall.setWHLocation(WHLocation);
         wdHall.setWhNumber(whNumber);
         wdHall.setWhContent(whContent);
         
         if(!StringUtil.isEmpty(whName) && !StringUtil.isEmpty(WHLocation) && !StringUtil.isEmpty(whNumber) && !StringUtil.isEmpty(whContent)) {
            if(wdHallService.weddinghallInsert(wdHall) > 0) {
               ajaxResponse.setResponse(0, "Success");
            }
            else {
               ajaxResponse.setResponse(-1, "Error");
            }
         }
         else {
            ajaxResponse.setResponse(400, "Not Paremeter");
         }
         
         return ajaxResponse;
      }
      
      @RequestMapping(value="/mng/plusHall")
      public String plusHall(Model model,HttpServletRequest request, HttpServletResponse response) 
      {   
         List<WDHall> HCodeName = null;
         HCodeName = wdHallService.whNameAndCode();
         model.addAttribute("HCodeName",HCodeName);
         
         return "/mng/plusHall";
      }
      
      @RequestMapping(value="/mng/hallWrite")
      @ResponseBody
      public Response<Object> hallWrite(MultipartHttpServletRequest request, HttpServletResponse response)
      {
         
         Response<Object> ajaxResponse = new Response<Object>();
         
         String whCode = HttpUtil.get(request, "whCode", "");
         String hallName = HttpUtil.get(request, "hallName", "");
         long hallPrice = HttpUtil.get(request, "hallPrice", (long)0);
         long hallFood = HttpUtil.get(request, "hallFood", (long)0);
         long hallMin = HttpUtil.get(request, "hallMin", (long)0);
         long hallMax = HttpUtil.get(request, "hallMax", (long)0);
         String hallContent = HttpUtil.get(request, "hallContent", "");
//         String hallImgName = HttpUtil.get(request, "hallImgName", "");
         String maxName = wdHallService.maxImgName();
         maxName = maxName.replace("H", "");
         maxName = maxName.replace(".jpg", "");
         maxName = maxName.replace(".png", "");
         int namePlus = Integer.parseInt(maxName)+1;
         maxName = "H"+namePlus;
         
    	 namePlus++;
    	 String subImgName1 = maxName+"_1";   
    	 
    	 namePlus++;
    	 String subImgName2 = maxName+"_2";
         
         //홀 파일 첨부
         FileData fileData1 = HttpUtil.getFile(request, "hallImgName1", UPLOAD_SAVE_HALL,maxName);
         FileData fileData2 = HttpUtil.getFile(request, "hallImgName2", UPLOAD_SAVE_HALLSUB,subImgName1);
         FileData fileData3 = HttpUtil.getFile(request, "hallImgName3", UPLOAD_SAVE_HALLSUB,subImgName2);
         
         int subFile = 0;
         
         if(fileData1 == null)
         {
        	 ajaxResponse.setResponse(999, "Not Paremeter");
        	 return ajaxResponse;
         }
         if(fileData2 != null) 
         {
        	 subFile++;
         }
         if(fileData3 != null) {
        	 subFile++;
         }
         
         long hallHDiscount = HttpUtil.get(request, "hallHDiscount", (long)0);
         
         long hCode = wdHallService.maxHCode(whCode)+1;
         String HCode = ""+hCode;
         
         WDHall wdHall = new WDHall();
         
         wdHall.setWHCode(whCode);
         wdHall.setHCode(HCode);
         wdHall.setHName(hallName);
         wdHall.setHPrice(hallPrice);
         wdHall.setHFood(hallFood);
         wdHall.setHMin(hallMin);
         wdHall.setHMax(hallMax);
         wdHall.setHContent(hallContent);
         wdHall.sethDiscount(hallHDiscount);
         wdHall.sethSubImg(subFile);
         
         
         if(!StringUtil.isEmpty(whCode) && !StringUtil.isEmpty(hallName) 
        		 && !StringUtil.isEmpty(hallPrice) && !StringUtil.isEmpty(hallFood)
               && !StringUtil.isEmpty(hallMin) && !StringUtil.isEmpty(hallMax)
               && !StringUtil.isEmpty(hallContent) && !StringUtil.isEmpty(hallHDiscount)) 
         {
     		WDHallFile wdHallSubFile1 = new WDHallFile();
     		WDHallFile wdHallSubFile2 = new WDHallFile();
     		
        	if(fileData1 != null && fileData1.getFileSize() > 0)
        	{
        		WDHallFile wdHallFile = new WDHallFile();
        		
        		wdHallFile.setHFileName(fileData1.getFileName());
        		wdHallFile.setHFileOrgName(fileData1.getFileOrgName());
        		wdHallFile.setHFileExt(fileData1.getFileExt());
        		wdHallFile.setHFileSize(fileData1.getFileSize());
        		wdHallFile.setWHCode(wdHall.getWHCode());
        		wdHallFile.setHCode(wdHall.getHCode());
        		wdHallFile.setHFileSeq(1);
        		
        		wdHall.setHImgName(fileData1.getFileName());
        		
        		wdHall.setWdHallFile(wdHallFile);
        	}
        	try {
	            if(wdHallService.hallInsert(wdHall) > 0) {
	            	if(fileData2 != null && fileData2.getFileSize() > 0) {
	            		wdHallSubFile1.setHFileName(fileData2.getFileName());
	            		wdHallSubFile1.setHFileOrgName(fileData2.getFileOrgName());
	            		wdHallSubFile1.setHFileExt(fileData2.getFileExt());
	            		wdHallSubFile1.setHFileSize(fileData2.getFileSize());
	            		wdHallSubFile1.setWHCode(wdHall.getWHCode());
	            		wdHallSubFile1.setHCode(wdHall.getHCode());
	            		wdHallSubFile1.setHFileSeq(2);
	            		
	            		wdHallService.hallFileInsert(wdHallSubFile1);
	            	}
	            	if(fileData3 != null && fileData3.getFileSize() > 0)
	            	{
	            		wdHallSubFile2.setHFileName(fileData3.getFileName());
	            		wdHallSubFile2.setHFileOrgName(fileData3.getFileOrgName());
	            		wdHallSubFile2.setHFileExt(fileData3.getFileExt());
	            		wdHallSubFile2.setHFileSize(fileData3.getFileSize());
	            		wdHallSubFile2.setWHCode(wdHall.getWHCode());
	            		wdHallSubFile2.setHCode(wdHall.getHCode());
	            		wdHallSubFile2.setHFileSeq(subFile+1);
	            		
	            		wdHallService.hallFileInsert(wdHallSubFile2);
	            	}
	               ajaxResponse.setResponse(0, "Success");
	            }
	            else {
	               ajaxResponse.setResponse(-1, "Error");
	            }
        	}
			catch(Exception e) 
			{
				logger.error("[WDAdminIndexController] /mng/hallWrite Exception", e);
				ajaxResponse.setResponse(500, "Internal Server Error");
			}
         }
         else 
         {
            ajaxResponse.setResponse(400, "Not Paremeter");
         }
         
         return ajaxResponse;
      }         
         
     //스튜디오 관리자페이지 추가
     @RequestMapping(value="/mng/plusStudio")
     public String plusStudio(Model model,HttpServletRequest request, HttpServletResponse response) 
     {   
        return "/mng/plusStudio";
     }
     
     //스튜디오추가 스튜디오첨부파일
     @RequestMapping(value="/mng/studioWrite")
     @ResponseBody
     public Response<Object> studioWrite(MultipartHttpServletRequest request, HttpServletResponse response)
     {    
         Response<Object> ajaxResponse = new Response<Object>();
         
         //가장 큰 웨딩홀 코드를 받아와서 s제거
         String maxSCode = wdStudioService.maxSCode();
         maxSCode = maxSCode.replace("S", "");      
         //W 제거 후 남은 숫자를 int 형으로 바꿔서 1을 더해줌
         int sCodePlus = Integer.parseInt(maxSCode)+1;
         //해당 숫자앞에 다시 W를 추가하여 숫자와 붙여서 문자열로 만듬
         maxSCode = "S"+sCodePlus;

         String sName = HttpUtil.get(request, "studioName", "");
         long sPrice = HttpUtil.get(request, "studioPrice", (long)0);
         String sLocation = HttpUtil.get(request, "studioLocation", "");
         String sNumber = HttpUtil.get(request, "studioNumber", "");
         String sContent = HttpUtil.get(request, "studioNumber","");
         long sDiscount = HttpUtil.get(request, "studioDiscount", (long)0);
         
         String maxName = wdStudioService.maxImgName();
         maxName = maxName.replace("S", "");
         maxName = maxName.replace(".jpg", "");
         maxName = maxName.replace(".png", "");
         int namePlus = Integer.parseInt(maxName)+1;
         maxName = "S"+namePlus; 
         
         FileData fileData = HttpUtil.getFile(request, "studioImg", UPLOAD_SAVE_STUDIO,maxName);
         
         if(fileData == null)
         {
        	 ajaxResponse.setResponse(999, "Not Paremeter");
        	 return ajaxResponse;
         }
        
        
        WDStudio wdStudio = new WDStudio();
        
        wdStudio.setsCode(maxSCode);
        wdStudio.setsName(sName);
        wdStudio.setsPrice(sPrice);
        wdStudio.setsLocation(sLocation);
        wdStudio.setsNumber(sNumber);
        wdStudio.setsContent(sContent);
        wdStudio.setsDiscount(sDiscount);
        wdStudio.setsSubImg(0);
        
        
        if(!StringUtil.isEmpty(sName) && !StringUtil.isEmpty(sPrice) && !StringUtil.isEmpty(sLocation) &&
              !StringUtil.isEmpty(sNumber) && !StringUtil.isEmpty(sContent)  && !StringUtil.isEmpty(sDiscount)) 
        {
        	if(fileData != null && fileData.getFileSize() > 0)
        	{
        		WDStudioFile wdStudioFile = new WDStudioFile();
        		
        		wdStudioFile.setSfileName(fileData.getFileName());
        		wdStudioFile.setsFileOrgName(fileData.getFileOrgName());
        		wdStudioFile.setsFileExt(fileData.getFileExt());
        		wdStudioFile.setsFileSize(fileData.getFileSize());
        		wdStudioFile.setsCode(wdStudio.getsCode());
        		wdStudioFile.setsFileSeq(1);
        		
        		wdStudio.setsImgname(fileData.getFileName());
        		wdStudio.setWdStudoiFile(wdStudioFile);
        	}
        	try {
		           if(wdStudioService.studioInsert(wdStudio) > 0) 
		           {
		              ajaxResponse.setResponse(0, "Success");
		           }
		           else 
		           {
		              ajaxResponse.setResponse(-1, "Error");
		           }
        	}
			catch(Exception e) 
			{
				logger.error("[WDAdminIndexController] /mng/studioWrite Exception", e);
				ajaxResponse.setResponse(500, "Internal Server Error");
			}
        }
        else 
        {
           ajaxResponse.setResponse(400, "Not Paremeter");
        }
        
        return ajaxResponse;
     }
     
     //드레스샵 관리자페이지 추가
     @RequestMapping(value="/mng/plusDressCom")
     public String plusDressCom(Model model,HttpServletRequest request, HttpServletResponse response) 
     {   
        return "/mng/plusDressCom";
     }
  
     //드레스 관리자페이지 추가
     @RequestMapping(value="/mng/plusDress")
     public String plusDress(Model model,HttpServletRequest request, HttpServletResponse response) 
     {   
    	 List<WDDress> dNoName = null;
    	 dNoName = wdDressService.dNoAndName();
    	 model.addAttribute("dNoName", dNoName);
         
        return "/mng/plusDress";
     }
     
     //드레스샵 추가
     @RequestMapping(value="/mng/dressComWrite")
     @ResponseBody
     public Response<Object> dressComWrite(HttpServletRequest request, HttpServletResponse response)
     {
        
        Response<Object> ajaxResponse = new Response<Object>();
        
        String dcName = HttpUtil.get(request, "dresscomName", "");
        String dcLocation = HttpUtil.get(request, "dresscomlocation", "");
        String dcNumber = HttpUtil.get(request, "dresscomnumber", "");
        String dcContent = HttpUtil.get(request, "dresscomcontent", "");
        
        //가장 큰 드레스샵 코드를 받아와서 D제거
        String maxDCCode = wdDressService.maxDCCode();
        maxDCCode = maxDCCode.replace("D", "");      
        //D 제거 후 남은 숫자를 int 형으로 바꿔서 1을 더해줌
        int dcCodePlus = Integer.parseInt(maxDCCode)+1;
        //해당 숫자앞에 다시D를 추가하여 숫자와 붙여서 문자열로 만듬
        maxDCCode = "D" + dcCodePlus;
        
        System.out.println("############# maxDCCode ############# : " + maxDCCode);
        System.out.println("############# dcName ############# : " + dcName);

        WDDress wdDress = new WDDress();
        wdDress.setDcCode(maxDCCode);
        wdDress.setDcName(dcName);
        wdDress.setDcLocation(dcLocation);
        wdDress.setDcNumber(dcNumber);
        wdDress.setDcContent(dcContent);
        
        if(!StringUtil.isEmpty(dcName) && !StringUtil.isEmpty(dcLocation) && !StringUtil.isEmpty(dcNumber) && !StringUtil.isEmpty(dcContent)) 
        {
           if(wdDressService.dressComInsert(wdDress) > 0) 
           {
              ajaxResponse.setResponse(0, "Success");
           }
           else 
           {
              ajaxResponse.setResponse(-1, "Error");
           }
        }
        else 
        {
           ajaxResponse.setResponse(400, "Not Paremeter");
        }
        
        return ajaxResponse;
     }
     
     //드레스추가
     @RequestMapping(value="/mng/dressWrite")
     @ResponseBody
     public Response<Object> dressWrite(MultipartHttpServletRequest request, HttpServletResponse response)
     {
        
        Response<Object> ajaxResponse = new Response<Object>();
        
        //가장 큰드레스 코드 받아오기
        String maxDCode = wdDressService.maxDCode();
        //숫자를 int형으로 바꿔서 1을 더해줌
        int dNoPlus = Integer.parseInt(maxDCode)+1;
        //다시 문자열로 만들기
        maxDCode = "" + dNoPlus;  ///이러면 1000번대로 가면안되눈뎅 ,,,

        String dcCode = HttpUtil.get(request, "dcCode", "");
        String dName = HttpUtil.get(request, "dressname", "");
        long dPrice = HttpUtil.get(request, "dressprice", (long)0);
        String dContent = HttpUtil.get(request, "dresscontent", "");
        long dDiscount = HttpUtil.get(request, "dressdiscount", (long)0);
        
        WDDress wdDress = new WDDress();
        wdDress.setDcCode(dcCode);
        wdDress.setdNo(maxDCode);
        wdDress.setdName(dName);
        wdDress.setdPrice(dPrice);
        wdDress.setdContent(dContent);
        wdDress.setdDiscount(dDiscount);
        
        String maxName = wdDressService.maxImgName();
        maxName = maxName.replace("D", "");
        maxName = maxName.replace(".jpg", "");
        maxName = maxName.replace(".png", "");
        int namePlus = Integer.parseInt(maxName)+1;
        maxName = "D0"+namePlus; 
        
        FileData fileData = HttpUtil.getFile(request, "dressimgname", UPLOAD_SAVE_DRESS,maxName);
        
        if(fileData == null)
        {
       	 ajaxResponse.setResponse(999, "Not Paremeter");
       	 return ajaxResponse;
        }
        
        
        if(!StringUtil.isEmpty(dName) && !StringUtil.isEmpty(dPrice) && !StringUtil.isEmpty(dContent) && !StringUtil.isEmpty(dDiscount)) 
        {
        	if(fileData != null && fileData.getFileSize() > 0)
        	{
        		WDDressFile wdDressFile = new WDDressFile();
        		
        		wdDressFile.setdFileName(fileData.getFileName());
        		wdDressFile.setdFileOrgName(fileData.getFileOrgName());
        		wdDressFile.setdFileExt(fileData.getFileExt());
        		wdDressFile.setdFileSize(fileData.getFileSize());
        		wdDressFile.setdcCode(wdDress.getDcCode());
        		wdDressFile.setdFileSeq(1);
        		
        		wdDress.setdImgname(fileData.getFileName());
        		wdDress.setWdDressFile(wdDressFile);
        	}
        	
        	try 
        	{
	           if(wdDressService.dressInsert(wdDress) > 0) 
	           {
	        	   ajaxResponse.setResponse(0, "Success");
	           }
	           else 
	           {
	              ajaxResponse.setResponse(-1, "Error");
	           }
        	}
			catch(Exception e) 
			{
				logger.error("[WDAdminIndexController] /mng/dressWrite Exception", e);
				ajaxResponse.setResponse(500, "Internal Server Error");
			}
        }
        else 
        {
           ajaxResponse.setResponse(400, "Not Paremeter");
        }
        
        return ajaxResponse;
     }
     
     //관리자 메이크업
     @RequestMapping(value="/mng/plusMakeup")
     public String plusMakeup(Model model,HttpServletRequest request, HttpServletResponse response) 
     {
        return "/mng/plusMakeup";
     }
     
     
     /*@RequestMapping(value="/mng/MngMakeupUpdate")
     public String MngMakeupUpdate(Model model,HttpServletRequest request, HttpServletResponse response) 
     {
    	 
         return "/mng/MngMakeupUpdate";
      }*/
     
   //메이크업 수정창
     @RequestMapping(value="/mng/MngMakeupUpdate")
     public String MngMakeupUpdate(Model model,HttpServletRequest request, HttpServletResponse response) 
     {
    	 //String mkName = HttpUtil.get(request, "mkName");
    	 String mCode = HttpUtil.get(request, "mCode", "");
    	 
    
    	
    	 
    	 WDMakeUp wdmakeup = null;
    	 
    	 if(!StringUtil.isEmpty(mCode))
    	 {
    		 wdmakeup = wdMakeUpService.makeupSelect(mCode);
    		 
    		 model.addAttribute("wdmakeup", wdmakeup);
    		 
    		 
    		 
    		 
    		 
    	 }
    	 
    	
    	 model.addAttribute("wdmakeup", wdmakeup);
    	 System.out.println("mContent" + mCode);
    	
    	 
    	 return "/mng/MngMakeupUpdate";
     }
     
     
     @RequestMapping(value="/mng/makeupWrite")
     @ResponseBody
     public Response<Object> makeupWrite(MultipartHttpServletRequest request, HttpServletResponse response)
     {
        Response<Object> ajaxResponse = new Response<Object>();
        
        String makeupMax = wdMakeUpService.makeupMax();
        makeupMax = makeupMax.replace("M", "");
        int wdMakeupCodePlus = Integer.parseInt(makeupMax)+1;
        makeupMax = "M"+wdMakeupCodePlus;
        
        String mkName = HttpUtil.get(request, "makeupName", "");
        String mkLocation = HttpUtil.get(request, "makeupLocation", "");
        String mkNumber = HttpUtil.get(request, "makeupnumber", "");
        long mkPrice = HttpUtil.get(request, "makeupprice",(long)0);
        String mkContent = HttpUtil.get(request,"makeupContent", "");
        long mkPlus = HttpUtil.get(request, "makeupPlus",(long)0);
        long mkDiscount = HttpUtil.get(request, "makeupdiscount",(long)0);
        
        String maxName = wdMakeUpService.maxImgName();
        maxName = maxName.replace("M", "");
        maxName = maxName.replace(".jpg", "");
        maxName = maxName.replace(".png", "");
        int namePlus = Integer.parseInt(maxName)+1;
        maxName = "M"+namePlus; 
        
        FileData fileData = HttpUtil.getFile(request, "makeupimgname", UPLOAD_SAVE_MAKEUP,maxName);
        
        WDMakeUp wdmakeup = new WDMakeUp();
        
        wdmakeup.setmCode(makeupMax);
        wdmakeup.setmName(mkName);
        wdmakeup.setmLocation(mkLocation);
        wdmakeup.setmNumber(mkNumber);
        wdmakeup.setmPrice(mkPrice);
        wdmakeup.setmContent(mkContent);
        wdmakeup.setmPlus(mkPlus);
        wdmakeup.setmDiscount(mkDiscount);
  
        
        if(!StringUtil.isEmpty(mkName) &&
              !StringUtil.isEmpty(mkLocation) && !StringUtil.isEmpty(mkNumber) && !StringUtil.isEmpty(mkPrice) &&
              !StringUtil.isEmpty(mkContent) && !StringUtil.isEmpty(mkDiscount))
        {
        	
        	if(fileData != null && fileData.getFileSize() > 0)
        	{
        		WDMakeUpFile wdMakeUpFile = new WDMakeUpFile();
        		
        		wdMakeUpFile.setmFileName(fileData.getFileName());
        		wdMakeUpFile.setmFileOrgName(fileData.getFileOrgName());
        		wdMakeUpFile.setmFileExt(fileData.getFileExt());
        		wdMakeUpFile.setmFileSize(fileData.getFileSize());
        		wdMakeUpFile.setmCode(wdmakeup.getmCode());
        		wdMakeUpFile.setmFileSeq(1);
        		
        		wdmakeup.setmImgName(fileData.getFileName());
        		wdmakeup.setWdMakeUpFile(wdMakeUpFile);
        	}
        	
        	try {
		           if(wdMakeUpService.makeupInsert(wdmakeup) > 0) 
		           {
		              ajaxResponse.setResponse(0, "Success");
		           }
		           else 
		           {
		              ajaxResponse.setResponse(-1, "Error");
		           }
        	}
			catch(Exception e) 
			{
				logger.error("[WDAdminIndexController] /mng/makeupWrite Exception", e);
				ajaxResponse.setResponse(500, "Internal Server Error");
			}
        	
        }
        else {
           ajaxResponse.setResponse(400, "Not Paremeter");
        }
        
        return ajaxResponse;
     }
     
     //공지사항 목록 불러오기
     @RequestMapping(value="/mng/nBoardList")
     public String nBoardList(Model model,HttpServletRequest request, HttpServletResponse response)
     {
        //리스트 페이징 처리를 위한 개수 체크 변수
        long nBoardCount = 0;
        
        //리스트를 조회 할때 쓸 객체 선언 (검색기능도 이 객체에서 처리함)
        WDNBoard wdNBoard = new WDNBoard();
        
        //정보가 담길 리스트 객체 선언
        List<WDNBoard> nBList = null;
        
        //쿠키 조회
         String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
        //닉네임 달거야
         WDAdmin wdAdmin = wdAdminService.wdAdminSelect(cookieUserId);
        //조회항목
        String searchType = HttpUtil.get(request, "searchType", "");
        //조회값
        String searchValue = HttpUtil.get(request, "searchValue", "");
        //현재 페이지
        long curPage = HttpUtil.get(request, "curPage", (long)1);
        
        Paging paging = null;
        
        if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
        {
        	wdNBoard.setSearchType(searchType);
        	wdNBoard.setSearchValue(searchValue);
        }
        else
        {
        	searchType = "";
        	searchValue = "";
        }
        
        //리스트 갯수체크
        nBoardCount = wdNBoardService.nBoardListCount(wdNBoard);
        logger.debug("nBoardCount : " + nBoardCount);
        
        if(nBoardCount > 0)
        {
        	paging = new Paging("/mng/nBoardList", nBoardCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
        	paging.addParam("searchType", searchType);
        	paging.addParam("searchValue", searchValue);
        	paging.addParam("curPage", curPage);
        	
        	wdNBoard.setStartRow(paging.getStartRow());
        	wdNBoard.setEndRow(paging.getEndRow());
        	
        	nBList = wdNBoardService.nBoardList(wdNBoard);
        }
        
        
        model.addAttribute("wdAdmin",wdAdmin);
        model.addAttribute("nBList", nBList);
        model.addAttribute("paging",paging);
        model.addAttribute("searchType", searchType);
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("curPage", curPage);      
        
        return "/mng/nBoardList";
     }

     
     //공지사항 수정페이지 내용 불러오기
     @RequestMapping(value="/mng/nBoardUpdate")
     public String nBoardUpdate(Model model,HttpServletRequest request, HttpServletResponse response)
     {
        //수정페이지에 필요한거 받아오기
    	long bSeq = HttpUtil.get(request, "bSeq", (long)0);
    	
    	WDNBoard nBList = null;
    	
    	System.out.println("**************nSeq: " + bSeq);
        
        if(bSeq > 0)
        {
           nBList = wdNBoardService.nBoardSelect(bSeq);
           
           model.addAttribute("nBList", nBList);
        }
        
        model.addAttribute("bSeq", bSeq);
        model.addAttribute("nBList", nBList);
        
        return "/mng/nBoardUpdate";
     }
     
     //공지사항 게시글 수정하기
        @RequestMapping(value="/mng/nBoardUpdateProc", method=RequestMethod.POST)
        @ResponseBody
        public Response<Object> nBoardUpdateProc(HttpServletRequest request, HttpServletResponse response)
        {
           Response<Object> res = new Response<Object>();
           
           //새로입력한 정보 받아오기
           long bSeq = HttpUtil.get(request, "bSeq", (long)0);
           String adminId = HttpUtil.get(request, "adminId", "");
           String bTitle = HttpUtil.get(request, "bTitle", "");
           String bContent = HttpUtil.get(request, "bContent", "");
           
           WDNBoard nBList = null;
           
           if(bSeq > 0 && !StringUtil.isEmpty(bTitle) && !StringUtil.isEmpty(bContent))
           {
        	   //게시글 존재하고, 제목,내용받아옴
        	   nBList = wdNBoardService.nBoardSelect(bSeq);
        	   
        	   if(nBList != null)
        	   {
        		   //새로운 정보 넣어주기
        		   nBList.setbSeq(bSeq);
        		   nBList.setbTitle(bTitle);
        		   nBList.setbContent(bContent);
        		   
        		   if(wdNBoardService.nBoardUpdate(nBList) > 0)
        		   {
        			   res.setResponse(0, "Success");
        		   }
        		   else
        		   {
        			   res.setResponse(-1, "Fail");
        		   }
        		   
        	   }
        	   else
        	   {
        		   res.setResponse(400, "Bad Request");
        	   }
           }
           else 
			{
        	   res.setResponse(400, "Bad Request");
			}
           
           
           return res;
        }


        //공지사항 게시글 등록
        @RequestMapping(value="/mng/plusNBoard")
        public String plusNBoard(Model model, HttpServletRequest request, HttpServletResponse response)
        {
        	return "/mng/plusNBoard";
        }
        
        //공지사항 게시글 추가하기!!
        @RequestMapping(value="/mng/nBoardWrite")
        @ResponseBody
        public Response<Object> nBoardWrite(Model model, HttpServletRequest request, HttpServletResponse response)
        {
            Response<Object> ajaxResponse = new Response<Object>();
            
            String adminId = HttpUtil.get(request, "adminId", "");
            String bTitle = HttpUtil.get(request, "bTitle", "");
            String bContent = HttpUtil.get(request, "bContent", "");
            
            //쿠키 조회
            String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
           //닉네임 달거야
            WDAdmin wdAdmin = wdAdminService.wdAdminSelect(cookieUserId);
            //받아온 값을 엔보드에 넣어주기
        	WDNBoard wdNBoard = new WDNBoard();
        	
        	//wdNBoard.setAdminId("admin"); //안들어가니께 하드코딩해부러
        	wdNBoard.setAdminId(cookieUserId);
        	wdNBoard.setbTitle(bTitle);
        	wdNBoard.setbContent(bContent);
        	
        	//얘가 트렌젝션하래 안하면 오류띄워 이씨
            if(!StringUtil.isEmpty(bTitle) && !StringUtil.isEmpty(bContent))
            {
            	try
            	{
            		if(wdNBoardService.nBoardInsert(wdNBoard) > 0)
                	{
                		ajaxResponse.setResponse(0, "Success");
                	}
                	else
                	{
                		ajaxResponse.setResponse(-1, "Error");
                	}
            	}
            	catch(Exception e)
          	  	{
          		  logger.error("[WDAdminIndexController] /mng/nBoardWrite Exception", e);
          		  ajaxResponse.setResponse(500, "Internal server Error");
          	  	}
            }
            else 
            {
               ajaxResponse.setResponse(400, "Not Paremeter");
            }

            return ajaxResponse;
        }
        
        //공지사항 게시글 삭제
        @RequestMapping(value="/mng/nBoardDelete", method=RequestMethod.POST)
        @ResponseBody
        public Response<Object> nBoardDelete(HttpServletRequest request, HttpServletResponse response)
        {
     	   Response<Object> ajaxResponse = new Response<Object>();
           
     	   long bSeq = HttpUtil.get(request, "bSeq", (long)0);
	       System.out.println("**************이거안받아오는거지 띠바야 bSeq: " + bSeq);
     	   
     	   if(bSeq > 0) //0보다 클떄 실제로 넘어온 값
     	   {
     		  WDNBoard nBList = wdNBoardService.nBoardSelect(bSeq);
     		   
     		   if(nBList != null) //nBList가 널이면 게시물이 없다는거니까 널이 아닐떄 !
     		   {
     			   //널이 아닐때
				   if(wdNBoardService.nBoardDelete(nBList.getbSeq()) > 0)
				   {
					   //0보다 크면 정상적으로 삭제됬따
					   ajaxResponse.setResponse(0, "Success");
				   }
				   else
				   {
					   //아니야. 삭제못했어,,,왜? 왜못하는데 여기걸리는데 왠데 왜? 와이? 와땀시?
					   ajaxResponse.setResponse(500, "Internal Server Error");
				   }
     		   }
     		   else
     		   {
     			   //널일때 = 게시물이 없다
     			   ajaxResponse.setResponse(404, "Not Found");
     		   }
     	   }
     	   else
     	   {
     		   //0이거나 0보다 작을때는 안넘어온거임
     		   ajaxResponse.setResponse(400, "Bad Request");
     	   }
     	   
     	   return ajaxResponse;
        }
        
        
        //드레스업체 수정,삭제 페이지 띄우기
        @RequestMapping(value="/mng/dressComUpdate")
        public String dressComUpdate(Model model,HttpServletRequest request, HttpServletResponse response) 
        {   
        	String dcCode = HttpUtil.get(request, "dcCode", "");
        	//String dNo = HttpUtil.get(request, "dNo", "");
        	
        	WDDress dList = null;
        	
        	System.out.println("******************dcCode : " + dcCode);
        	//System.out.println("******************dNo : " + dNo);
        	
        	if(!StringUtil.isEmpty(dcCode))
        	{
        		dList = wdDressService.onlyDressComSelect(dcCode);
        		
        		model.addAttribute("dList", dList);
        	}
        	
        	model.addAttribute("dcCode", dcCode);
        	model.addAttribute("dList", dList);
        	
        	return "/mng/dressComUpdate";
        }
        
        //드레스업체 삭제하기
        @RequestMapping(value="/mng/dressComDelete")
        @ResponseBody
        public Response<Object> dressComDelete(HttpServletRequest request, HttpServletResponse response)
        {
        	Response<Object> ajaxResponse = new Response<Object>();
        	
        	String dcCode = HttpUtil.get(request, "dcCode", "");
        	
        	System.out.println("***********dcCode : " + dcCode);
        	
        	if(!StringUtil.isEmpty(dcCode))
      	   {
        		WDDress dList = wdDressService.onlyDressComSelect(dcCode);
       		   
       		   if(dList != null) //dList가 널이면 게시물이 없다는거니까 널이 아닐떄 !
       		   {
       			   //널이 아닐때
  				   if(wdDressService.onlyDressComDelete(dList.getDcCode()) > 0)
  				   {
  					   //0보다 크면 정상적으로 삭제됬따
  					 ajaxResponse.setResponse(0, "Success");
  				   }
  				   else
  				   {
  					   //아니야. 삭제못했어
  					 ajaxResponse.setResponse(500, "Internal Server Error");
  				   }
       		   }
       		   else
       		   {
       			   //널일때 = 게시물이 없다
       			ajaxResponse.setResponse(404, "Not Found");
       		   }
       	   }
       	   else
       	   {
       		   //0이거나 0보다 작을때는 안넘어온거임
       		ajaxResponse.setResponse(400, "Bad Request");
       	   }
        	
        	return ajaxResponse;
        }
        
        
        //드레스 수정,삭제 페이지 띄우기
        @RequestMapping(value="/mng/dressUpdate")
        public String dressUpdate(Model model,HttpServletRequest request, HttpServletResponse response) 
        {   
        	String dNo = HttpUtil.get(request, "dNo", "");
        	
        	WDDress dList = null;
        	
        	System.out.println("******************dNo : " + dNo);
        	
        	if(!StringUtil.isEmpty(dNo))
        	{
        		dList = wdDressService.dressSelect(dNo);
        		
        		model.addAttribute("dList", dList);
        	}
        	
        	model.addAttribute("dcCode", dNo);
        	model.addAttribute("dList", dList);
        	
        	return "/mng/dressUpdate";
        }

        //드레스 삭제하기
        @RequestMapping(value="/mng/dressDelete")
        @ResponseBody
        public Response<Object> dressDelete(HttpServletRequest request, HttpServletResponse response)
        {
        	Response<Object> ajaxResponse = new Response<Object>();
        	
        	String dcCode = HttpUtil.get(request, "dcCode", "");
        	String dNo = HttpUtil.get(request, "dNo", "");
        	
        	System.out.println("***********dcCode : " + dcCode);
        	System.out.println("***********dNo : " + dNo);
        	
        	WDDress dList = new WDDress();
        	
        	if(!StringUtil.isEmpty(dcCode) && !StringUtil.isEmpty(dNo))
      	   {
        		dList = wdDressService.dressSelect(dNo);
       		   
       		   if(dList != null) //dList가 널이면 게시물이 없다는거니까 널이 아닐떄 !
       		   {
       			   //널이 아닐때
  				   if(wdDressService.onlyDressDelete(dList) > 0)
  				   {
  					   //0보다 크면 정상적으로 삭제됬따
  					 ajaxResponse.setResponse(0, "Success");
  				   }
  				   else
  				   {
  					   //아니야. 삭제못했어
  					 ajaxResponse.setResponse(500, "Internal Server Error");
  				   }
       		   }
       		   else
       		   {
       			   //널일때 = 게시물이 없다
       			ajaxResponse.setResponse(404, "Not Found");
       		   }
       	   }
       	   else
       	   {
       		   //0이거나 0보다 작을때는 안넘어온거임
       		ajaxResponse.setResponse(400, "Bad Request");
       	   }
        	
        	return ajaxResponse;
        }
        
        //웨딩홀업체 수정,삭제 페이지 띄우기
        @RequestMapping(value="/mng/WeddingHallUpdate")
        public String WeddingHallUpdate(Model model,HttpServletRequest request, HttpServletResponse response) 
        {   
        	String whCode = HttpUtil.get(request, "whCode", "");
        	//String dNo = HttpUtil.get(request, "dNo", "");
        	
        	WDHall wdHall = null;        	
        	
        	if(!StringUtil.isEmpty(whCode))
        	{
        		wdHall = wdHallService.onlyWeddingHall(whCode);
        		
        		model.addAttribute("wdHall", wdHall);
        	}
        	
        	model.addAttribute("whCode", whCode);
        	
        	return "/mng/WeddingHallUpdate";
        }
        
        //웨딩홀 삭제하기
        @RequestMapping(value="/mng/WeddingHallDelete")
        @ResponseBody
        public Response<Object> WeddingHallDelete(HttpServletRequest request, HttpServletResponse response)
        {
        	Response<Object> ajaxResponse = new Response<Object>();
        	
        	String whCode = HttpUtil.get(request, "whCode", "");
        	
        	WDHall wdHall = null;
        	
        	if(!StringUtil.isEmpty(whCode))
      	   {
        		wdHall = wdHallService.onlyWeddingHall(whCode);
       		   
       		   if(wdHall != null) //dList가 널이면 게시물이 없다는거니까 널이 아닐떄 !
       		   {
       			   //널이 아닐때
  				   if(wdHallService.weddingHallDelete(whCode) > 0)
  				   {
  					   //0보다 크면 정상적으로 삭제됬따
  					 ajaxResponse.setResponse(0, "Success");
  				   }
  				   else
  				   {
  					   //아니야. 삭제못했어
  					 ajaxResponse.setResponse(500, "Internal Server Error");
  				   }
       		   }
       		   else
       		   {
       			   //널일때 = 게시물이 없다
       			ajaxResponse.setResponse(404, "Not Found");
       		   }
       	   }
       	   else
       	   {
       		   //0이거나 0보다 작을때는 안넘어온거임
       		ajaxResponse.setResponse(400, "Bad Request");
       	   }
        	
        	return ajaxResponse;
        }
        
        //홀업체 수정,삭제 페이지 띄우기
        @RequestMapping(value="/mng/hallUpdate")
        public String hallUpdate(Model model,HttpServletRequest request, HttpServletResponse response) 
        {   
        	String whCode = HttpUtil.get(request, "whCode", "");
        	String hCode = HttpUtil.get(request, "hCode", "");
        	
        	WDHall wdHall = new WDHall();
        	
        	wdHall.setWHCode(whCode);
        	wdHall.setHCode(hCode);     	
        	
        	if(!StringUtil.isEmpty(whCode) && !StringUtil.isEmpty(hCode))
        	{
        		wdHall = wdHallService.WDHallSelect(wdHall);
        		
        		model.addAttribute("wdHall", wdHall);
        	}
        	
        	model.addAttribute("whCode", whCode);
        	model.addAttribute("hCode", hCode);
        	
        	return "/mng/hallUpdate";
        }
        
        //홀 삭제하기
        @RequestMapping(value="/mng/hallDelete")
        @ResponseBody
        public Response<Object> hallDelete(HttpServletRequest request, HttpServletResponse response)
        {
        	Response<Object> ajaxResponse = new Response<Object>();
        	
        	String whCode = HttpUtil.get(request, "whCode", "");
        	String hCode = HttpUtil.get(request, "hCode", "");
        	
        	WDHall wdHall = new WDHall();
        	
        	System.out.println("fgdgfdg : " + whCode);
        	System.out.println("fgdgfdg : " + hCode);
        	
        	if(!StringUtil.isEmpty(whCode) && !StringUtil.isEmpty(hCode))
      	   {
	    		wdHall.setWHCode(whCode);
	    		wdHall.setHCode(hCode);
    		
   			   //널이 아닐때
			   if(wdHallService.hallDelete(wdHall) > 0)
			   {
				   //0보다 크면 정상적으로 삭제됬따
				 ajaxResponse.setResponse(0, "Success");
			   }
			   else
			   {
				   //아니야. 삭제못했어
				 ajaxResponse.setResponse(500, "Internal Server Error");
			   }
   		   }
   		   else
   		   {
   			   //널일때 = 게시물이 없다
   			ajaxResponse.setResponse(404, "Not Found");
   		   }
        	
        	return ajaxResponse;
        }

        //드레스업체 수정하기
        @RequestMapping(value="/mng/dressComUpdateProc", method=RequestMethod.POST)
        @ResponseBody
        public Response<Object> dressComUpdateProc(HttpServletRequest request, HttpServletResponse response)
        {
           Response<Object> res = new Response<Object>();
           
           //새로입력한 정보 받아오기
           String dcCode = HttpUtil.get(request, "dcCode", "");
           String dcName = HttpUtil.get(request, "dcName", "");
           String dcLocation = HttpUtil.get(request, "dcLocation", "");
           String dcNumber = HttpUtil.get(request, "dcNumber", "");
           String dcContent = HttpUtil.get(request, "dcContent", "");
           //String dcImgname = HttpUtil.get(request, "dcImgname", "");
           
           WDDress dList = new WDDress();
           
           System.out.println("혹시여긴오나몰라11111");
           
           if(!StringUtil.isEmpty(dcCode) && !StringUtil.isEmpty(dcName) && !StringUtil.isEmpty(dcLocation) &&
        		   !StringUtil.isEmpty(dcNumber) && !StringUtil.isEmpty(dcContent))
           {
        	   System.out.println("혹시여긴오나몰라222222");
        	   
        	   //게시글 존재하고, 제목,내용받아옴
        	   dList = wdDressService.onlyDressComSelect(dcCode);
        	   
        	   if(dList != null)
        	   {
        		   System.out.println("혹시여긴오나몰라33333");
        		   
        		   //새로운 정보 넣어주기
        		   dList.setDcCode(dcCode);
        		   dList.setDcName(dcName);
        		   dList.setDcLocation(dcLocation);
        		   dList.setDcNumber(dcNumber);
        		   dList.setDcContent(dcContent);
        		   //dList.setDcContent(dcImgname);
        		   
        		   if(wdDressService.dressComUpdate(dList) > 0)
        		   {
        			   res.setResponse(0, "Success");
        			   System.out.println("혹시여긴오나몰라4444");
        		   }
        		   else
        		   {
        			   res.setResponse(-1, "Fail");
        			   System.out.println("혹시여긴오나몰라55555");
        		   }
        		   
        	   }
        	   else
        	   {
        		   res.setResponse(400, "Bad Request");
        		   System.out.println("혹시여긴오나몰라6666");
        	   }
           }
           else 
			{
        	   res.setResponse(400, "Bad Request");
        	   System.out.println("혹시여긴오나몰라777777");
			}
           
           
           return res;
        }
        
        //드레스 수정하기
        @RequestMapping(value="/mng/dressUpdateProc", method=RequestMethod.POST)
        @ResponseBody
        public Response<Object> dressUpdateProc(HttpServletRequest request, HttpServletResponse response)
        {
           Response<Object> res = new Response<Object>();
           
           //새로입력한 정보 받아오기
           String dcCode = HttpUtil.get(request, "dcCode", "");
           String dNo = HttpUtil.get(request, "dNo", "");
           String dcName = HttpUtil.get(request, "dcName", "");
           String dName = HttpUtil.get(request, "dName", "");
           String dContent = HttpUtil.get(request, "dContent", "");
           long dPrice = HttpUtil.get(request, "dPrice", (long)0);
           //String dImgname = HttpUtil.get(request, "dImgname", "");
           
           WDDress dList = new WDDress();
           
           System.out.println("혹시여긴오나몰라11111");
           
           if(!StringUtil.isEmpty(dcCode) && !StringUtil.isEmpty(dNo) && !StringUtil.isEmpty(dcName) &&
        		   !StringUtil.isEmpty(dName) && !StringUtil.isEmpty(dContent))
           {
        	   System.out.println("혹시여긴오나몰라222222");
        	   
        	   //게시글 존재하고, 제목,내용받아옴
        	   dList = wdDressService.dressSelect(dNo);
        	   
        	   if(dList != null)
        	   {
        		   System.out.println("여긴타니여긴타니여긴타니??");
        		   
        		   //새로운 정보 넣어주기
        		   dList.setDcCode(dcCode);
        		   dList.setdNo(dNo);
        		   dList.setDcName(dcName);
        		   dList.setdName(dName);
        		   dList.setdContent(dContent);
        		   dList.setdPrice(dPrice);
        		   //dList.setDsContent(dImgname);
        		   
        		   System.out.println("==========이거 값은 얼마냐??==="+dList.getdName());
        		   
        		   if(wdDressService.dressUpdate(dList) > 0)
        		   {
        			   res.setResponse(0, "Success");
        			   System.out.println("혹시여긴오나몰라44*******************44d와주겠니");
        		   }
        		   else
        		   {
        			   res.setResponse(-1, "Fail");
        			   System.out.println("혹시여긴오나몰라55555");
        		   }
        		   
        	   }
        	   else
        	   {
        		   res.setResponse(400, "Bad Request");
        		   System.out.println("혹시여긴오나몰라6666");
        	   }
           }
           else 
			{
        	   res.setResponse(400, "Bad Request");
        	   System.out.println("혹시여긴오나몰라777777");
			}
           
           
           return res;
        }
        
        //웨딩홀 수정하기
        @RequestMapping(value="/mng/weddinghallUpdateProc", method=RequestMethod.POST)
        @ResponseBody
        public Response<Object> weddinghallUpdateProc(HttpServletRequest request, HttpServletResponse response)
        {
           Response<Object> res = new Response<Object>();
           
           //새로입력한 정보 받아오기
           String wdName = HttpUtil.get(request, "wdName", "");
           String wdLocation = HttpUtil.get(request, "wdLocation", "");
           String wdNumber = HttpUtil.get(request, "wdNumber", "");
           String wdContent = HttpUtil.get(request, "wdContent", "");
           String wdCode = HttpUtil.get(request, "wdCode", "");
           
           WDHall wdHall = null;
           
           System.out.println("혹시여긴오나몰라11111");
           
           if(!StringUtil.isEmpty(wdName) && !StringUtil.isEmpty(wdLocation) && !StringUtil.isEmpty(wdNumber) &&
        		   !StringUtil.isEmpty(wdContent) && !StringUtil.isEmpty(wdCode))
           {
        	   System.out.println("혹시여긴오나몰라222222");
        	   
        	   //게시글 존재하고, 제목,내용받아옴
        	   wdHall = wdHallService.onlyWeddingHall(wdCode);
        	   
        	   if(wdHall != null)
        	   {
        		   System.out.println("여긴타니여긴타니여긴타니??");
        		   
        		   //새로운 정보 넣어주기
        		   wdHall.setWhName(wdName);
        		   wdHall.setWHLocation(wdLocation);
        		   wdHall.setWhNumber(wdNumber);
        		   wdHall.setWhContent(wdContent);
        		   //dList.setDsContent(dImgname);
        		   
        		   if(wdHallService.weddinghallUpdate(wdHall) > 0)
        		   {
        			   res.setResponse(0, "Success");
        			   System.out.println("혹시여긴오나몰라44*******************44d와주겠니");
        		   }
        		   else
        		   {
        			   res.setResponse(-1, "Fail");
        			   System.out.println("혹시여긴오나몰라55555");
        		   }
        		   
        	   }
        	   else
        	   {
        		   res.setResponse(400, "Bad Request");
        		   System.out.println("혹시여긴오나몰라6666");
        	   }
           }
           else 
			{
        	   res.setResponse(400, "Bad Request");
        	   System.out.println("혹시여긴오나몰라777777");
			}
           
           
           return res;
        }
        
        //홀 수정하기
        @RequestMapping(value="/mng/hallUpdateProc", method=RequestMethod.POST)
        @ResponseBody
        public Response<Object> hallUpdateProc(HttpServletRequest request, HttpServletResponse response)
        {
           Response<Object> res = new Response<Object>();
           
           //새로입력한 정보 받아오기
           String whCode = HttpUtil.get(request, "whCode", "");
           String hCode = HttpUtil.get(request, "hCode", "");
           String hName = HttpUtil.get(request, "hName", "");
           long hPrice = HttpUtil.get(request, "hPrice", (long)0);
           long hFood = HttpUtil.get(request, "hFood", (long)0);
           long hMin = HttpUtil.get(request, "hMin", (long)0);
           long hMax = HttpUtil.get(request, "hMax", (long)0);
           String hContent = HttpUtil.get(request, "hContent", "");
           //String dImgname = HttpUtil.get(request, "dImgname", "");
           
           WDHall wdHall = new WDHall();
           
           System.out.println("혹시여긴오나몰라11111");
           
           wdHall.setWHCode(whCode);
           wdHall.setHCode(hCode);
           
           if(!StringUtil.isEmpty(whCode) && !StringUtil.isEmpty(hCode) && !StringUtil.isEmpty(hName) && !StringUtil.isEmpty(hContent))
           {
        	   System.out.println("혹시여긴오나몰라222222");
        	   
        	   //게시글 존재하고, 제목,내용받아옴
        	   wdHall = wdHallService.WDHallSelect(wdHall);
        	   
        	   if(wdHall != null)
        	   {
        		   System.out.println("여긴타니여긴타니여긴타니??");
        		   
        		   //새로운 정보 넣어주기
        		   wdHall.setHName(hName);
        		   wdHall.setHPrice(hPrice);
        		   wdHall.setHFood(hFood);
        		   wdHall.setHMin(hMin);
        		   wdHall.setHMax(hMax);
        		   wdHall.setHContent(hContent);
        		   //dList.setDsContent(dImgname);
        		   
        		   System.out.println("==========이거 값은 얼마냐??==="+wdHall.getHName());
        		   
        		   if(wdHallService.hallUpdate(wdHall) > 0)
        		   {
        			   res.setResponse(0, "Success");
        			   System.out.println("혹시여긴오나몰라44*******************44d와주겠니");
        		   }
        		   else
        		   {
        			   res.setResponse(-1, "Fail");
        			   System.out.println("혹시여긴오나몰라55555");
        		   }
        		   
        	   }
        	   else
        	   {
        		   res.setResponse(400, "Bad Request");
        		   System.out.println("혹시여긴오나몰라6666");
        	   }
           }
           else 
			{
        	   res.setResponse(400, "Bad Request");
        	   System.out.println("혹시여긴오나몰라777777");
			}
           
           
           return res;
        }
        
}