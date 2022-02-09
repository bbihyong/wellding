<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
 	<%@ include file="/WEB-INF/views/include/head.jsp" %>
 <style>
 #prod{width:100px; height:100px;}
 </style>
 <script>
 $(document).ready(function(){
	 
 });
 
 function fn_view1(whCode, hCode)
 {
	document.rezForm.WHCode.value = whCode; 
    document.rezForm.HCode.value = hCode;
    document.rezForm.action = "/hsdm/HallView";  
    document.rezForm.submit();
 } 
 function fn_view2(sCode)
 {
 	document.rezForm.sCode.value = sCode; 
 	document.rezForm.action = "/hsdm/studioView";
 	document.rezForm.submit();
 }
 function fn_view3(dNo)
 {
 	document.rezForm.dNo.value = dNo;
 	document.rezForm.action = "/hsdm/dressView";
 	document.rezForm.submit();
 }
 function fn_view4(mCode)
 {
 	document.rezForm.mCode.value = mCode; 
 	document.rezForm.action = "/hsdm/makeupView";	
 	document.rezForm.submit();
 }


 
 </script>
</head>
<body>
	  <%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<section class="top">
	<div class="back"></div>
</section>

    <!-- ***** About Us Page ***** -->
    <div class="page-heading-shows-events6">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h2>My wishlist</h2>
                    <!-- span>Check out upcoming and past shows & events and grab your ticket right now.</span -->
                </div>
            </div>
        </div>
    </div>

    <section class="cart-section">
			<div class="container">
				<div class="row">
    			<div class="col-md-12 ftco-animate">
    				<div class="cart-list">
	    				<table class="table">
						    <thead class="thead-primary">
						      <tr class="text-center">
						        <th>Image</th>
						        <th>Product</th>
						        <th>Price</th>
						        <th>Discount</th>
						        <th>Total</th>
						        <th>Cancel</th>
						      </tr>
						    </thead>
						    <tbody>
						      <tr class="text-center1">
						    
						        <td class="image-prod"><a href="javascript:void(0)" onclick="fn_view1('${wdRez.whCode}','${wdRez.hCode}')"><img src="/resources/images/hallrepimage/${wdRez.hImgName}" id="prod"></a></td>
						        
						        <td class="product-name">
						        	<h3><c:out value="${wdRez.whName}" /></h3>
						        	<p><c:out value="${wdRez.hName}" /></p>
						        </td>
						        
						        <td class="price"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hPrice}" /></td>
						        
						        <td class="discount_rate"><c:out value="${wdRez.hDiscount}" />%</td>
						        
						        <td class="total"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hPrice * (1-wdRez.hDiscount*0.01)}" /></td>
						        
						        <td class="product-remove1"><a href="#"><span>X</span></a></td>
						      </tr><!-- END TR-->
							
						      <tr class="text-center2">
						       
						         <td class="image-prod"><a href="javascript:void(0)" onclick="fn_view2('${wdRez.sCode}')"><img src="/resources/images/studio/${wdRez.sImgName}" id="prod"></a></td>
						       
						        <td class="product-name">
						        	<h3><c:out value="${wdRez.sName}" /></h3>
						        	<p><c:out value="${wdRez.sContent}" /></p>
						        </td>
						        
						        <td class="price"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.sPrice}" /></td>
						        
						        <td class="discount_rate"><c:out value="${wdRez.sDiscount}" />%</td>
						        
						        <td class="total"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.sPrice * (1-wdRez.sDiscount*0.01)}" /></td>
						        
						        <td class="product-remove2"><a href="#"><span>X</span></a></td>
						      </tr><!-- END TR-->
						   
						      <tr class="text-center3">
						       
						         <td class="image-prod"><a href="javascript:void(0)" onclick="fn_view3('${wdRez.dNo}')"><img src="/resources/images/dress/${wdRez.dImgName}" id="prod"></a></td>
						        
						        <td class="product-name">
						        	<h3><c:out value="${wdRez.dName}" /></h3>
						        	<p><c:out value="${wdRez.dContent}" /></p>
						        </td>
						        
						         <td class="price"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.dPrice}" /></td>
						        
						        <td class="discount_rate"><c:out value="${wdRez.dDiscount}" />%</td>
						        
						        <td class="total"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.dPrice * (1-wdRez.dDiscount*0.01)}" /></td>
						        
						        <td class="product-remove3"><a href="#"><span>X</span></a></td>
						      </tr><!-- END TR-->
						      
						      <tr class="text-center4">
						       
						         <td class="image-prod"><a href="javascript:void(0)" onclick="fn_view4('${wdRez.mCode}')"><img src="/resources/images/makeup/${wdRez.mImgName}" id="prod"></a></td>
						        
						        <td class="product-name">
						        	<h3><c:out value="${wdRez.mName}" /></h3>
						        	<p><c:out value="${wdRez.mContent}" /></p>
						        </td>
						        
						         <td class="price"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.mPrice}" /></td>
						        
						        <td class="discount_rate"><c:out value="${wdRez.mDiscount}" />%</td>
						        
						        <td class="total"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.mPrice * (1-wdRez.mDiscount*0.01)}" /></td>
						        
						        <td class="product-remove4"><a href="#"><span>X</span></a></td>
						      </tr><!-- END TR-->
						    </tbody>
						  </table>
					  </div>
    			</div>
    		</div>
    		
    		<div class="row mt-5 pt-3 d-flex">
	          	<div class="col-md-6 p-5 d-flex">
	          		<div class="cart-detail cart-total bg-light p-3 p-md-4">
	          			<h3 class="billing-heading mb-4">Cart Total</h3>
	          			<p class="d-flex">
		    						<span>Subtotal</span>
		    						<span><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hPrice + wdRez.sPrice + wdRez.dPrice + wdRez.mPrice}" /></span>
		    					</p>
		    					<p class="d-flex">
		    						<span>Discount</span>
		    						<span><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hPrice * (wdRez.hDiscount*0.01) + wdRez.sPrice * (wdRez.sDiscount*0.01) + wdRez.dPrice * (wdRez.dDiscount*0.01) + wdRez.mPrice * (wdRez.mDiscount*0.01)}" /></span>
		    					</p>
		    					<hr>
		    					<p class="d-flex total-price">
		    						<span>Total</span>
		    						<span><fmt:formatNumber type="number" maxFractionDigits="0" value="${(wdRez.hPrice + wdRez.sPrice + wdRez.dPrice + wdRez.mPrice) - (wdRez.hPrice * (wdRez.hDiscount*0.01) + wdRez.sPrice * (wdRez.sDiscount*0.01) + wdRez.dPrice * (wdRez.dDiscount*0.01) + wdRez.mPrice * (wdRez.mDiscount*0.01)) }" /></span>
		    					</p>
								</div>
	          	</div>
	          	<div class="col-md-6 p-5">
	          		<div class="cart-detail bg-light p-3 p-md-4">
	          			<h3 class="billing-heading mb-4">Payment Method</h3>
									<div class="form-group">
										<div class="col-md-12">
											<div class="radio">
											   <label><input type="radio" name="optradio" class="mr-2"> kakaoPay</label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-md-12">
											<div class="radio">
											   <label><input type="radio" name="optradio" class="mr-2"> Check Payment</label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-md-12">
											<div class="radio">
											   <label><input type="radio" name="optradio" class="mr-2"> Paypal</label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-md-12">
											<div class="checkbox">
											   <label><input type="checkbox" value="" class="mr-2"> I have read and accept the terms and conditions</label>
											</div>
										</div>
									</div>
									<p><a href="#"class="btn btn-primary py-3 px-4">Place an order</a></p>
								</div>
							</div>
						</div>
					</div>
				</section>				
    	
<form name="rezForm" id="rezForm" method="post">
	  <input type="hidden" name="WHCode" value="" /> 
      <input type="hidden" name="HCode" value="" /> 
      <input type="hidden" name="sCode" value="" />
      <input type="hidden" name="dNo" value="" />
      <input type="hidden" name="mCode" value="" /> 
</form>    		
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    </body>	
</html>