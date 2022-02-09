package com.icia.web.controller;

import java.io.File;
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
import org.springframework.web.servlet.ModelAndView;

import com.icia.common.util.FileUtil;
import com.icia.common.util.StringUtil;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.model.WDAdmin;
import com.icia.web.model.WDBoardFile;
import com.icia.web.model.WDComment;
import com.icia.web.model.WDFBoard;
import com.icia.web.model.WDReview;
import com.icia.web.service.WDAdminService;
import com.icia.web.service.WDCommentService;
import com.icia.web.service.WDFBoardService;
import com.icia.web.service.WDReviewService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("wdAdminFRBoardController")
public class WDAdminFRBoardController {
   private static Logger logger = LoggerFactory.getLogger(WDAdminFRBoardController.class);
   
   @Autowired
   private WDAdminService wdAdminService;
   
   @Autowired
   private WDFBoardService wdFBoardService;
   
   @Autowired
   private WDReviewService wdReviewService;

   @Autowired
   private WDCommentService wdCommentService;
   
   @Value("#{env['upload.save.dir']}")
   private String UPLOAD_SAVE_DIR;

   //쿠키명
   @Value("#{env['auth.cookie.name']}")
   private String AUTH_COOKIE_NAME;
   
   private static final int LIST_COUNT = 10;
   private static final int PAGE_COUNT = 5;
   
   @RequestMapping(value="/mng/boardList")
   public String AdminBoardList(ModelMap model,HttpServletRequest request, HttpServletResponse response) 
   {
	   //자유게시판, 리뷰게시판 페이징을 위한 개수 체크 변수
	   long fboardCnt = 0;
	   long rboardCnt = 0;
	   long cboardCnt = 0;
	   
	   //자유게시판 리스트를 조회할 때 쓸 객체 선언
	   WDFBoard wdFBoard = new WDFBoard();
	   WDReview wdReview = new WDReview();
	   WDComment wdComment = new WDComment();
	   
	   //결과가 보여질 배열 객체 선언
	   List<WDFBoard> fList = null;
	   List<WDReview> rList = null;
	   List<WDComment> cList = null;
	   
	   //페이징 처리 어디서 했는지 확인용
	   int frCheck = HttpUtil.get(request, "frCheck", 1);
	   model.addAttribute("frCheck", frCheck);
	   
	   //alert창을 위한 메세지
	   String msg = "";
	   //부모번호
	   long parentSeq = HttpUtil.get(request, "parentSeq", (long)0);
	   //댓글번호
	   long commentSeq = HttpUtil.get(request, "commentSeq", (long)0);
	   int count = 0;
	   WDComment wdCom = new WDComment();
	   
	   String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	   WDAdmin wdAdmin = wdAdminService.wdAdminSelect(cookieUserId);
	   
	   //조회항목
	   String searchType = HttpUtil.get(request, "searchType", "");
	   //조회값
	   String searchValue = HttpUtil.get(request, "searchValue", "");
	   //현재 페이지
       long curPage = HttpUtil.get(request, "curPage", (long)1);
	   
       
       long bSeq = HttpUtil.get(request, "bSeq", (long)0);
       long rSeq = HttpUtil.get(request, "rSeq", (long)0);
       long cSeq = HttpUtil.get(request, "cSeq", (long)0);

       
       Paging fPaging = null;
       Paging rPaging = null;
       Paging cPaging = null;
       
       if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) 
		{
			//받아온 값
    	   wdFBoard.setSearchType(searchType);
    	   wdFBoard.setSearchValue(searchValue);
    	   wdReview.setSearchValue(searchValue);
		}
		else 
		{
			searchType = "";
			searchValue = "";
		}
       
       fboardCnt = wdFBoardService.fBoardListCount(wdFBoard);
       rboardCnt = wdReviewService.ReviewListCount(wdReview);
       cboardCnt = wdCommentService.commentTotalCnt();
       
