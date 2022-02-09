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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.WDBoardFile;
import com.icia.web.model.WDComment;
import com.icia.web.model.WDFBoard;
import com.icia.web.model.WDReview;
import com.icia.web.model.WDReviewFile;
import com.icia.web.model.WDUser;
import com.icia.web.service.WDReviewService;
import com.icia.web.service.WDUserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("WDReviewController")
public class WDReviewController {
   
   private static Logger logger= LoggerFactory.getLogger(WDReviewController.class);
   
   //쿠키명
   @Value("#{env['auth.cookie.name']}")
   private String AUTH_COOKIE_NAME;
   
   //파일저장경로
   @Value("#{env['upload.save.dir']}")
   private String UPLOAD_SAVE_DIR;
   
   @Autowired
   private WDReviewService wdReviewService;
   
   @Autowired
   private WDUserService wdUserService;
   
   private static final int LIST_COUNT = 10;    //한페이지의 게시물 수
   private static final int PAGE_COUNT = 5;      //페이징 수
   

   @RequestMapping(value = "/board/reviews")
   public String review(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
      
        //조회값
        String searchValue = HttpUtil.get(request, "searchValue", "");
        //현재페이지
        long curPage = HttpUtil.get(request, "curPage", (long)1);
        
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      WDUser wdUser = wdUserService.userSelect(cookieUserId);
        
        List<WDReview> list = null;
        WDReview wdReview = new WDReview();
        long totalCount = 0;
        
        Paging paging = null;
        
        if(!StringUtil.isEmpty(searchValue)) {
           wdReview.setSearchValue(searchValue);
        }
        
        totalCount = wdReviewService.ReviewListCount(wdReview);
        
        
      logger.debug("[totalCount] = "+totalCount);
      
      if(totalCount > 0) {
         paging = new Paging("/board/reviews", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
         paging.addParam("searchValue",searchValue);
         paging.addParam("curPage", curPage);
         
         wdReview.setStartRow(paging.getStartRow());
         wdReview.setEndRow(paging.getEndRow());
         
         list = wdReviewService.ReviewList(wdReview);
      }
      
      model.addAttribute("list",list);
      model.addAttribute("searchValue", searchValue);
      model.addAttribute("curPage", curPage);
      model.addAttribute("paging", paging);
      model.addAttribute("wdUser", wdUser);
      
      return "/board/reviews";
   }
   @RequestMapping(value="/board/reviewWrite")
   @ResponseBody
   public Response<Object> rezCheck(HttpServletRequest request, HttpServletResponse response){
      
      Response<Object> ajaxResponse = new Response<Object>();
      
      //쿠키 값
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
         
      String rezNo = HttpUtil.get(request, "rezNo", "");
      
      WDReview wdReview = null;
      wdReview = wdReviewService.rezCheck(rezNo);
      
      System.out.println("예약번호 : "+ rezNo);
      System.out.println("여기다 : "+wdReviewService.reviewOverlapCheck(rezNo));
      
      if(wdReview != null) {
         if(!StringUtil.equals(wdReviewService.reviewOverlapCheck(rezNo), "Y")) {
            if(Integer.valueOf(wdReview.getToday()) >= Integer.valueOf(wdReview.getWDate())) {
               ajaxResponse.setResponse(0, "Success");
            }
            else {
               ajaxResponse.setResponse(401, "Bad Request");
            }
         }
         else {
            ajaxResponse.setResponse(501, "Bad Request");
         }
      }
      else {
         ajaxResponse.setResponse(400, "No parameter");
      }
      
      return ajaxResponse;
      
   }
   
   @RequestMapping(value = "/board/reviewWriteGo")
   public String reviewWrite(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
      
      //쿠키 값
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      
      String rezNo = HttpUtil.get(request, "FormRezNo", "");
       
      WDUser wdUser = wdUserService.userSelect(cookieUserId);
      
      model.addAttribute("wdUser",wdUser);    
      model.addAttribute("rezNo",rezNo);
      
      return "/board/reviewWriteGo";
   }
   
    //리뷰게시물 작성
   @RequestMapping(value="/board/reviewWriteProc", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> ajaxResponse = new Response<Object>();
      
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String hiBbsTitle = HttpUtil.get(request, "hiBbsTitle", "");
      String hiBbsContent = HttpUtil.get(request, "hiBbsContent", "");
      double rScore = HttpUtil.get(request, "starScore", (double)0);
      String rezNo = HttpUtil.get(request, "rezNo", "");
            
      WDReview wdReviewRez = null;
      wdReviewRez = wdReviewService.rezCheck(rezNo);      
      
      System.out.println("이거입니당 : "+rezNo);
      
      System.out.println("이거입니당 : "+wdReviewRez.getWDate());
      
      FileData fileData = HttpUtil.getFile(request, "hiBbsFile", UPLOAD_SAVE_DIR);
      if(wdReviewRez != null) {
         if(!StringUtil.isEmpty(hiBbsTitle) && !StringUtil.isEmpty(hiBbsContent)) 
         {
            WDReview wdReview = new WDReview();
            wdReview.setUserId(cookieUserId);
            wdReview.setRTitle(hiBbsTitle);
            wdReview.setRContent(hiBbsContent);
            wdReview.setRezNo(wdReviewRez.getRezNo());
            wdReview.setWDate(wdReviewRez.getWDate());
            wdReview.setRScore(rScore);
            
            if(fileData != null && fileData.getFileSize() > 0) 
            {
               WDReviewFile wdReviewFile = new WDReviewFile();
               
               wdReviewFile.setrFileName(fileData.getFileName());
               wdReviewFile.setrFileOrgName(fileData.getFileOrgName());
               wdReviewFile.setrFileExt(fileData.getFileExt());
               wdReviewFile.setrFileSize(fileData.getFileSize());
               
               wdReview.setReviewFile(wdReviewFile);
            }
         
            try 
            {
               if(wdReviewService.reviewInsert(wdReview) > 0) 
               {
                  wdReviewService.reviewCPT(rezNo);
                  ajaxResponse.setResponse(0, "Success");
               }
               else 
               {
                  ajaxResponse.setResponse(500, "Internal Server Error");
               }
            }
            catch(Exception e) 
            {
               logger.error("[WDReviewController] /board/reviewWriteProc Exception", e);
               ajaxResponse.setResponse(500, "Internal Server Error");
            }
         
         }
         else 
         {
            ajaxResponse.setResponse(400, "Bad Request: No parameter");
         }
      }
      else 
      {
         ajaxResponse.setResponse(-1, "Bad Request");
      }
      
      return ajaxResponse;
   }
   
   //상세 뷰페이지
   @RequestMapping(value="/board/reviewInfo")
   public String reviewInfo(ModelMap model, HttpServletRequest request, HttpServletResponse response) 
   {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      
      long RSeq = HttpUtil.get(request, "RSeq", (long)0);
      String searchValue = HttpUtil.get(request, "searchValue", "");
      long curPage = HttpUtil.get(request, "curPage", (long)1);
      
      String boardMe = "N";
      WDReview wdReview = null;
      
      WDReview hsdmName = new WDReview();      
      if(RSeq > 0) 
      {
         wdReview = wdReviewService.ReviewSelect(RSeq);         
         
         if(wdReview != null && StringUtil.equals(wdReview.getUserId(), cookieUserId)) 
         {
            boardMe = "Y";
         }      
      }
      
      hsdmName.setRezNo(wdReview.getRezNo());
      
      hsdmName = wdReviewService.reviewhsdmCodeSet(hsdmName);
      System.out.println("홀 코드 : "+hsdmName.gethCode());
      System.out.println("스 코드 : "+hsdmName.getsCode());
      System.out.println("드 코드 : "+hsdmName.getDcCode());
      System.out.println("메 코드 : "+hsdmName.getmCode());
      
      System.out.println("보내는 친구 예약번호 : " + wdReview.getRezNo());
      hsdmName.setRezNo(wdReview.getRezNo());
      System.out.println("예약번호 : "+hsdmName.getRezNo());
      hsdmName = wdReviewService.reviewInfohsdmName(hsdmName);
      System.out.println(hsdmName.gethName());
      
      if(wdReview.getReviewFile() != null) 
      {
         String url = wdReview.getReviewFile().getrFileName();
         model.addAttribute("url", url);
      }
      
      WDUser wdUser = wdUserService.userSelect(cookieUserId);
      
      String content = wdReview.getRContent().replaceAll("<br/>", "\r\n");
      wdReview.setRContent(content);
      
      model.addAttribute("hsdmName",hsdmName);
      model.addAttribute("wdUser", wdUser);
      model.addAttribute("cookieUserId",cookieUserId);
      model.addAttribute("RSeq", RSeq);
      model.addAttribute("searchValue", searchValue);
      model.addAttribute("curPage", curPage);
      model.addAttribute("wdReview", wdReview);
      model.addAttribute("boardMe", boardMe);
      
      return "/board/reviewInfo";
   }
   
   //게시글 삭제
   @RequestMapping(value="/board/reviewDelete", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> delete(HttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> ajaxResponse = new Response<Object>();
      
      String cookieUserId =  CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      long RSeq = HttpUtil.get(request, "RSeq", (long)0);
      
      System.out.println("RSeq"+ RSeq);
      
      
      if(RSeq > 0) 
      {
         WDReview wdReview = wdReviewService.ReviewSelect(RSeq);
         if(wdReview != null) 
         {
            
            if(StringUtil.equals(wdReview.getUserId(), cookieUserId)) 
            {
               try 
               {
                  if(wdReviewService.reviewDelete(RSeq) > 0) 
                  {
                     ajaxResponse.setResponse(0, "Success");
                  }
                  else 
                  {
                     ajaxResponse.setResponse(500, "Internal Server Error");
                  }
               }
               catch(Exception e) 
               {
                  logger.error("[WDReviewController] delete Exception", e);
                  ajaxResponse.setResponse(500, "Internal Server Error");
               }
            }
            else 
            {
               ajaxResponse.setResponse(405, "User Error");               
            }
         }
         else 
         {
            ajaxResponse.setResponse(404, "Not Exist");            
         }
         
      }
      else 
      {
         ajaxResponse.setResponse(400, "Bad Request");
      }
      
      return ajaxResponse;
   }
   
      //게시물 수정 페이지
      @RequestMapping(value="/board/reviewUpdate")
      public String fUpdateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) 
      {
         String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
         
         long RSeq = HttpUtil.get(request, "RSeq", (long)0);
         String searchValue = HttpUtil.get(request, "searchValue", "");
         long curPage = HttpUtil.get(request, "curPage", (long)1);
         
         WDReview wdReview = null;
         WDUser wdUser = null;
         
         if(RSeq > 0) 
         {
            wdReview = wdReviewService.ReviewSelect(RSeq);
            
            if(wdReview != null) 
            {
               if(!StringUtil.equals(cookieUserId, wdReview.getUserId())) 
               {
                  wdReview = null;
               }
               else 
               {
                  wdUser = wdUserService.userSelect(cookieUserId);
               }
            }
         }
         
         model.addAttribute("searchvalue", searchValue);
         model.addAttribute("curPage", curPage);
         model.addAttribute("wdReview", wdReview);
         model.addAttribute("wdUser", wdUser);
         
         return "/board/reviewUpdate";
      }
      
      //수정페이지에서 파일 삭제
      @RequestMapping(value="/board/ReviewdeleteFileProc", method=RequestMethod.POST)
      @ResponseBody
      public Response<Object> reviewDeleteFileProc(HttpServletRequest request, HttpServletResponse response)
      {
         Response<Object> ajaxResponse = new Response<Object>();
         String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
         long RSeq = HttpUtil.get(request, "RSeq", (long)0);
         
         if(RSeq>0) 
         {
            WDReview wdReview = wdReviewService.ReviewSelect(RSeq);
            
            if(wdReview != null) 
            {
               if(StringUtil.equals(cookieUserId, wdReview.getUserId())) 
               {
                  WDReviewFile wdReviewFile = wdReviewService.ReviewFileSelect(RSeq);
                  
                  wdReview.setReviewFile(wdReviewFile);
                  
                  if(wdReviewFile != null) 
                  {
                     //파일 삭제
                     try 
                     {
                        if(wdReviewService.reviewDeleteFile(wdReview) > 0) 
                        {
                           ajaxResponse.setResponse(0, "Success");
                        }                     
                     }
                     catch(Exception e) 
                     {
                        logger.debug("[WDReviewController] reviewDeleteFileProc Exception", e);
                        ajaxResponse.setResponse(500, "Bad Request");
                     }
                  }
                  else 
                  {
                     ajaxResponse.setResponse(404, "Bad Request");
                  }
               }
               else 
               {
                  ajaxResponse.setResponse(401, "Bad Request");
               }
            }
         }
         else 
         {
            ajaxResponse.setResponse(404, "Bad Request");

         }
         
         return ajaxResponse;
      }
      
      @RequestMapping(value="/board/reviewUpdateProc", method=RequestMethod.POST)
      @ResponseBody
      public Response<Object> reviewUpdateProc(MultipartHttpServletRequest request, HttpServletResponse response)
      {
         Response<Object> ajaxResponse = new Response<Object>();
         
         String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
         
         long RSeq = HttpUtil.get(request, "RSeq", (long)0);
         String bTitle = HttpUtil.get(request, "bTitle", "");
         String bContent = HttpUtil.get(request, "bContent", "");
         double rScore = HttpUtil.get(request, "starScore", (double)0);
         
         System.out.println("점수 : "+rScore);
         
         FileData fileData = HttpUtil.getFile(request, "hiBbsFile", UPLOAD_SAVE_DIR);
         WDReview wdReview = null;
         System.out.println("RSeq : "+RSeq);
         if(RSeq > 0 && !StringUtil.isEmpty(bTitle) && !StringUtil.isEmpty(bContent)) 
         {
            //게시글 존재, 제목, 내용도 넘어옴.
            wdReview = wdReviewService.ReviewSelect(RSeq);
            if(wdReview != null) 
            {
               if(StringUtil.equals(cookieUserId, wdReview.getUserId())) 
               {
                  //게시물 작성자 아이디와 쿠키 아이디가 같음
                  //얘는 변경이 없지만 해두자                  
                  wdReview.setRSeq(RSeq);
                  wdReview.setRTitle(bTitle);
                  wdReview.setRContent(bContent);
                  wdReview.setRScore(rScore);
                  
                  if(fileData != null && fileData.getFileSize()>0) 
                  {
                     //파일 존재
                     WDReviewFile wdReviewFile = new WDReviewFile();

                     //새로운 값들을 넣어줌
                     wdReviewFile.setrFileName(fileData.getFileName());
                     wdReviewFile.setrFileOrgName(fileData.getFileOrgName());
                     wdReviewFile.setrFileExt(fileData.getFileExt());
                     wdReviewFile.setrFileSize(fileData.getFileSize());
                     
                     wdReview.setReviewFile(wdReviewFile);
                  }
                  
                  //업데이트 할 것인데, 파일첨부까지 생각해야 함. 그래서 트랜잭션을 걸어야 하기 때문에 try catch
                  try 
                  {
                     //의수 여기서 잠시멈춤
                     if(wdReviewService.reviewUpdate(wdReview) > 0) 
                     {
                        ajaxResponse.setResponse(0, "Success");
                     }
                     else 
                     {
                        ajaxResponse.setResponse(500, "Internal Server Error");
                     }
                  }
                  catch(Exception e) 
                  {
                     logger.error("[WDReviewController] reviewUpdateProc Exception", e);
                     ajaxResponse.setResponse(500, "Internal Server Error");
                  }
                  
               }
               else 
               {
                  //본인 게시물이 아님
                  ajaxResponse.setResponse(404, "Not The Owner");
               }
            }
            else 
            {
               ajaxResponse.setResponse(401, "Not Found");
            }
         }
         else 
         {
            ajaxResponse.setResponse(400, "Bad Request");
         }
               
         return ajaxResponse;
      }

}