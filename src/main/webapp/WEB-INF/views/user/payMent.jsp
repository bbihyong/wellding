<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en">

<head>
       <%@ include file="/WEB-INF/views/include/head.jsp" %>
       <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Bitter:ital@0;1&family=The+Nautigal&display=swap" rel="stylesheet">
<script>
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

//결제 옵션 추가
$(document).ready(function(){
		$("#couponChoice").change(function(){
		
		   //쿠폰 가격
		   var price = $("#couponChoice").val();
		   //쿠폰 코드 가져오기
		   var couponCode = $("#couponChoice > option:selected").attr("value2");
		   
		   $("#couponValue").val(price);
	   });
		
      //포인트 사용범위 제한
      $("#pointValue").keyup(function(){
    	  var val = $(this).val();
    	  if((val < 0) || (val > ${wdUser.userPoint}))
    	  {
    		  //alert("범위를 초과하였습니다.");
    		  //$(this).val("");
				Swal.fire({ 
					icon: 'error',
					text: '포인트 사용범위를 초과하였습니다.'
				}).then(function(){
					$("#pointValue").val("");
					$("#pointValue").fucus();

				});
    	  }
      });
	      
	      
      //적용 선택시 금액 리프레쉬
	  $("#couponSelect").on("click", function(){
	     
	     var price = $("#couponChoice").val();
	     
	     var point = $("#pointValue").val();
	     
	  	  if(point < 0)
		  {
				Swal.fire({ 
					icon: 'error',
					text: '포인트 사용범위를 초과하였습니다.'
				}).then(function(){
					return;
				});
				
				//return;
				
		  }
	     
	     var pointMax = ${wdUser.userPoint} - point;
	     
	     //총액
	     var aftPPn = Math.round(${wdRez.hPrice *(1- wdRez.hDiscount*0.01) + (wdRez.hFood * wdRez.hMin) + wdRez.sPrice *(1- wdRez.sDiscount*0.01) + wdRez.dPrice *(1- wdRez.dDiscount*0.01) + wdRez.mPrice * (1- wdRez.mDiscount*0.01)+ (wdRez.mPlus*wdRez.mPlusNum)});
	     
	  	  if(aftPPn < point)
		  {
				Swal.fire({ 
					icon: 'error',
					text: '사용하시는 포인트가 총 주문금액보다 많습니다.'
				}).then(function(){
					$("#pointValue").val("");
					$("#pointValue").focus();
				});
				
				return;
		  }
	     
	     pointMax = pointMax.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") ;
	     
	     document.getElementById("pointBox").innerHTML = pointMax;
	     
	     var ddong = Math.round(${wdRez.hPrice - (wdRez.hPrice *(1- wdRez.hDiscount*0.01)) + wdRez.sPrice - (wdRez.sPrice *(1- wdRez.sDiscount*0.01)) + wdRez.dPrice - (wdRez.dPrice *(1- wdRez.dDiscount*0.01)) + wdRez.mPrice - (wdRez.mPrice *(1- wdRez.mDiscount*0.01))}) + parseInt(price) + Number(point);
	           
	     ddong = ddong.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	     
	     document.getElementById("sale").innerHTML= ddong+"원";
	    
	     aftPPn = aftPPn - parseInt(price) - Number(point);
	     $("#totalAmount").val(aftPPn);
	     
	     var aftPP = aftPPn.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	     
	     document.getElementById("totalPriceAfter").innerHTML = aftPP+"원";
	     
	  });
      

      
      
	  $("#btnPay").on("click", function(){
	     $("#btnPay").prop("disabled", true); //버튼비활성화
      
		//쿠폰 코드 가져오기
      var couponCode = $("#couponChoice > option:selected").attr("value2");
	  var point = $("#pointValue").val();
      
      ///////ajax
      icia.ajax.post({
         url: "/kakao/payReady",
         data:{
            itemCode: $("#itemCode").val(),
            itemName: $("#itemName").val(),
            quantity: $("#quantity").val(),
            totalAmount: $("#totalAmount").val()
         },
         success: function(response)
         {
            icia.common.log(response);
            
            if(response.code == 0)
            {
               var orderId = response.data.orderId;
               var tId = response.data.tId;
               var pcUrl = response.data.pcUrl;
               
               //동욱 추가
               var couponNum = couponCode;
               var rezNo = response.data.rezNo;
               var rezFullPrice = response.data.rezFullPrice;
               var rezPoint = point;

               
               $("#orderId").val(orderId);
               $("#tId").val(tId);
               $("#pcUrl").val(pcUrl);
               
               //동욱 추가
               $("#cCode").val(couponNum);
               $("#rezNo").val(rezNo);
               $("#rezFullPrice").val(rezFullPrice);
               $("#rezPoint").val(rezPoint);

               
               var win = window.open('', 'kakaoPopUp', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=540,height=650,left=100,top=100');
               
               $("#kakaoForm").submit();
               $("#btnPay").prop("disabled", false);
            }
            else if(response.code == 500)
            {
            	//해당 날짜에 해당 홀이 이미 결제되어있음
            	//alert("이미 해당 날짜에 결제된 홀이 장바구니에 있습니다. 장바구니에서 제거 후 결제를 진행해주세요.");
				Swal.fire({ 
					icon: 'warning',
					text: '이미 해당 날짜에 결제된 홀이 장바구니에 있습니다. 장바구니에서 제거 후 결제를 진행해주세요.'
				}).then(function(){
					$("#btnPay").prop("disabled", false);
					return;
				});
            }
            else if(response.code == 501)
            {
            	//해당 날짜에 해당 스튜디오가 이미 결제되어있음
            	//alert("이미 해당 날짜에 결제된 스튜디오가 장바구니에 있습니다. 장바구니에서 제거 후 결제를 진행해주세요.");
				Swal.fire({ 
					icon: 'warning',
					text: '이미 해당 날짜에 결제된 스튜디오가 장바구니에 있습니다. 장바구니에서 제거 후 결제를 진행해주세요.'
				}).then(function(){
					$("#btnPay").prop("disabled", false);
					return;
				});
            }
            else if(response.code == 502)
            {
            	//해당 날짜에 해당 드레스가 이미 결제되어있음
            	//alert("이미 해당 날짜에 결제된 드레스가 장바구니에 있습니다. 장바구니에서 제거 후 결제를 진행해주세요.");
				Swal.fire({ 
					icon: 'warning',
					text: '이미 해당 날짜에 결제된 드레스가 장바구니에 있습니다. 장바구니에서 제거 후 결제를 진행해주세요.'
				}).then(function(){
					$("#btnPay").prop("disabled", false);
					return;
				});
            }
            else if(response.code == 503)
            {
            	//해당 날짜에 해당 메이크업 업체가 이미 결제되어있음
            	//alert("이미 해당 날짜에 결제된 메이크업 업체가 장바구니에 있습니다. 장바구니에서 제거 후 결제를 진행해주세요.");
				Swal.fire({ 
					icon: 'warning',
					text: '이미 해당 날짜에 결제된 메이크업 업체가 장바구니에 있습니다. 장바구니에서 제거 후 결제를 진행해주세요.'
				}).then(function(){
					$("#btnPay").prop("disabled", false);
					return;
				});
            }
            else
            {
               ///alert("오류가 발생하였습니다.");
               //$("#btnPay").prop("disabled", false);
				Swal.fire({ 
					icon: 'error',
					text: '오류가 발생했습니다.'
				}).then(function(){
					$("#btnPay").prop("disabled", false);
					return;
				});
            }
         },
         error: function(error)
         {
            icia.common.error(error);
            $("#btnPay").prop("disabled", false);
         }
      });
   });
});

function movePage()
{
   location.href = "/user/payComplete";
}

//인풋박스 입력시 세자리마다 컴마찍는 함수
    function comma(str) {
        str = String(str);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    }

    function uncomma(str) {
        str = String(str);
        return str.replace(/[^\d]+/g, '');
    } 
    
    function inputNumberFormat(obj) {
        obj.value = comma(uncomma(obj.value));
    }
    
    function inputOnlyNumberFormat(obj) {
        obj.value = onlynumber(uncomma(obj.value));
    }
    
    function onlynumber(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g,'$1');
	}
