<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
<script type="text/javascript">
function kakaoPayResult(pgToken)
{
   $("#pgToken").val(pgToken);
    
    document.kakaoForm.action = "/kakao/payResult";
    document.kakaoForm.submit();
}
</script>
</head>
<body>
<iframe width="100%," height="650" src="${pcUrl}" frameborder="0" allowfullscreen=""></iframe>
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