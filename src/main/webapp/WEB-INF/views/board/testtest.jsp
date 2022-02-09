<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<style>
span.star-prototype, span.star-prototype > * {
    height: 50px; 
    /*background: url(http://i.imgur.com/YsyS5y8.png) 0 -16px repeat-x;*/
    background: url(../resources/images/star123.png) 0 -52px repeat-x;
    width: 250px;
    display: inline-block;
}
 
span.star-prototype > * {
    background-position: 0 0;
    max-width:250px;
}
</style>
<script src="../resources/js/jquery-3.5.1.min.js"></script>
<script>
$(function(){
	$.fn.generateStars = function() {
	    return this.each(function(i,e){$(e).html($('<span/>').width($(e).text()*50));});
	};
	
	// 숫자 평점을 별로 변환하도록 호출하는 함수
	$('.star-prototype').generateStars();
});
</script>
</head>
<body>

평가 :   
 <span class="star-prototype">5</span>
</body>
</html>