</script>
<style>
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
</style>
</head>
    
<body>
    <jsp:include page="/WEB-INF/views/include/navigation.jsp" >
    <jsp:param name="userName" value="${wdUser.userNickname}" />
    </jsp:include>
    
    <div class="page-heading-rent-venue2">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                </div>
            </div>
        </div>
    </div>
    
   <div class="container-fluid">
      <div class="row">
         <div class="col-lg-12 bcline">
            
            <div class="row">
               <div class="col-lg-1">
               </div>
               <div class="col-lg-10">
                  <h2 style="font-family: 'Bitter'; margin-top: 50px; padding-left: 10px;">주문/결제</h2>
                  <nav class="bcItem">
                     <ol class="breadcrumb bc" >
                        <li class="breadcrumb-item active">
                        </li>
                     </ol>
                  </nav>
               
               </div>
               <div class="col-lg-1">
               </div>
               
               <!-- 다음 라인 -->
               <div class="col-lg-1">
               
               </div>
               <!-- 경계선 및 내용 -->
               <div class="col-lg-10 lineListMypage">
               
                  
                        <table class="table tableWish">
                     <tr>
                        <div class="rez_sta">
                           
						   <h5 class="rez_date">결혼예정일자 &nbsp;&nbsp; <span>${year}-${month}-${day}</span></h5>									
                           <h5 class="rez_number">예약번호&nbsp;&nbsp; <span>${wdRez.rezNo}</span></h5>
                        </div>
                     </tr>
                            <tr style="border-top: 3px solid #444;">
                                <th>이미지</th>
                                <th>상품정보</th>
                                <th>참고사항</th>
                                <th>총가격</th>
                            </tr>                           
                            <!-- 홀 -->
