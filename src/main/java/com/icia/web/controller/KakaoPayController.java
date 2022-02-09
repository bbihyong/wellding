package com.icia.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.icia.common.util.StringUtil;
import com.icia.web.model.KakaoPayApprove;
import com.icia.web.model.KakaoPayOrder;
import com.icia.web.model.KakaoPayReady;
import com.icia.web.model.Response;
import com.icia.web.model.WDRez;
import com.icia.web.service.KakaoPayService;
import com.icia.web.service.WDHallService;
import com.icia.web.service.WDRezService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("kakaoPayController")
public class KakaoPayController 
{
   private static Logger logger = LoggerFactory.getLogger(KakaoPayController.class);
   
   @Autowired
   private KakaoPayService kakaoPayService;
   
   @Autowired
   private WDRezService wdRezService;
   
   @Autowired
   private WDHallService wdHallService;
   
   // 쿠키명
   @Value("#{env['auth.cookie.name']}")
   private String AUTH_COOKIE_NAME;
   
   private static final String KAKAO_PAY_ORDER_NAME = "kakaPayOrderSession";
   
   @RequestMapping(value="/kakao/pay")
   public String pay(HttpServletRequest request, HttpServletResponse response)
   {
      return "/kakao/pay";
   }
   
   @RequestMapping(value="/kakao/payPopUp", method=RequestMethod.POST)
   public String payPopUp(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      String pcUrl = HttpUtil.get(request, "pcUrl", "");
      String orderId = HttpUtil.get(request, "orderId", "");
      String tId = HttpUtil.get(request, "tId", "");
      String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      
      //동욱 추가
      String cCode = HttpUtil.get(request, "cCode", "");
      String rezNo = HttpUtil.get(request, "rezNo", "");
      int rezFullPrice = HttpUtil.get(request, "rezFullPrice", 0);
      //포인트 추가
      int rezPoint = HttpUtil.get(request, "rezPoint", 0);
       
      model.addAttribute("pcUrl", pcUrl);
      model.addAttribute("orderId", orderId);
      model.addAttribute("tId", tId);
      model.addAttribute("userId", userId);
      
      //동욱 추가
      model.addAttribute("cCode", cCode);
      model.addAttribute("rezNo", rezNo);
      model.addAttribute("rezFullPrice", rezFullPrice);
      //포인트 추가
      model.addAttribute("rezPoint", rezPoint);

      
      return "/kakao/payPopUp";
   }
   
