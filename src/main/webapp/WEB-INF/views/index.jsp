<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>
   <%@ include file="/WEB-INF/views/include/head.jsp" %>
   <script>
   <%
      if(com.icia.web.util.CookieUtil.getHexValue(request, (String)request.getAttribute("AUTH_COOKIE_NAME")).equals("admin"))
      {
   %>
      location.href = "/mng/userList";
   <%
      }
   %>
      $(function(){
         //다른화보보기 슬라이더 - 홀뷰
         $('.post-wrapper3').slick({
              slidesToShow: 1,
              slidesToScroll: 1,
              autoplay: true,
              autoplaySpeed : 2000,
              pauseOnHover : true,
              prevArrow : "<button type='button' class='slick-prev3'></button>",      // 이전 화살표 모양 설정
              nextArrow : "<button type='button' class='slick-next3'></button>"      // 다음 화살표 모양 설정
            });
      });
      function fn_view(whCode, hCode)
      {
         document.hallForm.WHCode.value = whCode;
         document.hallForm.HCode.value = hCode;
         document.hallForm.action = "/hsdm/HallView";  
         document.hallForm.submit();
      }

      function fn_view3(RSeq)
      {
         document.fBoardForm.RSeq.value = RSeq;
         document.fBoardForm.action = "/board/reviewInfo";
         document.fBoardForm.submit();
      }
      
      function fn_view2(eBSeq)
      {
      //alert(eBSeq);
         document.eBoardForm.eBSeq.value = eBSeq;
         document.eBoardForm.action = "/board/eView";
         document.eBoardForm.submit();
      }
      
       $(document).ready(function(){

          var cookieData = document.cookie;
          if(cookieData.indexOf("close=Yes") < 0)
          {
               var option="width = 500, height = 540, top = 100, left = 200, location = no, menubar = no, status=no,toolbar=no, scrollbars=no, left=70, top=110";
               window.open("/popUpRoad", "PopUP", option);

          }

       });
       
   </script>
</head> 
    <body>  
    <!-- 메뉴바 시작 -->
       <jsp:include page="/WEB-INF/views/include/navigation.jsp" >
       <jsp:param name="userName" value="${wdUser.userNickname}" />
       </jsp:include>
    <!-- 메뉴바 종료 -->

    <!-- ***** Main Banner Area Start ***** -->
    <div class="main-banner">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="main-content">                      
                        <h2>Wellding</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ***** Main Banner Area End ***** -->

