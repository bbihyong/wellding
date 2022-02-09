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

import com.icia.web.model.WDCoupon;
import com.icia.web.service.WDCouponService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;

@Controller("WDCouponController")
public class WDCouponController {
	
	private static Logger logger = LoggerFactory.getLogger(WDCouponController.class);
	
	//쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	private WDCouponService wdCouponService;
	
	@RequestMapping(value="/board/Coupon")
	public String coupon(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		List<WDCoupon> list = null;
		
		list = wdCouponService.couponSelectList(cookieUserId);
		
		model.addAttribute("list",list);		
		
		return "/board/Coupon";
	}
	
	//큐알팝업
	@RequestMapping(value="/board/qrTest")
	public String qrTest(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		
		return "/board/qrTest";
	}
	
	//신랑측 식권
	@RequestMapping(value="/board/foodCpnM")
	public String foodCpnM(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String rezNo = HttpUtil.get(request, "rezNo", "");
		
		model.addAttribute("rezNo",rezNo);
		
		return "/board/foodCpnM";
	}
	
	//신랑측 식권2
	@RequestMapping(value="/board/foodCpnM2")
	public String foodCpnM2(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		
		String rezNo = HttpUtil.get(request, "rezNo", "");
		
		wdCouponService.qrCodeMPlus(rezNo);
		
		WDCoupon wdCoupon = null;
		
		wdCoupon = wdCouponService.cntSelect(rezNo);
		
		model.addAttribute("wdCoupon",wdCoupon);
		
		return "/board/foodCpnM2";
	}
	
	//신부측 식권
	@RequestMapping(value="/board/foodCpnF")
	public String foodCpnF(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String rezNo = HttpUtil.get(request, "rezNo", "");
		
		model.addAttribute("rezNo",rezNo);
		
		return "/board/foodCpnF";
	}
	
	//신부측 식권2
	@RequestMapping(value="/board/foodCpnF2")
	public String foodCpnF2(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		
		String rezNo = HttpUtil.get(request, "rezNo", "");
		
		wdCouponService.qrCodeFPlus(rezNo);
		
		WDCoupon wdCoupon = null;
		
		wdCoupon = wdCouponService.cntSelect(rezNo);
		
		model.addAttribute("wdCoupon",wdCoupon);
		
		return "/board/foodCpnF2";
	}
	
	
}