   @RequestMapping(value="/kakao/payReady", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> payReady(HttpServletRequest request, HttpServletResponse response)
   {
      Response<Object> ajaxResponse = new Response<Object>();
      
      String orderId = StringUtil.uniqueValue();
      String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String itemCode = HttpUtil.get(request, "itemCode", "");
      String itemName = HttpUtil.get(request, "itemName", "");
      String cCode = HttpUtil.get(request, "cCode", "");
      int quantity = HttpUtil.get(request, "quantity", (int)0);
      int totalAmount = HttpUtil.get(request, "totalAmount", (int)0);
      int taxFreeAmount = HttpUtil.get(request, "taxFreeAmount", (int)0);
      int vatAmount = HttpUtil.get(request, "vatAmount", (int)0);
      int rezPoint = HttpUtil.get(request, "rezPoint", (int)0);

      KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
      
      kakaoPayOrder.setPartnerOrderId(orderId);
      kakaoPayOrder.setPartnerUserId(userId);
      kakaoPayOrder.setItemCode(itemCode);
      kakaoPayOrder.setItemName(itemName);
      kakaoPayOrder.setQuantity(quantity);
      kakaoPayOrder.setTotalAmount(totalAmount);
      kakaoPayOrder.setTaxFreeAmount(taxFreeAmount);
      kakaoPayOrder.setVatAmount(vatAmount);
      
      KakaoPayReady kakaoPayReady = kakaoPayService.kakaoPayReady(kakaoPayOrder);
      
      if(kakaoPayReady != null)
      {
         logger.debug("[KakaoPayController] payReady : " + kakaoPayReady);
                  
         kakaoPayOrder.settId(kakaoPayReady.getTid());
         
         JsonObject json = new JsonObject();
         
         json.addProperty("orderId", orderId);
         json.addProperty("tId", kakaoPayReady.getTid());
         json.addProperty("appUrl", kakaoPayReady.getNext_redirect_app_url());
         json.addProperty("mobileUrl", kakaoPayReady.getNext_redirect_mobile_url());
         json.addProperty("pcUrl", kakaoPayReady.getNext_redirect_pc_url());
         
         //동욱 추가
         json.addProperty("cCode", cCode);
         /*동욱 수정
         WDRez wdRez = new WDRez();
         wdRez.setUserId(userId);
         wdRez.setRezNo(itemCode);
         wdRez.setRezFullPrice(totalAmount);
         
         wdRez.setcCode(cCode);
         
         
         if(wdRezService.rezUpdatePay(wdRez) > 0) 
         {
            ajaxResponse.setResponse(0, "success", json);            
         }
         else 
         {
            ajaxResponse.setResponse(-1, "fail", null);
         }
*/
         
         //여기에 해당 홀, 스, 드, 메가 해당 날짜에 예약되어있는지 로직 추가
         //우선 정보부터 얻어와보자
         WDRez wdRez = new WDRez();
         
         //예약정보 얻어오려면 3가지 필요, 아이디, 예약번호, 상태
         wdRez.setUserId(userId);
         wdRez.setRezNo(itemCode);
         //아직 장바구니에 있는 애를 확인하기 위한 것이니까 결제 상태는 N인 애를 가져와야 함.
         wdRez.setRezStatus("N");
         
         //예약정보 가져오기
         wdRez = wdRezService.rezSelect(wdRez);
         if(wdRez != null) 
         {
        	 //홀부터 체크
        	 int isH, isS, isD, isM;
        	 
        	 isH = wdRezService.isHallRez(wdRez);
        	 isS = wdRezService.isStudioRez(wdRez);
        	 isD = wdRezService.isDressRez(wdRez);
        	 isM = wdRezService.isMakeUpRez(wdRez);
        	 if(isH > 0) 
        	 {
        		 ajaxResponse.setResponse(500, "AlreadyHallExist", null);
        	 }
        	 else if(isS > 0) 
        	 {
        		 ajaxResponse.setResponse(501, "AlreadyStudioExist", null);
        	 }
        	 else if(isD > 0) 
        	 {
        		 ajaxResponse.setResponse(502, "AlreadyDressExist", null);
        	 }
        	 
        	 else if(isM > 0) 
        	 {
        		 ajaxResponse.setResponse(503, "AlreadyMakeUpExist", null);
        	 }
        	 else 
        	 {
        		 json.addProperty("rezNo", itemCode);
        		 json.addProperty("rezFullPrice", totalAmount);
        		 //포인트 추가
        		 json.addProperty("rezPoint", rezPoint);
        		 
        		 ajaxResponse.setResponse(0, "success", json);         		 
        	 }
        	 
        	 
             
         }
         else 
         {
             ajaxResponse.setResponse(-1, "fail", null);
         }

      }
      else
      {
         ajaxResponse.setResponse(-1, "fail", null);
      }
      
      return ajaxResponse;
   }
   
   @RequestMapping(value="/kakao/paySuccess")
   public String paySuccess(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      String pgToken = HttpUtil.get(request, "pg_token", "");
      
      model.addAttribute("pgToken", pgToken);
      
      return "/kakao/paySuccess";
   }
   
   @RequestMapping(value="/kakao/payResult")
   public String payResult(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
      KakaoPayApprove kakaoPayApprove = null;
      
      String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String orderId = HttpUtil.get(request, "orderId", "");
      String tId = HttpUtil.get(request, "tId", "");
      String pgToken = HttpUtil.get(request, "pgToken", "");
      
      //동욱 추가
      String itemCode = HttpUtil.get(request, "itemCode", "");
      String cCode = HttpUtil.get(request, "cCode", "");
      int totalAmount = HttpUtil.get(request,  "totalAmount", (int)0);
      
      String rezNo = HttpUtil.get(request, "rezNo", "");
      
      int rezFullPrice = HttpUtil.get(request, "rezFullPrice", 0);
      
      int rezPoint = HttpUtil.get(request, "rezPoint", 0);
      //여기까지
      
      KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
      
      kakaoPayOrder.setPartnerOrderId(orderId);
      kakaoPayOrder.setPartnerUserId(userId);
      kakaoPayOrder.settId(tId);
      kakaoPayOrder.setPgToken(pgToken);
      
      kakaoPayApprove = kakaoPayService.kakaoPayApprove(kakaoPayOrder);
      
      WDRez wdRez = new WDRez();
      wdRez.setUserId(userId);
      wdRez.setRezNo(rezNo);
      wdRez.setRezFullPrice(rezFullPrice);
      
      int cnt = 0;
      
      if(cCode != null && cCode != "") 
      {
    	  wdRez.setcCode(cCode);
 
    	  try 
    	  {
    		  //cCode가 비어있지 않으면, 세개 전부 변경하는 쿼리 실행
    		  cnt = wdRezService.rezUpdatePay(wdRez);
    	  }
    	  catch(Exception e) 
    	  {
    		  logger.error("[KakaoPayController] payReady rezUpdatePay Exception", e);
    	  }    	  
      }
      else 
      {
    	  try 
    	  {
    		  //cCode가 비어있으면 쿠폰에 대한 업데이트 하지 않음.
    		  cnt = wdRezService.rezUpdatePayNoC(wdRez);
    	  }
    	  catch(Exception e) 
    	  {
    		  logger.error("[KakaoPayController] payReady rezUpdatePay Exception", e);
    	  }
      }
      
      //예약 성공 시 해당 예약번호로 
      if(cnt != 0) 
      {
    	  wdHallService.rezCountPlus(rezNo);
      }
      
      //동욱 포인트 추가
      if(rezPoint >= 0)
      {
    	  wdRez.setRezPoint(rezPoint);
    	  
    	  try
    	  {
    		  cnt = wdRezService.rezPointUpdate(wdRez);
    	  }
    	  catch(Exception e)
    	  {
    		  logger.error("[KakaoPayController] payReady rezPoint Exception", e);
    	  }
      }
      
      model.addAttribute("kakaoPayApprove", kakaoPayApprove);
      
      return "/kakao/payResult";
   }
      
   @RequestMapping(value="/kakao/payFail")
   public String payFail(HttpServletRequest request, HttpServletResponse response)
   {
      HttpSession session = request.getSession(true);
      KakaoPayOrder kakaoPayOrder = (KakaoPayOrder)session.getAttribute(KAKAO_PAY_ORDER_NAME);
      
      if(kakaoPayOrder != null)
      {
         session.removeAttribute(KAKAO_PAY_ORDER_NAME);
      }
      
      return "/kakao/payFail";
   }
   
   @RequestMapping(value="/kakao/payCancel")
   public String payCancel(HttpServletRequest request, HttpServletResponse response)
   {
      HttpSession session = request.getSession(true);
      KakaoPayOrder kakaoPayOrder = (KakaoPayOrder)session.getAttribute(KAKAO_PAY_ORDER_NAME);
      
      if(kakaoPayOrder != null)
      {
         session.removeAttribute(KAKAO_PAY_ORDER_NAME);
      }
      
      return "/kakao/payCancel";
   }
}