<!-- -------------------------보현수정----------------------------- -->
    <!-- *** 보현수정 베스트웨딩홀 ***-->
       <div class="coming-events2">
        <div class="container">
            <div class="row">
            <div class="col-lg-12">
                 <div class="bestWedding">
                   <h2>Wellding's Best</h2>
                   <p>Best Wedding Hall</p>
                 </div>
                </div>
                <c:forEach var="hallList" items="${hall}" varStatus="status">
                   <div class="col-lg-4" onclick="fn_view('${hallList.WHCode}', '${hallList.HCode}')">
                       <div class="event-item2">
                           <div class="thumb2">
                                <a href="javascript:void(0)" onclick="fn_view('${hallList.WHCode}', '${hallList.HCode}')" ><img src="/resources/images/hallrepimage/${hallList.HImgName}" alt=""></a>                 
                           </div>
                           <div class="down-content2">
                               <a href="event-details.html"><h4>${hallList.HName}</h4></a>
                               <ul>
                                   <li class="main_location"><i class="fa fa-map-marker"></i> <p>${hallList.WHLocation}</p></li>
                                   <li class="main_person"><i class="fa fa-user"></i> ${hallList.HMax}명 수용 가능</li>
                                   <li class="m_h_price"><i class="fa fa-krw" aria-hidden="true"></i>
                                   <fmt:formatNumber type="number" maxFractionDigits="3" value="${hallList.HPrice}" />
                                   </li>
                               </ul>
                              <div class="main-white-button">
                                  <a href="javascript:void(0)" onclick="fn_view('${hallList.WHCode}', '${hallList.HCode}')" >VIEW MORE ▶</a>
                              </div>
                           </div>
                       </div>
                   </div>
                </c:forEach>             
            </div>
        </div>
    </div>
    
   <!-- ------------------------------------------------------------------- -->

     <!-- *** 보현수정 스드메  ***-->
     <div class="venue-tickets">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                 <div class="category">
                   <h2>SDM category</h2>
                   <p>Wedding Collection</p>
                 </div>
                </div>
                <div class="col-lg-4">
                    <div class="venue-item">
                        <div class="thumb sdmimg">
                        <a href="/hsdm/studio">
                            <img src="/resources/images/S68.jpg" width="100%" height="auto">
                            <a class="sdm_title" href="/hsdm/studio">Studio</a>
                        </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="venue-item">
                        <div class="thumb sdmimg">
                           <a href="/hsdm/dress">
                               <img src="/resources/images/D10.jpg" width="100%" height="auto">
                              <a class="sdm_title" href="/hsdm/dress">Dress</a>                          
                           </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="venue-item">
                        <div class="thumb sdmimg">
                            <a href="/hsdm/makeUp">
                               <img src="/resources/images/M00.jpg" width="100%" height="auto">
                              <a class="sdm_title" href="/hsdm/makeUp">Makeup</a>
                           </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--의수 수정 + 준호수정 + 보현수정-->

    <div class="slider">
       <div class="row">
           <div class="col-lg-12">
            <div class="category">
              <h2>wellding promotion</h2>
              <p>Event & Promotion</p>
            </div>
           </div>
         </div>  
        <!-- div class="innerbox">
            <ul class="bxslider" style="text-align: center;"> 
             <c:forEach var="eboard" items="${wdEBoard}" varStatus="status">
                <li><a href=""><a href="javascript:void(0)" onclick="fn_view2(${eboard.eBSeq})">
                <img src="/resources/board/${eboard.eBImgName}" style="width: 80%; height: 350px;" /></a></li> 
             </c:forEach>
                <!--li><img src="resources/images/305.jpg" style="width: 80%; height: 350px;" /></li> 
                <li><img src="resources/images/608.jpg" style="width: 80%; height: 350px;" /></li> 
            </ul>
        </div-->
   <div class="left-image-hall">        
        <div class="post-slider3">
             <div class="post-wrapper3">
             <c:forEach var="eboard" items="${wdEBoard}" varStatus="status">
                <li>
                   <a href="javascript:void(0)" onclick="fn_view2(${eboard.eBSeq})">
                     <div class="post3"><img src="/resources/board/${eboard.eBImgName}" style="width: 100%; height: 350px;" alt="" /></div>
                  </a>
               </li> 
              </c:forEach>
             </div>
      </div>
        </div>
    </div>
      
    <!--의수수정중 끝-->
    
    <!-- 김동욱 수정 시작 + 보현수정 -->
    <!-- *** Amazing Venus ***-->
    <div class="amazing-venues">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="left-content">
                        <!--<iframe width="530" height="300" src="https://www.youtube.com/embed/kqUUPueWUxE?autoplay=1&amp;mute=1" title="video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> -->
                         <div style="width:530px; height:300px; background:#000;"><video width="530" height="300" src="/resources/images/video/wedding.mp4" controls autoplay muted loop></video></div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="right-content">
                        <div class="communitytitle">
                            <h2>Community</h2>
                            <p>Wellding Reviews</p>
                          </div>
                          
                          <div class="text-button"><a href="/board/reviews"><span id="plusssss">더 보기</span></a></div>
                        <div class="lisylebox">
                            <ul class="listyle">
                               <c:forEach var="review" items="${wdReviewList}" varStatus="status"> 
                                <li>
                                    <div class="board">
                                        <div class="btitle active"><a href="javascript:void(0)" onclick="fn_view3(${review.RSeq})"><c:out value="${review.RTitle}"/></a></div>
                                        <div class="bwriter"><p><c:out value="${review.UNickName}"/></p></div>
                                        <div class="bdate"><p><c:out value="${review.regDate}"/></p></div>
                                    </div>
                                </li>
                               </c:forEach> 
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 김동욱 수정 끝 -->
    
    <!-- 홀 랭킹 뷰를 위한 폼 -->
    <form name="hallForm" id="hallForm" method="post">
      <input type="hidden" name="WHCode" value="" /> 
      <input type="hidden" name="HCode" value="" /> 
   </form>
   <!-- 홀 랭킹 뷰를 위한 폼 -->
 
   <!-- 게시글 상세 페이지를 위한 폼 -->
   <form name="fBoardForm" id="fBoardForm" method="post">
         <input type="hidden" name="RSeq" value="" />
   </form>
   <!-- 게시글 상세 페이지를 위한 폼 -->

   <form name="eBoardForm" id="eBoardForm" method="post">
   <input type="hidden" name="eBSeq" value="" />
   </form>


 <!-- *** 욱채수정Footer 시작 *** -->
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
 <!-- *** 욱채수정Footer 종료 *** -->
  </body>
</html>