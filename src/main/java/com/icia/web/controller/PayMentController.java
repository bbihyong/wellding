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
import com.icia.web.model.WDCoupon;
import com.icia.web.model.WDRez;
import com.icia.web.model.WDUser;
import com.icia.web.service.WDCouponService;
import com.icia.web.service.WDRezService;
import com.icia.web.service.WDUserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("payMentController")
public class PayMentController 
{
	private static Logger logger = LoggerFactory.getLogger(PayMentController.class);
	
	//쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//유저서비스
	@Autowired
	private WDUserService wdUserService;
	
	//예약 서비스
	@Autowired
	private WDRezService wdRezService;
	
	//쿠폰 서비스
	@Autowired
	private WDCouponService wdCouponService;
	
	
	@RequestMapping(value="/user/payMent")
	public String payMent(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		WDUser wdUser = wdUserService.userSelect(cookieUserId);
		
		WDRez search = new WDRez();
		List<WDCoupon> couponList = null;
		
		String wDate = null;
		
		String year = null;
		
		String month = null;
		
		String day = null;
		
		//의수 쿠폰 수정, 상태가 N인 애들만 목록에 나타남
		WDCoupon wdCoupon = new WDCoupon();
		wdCoupon.setUserId(wdUser.getUserId());
		wdCoupon.setcStatus("N");
		
		couponList = wdCouponService.couponList(wdCoupon);
		
		
		if(couponList != null) {
			model.addAttribute("couponList",couponList);
			model.addAttribute("num", couponList.size());
		}
		
		if(wdUser != null) 
		{

			if(StringUtil.equals(wdUser.getStatus(), "Y")) 
			{
				search.setUserId(cookieUserId);
				//wdRez = wdRezService.rezSelect(wdUser.getUserId());
				search.setRezStatus("N");
				WDRez wdRez = wdRezService.rezSelect(search);
				wdRez = wdRezService.rezList(wdRez);
				
				wDate = wdRez.getwDate();
				year = wDate.substring(0, 4);
				month = wDate.substring(4, 6);
				day = wDate.substring(6, 8);
				
				model.addAttribute("wdRez", wdRez);
				model.addAttribute("wdUser",wdUser);
				
				model.addAttribute("wDate", wDate);
				model.addAttribute("year", year);
				model.addAttribute("month", month);
				model.addAttribute("day", day);
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
		
		return "/user/payMent";
		
		
	}
	
	@RequestMapping(value="/user/payList")
	   public String payList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	   {
	      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	      long curPage = HttpUtil.get(request, "curPage", (long)0);
	      
	      
	      WDUser wdUser = wdUserService.userSelect(cookieUserId);
	      
	      List<WDRez> list = null;

	      
	      
	      if(wdUser != null) 
	      {

	         if(StringUtil.equals(wdUser.getStatus(), "Y")) 
	         {
	            
	            list = wdRezService.rezSelectList(wdUser.getUserId());
	            
	            
	            model.addAttribute("list", list);
	            model.addAttribute("wdUser",wdUser);
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
	      
	      return "/user/payList";
	   }
	
	@RequestMapping(value="/user/payListView", method=RequestMethod.POST)
	   public String payListView (ModelMap model, HttpServletRequest request, HttpServletResponse response)
	   {
	      String rezNo = HttpUtil.get(request, "rezNo", "");
	      
	      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	      
	      WDUser wdUser = wdUserService.userSelect(cookieUserId);
	      
	      WDRez wdRez = null;
	      
	      WDCoupon wdCoupon = null;
	      
	      if(wdUser != null) 
	      {
	    	  //Y
	         if(StringUtil.equals(wdUser.getStatus(), "Y")) 
	         {
	            WDRez search = new WDRez();
	            search.setUserId(wdUser.getUserId());
	            search.setRezNo(rezNo);
	            search.setRezStatus("Y");
	            
	            wdRez = wdRezService.rezSelect(search);
	            wdRez = wdRezService.rezList(wdRez);
	            
	            if(wdRez != null) 
	            {
	               HashMap<String, Object> map = new HashMap<String, Object>();
	               map.put("userId", wdRez.getUserId());
	               map.put("rezNo", wdRez.getRezNo());
	               
	               wdCoupon = wdCouponService.couponSelectPayOk(map);
	               
	               model.addAttribute("wdRez", wdRez);
	               model.addAttribute("wdCoupon", wdCoupon);
	               model.addAttribute("wdUser",wdUser);
	               
	            }
	         }
	      }
	      
	      return "/user/payListView";
	   }
	
	@RequestMapping(value="/user/payComplete")
	public String payComplete(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		WDUser wdUser = wdUserService.userSelect(cookieUserId);
		
		List<WDRez> list = null;

		
		
		if(wdUser != null) 
		{

			if(StringUtil.equals(wdUser.getStatus(), "Y"))
			{
				
				list = wdRezService.rezSelectList(wdUser.getUserId());
				
				
				model.addAttribute("list", list);
				model.addAttribute("wdUser",wdUser);
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
		
		return "/user/payComplete";
	}
	
	@RequestMapping(value="/user/payCancel", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> payCancel (HttpServletRequest request, HttpServletResponse response)
	{	
		Response<Object> ajaxResponse = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		String rezNo = HttpUtil.get(request, "rezNo", "");
		
		WDUser wdUser = wdUserService.userSelect(cookieUserId);
		
		WDRez wdRez = new WDRez();
		
		if(wdUser != null)
		{
			if(StringUtil.equals(wdRez.getRezStatus(), "N"))
			{
				wdRez.setUserId(wdUser.getUserId());
				wdRez.setRezNo(rezNo);
				wdRez.setRezStatus("Y");
				
				
				System.out.println("=============================" + wdRez.getRezNo());
				System.out.println("=============================" + wdRez.getRezStatus());
				
				if(wdRezService.rezCancelPayment(wdRez) > 0)
				{
					ajaxResponse.setResponse(0, "Success");
					
					System.out.println("222222222222222222222222" + wdRez.getRezNo());
					System.out.println("222222222222222222222222" + wdRez.getRezStatus());
				}
			}
		}
		
		
		
		return ajaxResponse;
	}
	
	
	
	@RequestMapping(value="/user/payCancelList")
   public String paycancelList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      
      
      WDUser wdUser = wdUserService.userSelect(cookieUserId);
      
      List<WDRez> list = null;

      
      
      if(wdUser != null) 
      {

         if(StringUtil.equals(wdUser.getStatus(), "Y")) 
         {
            
            list = wdRezService.rezSelectStatusNotNY(wdUser.getUserId());
            
            
            model.addAttribute("list", list);
            model.addAttribute("wdUser",wdUser);
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
      
      return "/user/payCancelList";
   }
	
	@RequestMapping(value="/user/payCancelListView")
	public String payCancelListView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
	      String rezNo = HttpUtil.get(request, "rezNo", "");
	      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	      WDUser wdUser = wdUserService.userSelect(cookieUserId);
	      
	      WDRez wdRez = null;
	      //List<WDRez> wdRez = null;
	      WDCoupon wdCoupon = null;
	      
	      if(wdUser != null) 
	      {
	         if(StringUtil.equals(wdUser.getStatus(), "Y")) 
	         {
	            WDRez search = new WDRez();
	            search.setUserId(wdUser.getUserId());
	            search.setRezNo(rezNo);
	            
	            search.setRezStatus("C");
	            
	            wdRez = wdRezService.rezSelect(search);
	            wdRez = wdRezService.rezList(wdRez);
	            
	            if(wdRez != null) 
	            {
	               HashMap<String, Object> map = new HashMap<String, Object>();
	               map.put("rezStatus", 'C');
	               map.put("userId", wdRez.getUserId());
	               map.put("rezNo", wdRez.getRezNo());
	               
	               wdCoupon = wdCouponService.couponSelectCancelOk(map);
	               
	               model.addAttribute("wdRez", wdRez);
	               model.addAttribute("wdCoupon", wdCoupon);
	               model.addAttribute("wdUser",wdUser);
	            }
	         }
	         
	      }
	      
		return "/user/payCancelListView";
	}
	
	
	@RequestMapping(value="/user/payCancelListView2")
	public String payCancelListView2(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
	      String rezNo = HttpUtil.get(request, "rezNo", "");
	      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	      WDUser wdUser = wdUserService.userSelect(cookieUserId);
	      
	      WDRez wdRez = null;
	      //List<WDRez> wdRez = null;
	      WDCoupon wdCoupon = null;
	      
	      if(wdUser != null) 
	      {
	         if(StringUtil.equals(wdUser.getStatus(), "Y")) 
	         {
	            WDRez search = new WDRez();
	            search.setUserId(wdUser.getUserId());
	            search.setRezNo(rezNo);
	            
	            search.setRezStatus("D");
	            
	            wdRez = wdRezService.rezSelect(search);
	            wdRez = wdRezService.rezList(wdRez);
	            
	            if(wdRez != null) 
	            {
	               HashMap<String, Object> map = new HashMap<String, Object>();
	               map.put("rezStatus", 'D');
	               map.put("userId", wdRez.getUserId());
	               map.put("rezNo", wdRez.getRezNo());
	               
	               wdCoupon = wdCouponService.couponSelectCancelOk(map);
	               
	               model.addAttribute("wdRez", wdRez);
	               model.addAttribute("wdCoupon", wdCoupon);
	               model.addAttribute("wdUser",wdUser);
	            }
	         }

	         
	      }
	      
		return "/user/payCancelListView2";
	}


}