<c:if test="${!empty wdRez.whCode}">
                            
                            <tr id="wishH">
                                <td class="image-prod">
                                   <div class="imgbox" onclick="fn_view1('${wdRez.whCode}','${wdRez.hCode}')">
                                      <img src="../resources/images/hallrepimage/${wdRez.hImgName}" id="prod" class="wishImg">
                                   </div>
                                </td>
                                
                                <td class="product-name alignleft">
                             <p class="my_hall"><c:out value="${wdRez.whName}" /></p>
                             <p><h4>&nbsp;<c:out value="${wdRez.hName}" /></h4></p>
                             <!-- 주소 넣어야 할까유?? ㄴㄴㄴㄴ무쓸모 -->
                          </td>
                                
                                <td class="HpriceTd alignleft">
                                   <p class="Hpc">홀대관비&nbsp; <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hPrice *(1- wdRez.hDiscount*0.01)}" />원
                                   &nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;식비&nbsp; <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hFood * wdRez.hMin}" />원</p>
                                   <p class="sangsaeP">
                                      <span class="chamgo">
                                         대관료할인: <span id="discountSpan">${wdRez.hDiscount}%</span> &nbsp;&nbsp;</span>
                                         <span id="xPrice"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hPrice}" />원 </span>&nbsp;&nbsp;
                                         <span id="nPrice"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hPrice *(1- wdRez.hDiscount*0.01)}" />원</span>
                                      
                                   </p>   
                                   <p class="sangsaeP">
                                      <span class="chamgo">                                        
                                         1인당 식비: <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hFood}" />원 x ${wdRez.hMin}명 = <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hFood * wdRez.hMin}" />원
                                      </span>
                                   </p>
                                </td>
                                
                                <td class="HpriceTotal" id="hollprice">
                                   <h4>
                                      <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hPrice *(1- wdRez.hDiscount*0.01) + (wdRez.hFood * wdRez.hMin)}" />원
                                   </h4>
                                </td>
                            </tr>
</c:if>
                            <!-- 스 -->