       //자유게시판 페이징
       if(fboardCnt > 0) 
       {
    	   fPaging = new Paging("/mng/boardList", fboardCnt, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
    	   
    	   fPaging.addParam("searchType", searchType);
    	   fPaging.addParam("searchValue", searchValue);
    	   fPaging.addParam("curPage", curPage);
    	   
    	   wdFBoard.setStartRow(fPaging.getStartRow());
    	   wdFBoard.setEndRow(fPaging.getEndRow());
    	   
    	   fList = wdFBoardService.fBoardList(wdFBoard);
       }
       //리뷰게시판 페이징
       if(rboardCnt > 0) 
       {
    	   rPaging = new Paging("/mng/boardList", rboardCnt, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
    	   
    	   //rPaging.addParam("searchType", searchType);
    	   rPaging.addParam("searchValue", searchValue);
    	   rPaging.addParam("curPage", curPage);
    	   
    	   wdReview.setStartRow(rPaging.getStartRow());
    	   wdReview.setEndRow(rPaging.getEndRow());
    	   
    	   rList = wdReviewService.ReviewList(wdReview);
       }
       
		if(parentSeq>0 && commentSeq>0) 
		{
			wdCom.setParentSeq(parentSeq);
			wdCom.setCommentSeq(commentSeq);
			
			count = wdCommentService.commentDelAdm(wdCom);
			
			if(count>0) 
			{
				msg = "Y";
				frCheck = 3;
			}
			else 
			{
				msg = "N";
			}
	
		}
       
       if(cboardCnt >0) 
       {
    	   cPaging = new Paging("/mng/boardList", cboardCnt, 20, 5, curPage, "curPage");
    	   
    	   cPaging.addParam("curPage", curPage);
    	   
    	   HashMap<String, Object> map = new HashMap<String, Object>();
    	   
    	   map.put("startRow", cPaging.getStartRow());
    	   map.put("endRow", cPaging.getEndRow());
    	   
    	   wdComment.setStartRow(cPaging.getStartRow());
    	   wdComment.setEndRow(cPaging.getEndRow());
    	   
    	   cList = wdCommentService.commentTotalSelect(map);
       }
       

       
       model.addAttribute("wdAdmin",wdAdmin);
       model.addAttribute("fList", fList);
       model.addAttribute("fPaging",fPaging);
       model.addAttribute("rList", rList);
       model.addAttribute("rPaging",rPaging);
       model.addAttribute("cList", cList);
       model.addAttribute("cPaging",cPaging);
       model.addAttribute("searchType", searchType);
       model.addAttribute("searchValue", searchValue);
       model.addAttribute("curPage", curPage);
       model.addAttribute("msg", msg);
       model.addAttribute("frCheck", frCheck);
       
       return "/mng/boardList";
   }
   
   
   @RequestMapping(value="/mng/mngFboardUpdate")
   public String MngFboardUpdate(ModelMap model,HttpServletRequest request, HttpServletResponse response) 
   {
	   long bSeq = HttpUtil.get(request, "bSeq", (long)0);
	   
	   WDFBoard wdFBoard = null;
	   
	   if(bSeq>0) 
	   {
		   wdFBoard = wdFBoardService.wdFBoardView(bSeq);
		   
		   if(wdFBoard != null) 
		   {
			   model.addAttribute("wdFBoard", wdFBoard);
		   }
	   }
	   
	   return "/mng/mngFboardUpdate";
   }
   
   @RequestMapping(value="/mng/mngReviewUpdate")
   public String mngReviewUpdate(ModelMap model,HttpServletRequest request, HttpServletResponse response) 
   {
	   long RSeq = HttpUtil.get(request, "RSeq", (long)0);
	   
	   WDReview wdReview = null;
	   
	   if(RSeq>0) 
	   {
		   wdReview = wdReviewService.ReviewSelect(RSeq);
		   
		   if(wdReview != null) 
		   {
			   model.addAttribute("wdReview", wdReview);
		   }
	   }
	   
	   return "/mng/mngReviewUpdate";
   }
   
   @RequestMapping(value="/mng/reviewDelete")
   @ResponseBody
   public Response<Object> reviewDelete(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   
	   long RSeq = HttpUtil.get(request, "RSeq", (long)0);
	   
	   if(RSeq>0) {
			try 
			{
				if(wdReviewService.reviewDelete(RSeq) > 0) 
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else 
				{
					ajaxResponse.setResponse(-1, "Internal Server Error");
				}
			}
			catch(Exception e) 
			{
				logger.error("[WDAdminFRBoardController] reviewDelete Exception", e);
				ajaxResponse.setResponse(-1, "Internal Server Error");
			}
	   }
	   else {
		   ajaxResponse.setResponse(400, "Bad Parameter");
	   }
	   
	   return ajaxResponse;
   }
	
	//게시글 삭제
   	@RequestMapping(value="/mng/fDelete", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> fdelete(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		long bSeq = HttpUtil.get(request, "bSeq", (long)0);
		
		System.out.println("bSeq"+ bSeq);
		
		
		if(bSeq > 0) 
		{
			WDFBoard wdFBoard = wdFBoardService.wdFBoardView(bSeq);
			if(wdFBoard != null) 
			{
				
					try 
					{
						if(wdFBoardService.fBoardDelete(bSeq) > 0) 
						{
							wdCommentService.commentBoardDelete(bSeq);
							ajaxResponse.setResponse(0, "Success");
						}
						else 
						{
							ajaxResponse.setResponse(500, "Internal Server Error");
						}
					}
					catch(Exception e) 
					{
						logger.error("[WDFBoardController] delete Exception", e);
						ajaxResponse.setResponse(500, "Internal Server Error");
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
   	
   	
   	@RequestMapping("/board/fdownload")
   	public ModelAndView fdownload(HttpServletRequest request, HttpServletResponse response) 
   	{
   		ModelAndView modelAndView = null;
   		
   		long bSeq = HttpUtil.get(request, "bSeq", (long)0);
   		
   		if(bSeq > 0) 
   		{
   			WDBoardFile wdBoardFile = wdFBoardService.fBoardFileSelect(bSeq);
   			
   			if(wdBoardFile != null && wdBoardFile.getFileSize() > 0) 
   			{
   				//파일이 존재하면
   				File file = new File(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator()+wdBoardFile.getFileName());
   			
   				logger.debug("UPLOAD_SAVE_DIR : "+UPLOAD_SAVE_DIR);
   				logger.debug("FileUtil.getFileSeparator() : "+ FileUtil.getFileSeparator());
				logger.debug("wdBoardFile.getFileName() : "+ wdBoardFile.getFileName());
				
				if(FileUtil.isFile(file)) 
				{
					modelAndView = new ModelAndView();
					
					modelAndView.setViewName("fileDownloadView");
					
					modelAndView.addObject("file", file);
					modelAndView.addObject("fileName", wdBoardFile.getFileOrgName());
				
					return modelAndView;
				}
   			}
   		}
   		return modelAndView;
   	}

}
