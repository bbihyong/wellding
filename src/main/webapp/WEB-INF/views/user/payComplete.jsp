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
$(document).ready(function() {
   $("#btnComplete").on("click", function() {
      
      location.href = "/user/payList";
   });
   $("#btnMyPage").on("click", function() {
      
      location.href = "/user/wishlist";
   });
   
});
</script>
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

                            <tr style="border-top: 3px solid #444;">
                            </tr>

                        </table>

               
               </div>
               <!-- 경계선 종료 -->
               <div class="col-lg-1"></div>
            `
               <div class="col-lg-1"></div>
               <div class="col-lg-10">
               <!-- 쿠폰 가져오기 -->
               <div class="col-lg-10">
               </div>
               <div style="text-align: center;">
               <img src="../resources/images/icons/check.png" style="width:100px; margin-bottom:70px;">
               <p style="font-size:xx-large; font-weight:500;">결제가 완료 되었습니다.</p>
               </div>
                  <div class="rez_sum">
                     <button type="button" id="btnComplete" class="btn btn-primary" title="결제내역보러가기" style="border: solid 1px black; background:white; position:relative; top:4px; color:black;">결제내역 보러가기</button>
                     <!--button type="button" id="btnMyPage" class="btn btn-primary" title="장바구니" style="border: solid 1px black; background:white; position:relative; top:4px; color:black;">장바구니</button-->
                  </div>
               </div>
               
               <div class="col-lg-1"></div>
            
            </div>
         </div>         
      </div>
   </div>   

      <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  </body>

</html>