<c:if test="${!empty wdRez.sCode}">
                         
                            <tr id="wishS">
                                <td class="image-prod">
                                   <div class="imgbox"  onclick="fn_view2('${wdRez.sCode}')">
                                      <img src="../resources/images/studio/${wdRez.sImgName}" id="prod" class="wishImg">
                                   </div>
                                </td>
                                
                                <td class="product-name alignleft">
                             <p><h4>&nbsp;<c:out value="${wdRez.sName}" /></h4></p>
                             <!-- 주소 넣어야 할까유?? ㄴㄴ필요없을듯-->
                          </td>
                                
                                <td class="HpriceTd alignleft">
                                   <p class="Spc">스튜디오 예약일자 &nbsp <span style="font-weight:700; font-size:18px; color: #333;"><c:out value="${wdRez.sDate}"/></span></p>
                                   <p class="sangsaeP">
                                      <span class="chamgo">
                                         할인: <span id="discountSpan">${wdRez.sDiscount}%</span> &nbsp;&nbsp;</span>
                                         <span id="xPrice"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.sPrice}" />원 </span>&nbsp;&nbsp;
                                         <span id="nPrice"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.sPrice *(1- wdRez.sDiscount*0.01)}" />원</span>
                                      
                                   </p>
                                   <p><span class="chamgo">
                                      예약일 변경 시 스튜디오와 직접 상의하시면 더 빠르게 처리가 가능합니다.
                                   </span></p>
                                </td>
                                
                                <td class="HpriceTotal">
                                   <h4>
                                      <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.sPrice *(1- wdRez.sDiscount*0.01)}" />원
                                   </h4>
                                </td>
                            </tr>
</c:if>

                            <!-- 드 -->
<c:if test="${!empty wdRez.dNo}">
                            <tr id="wishD">
                                <td class="image-prod">
                                   <div class="imgbox" onclick="fn_view3('${wdRez.dNo}')">
                                      <img src="../resources/images/dress/${wdRez.dImgName}" id="prod" class="wishImg">
                                   </div>
                                </td>
                                
                                <td class="product-name alignleft">
                                   <p class="my_hall"><c:out value="${wdRez.dcName}" /></p>
                             <p><h4>&nbsp;<c:out value="${wdRez.dName}" /></h4></p>
                             <!-- 주소 넣어야 할까유?? -->
                          </td>
                                
                                <td class="HpriceTd alignleft">
                                   <p class="Dpc Hpc"><c:out value="${wdRez.dContent}" /></p>
                                                                      <p class="sangsaeP">
                                   <span class="chamgo">
                                      할인: <span id="discountSpan">${wdRez.dDiscount}%</span> &nbsp;&nbsp;</span>
                                      <span id="xPrice"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.dPrice}" />원 </span>&nbsp;&nbsp;
                                      <span id="nPrice"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.dPrice *(1- wdRez.dDiscount*0.01)}" />원</span>   
                                   </p>
                                   <p><span class="chamgo">
                                   </span></p>
                                </td>
                                
                                <td class="HpriceTotal">
                                   <h4>
                                      <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.dPrice *(1- wdRez.dDiscount*0.01)}" />원
                                   </h4>
                                </td>
                            </tr>
</c:if>

                            <!-- 메 -->
<c:if test="${!empty wdRez.mCode}">
                            <tr id="wishM">
                                <td class="image-prod">
                                   <div class="imgbox"  onclick="fn_view4('${wdRez.mCode}')">
                                      <img src="../resources/images/makeup/${wdRez.mImgName}" id="prod" class="wishImg">
                                   </div>
                                </td>
                                
                                <td class="product-name alignleft">
                             <p><h4>&nbsp;<c:out value="${wdRez.mName}" /></h4></p>
                             <!-- 주소 넣어야 할까유?? -->
                          </td>
                                
                                <td class="HpriceTd alignleft">
                                   <p class="Hpc">비용&nbsp; <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.mPrice *(1- wdRez.mDiscount*0.01)}" />원
<c:if test="${!empty wdRez.mPlusNum}"> 
                                   &nbsp;&nbsp;/&nbsp;&nbsp; 추가비용&nbsp; <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.mPlus * wdRez.mPlusNum}" />원</p>
