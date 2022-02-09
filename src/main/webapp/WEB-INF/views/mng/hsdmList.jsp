<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head2.jsp" %>
<style>
*, ::after, ::before {
   box-sizing: unset;
}
.table-hover th, td{
   border: 1px solid #c4c2c2;
   text-align: center;
}

.sel{
   background: #f5a4aa;
}
.wookhall{
  /* width: 120px;*/
}

table td
{
	text-align: left;
}

/*다크모드관련*/
.btn-toggle
{
	background: none;
    position: absolute;
    top: 5px;
    right: 0;
    border: none;
    outline: none;
    color: #ccc;
    font-size: 13px;
    text-decoration: underline;
}

button:focus
{
   outline: none;
}
.btn-toggle:active
{
   outline: none!important;
}
/*다크모드 */
body {  color: #efefef; background: #121212;} 
a { color: #809fff; } 
td,th {color: #eee;}
span {color: #efefef;}
p{color: #efefef;}
.page-link
{
   background: #555!important;
    /*border: none;*/
}
/* Dark Mode 아닐떄 */ 
body.dark-theme { color: #222; background: #fff; } 
body.dark-theme a { }
body.dark-theme td,th {color: #333;}
body.dark-theme .page-link.active
{

	   /* background: #f5a4aa!important;*/

      /* background: #f5a4aa!important;*/

      /* background: #f5a4aa!important;*/
}
</style>
<script>
 var hsdmCheck = <c:out value="${hsdmCheck}" />;
 
 $(function(){
       //다크모드
       const btn = document.querySelector('.btn-toggle');
       btn.addEventListener('click', function() {
          document.body.classList.toggle('dark-theme'); 
          });
       
      //다크모드 끛
      
      $(".weddingHall_modal").colorbox({
          iframe:true, 
          innerWidth:1000,
          innerHeight:650,
          scrolling:false,
          onComplete:function()
          {
             $("#colorbox").css("width", "1000px");
             $("#colorbox").css("height", "650px");
             $("#colorbox").css("border-radius", "10px");
             
             $('html').css("overflow","hidden");
          } , 
          onClosed: function()
          {
            $('html').css("overflow","auto");
            location.reload(); 
          }  
   });
      
      $(".hall_modal2").colorbox({
          iframe:true, 
          innerWidth:1000,
          innerHeight:780,
          scrolling:true,
          onComplete:function()
          {
             $("#colorbox").css("width", "1000px");
             $("#colorbox").css("height", "780px");
             $("#colorbox").css("border-radius", "10px");
             
             $('html').css("overflow","hidden");
          } , 
          onClosed: function()
          {
            $('html').css("overflow","auto");
          }  
   });
      
     $(".studio_modal").colorbox({
            iframe:true, 
            innerWidth:1000,
            innerHeight:750,
            scrolling:true,
            onComplete:function()
            {
               $("#colorbox").css("width", "1000px");
               $("#colorbox").css("height", "750px");
               $("#colorbox").css("border-radius", "10px");
               
               $('html').css("overflow","hidden");
            } , 
            onClosed: function()
            {
              $('html').css("overflow","auto");
            }  
     });
	
	//스튜디오 수정 및 삭제 모달
	$(".studiomodal").colorbox({
            iframe:true, 
            innerWidth:1200,
            innerHeight:700,
            scrolling:false,
            onComplete:function()
            {
               $("#colorbox").css("width", "1200px");
               $("#colorbox").css("height", "700px");
               $("#colorbox").css("border-radius", "10px");
               
               $('html').css("overflow","hidden");
            } , 
            onClosed: function()
                {
                  $('html').css("overflow","auto");
                }  
     });
    
     $(".wdhall_modal").colorbox({
         iframe:true, 
         innerWidth:1000,
         innerHeight:500,
         scrolling:false,
         onComplete:function()
         {
            $("#colorbox").css("width", "1000px");
            $("#colorbox").css("height", "500px");
            $("#colorbox").css("border-radius", "10px");
            
            $('html').css("overflow","hidden");
         } , 
         onClosed: function()
         {
           $('html').css("overflow","auto");
         }  
   });
     
     $(".hall_modal").colorbox({
         iframe:true, 
         innerWidth:1000,
         innerHeight:750,
         scrolling:true,
         onComplete:function()
         {
            $("#colorbox").css("width", "1000px");
            $("#colorbox").css("height", "800px");
            $("#colorbox").css("border-radius", "10px");
            
            $('html').css("overflow","hidden");
         } , 
         onClosed: function()
         {
           $('html').css("overflow","auto");
         }  
   });
     
     //dresscom_modal & dress_modal
     $(".dresscom_modal").colorbox({
         iframe:true, 
         innerWidth:1000,
         innerHeight:550,
         scrolling:false,
         onComplete:function()
         {
            $("#colorbox").css("width", "1000px");
            $("#colorbox").css("height", "550px");
            $("#colorbox").css("border-radius", "10px");
            
            $('html').css("overflow","hidden");
         } , 
         onClosed: function()
         {
           $('html').css("overflow","auto");
         }  
   });
     
     $(".dress_modal").colorbox({
         iframe:true, 
         innerWidth:1000,
         innerHeight:650,
         scrolling:false,
         onComplete:function()
         {
            $("#colorbox").css("width", "1000px");
            $("#colorbox").css("height", "650px");
            $("#colorbox").css("border-radius", "10px");
            
            $('html').css("overflow","hidden");
         } , 
         onClosed: function()
         {
           $('html').css("overflow","auto");
         }  
   });
     
     $(".dresscom_modal2").colorbox({
         iframe:true, 
         innerWidth:1100,
         innerHeight:650,
         scrolling:false,
         onComplete:function()
         {
            $("#colorbox").css("width", "1100px");
            $("#colorbox").css("height", "650px");
            $("#colorbox").css("border-radius", "10px");
            
            $('html').css("overflow","hidden");
         } , 
         onClosed: function()
         {
           $('html').css("overflow","auto");
         }  
   });
     
     $(".dress_modal2").colorbox({
         iframe:true, 
         innerWidth:1000,
         innerHeight:770,
         scrolling:false,
         onComplete:function()
         {
            $("#colorbox").css("width", "1000px");
            $("#colorbox").css("height", "770px");
            $("#colorbox").css("border-radius", "10px");
            
            $('html').css("overflow","hidden");
         } , 
         onClosed: function()
         {
           $('html').css("overflow","auto");
         }  
   });
     
	     //메이크업모달
	     $(".makeup_modal").colorbox({
	         iframe:true, 
	         innerWidth:1000,
	         innerHeight:900,
	         scrolling:true,
	         onComplete:function()
	         {
	            $("#colorbox").css("width", "1000px");
	            $("#colorbox").css("height", "900px");
	            $("#colorbox").css("border-radius", "10px");
	            
	            $('html').css("overflow","hidden");
	         } , 
	         onClosed: function()
	         {
	           $('html').css("overflow","auto");
	         }  
	   });
	     
     //메이크업 수정
         $(".makeupUpdate").colorbox({
               iframe:true, 
               innerWidth:1000,
               innerHeight:780,
               scrolling:true,
               onComplete:function()
               {
                  $("#colorbox").css("width", "1000px");
                  $("#colorbox").css("height", "780px");
                  $("#colorbox").css("border-radius", "10px");
                  
                  $('html').css("overflow","hidden");
               } , 
               onClosed: function()
   	          {
   	            $('html').css("overflow","auto");
   	          }  
         });
     
    
     if(hsdmCheck == 1){
         document.getElementById('id1').classList.remove('sel');
         document.getElementById('id2').classList.remove('sel');
         document.getElementById('id3').classList.remove('sel');
         document.getElementById('id4').classList.remove('sel');
         document.getElementById('id${hsdmCheck}').className += ' sel';  
        
         $("#hall").show();
         $("#studio").hide();
         $("#dress").hide();
         $("#makeup").hide();
      }
     else if(hsdmCheck == 2){
         document.getElementById('id1').classList.remove('sel');
         document.getElementById('id2').classList.remove('sel');
         document.getElementById('id3').classList.remove('sel');
         document.getElementById('id4').classList.remove('sel');
         document.getElementById('id${hsdmCheck}').className += ' sel';  
        
         $("#studio").show();
         $("#hall").hide();
         $("#dress").hide();
         $("#makeup").hide();
      }
     else if(hsdmCheck == 3){
         document.getElementById('id1').classList.remove('sel');
         document.getElementById('id2').classList.remove('sel');
         document.getElementById('id3').classList.remove('sel');
         document.getElementById('id4').classList.remove('sel');
         document.getElementById('id${hsdmCheck}').className += ' sel';  
        
         $("#dress").show();
         $("#studio").hide();
         $("#hall").hide();
         $("#makeup").hide();
      }
     else if(hsdmCheck == 4){
         document.getElementById('id1').classList.remove('sel');
         document.getElementById('id2').classList.remove('sel');
         document.getElementById('id3').classList.remove('sel');
         document.getElementById('id4').classList.remove('sel');
         document.getElementById('id${hsdmCheck}').className += ' sel';  
        
         $("#makeup").show();
         $("#studio").hide();
         $("#dress").hide();
         $("#hall").hide();
      } 
     
     $("#weddinghallWrite").on("click",function(){
        location.href = "/mng/plusWHall";
     });
     
     
     $("#id1").on("click", function(){
        document.bbsFormH.curPage.value = 1;
        //document.bbsFormH.action = "/mng/hsdmList";
        document.bbsFormH.submit();
     });
     
     $("#id2").on("click", function(){
        document.bbsFormS.curPage.value = 1;
        //document.bbsFormS.action = "/mng/hsdmList";
        document.bbsFormS.submit();
     });
     
     $("#id3").on("click", function(){
        document.bbsFormD.curPage.value = 1;
        //document.bbsFormD.action = "/mng/hsdmList";
        document.bbsFormD.submit();
     });
     
     $("#id4").on("click", function(){
        document.bbsFormM.curPage.value = 1;
        //document.bbsFormM.action = "/mng/hsdmList";
        document.bbsFormM.submit();
     });
     
     
    /* $(".hsdm_btn").on("click", function(){
    	 location.reload();
     });*/
 });
function fn_search()
{
   document.searchForm.curPage.value = 1; //검색한단 이야기는 첨부터 한다는 뜻이라 1부터
   document.searchForm.action = "/mng/hsdmList";
   document.searchForm.submit();
}

function fn_pagingH(curPage)
{
   document.bbsFormH.curPage.value = curPage; //매개변수로 받은 현재페이지를 가져옴
   document.bbsFormH.action = "/mng/hsdmList";
   document.bbsFormH.submit();

}
function fn_pagingS(curPage)
{
   document.bbsFormS.curPage.value = curPage; //매개변수로 받은 현재페이지를 가져옴
   document.bbsFormS.action = "/mng/hsdmList";
   document.bbsFormS.submit();
}
function fn_pagingD(curPage)
{
   document.bbsFormD.curPage.value = curPage; //매개변수로 받은 현재페이지를 가져옴
   document.bbsFormD.action = "/mng/hsdmList";
   document.bbsFormD.submit();
}
function fn_pagingM(curPage)
{
   document.bbsFormM.curPage.value = curPage; //매개변수로 받은 현재페이지를 가져옴
   document.bbsFormM.action = "/mng/hsdmList";
   document.bbsFormM.submit();
}
/*
function classChange(id){
      document.getElementById('id1').classList.remove('sel');
      document.getElementById('id2').classList.remove('sel');
      document.getElementById('id3').classList.remove('sel');
      document.getElementById('id4').classList.remove('sel');
      //id.setAttribute('class','sel');
      document.getElementById(id.id).className += ' sel';      
      
       if($('#id1').hasClass('sel')){
           hsdmCheck = 1;
           $("#hall").show();
           $("#studio").hide();
           $("#dress").hide();
           $("#makeup").hide();
        }
       else if($('#id2').hasClass('sel')){
           hsdmCheck = 2;
           $("#studio").show();
           $("#hall").hide();
           $("#dress").hide();
           $("#makeup").hide();
        }
       else if($('#id3').hasClass('sel')){
           hsdmCheck = 3;
           $("#dress").show();
           $("#studio").hide();
           $("#hall").hide();
           $("#makeup").hide();
        }
       else if($('#id4').hasClass('sel')){
           hsdmCheck = 4;
           $("#makeup").show();
           $("#studio").hide();
           $("#dress").hide();
           $("#hall").hide();
        }
}*/

function reloadPage() 
{
    location.reload(); 
}

</script>
</head>
<body id="school_list" class="light-theme || dark-theme">  
      <jsp:include page="/WEB-INF/views/include/adminNav.jsp" >
       <jsp:param name="userName" value="${wdAdmin.admName}" />
       </jsp:include>
       
<div>
<button class="btn-toggle">다크모드</button>
</div>
       
<div class="container">
    <div class="row" style="width: 100%;">
       <div class="col-lg-12" style="width:100%; height:20px;"></div>
 <!-- /////////////////////////////////////////// --> 
      <div class="col-lg-12">
         <div class="hsdm_nav">
                <ul class="hsdm_menu">
                    <li class="hsem_li sel" id="id1" onclick="classChange(this)"><a class="hsem_a" href="javascript:void(0)">웨딩홀</a></li>
                    <li class="hsem_li" id="id2" onclick="classChange(this)"><a class="hsem_a" href="javascript:void(0)">스튜디오</a></li>
                    <li class="hsem_li" id="id3" onclick="classChange(this)"><a class="hsem_a" href="javascript:void(0)">드레스</a></li>
                    <li class="hsem_li" id="id4" onclick="classChange(this)"><a class="hsem_a" href="javascript:void(0)">메이크업</a></li>
                </ul>  
                
         </div>
      </div>
      <!-- 홀 시작 -->
      <div class="col-lg-12" width="100%">
      <div id="hall">
         <ul>
            <li class="wdhth">
               <div class="wdhtitle" style="width:10%;"><p>웨딩홀명</p></div><!-- whName -->
               <div class="wdhtitle" style="width:17%;"><p>웨딩홀설명</p></div><!-- whContent -->
               <div class="wdhtitle" style="width:12%;"><p>주소</p></div><!-- WHLocation -->
               <div class="wdhtitle" style="width:9%;"><p>전화번호</p></div><!-- whNumber -->
               <!-- div class="wdhtitle" style="width:7%;"><p>대표이미지명</p></div>< HImgName -->
               <div class="wdhtitle" style="width:8%;"><p>홀명</p></div><!-- HName -->
               <div class="wdhtitle" style="width:7%;"><p>홀대관비</p></div><!-- HPrice -->
               <div class="wdhtitle" style="width:5%;"><p>1인당식비</p></div><!-- HFood -->
               <div class="wdhtitle" style="width:5%;"><p>최소인원</p></div><!-- HMin -->
               <div class="wdhtitle" style="width:5%;"><p>최대수용인원</p></div><!-- HMax -->
               <div class="wdhtitle" style="width:16%;"><p>설명</p></div><!-- HContent -->
               <div class="wdhtitle" style="width:5%;"><p>할인율</p></div><!-- hDiscount -->
            </li>
            <c:forEach var="hallList" items="${hList}" varStatus="status">
            <li class="wdhtd">
               <div class="wdhcon" style="width:10%;">
               <p><a href="/mng/WeddingHallUpdate?whCode=${hallList.WHCode }" name="weddingHall_modal" class="weddingHall_modal" style="font-weight:800;">${hallList.whName }</a></p>
               </div>
               <div class="wdhcon" style="width:17%;"><p>${hallList.whContent}</p></div>
               <div class="wdhcon" style="width:12%;"><p>${hallList.WHLocation }</p></div>
               <div class="wdhcon" style="width:9%;"><p>${hallList.whNumber }</p></div>
               <!-- div class="wdhcon" style="width:7%;"><p>${hallList.HImgName }</p></div -->
               <div class="wdhcon" style="width:8%;">
               <p><a href="/mng/hallUpdate?whCode=${hallList.WHCode }&&hCode=${hallList.HCode }" name="hall_modal2" class="hall_modal2" style="font-weight:800;">${hallList.HName }</a></p>
               </div>
               <div class="wdhcon" style="width:7%;"><p>${hallList.HPrice }</p></div>
               <div class="wdhcon" style="width:5%;"><p>${hallList.HFood }</p></div>
               <div class="wdhcon" style="width:5%;"><p>${hallList.HMin }</p></div>
               <div class="wdhcon" style="width:5%;"><p>${hallList.HMax }</p></div>               
               <div class="wdhcon" style="width:16%;"><p>${hallList.HContent }</p></div>
               <div class="wdhcon" style="width:5%;"><p>${hallList.hDiscount }</p></div>
            </li>
            </c:forEach>
         </ul>
      
      <div class="row">
         <div class="col-lg-12">
               <div>
                  <form id="subscribe" action="" method="get">
                     <div class="row" style="width: 100%;">
                        <div class="col-lg-12">
                           <div class="gosu_modal" href="/mng/plusDress">
                              <a href="/mng/plusHall" id="btnWrite" class="hall_modal hsdm_btn" style="margin-right:30px;">홀 추가</a>
                            </div>
                            <div class="gosu_modal" href="/mng/plusDressCom">
                              <a href="/mng/plusWHall" id="btnWrite" class="wdhall_modal hsdm_btn" style="margin-right: 10px;">웨딩업체 추가</a>
                           </div>
                        </div>
                     </div>
                  </form>
               </div>
            </div>
      </div>

         <div class="row">
              <div class="col-lg-9" style="left:43%;">
                <div class="pagination">
               <ul class="pagination justify-content-center">
                  <c:if test="${!empty hPaging}">
                     <c:if test="${hPaging.prevBlockPage gt 0}">   <!-- prevBlockPage이 0 보다 크냐 -->
                     <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingH(${hPaging.prevBlockPage})">이전</a></li>
                     </c:if>
                     <c:forEach var="i" begin="${hPaging.startPage}" end="${hPaging.endPage}">
                        <c:choose>
                           <c:when test="${i ne curPage}">
                              <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingH(${i})">${i}</a></li>
                           </c:when>
                           <c:otherwise>
                              <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default">${i}</a></li>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                     <c:if test="${hPaging.nextBlockPage gt 0}">         
                        <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingH(${hPaging.nextBlockPage})">다음</a></li>
                     </c:if>       
                  </c:if> 
                     <form name="bbsFormH" id="bbsFormH" method="post">
                        <input type="hidden" name="hsdmCheck" value="1" />
                  <input type="hidden" name="curPage" value="${curPage}" />
               </form>
               </ul>
                  </div>
              </div>
           </div>
           
         </div>
      </div>
      <!-- 홀 끝 -->
      <!-- 스튜디오 시작 -->
      <div class="col-lg-12" width="100%">
      <div id="studio">
         <ul>
            <li class="wdhth">
               <div class="wdhtitle" style="width:14%;"><p>스튜디오명</p></div><!-- sName -->
               <div class="wdhtitle" style="width:18%;"><p>주소</p></div><!-- sLocation -->
               <div class="wdhtitle" style="width:12%;"><p>전화번호</p></div><!-- sNumber -->
               <div class="wdhtitle" style="width:9%;"><p>스튜디오 가격</p></div><!-- sPrice -->
               <div class="wdhtitle" style="width:9%;"><p>대표이미지명</p></div><!-- sImgname -->
               <div class="wdhtitle" style="width:32%;"><p>스튜디오설명</p></div><!-- sContent -->
               <div class="wdhtitle" style="width:5%;"><p>할인율</p></div><!-- sDiscount -->
            </li>
            <c:forEach var="studioList" items="${sList}" varStatus="status">
            <li class="wdhtd">
               <div class="wdhcon" style="width:14%;"><p><a class="studiomodal" href="/mng/updateStudio?sCode=${studioList.sCode}" style="font-weight:800;">${studioList.sName }</a></p></div>
               <div class="wdhcon" style="width:18%;"><p>${studioList.sLocation }</p></div>
               <div class="wdhcon" style="width:12%;"><p>${studioList.sNumber }</p></div>
               <div class="wdhcon" style="width:9%;"><p>${studioList.sPrice }</p></div>
               <div class="wdhcon" style="width:9%;"><p>${studioList.sImgname }</p></div>
               <div class="wdhcon" style="width:32%;"><p>${studioList.sContent }</p></div>
               <div class="wdhcon" style="width:5%;"><p>${studioList.sDiscount }</p></div>
            </li>
            </c:forEach>
         </ul>

      <div class="row">
         <div class="col-lg-12">
               <div>
                  <form id="subscribe" action="" method="get">
                     <div class="row" style="width: 100%;">
                        <div class="col-lg-12">
                            <div class="gosu_modal" href="/mng/plusDressCom">
                              <a href="/mng/plusStudio" id="btnWrite" class="studio_modal hsdm_btn" style="margin-right: 10px;">스튜디오 추가</a>
                           </div>
                        </div>
                     </div>
                  </form>
               </div>
            </div>
      </div>

         <div class="row">
              <div class="col-lg-12" style="left:43%;">
                <div class="pagination">
               <ul class="pagination justify-content-center">
                  <c:if test="${!empty sPaging}">
                     <c:if test="${sPaging.prevBlockPage gt 0}">   <!-- prevBlockPage이 0 보다 크냐 -->
                     <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingS(${sPaging.prevBlockPage})">이전</a></li>
                     </c:if>
                     <c:forEach var="i" begin="${sPaging.startPage}" end="${sPaging.endPage}">
                        <c:choose>
                           <c:when test="${i ne curPage}">
                              <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingS(${i})">${i}</a></li>
                           </c:when>
                           <c:otherwise>
                              <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default">${i}</a></li>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                     <c:if test="${sPaging.nextBlockPage gt 0}">         
                        <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingS(${sPaging.nextBlockPage})">다음</a></li>
                     </c:if>       
                  </c:if> 
                     <form name="bbsFormS" id="bbsFormS" method="post">
                        <input type="hidden" name="hsdmCheck" value="2" />
                  <input type="hidden" name="curPage" value="${curPage}" />
               </form>
               </ul>
                  </div>
              </div>
           </div>
         </div>
      </div>
      <!-- 스튜디오 끝 -->
      <!-- 드레스 시작 -->
      <div class="col-lg-12" width="100%">
      <div id="dress">
         <ul>
            <li class="wdhth">
               <div class="wdhtitle" style="width:9%;"><p>드레스샵 이름</p></div><!-- dcName -->
               <div class="wdhtitle" style="width:13%;"><p>주소</p></div><!-- dcLocation -->
               <div class="wdhtitle" style="width:8%;"><p>전화번호</p></div><!-- dcNumber -->
               <div class="wdhtitle" style="width:16%;"><p>업체설명</p></div><!-- dcContent -->
               <div class="wdhtitle" style="width:15%;"><p>드레스명</p></div><!-- dName -->
               <div class="wdhtitle" style="width:8%;"><p>드레스 이미지명</p></div><!-- dImgname -->
               <div class="wdhtitle" style="width:8%;"><p>가격</p></div><!-- dPrice -->
               <div class="wdhtitle" style="width:17%;"><p>드레스설명</p></div><!-- dContent -->
               <div class="wdhtitle" style="width:5%;"><p>할인율</p></div><!-- dImgname -->
            </li>
            <c:forEach var="dressList" items="${dList}" varStatus="status">
            <li class="wdhtd">
               <div class="wdhcon" style="width:9%;">
               <p><a href="/mng/dressComUpdate?dcCode=${dressList.dcCode}" name="dresscom_modal2" class="dresscom_modal2" style="font-weight:800;">${dressList.dcName}</a></p>
               </div>
               <div class="wdhcon" style="width:13%;"><p>${dressList.dcLocation }</p></div>
               <div class="wdhcon" style="width:8%;"><p>${dressList.dcNumber }</p></div>
               <div class="wdhcon" style="width:16%;"><p>${dressList.dcContent }</p></div>
               <div class="wdhcon" style="width:15%;">
               <p><a href="/mng/dressUpdate?dNo=${dressList.dNo}" name="dress_modal2" class="dress_modal2" style="font-weight:800;">${dressList.dName }</a></p>
               </div>
               <div class="wdhcon" style="width:8%;"><p>${dressList.dImgname }</p></div>
               <div class="wdhcon" style="width:8%;"><p>${dressList.dPrice }</p></div>
               <div class="wdhcon" style="width:17%;"><p>${dressList.dContent }</p></div>
               <div class="wdhcon" style="width:5%;"><p>${dressList.dDiscount }</p></div>
            </li>
            </c:forEach>
         </ul>

      <div class="row">
         <div class="col-lg-12">
               <div>
                  <form id="subscribe" action="" method="get">
                     <div class="row" style="width: 100%;">
                        <div class="col-lg-12">
                           <div class="gosu_modal" href="/mng/plusDress">
                              <a href="/mng/plusDress" id="btnWrite" class="dress_modal hsdm_btn" style="margin-right: 30px;">드레스 추가</a>
                            </div>
                            <div class="gosu_modal" href="/mng/plusDressCom">
                              <a href="/mng/plusDressCom" id="btnWrite" class="dresscom_modal hsdm_btn" style="margin-right: 10px;">업체 추가</a>
                           </div>
                        </div>
                     </div>
                  </form>
               </div>
            </div>
      </div>

         <div class="row">
              <div class="col-lg-12" style="left:40%;">
                <div class="pagination">
               <ul class="pagination justify-content-center">
                  <c:if test="${!empty dPaging}">
                     <c:if test="${dPaging.prevBlockPage gt 0}">   <!-- prevBlockPage이 0 보다 크냐 -->
                     <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingD(${dPaging.prevBlockPage})">이전</a></li>
                     </c:if>
                     <c:forEach var="i" begin="${dPaging.startPage}" end="${dPaging.endPage}">
                        <c:choose>
                           <c:when test="${i ne curPage}">
                              <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingD(${i})">${i}</a></li>
                           </c:when>
                           <c:otherwise>
                              <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default">${i}</a></li>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                     <c:if test="${dPaging.nextBlockPage gt 0}">         
                        <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingD(${dPaging.nextBlockPage})">다음</a></li>
                     </c:if>       
                  </c:if> 
                    <form name="bbsFormD" id="bbsFormD" method="post">
                       <input type="hidden" name="hsdmCheck" value="3" />
                  <input type="hidden" name="curPage" value="${curPage}" />
               </form>
               </ul>
                  </div>
              </div>
              
           </div>
              
         </div>
      </div>
      <!-- 드레스 끝 -->

     <!-- 메이크업 시작 -->
      <div class="col-lg-12" width="100%">

    <!-- 메이크업 시작 -->
    <div class="col-lg-12" width="100%">

      <div id="makeup">
         <ul>
            <li class="wdhth">
               <div class="wdhtitle" style="width:17%;"><p>메이크업샵 이름</p></div><!-- mName -->
               <div class="wdhtitle" style="width:20%;"><p>주소</p></div><!-- mLocation -->
               <div class="wdhtitle" style="width:11%;"><p>전화번호</p></div><!-- mNumber -->
               <div class="wdhtitle" style="width:8%;"><p>대표이미지명</p></div><!-- mImgName -->
               <div class="wdhtitle" style="width:8%;"><p>기본가격</p></div><!-- mPrice -->
               <div class="wdhtitle" style="width:24%;"><p>설명</p></div><!-- mContent -->
               <div class="wdhtitle" style="width:5%;"><p>추가인원당 가격</p></div><!-- mPlus -->
               <div class="wdhtitle" style="width:5%;"><p>할인율</p></div><!-- mDiscount -->
            </li>
            <c:forEach var="makeupList" items="${mList}" varStatus="status">
            <li class="wdhtd">

               <div class="wdhcon" style="width:17%;font-weight:800; font-size: 14px;"><a href="/mng/MngMakeupUpdate?mCode=${makeupList.mCode}" name="makeupUpdate" class="makeupUpdate">${makeupList.mName}</a></div>

            

               <div class="wdhcon" style="width:20%;"><p>${makeupList.mLocation }</p></div>
               <div class="wdhcon" style="width:11%;"><p>${makeupList.mNumber }</p></div>
               <div class="wdhcon" style="width:8%;"><p>${makeupList.mImgName }</p></div>
               <div class="wdhcon" style="width:8%;"><p>${makeupList.mPrice }</p></div>
               <div class="wdhcon" style="width:24%;"><p>${makeupList.mContent }</p></div>
               <div class="wdhcon" style="width:5%;"><p>${makeupList.mPlus }</p></div>
               <div class="wdhcon" style="width:5%;"><p>${makeupList.mDiscount }</p></div>
            </li>
            </c:forEach>
         </ul>

      <div class="row">
         <div class="col-lg-12">
               <div>
                  <form id="subscribe" action="" method="get">
                     <div class="row" style="width: 100%;">
                        <div class="col-lg-12">
                           <div gosu_modal" href="/mng/plusDress">
                              <a href="/mng/plusMakeup" class="studio_modal hsdm_btn" id="btnWrite"style="margin-right: 30px;">메이크업 추가</a>
                            </div>
                        </div>
                     </div>
                  </form>
               </div>
            </div>
      </div>

         <div class="row">
              <div class="col-lg-10" style="left:43%;">
                <div class="pagination">
	               <ul class="pagination justify-content-center">
	                  <c:if test="${!empty mPaging}">
	                     <c:if test="${mPaging.prevBlockPage gt 0}">   <!-- prevBlockPage이 0 보다 크냐 -->
	                     <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingM(${mPaging.prevBlockPage})">이전</a></li>
	                     </c:if>
	                     <c:forEach var="i" begin="${mPaging.startPage}" end="${mPaging.endPage}">
	                        <c:choose>
	                           <c:when test="${i ne curPage}">
	                              <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingM(${i})">${i}</a></li>
	                           </c:when>
	                           <c:otherwise>
	                              <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default">${i}</a></li>
	                           </c:otherwise>
	                        </c:choose>
	                     </c:forEach>
	                     <c:if test="${mPaging.nextBlockPage gt 0}">         
	                        <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingM(${mPaging.nextBlockPage})">다음</a></li>
	                     </c:if>       
	                  </c:if> 
	                     <form name="bbsFormM" id="bbsFormM" method="post">
	                        <input type="hidden" name="hsdmCheck" value="4" />
	                        <input type="hidden" name="curPage" value="${curPage}" />
	                     </form>
	               </ul>
                 </div>
              </div>
            </div>
          </div>
        </div>
      <!-- 메이크업 끝 -->

	  <form class="d-flex" name="searchForm" id="searchForm" method="post" style="place-content: flex-end;">       
		<input type="hidden" name="curPage" value="" />
      </form>
	  </div>	
	</div>
</div>

   <%@ include file="/WEB-INF/views/include/footer3.jsp" %>
</body>
</html>