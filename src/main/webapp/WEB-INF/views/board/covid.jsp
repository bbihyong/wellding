<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">
<style>
.Wtitle
{
	/*font-family: 'Gamja Flower', cursive;*/
	font-size: 40px;
	text-align: center;
	padding-top: 20px;

}
</style>
<script>
$(document).ready(function(){
	$("#btnList").on("click", function(){
		document.bbsForm.action = "/board/nBoard";
		document.bbsForm.submit();
	});
});
</script>
</head>
<body>
   	<jsp:include page="/WEB-INF/views/include/navigation.jsp" >
       <jsp:param name="userName" value="${wdUser.userNickname}" />
       </jsp:include>
       
    <div class="page-heading-rent-venue">
        <div class="container">
            <div class="row">
            </div>
        </div>
    </div>
	<div class="category2" style="padding-top: 70px; padding-bottom: 8px;">
		<p>WELLDING NOTICE</p>
	</div>
    <p style="text-align:center; padding-bottom: 30px;">우리들의 웨딩이야기를 지금 들려드려요</p>
    <br />
<div class="container">
   <div class="row" style="margin-right:0; margin-left:0;">
      <table class="table">
         <thead>
            <tr class="dongdong2">
               <td style="width: 60%; padding-left: 25px; font-size: 18px; color: #222; font-weight: 600; height: 55px; line-height: 55px;">
               	<div class="pink_boxx">
                  	<a href="/board/covid"><span style="color:white;">공지</span></a>
               	</div>
                  	&nbsp;코로나19 예방조치 안내
               </td>
               <td scope="col" style="width: 40%; padding-right: 25px; color: #444; font-size: 16px;" class="text-right">
                   2021.12.29 &nbsp;15:29
               </td>
            </tr>
            <tr style="height: 46px;">
               <td style="width: 60%; padding-left: 20px; font-size: 15px; color: #666;">
               	작성자 : admin
               </td>
               <td style="width: 40%; padding-right: 20px; font-size: 15px; color: #666;" class="text-right">
                 
               </td>
              </tr>
         </thead>
         <tbody>
            <tr>
               <td colspan="2" style="text-align:center;">
               <div style="padding: 30px 20px; text-align: left; font-size: 16px;">
               <div>
               <p style="text-align:center;">코로나19 예방조치 안내 감염확산 방지를 위하여 적극적인 협조와 양해 부탁드립니다.</p>
               <p style="text-align:center;"><img style="width:50%; margin:30px;"src="../resources/images/icons/covid.png" /></p>
               <p style="text-align:center;"><img style="width:50%; margin:30px;"src="../resources/images/icons/covid1.png" /></p>
               </div>
               </div>
			   </td>
            </tr>
         </tbody>
         <tfoot>
         <tr>
               <td colspan="2">
               <button type="button" id="btnList" class="w-btn w-btn-green2" style="float: right; margin: 10px 0 40px;">리스트</button>
               </td>
         </tr>
         </tfoot>
      </table>
   </div>
</div>

<form name="bbsForm" id="bbsForm" method="post">
   <input type="hidden" name="bSeq" value="${bSeq}" />
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
   <input type="hidden" name="curPage" value="${curPage}" />
</form>

 <!-- *** 욱채수정Footer 시작 *** -->
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
 <!-- *** 욱채수정Footer 종료 *** -->
</body>
</html>