</c:if>                                   
                                   <p class="sangsaeP">
                                      <span class="chamgo">
                                         할인: <span id="discountSpan">${wdRez.mDiscount}% &nbsp;&nbsp;</span></span>
                                         <span id="xPrice"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.mPrice}" />원 </span>&nbsp;&nbsp;
                                         <span id="nPrice"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.mPrice *(1- wdRez.mDiscount*0.01)}" />원</span>
                                      
                                   </p>   
<c:if test="${!empty wdRez.mPlusNum}"> 
                                   <p class="sangsaeP">
                                      <span class="chamgo">                                        
                                         추가비용: <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.mPlus}" />원 x ${wdRez.mPlusNum}명 = <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.mPlus * wdRez.mPlusNum}" />원
                                      </span>
                                   </p>
</c:if>
                                </td>
                                
                                <td class="HpriceTotal">
                                   <h4>
                                      <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.mPrice *(1- wdRez.mDiscount*0.01)+ (wdRez.mPlus*wdRez.mPlusNum)}" />원
                                   </h4>
                                </td>
                            </tr>
</c:if>

                        </table>

                     </div>
                     <!-- 경계선 종료 -->
                     <div class="col-lg-1"></div>
                     <div class="col-lg-1"></div>
                     <div class="col-lg-10">
                     <div class="select_cnc">
	                     <!-- 쿠폰 가져오기 -->
	                     <div class="select_coupon">
							쿠폰 
		                     <select name="couponChoice" id="couponChoice" style="width:120px;">
		                        <option value="0">선택</option>
		                        
		                     <c:forEach var="coupon" items="${couponList}" varStatus="status">
		                        <option value="${coupon.cPrice}" value2="${coupon.cCode}">${coupon.cName}</option>
		                     </c:forEach>
		                     </select>&nbsp;&nbsp;&nbsp;
							할인금액 <input type="text" name="couponValue" id="couponValue" value="" readonly>
		      
		                     <!-- <button name="couponSelect" id="couponSelect" style="border: solid 1px black; background:white; position:relative; color:black;">적용</button> -->
	                     </div>
	                     <div class="select_line"></div>
	                     <!-- 포인트 가져오기 -->
	                     <div class="select_point">
	                     	보유포인트 :&nbsp;<span name="pointBox" id="pointBox" style="display:inline-block; width:90px; color:red;"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdUser.userPoint}" /></span> Point
		                     <span>
		                     	<span style="color: #999; font-weight: 300;">/</span> 사용포인트&nbsp;<input type="number" name="pointValue" id="pointValue" style="width:130px" value="0" min="0" max="${wdUser.userPoint}" />&nbsp;point
		                     	<!--<input type="text" name="pointValue" id="pointValue" style="width:100px" value="" min="0" max="${wdUser.userPoint}" onkeyup="inputNumberFormat(this);" />-->
		                     </span>
	                     	<!-- <button name="pointSelect" id="pointSelect" style="border: solid 1px black; background:white; position:relative; color:black;">적용</button> -->
						 </div>
						 
						 <!-- 적용버튼 -->
	                     <div class="selectcnc_btn">
	                     	<button name="couponSelect" id="couponSelect">적용</button>
	                     </div>
						 
                     </div>


