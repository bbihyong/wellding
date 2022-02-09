<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
<script type="text/javascript">
$(document).ready(function() {
   
   $("#btnClose").on("click", function() {
      
      opener.movePage();
      window.close();
   });
});
</script>
</head>
<body>
<div id="kakaopay_con">

<c:choose>
   <c:when test="${!empty kakaoPayApprove}">
   	
   	<!--  div id="nav"></div-->
      <div id="kakaopayh5">
      <img src="../resources/images/kakaopay.jpg" width="150" height="auto" style="margin: 35px 0 10px;" /></div>
	<div id="text">결제완료</div>  
      <div id="margin">
      <div id="approved_at"><span>결제일시</span><br/>${kakaoPayApprove.approved_at}</div>
      <div id="order_id"><span>주문번호</span><br/>${kakaoPayApprove.partner_order_id} </div>
      <div id="item_name"><span>상품명 </span><br/>${kakaoPayApprove.item_name}</div>
      <div id="quantity"><span>상품수량</span><br/>${kakaoPayApprove.quantity} </div>
      <div id="amount_total"><span>결제금액</span><br/><fmt:formatNumber type="number" maxFractionDigits="3" value="${kakaoPayApprove.amount.total}" /></div>
      <div id="payment_method_type"><span>결제방법</span><br/>${kakaoPayApprove.payment_method_type}</div>    
      <button id="btnClose" type="button">닫기</button>
      </div>
      
   </c:when>
   
   <c:otherwise>
      <h2>카카오페이 결제중 오류가 발생하였습니다.</h2>
   </c:otherwise>
</c:choose>
</div>


 
<form name="kakaoForm" id="kakaoForm" method="post" action="/kakao/payResult">

	<input type="hidden" name="orderId" id="orderId" value="${orderId}" />
	<input type="hidden" name="tId" id="tId" value="${tId}" />
	<input type="hidden" name="userId" id="userId" value="${userId}" />
	<input type="hidden" name="pgToken" id="pgToken" value="" />
	<input type="hidden" name="cCode" id="cCode" value="${cCode}" />	<!-- 동욱 추가 -->
	<input type="hidden" name="rezNo" id="rezNo" value="${rezNo}" />
    <input type="hidden" name="rezFullPrice" id="rezFullPrice" value="${rezFullPrice}" />
    <input type="hidden" name="rezPoint" id="rezPoint" value="${rezPoint}" />

</form>
</body>
</html>