<c:if test="${!empty wdRez.whCode or !empty wdRez.sCode or !empty wdRez.dNo or !empty wdRez.mCode or !empty wdRez.mPlusNum}">
                  <div class="rez_sum">
                     <dl class="sumbox1">
                        <dt class="sumsec">총상품금액</dt>
                        <dd class="sumpay1">
                           <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hPrice + (wdRez.hFood * wdRez.hMin) + wdRez.sPrice + wdRez.dPrice + wdRez.mPrice + (wdRez.mPlus*wdRez.mPlusNum)}" />원
                        </dd>
                     </dl>
                     
                     <dl class="sumbox3">
                        <dt class="pam">-</dt>
                     </dl>
                     
                     <dl class="sumbox1">
                        <dt class="sumsec">예상할인금액</dt>
                        <dd class="sumpay2" id="sale"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hPrice - (wdRez.hPrice *(1- wdRez.hDiscount*0.01)) + wdRez.sPrice - (wdRez.sPrice *(1- wdRez.sDiscount*0.01)) + wdRez.dPrice - (wdRez.dPrice *(1- wdRez.dDiscount*0.01)) + wdRez.mPrice - (wdRez.mPrice *(1- wdRez.mDiscount*0.01))}" />원</dd>
                     </dl>
                     
                     <dl class="sumbox3">
                        <dt class="pam">=</dt>
                     </dl>
                     
                     <div class="sumbox2">
                        <h5>총 주문금액 
                           <span id="totalPriceAfter">
                              <fmt:formatNumber type="number" maxFractionDigits="0"
                              value="${wdRez.hPrice *(1- wdRez.hDiscount*0.01) + (wdRez.hFood * wdRez.hMin) + wdRez.sPrice *(1- wdRez.sDiscount*0.01) + wdRez.dPrice *(1- wdRez.dDiscount*0.01) + wdRez.mPrice *(1- wdRez.mDiscount*0.01)+ (wdRez.mPlus*wdRez.mPlusNum)}"
                               />원
                           </span>
                        </h5>
                     </div>
                     <!-- 총 주문금액 변수 i에 넣어서  totalAmount 에 넣어주기-->
                     <fmt:parseNumber var="i" type="number" value="${wdRez.hPrice *(1- wdRez.hDiscount*0.01) + (wdRez.hFood * wdRez.hMin) + wdRez.sPrice *(1- wdRez.sDiscount*0.01) + wdRez.dPrice *(1- wdRez.dDiscount*0.01) + wdRez.mPrice *(1- wdRez.mDiscount*0.01)+ (wdRez.mPlus*wdRez.mPlusNum)}" />
                     <!-- 카카오 페이 버튼 추가 -->
                     <button id="btnPay" class="kakaopay_btnnn" title="카카오페이">
                     <img src="../resources/images/icons/kakaoPay.png" style="width: 80px;">
                     </button>
                  </div>
</c:if>
               </div>
               <div class="col-lg-1"></div>
            
            </div>
         </div>         
      </div>
   </div>   


<form name="rezForm" id="rezForm" method="post">
     <input type="hidden" name="WHCode" value="" /> 
      <input type="hidden" name="HCode" value="" /> 
      <input type="hidden" name="sCode" value="" />
      <input type="hidden" name="dNo" value="" />
      <input type="hidden" name="mCode" value="" /> 
</form>

<div class="container">
   <form name="payForm" id="payForm" method="post">
      <input type="hidden" name="itemCode" id="itemCode" maxlength="32" class="form-control mb-2" placeholder="상품코드" value="${wdRez.rezNo}" />
      <input type="hidden" name="itemName" id="itemName" maxlength="50" class="form-control mb-2" placeholder="상품명" value="${wdUser.userId} 의 상품" />
      <input type="hidden" name="quantity" id="quantity" maxlength="3" class="form-control mb-2" placeholder="수량" value="1" />
      <input type="hidden" name="totalAmount" id="totalAmount" maxlength="15" class="form-control mb-2" placeholder="금액" value="<c:out value='${i}' />" />     
      
   </form>
   <form name="kakaoForm" id="kakaoForm" method="post" target="kakaoPopUp" action="/kakao/payPopUp">
      <input type="hidden" name="orderId" id="orderId" value="" />
      <input type="hidden" name="tId" id="tId" value="" />
      <input type="hidden" name="pcUrl" id="pcUrl" value="" />
      <input type="hidden" name="cCode" id="cCode" value="" />   <!-- 동욱 추가 -->
      <input type="hidden" name="rezNo" id="rezNo" value="" />
      <input type="hidden" name="rezFullPrice" id="rezFullPrice" value="" />
      <input type="hidden" name="rezPoint" id="rezPoint" value="" />

   </form>
   
</div>

      <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  </body>

</html>