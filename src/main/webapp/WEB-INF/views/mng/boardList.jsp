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
   width: 120px;
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
    border: none;
}
/* Dark Mode 아닐떄 */ 
body.dark-theme { color: #222; background: #fff; } 
body.dark-theme a { }
body.dark-theme td,th {color: #333;}
body.dark-theme .page-link.active
{
	    background: #f5a4aa!important;
}
</style>
<script type="text/javascript" src="../resources/js/jquery.colorbox.js"></script>
<script type="text/javascript" src="../resources/js/colorBox.js"></script>
<script>
	var frCheck = <c:out value="${frCheck}" />
	
	$(function(){
		var msg = $("#msg").val();
		
	      $(".mngReviewUpdate").colorbox({
	            iframe:true, 
	            innerWidth:1235,
	            innerHeight:500,
	            scrolling:true,
	            onComplete:function()
	            {
	               $("#colorbox").css("width", "1235px");
	               $("#colorbox").css("height", "500px");
	               $("#colorbox").css("border-radius", "10px");
	               
	               $('html').css("overflow","hidden");
	            } , 
	            onClosed: function()
		          {
		            $('html').css("overflow","auto");
		          }  
	      });

	    
		if(msg == "Y")
		{
			alert("댓글 삭제에 성공했습니다.");

		}
		else if(msg == "N")
		{
			alert("댓글 삭제에 실패했습니다.");
		}
		
	      $(".FboardUpdate").colorbox({
	            iframe:true, 
	            innerWidth:1235,
	            innerHeight:500,
	            scrolling:false,
	            onComplete:function()
	            {
	               $("#colorbox").css("width", "1235px");
	               $("#colorbox").css("height", "500px");
	               $("#colorbox").css("border-radius", "10px");
	               
	               $('html').css("overflow","hidden");
	            } , 
	            onClosed: function()
		          {
		            $('html').css("overflow","auto");
		          }  
	      });
		
		//다크모드
	    const btn = document.querySelector('.btn-toggle');
	    btn.addEventListener('click', function() {
	    	document.body.classList.toggle('dark-theme'); 
	    	});
		//다크모드 끝
	     
		if(frCheck == 1){
	         document.getElementById('id1').classList.remove('sel');
	         document.getElementById('id2').classList.remove('sel');
	         document.getElementById('id3').classList.remove('sel');
	         document.getElementById('id${frCheck}').className += ' sel';  
	        
	         $("#fboard").show();
	         $("#review").hide();
	         $("#comment").hide();
	      }
	     else if(frCheck == 2){
	         document.getElementById('id1').classList.remove('sel');
	         document.getElementById('id2').classList.remove('sel');
	         document.getElementById('id3').classList.remove('sel');
	         document.getElementById('id${frCheck}').className += ' sel';  
	        
	         $("#review").show();
	         $("#fboard").hide();
	         $("#comment").hide();
	      }
	     else if(frCheck == 3)
	     {
	    	 document.getElementById('id1').classList.remove('sel');
	         document.getElementById('id2').classList.remove('sel');
	         document.getElementById('id3').classList.remove('sel');
	         document.getElementById('id${frCheck}').className += ' sel';  
	        
	         $("#review").hide();
	         $("#fboard").hide();
	         $("#comment").show();
	     }
		
		$("#id1").on("click", function(){
	        document.bbsFormF.curPage.value = 1;
	        document.bbsFormF.action = "/mng/boardList";
	        document.bbsFormF.submit();
		});
		

		 $("#id1").on("click", function(){
	        document.bbsFormF.curPage.value = 1;
	        //document.bbsFormH.action = "/mng/hsdmList";
	        document.bbsFormF.submit();
	     });
	     
	     $("#id2").on("click", function(){
	        document.bbsFormR.curPage.value = 1;
	        //document.bbsFormS.action = "/mng/hsdmList";
	        document.bbsFormR.submit();
	     });
	     
	     $("#id3").on("click", function(){
	        document.bbsFormC.curPage.value = 1;
	        //document.bbsFormD.action = "/mng/hsdmList";
	        document.bbsFormC.submit();
	     });
		
	});
	     
	     /*$("#delBtnC").on("click",function(){
	     	  
	     	  $("#delBtnC").prop("disabled", true);// 수정 버튼 비활성화 
	     	  
	     	  var form = $("#delCom")[0];
	      	  var formData = new FormData(form);
	      	 
	     	  $.ajax({
	   	            type:"POST",
	   	            url:"/mng/deleteCommentProc",
	   	            data:formData,
	   	            processData:false,
	   	  			contentType:false,
	   	  		    cache:false,
	   	  		    timeout:600000,
	   	            beforeSend:function(xhr){
	   	               xhr.setRequestHeader("AJAX", "true");
	   	            },
	   	            success:function(response){
	   	               if(response.code == 0)
	   	               {
	   	                  alert("댓글이 삭제되었습니다.");
	   	              	  fn_pagingC(1);
	   	               }
	   	               else if(response.code == 501)
	   	               {
	   	                  alert("파라미터 값이 올바르지 않습니다.");
	   	               }
	   	               else if(response.code == 500)
	   	               {
	   	            	  alert("댓글 삭제 중 오류가 발생했습니다."); 
	   	               }
	   	            },
	   	            complete:function(data){
	   	               icia.common.log(data);
	   	            },
	   	            error:function(xhr, status, error){
	   	               icia.common.error(error);
	   	            }
	   	         });
	     	  
	       });
	     
	     

		$("#id2").on("click", function(){
	        document.bbsFormR.curPage.value = 1;
	        document.bbsFormR.action = "/mng/boardList";
	        document.bbsFormR.submit();
		});

		
	});    

	
	function commentDelete(){
		
		var formData = {
				parentSeq: $(".parentSeq").val(),
				commentSeq: $(".commentSeq").val()
		};
		
   	  $.ajax({
	            type:"POST",
	            url:"/mng/deleteCommentProc",
	            data:formData,
	            processData:false,
	  			contentType:false,
	  		    cache:false,
	  		    timeout:600000,
	            beforeSend:function(xhr){
	               xhr.setRequestHeader("AJAX", "true");
	            },
	            success:function(response){
	               if(response.code == 0)
	               {
	                  alert("댓글이 삭제되었습니다.");
	              	  fn_pagingC(1);
	               }
	               else if(response.code == 501)
	               {
	                  alert("파라미터 값이 올바르지 않습니다.");
	               }
	               else if(response.code == 500)
	               {
	            	  alert("댓글 삭제 중 오류가 발생했습니다."); 
	               }
	            },
	            complete:function(data){
	               icia.common.log(data);
	            },
	            error:function(xhr, status, error){
	               icia.common.error(error);
	            }
	         });
	}
	*/
	
	function fn_pagingF(curPage)
	{
	   document.bbsFormF.curPage.value = curPage; //매개변수로 받은 현재페이지를 가져옴
	   document.bbsFormF.action = "/mng/boardList";
	   document.bbsFormF.submit();
	}
	
	function fn_pagingC(curPage)
	{
	   document.bbsFormC.curPage.value = curPage; //매개변수로 받은 현재페이지를 가져옴
	   document.bbsFormC.action = "/mng/boardList";
	   document.bbsFormC.submit();
	}
	
	function fn_search()
	{
	   document.searchForm.curPage.value = "1"; //검색한단 이야기는 첨부터 한다는 뜻이라 1부터
	   document.searchForm.action = "/mng/boardList";
	   document.searchForm.submit();
	}
	
	function fn_pageInit() //서치타입과 서치밸유에대한 설정
	{
	   $("#searchType option:eq(0)").prop("selected", true);//eq(0): 아무것도 선택안함
	   $("#searchValue").val("");
	   
	   fn_search();      
	}

</script>
<meta charset="UTF-8">
<title>게시판 관리</title>
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
                    <li class="hsem_li sel" id="id1" onclick="classChange(this)"><a class="hsem_a" href="javascript:void(0)">노하우공유</a></li>
                    <li class="hsem_li" id="id2" onclick="classChange(this)"><a class="hsem_a" href="javascript:void(0)">리뷰게시판</a></li>
                    <li class="hsem_li" id="id3" onclick="classChange(this)"><a class="hsem_a" href="javascript:void(0)">댓글관리</a></li>                
                </ul>              
         </div>
      </div>
      
	  <!-- 자유게시판 시작 -->
      <div class="col-lg-12" width="100%">
      <div id="fboard">
         <ul>
            <li class="wdhth2">
               <div class="wdhtitle2" style="width:6%;"><p>게시물<br /> 번호</p></div><!-- bSeq -->
               <div class="wdhtitle2" style="width:12%;"><p>아이디</p></div><!-- userId -->
               <div class="wdhtitle2" style="width:32%;"><p>제목</p></div><!-- bTitle -->
               <div class="wdhtitle2" style="width:33%;"><p>내용</p></div><!-- bContent -->
               <div class="wdhtitle2" style="width:8%;"><p>조회수</p></div><!-- bReadCnt -->
               <div class="wdhtitle2" style="width:8.5%;"><p>등록일</p></div><!-- regDate -->
            </li>
            <c:forEach var="fList" items="${fList}" varStatus="status">
            <li class="wdhtd2">
               <div class="wdhcon2" style="width:6%;"><p>${fList.bSeq}</p></div>
               <div class="wdhcon2" style="width:12%;"><p>${fList.userId}</p></div>
               <a href="/mng/mngFboardUpdate?bSeq=${fList.bSeq}" name="FboardUpdate" class="FboardUpdate">
	               <div class="wdhcon2 FboardUpdate" style="width:32%; border-right: 1px solid #dedede;">
	               		<p style="font-weight: bold; cursor: pointer;">${fList.bTitle}</p>
	               </div> 
               </a>
               <div class="wdhcon2 listcon" style="width:33%;"><p>${fList.bContent}</p></div>
               <div class="wdhcon2" style="width:8%;"><p>${fList.bReadCnt}</p></div>
               <div class="wdhcon2" style="width:8.5%;"><p>${fList.regDate}</p></div>
            </li>
            </c:forEach>
         </ul>

         <div class="row">
              <div class="col-lg-10" style="left:43%;">
                <div class="pagination">
               <ul class="pagination justify-content-center">
                  <c:if test="${!empty fPaging}">
                     <c:if test="${fPaging.prevBlockPage gt 0}">   <!-- prevBlockPage이 0 보다 크냐 -->
                     <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingF(${fPaging.prevBlockPage})">이전</a></li>
                     </c:if>
                     <c:forEach var="i" begin="${fPaging.startPage}" end="${fPaging.endPage}">
                        <c:choose>
                           <c:when test="${i ne curPage}">
                              <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingF(${i})">${i}</a></li>
                           </c:when>
                           <c:otherwise>
                              <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default">${i}</a></li>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                     <c:if test="${fPaging.nextBlockPage gt 0}">         
                        <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingF(${fPaging.nextBlockPage})">다음</a></li>
                     </c:if>       
                  </c:if> 
                     <form name="bbsFormF" id="bbsFormF" method="post">
                        <input type="hidden" name="frCheck" value="1" />
                  		<input type="hidden" name="curPage" value="${curPage}" />
               </form>
               </ul>
                  </div>
              </div>
            <div class="col-lg-1">
               <!--div>
                    <div class="ticket-item2 gosu_modal" href="/mng/plusStudio">
                        <div class="down-content2">
                            <div class="main-dark-button btn_go wookhall">
                                <a href="/mng/plusStudio" class="studio_modal" >스튜디오 추가</a>
                            </div>    
                         </div>
                    </div>
               </div-->
            </div>
           </div>
         </div>
      </div>
      <!-- 자유게시판 끝 -->    	

	  
	  <!-- 리뷰게시판 시작 -->
      <div class="col-lg-12" width="100%">
		<div id="review">
		   <ul>
			  <li class="wdhth2">
				 <div class="wdhtitle2" style="width:9%;"><p>게시물<br/>번호</p></div><!-- bSeq -->
				 <div class="wdhtitle2" style="width:9%;"><p>아이디</p></div><!-- userId -->
				 <div class="wdhtitle2" style="width:32%;"><p>제목</p></div><!-- bTitle -->
				 <div class="wdhtitle2" style="width:33%;"><p>내용</p></div><!-- bContent -->
				 <div class="wdhtitle2" style="width:8%;"><p>조회수</p></div><!-- bReadCnt -->
				 <div class="wdhtitle2" style="width:8%;"><p>등록일</p></div><!-- regDate -->
			  </li>
			  <c:forEach var="review" items="${rList}" varStatus="status">
			  <li class="wdhtd2">
				 <div class="wdhcon2" style="width:9%;"><p>${review.RSeq}</p></div>
				 <div class="wdhcon2" style="width:9%;"><p>${review.userId}</p></div>
				 <a href="/mng/mngReviewUpdate?RSeq=${review.RSeq}" name="RboardUpdate" class="RboardUpdate">
					<div class="wdhcon2 mngReviewUpdate" style="width:32%; border-right: 1px solid #dedede;" href="/mng/mngReviewUpdate?RSeq=${review.RSeq}"><p style="cursor: pointer; font-weight: bold;">${review.RTitle}</p></div>
				 </a>
				 <div class="wdhcon2" style="width:33%;"><p>${review.RContent}</p></div>
				 <div class="wdhcon2" style="width:8%;"><p>${review.RReadCnt}</p></div>
				 <div class="wdhcon2" style="width:8%;"><p>${review.regDate}</p></div>

			  </li>
			  </c:forEach>
		   </ul>
  
		   <div class="row">
				<div class="col-lg-10" style="left:43%;">
				  <div class="pagination">
				 <ul class="pagination justify-content-center">
					<c:if test="${!empty rPaging}">
					   <c:if test="${rPaging.prevBlockPage gt 0}">   <!-- prevBlockPage이 0 보다 크냐 -->
					   <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingF(${rPaging.prevBlockPage})">이전</a></li>
					   </c:if>
					   <c:forEach var="i" begin="${rPaging.startPage}" end="${rPaging.endPage}">
						  <c:choose>
							 <c:when test="${i ne curPage}">
								<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingF(${i})">${i}</a></li>
							 </c:when>
							 <c:otherwise>
								<li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default">${i}</a></li>
							 </c:otherwise>
						  </c:choose>
					   </c:forEach>
					   <c:if test="${rPaging.nextBlockPage gt 0}">         
						  <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingF(${rPaging.nextBlockPage})">다음</a></li>
					   </c:if>       
					</c:if> 
					   <form name="bbsFormR" id="bbsFormR" method="post">
						  <input type="hidden" name="frCheck" value="2" />
						  <input type="hidden" name="curPage" value="${curPage}" />
				 </form>
				 </ul>
					</div>
				</div>
			  <div class="col-lg-1">
				 <!--div>
					  <div class="ticket-item2 gosu_modal" href="/mng/plusStudio">
						  <div class="down-content2">
							  <div class="main-dark-button btn_go wookhall">
								  <a href="/mng/plusStudio" class="studio_modal" >스튜디오 추가</a>
							  </div>    
						   </div>
					  </div>
				 </div-->
			  </div>
			 </div>
		   </div>
		</div>
	  <!-- 리뷰게시판 끝 -->


	  <!-- 댓글 시작 -->
      <div class="col-lg-12" width="100%">
      <div id="comment">
         <ul>
            <li class="wdhth2">
               <div class="wdhtitle2" style="width:7%;"><p>게시글<br/>번호</p></div><!-- parentSeq -->
               <div class="wdhtitle2" style="width:7%;"><p>댓글번호</p></div><!-- commentSeq -->
               <div class="wdhtitle2" style="width:49%;"><p>내용</p></div><!-- wdFboardComment -->
               <div class="wdhtitle2" style="width:16%;"><p>닉네임</p></div><!-- uNickName -->
               <div class="wdhtitle2" style="width:14%;"><p>등록일</p></div><!-- regDate -->
               <div class="wdhtitle2" style="width:6.5%;"><p>삭제</p></div>
            </li>
            <c:forEach var="comment" items="${cList}" varStatus="status">
            <li class="wdhtd2">
               <div class="wdhcon2" style="width:7%;"><p>${comment.parentSeq}</p></div>
               <div class="wdhcon2" style="width:7%;"><p>${comment.commentSeq}</p></div>
               <div class="wdhcon2" style="width:49%;"><p>${comment.wdFBoardComment}</p></div>
               <div class="wdhcon2" style="width:16%;"><p>${comment.uNickName}</p></div>
               <div class="wdhcon2" style="width:14%;"><p>${comment.regDate}</p></div>
               <div class="wdhcon2" style="width:6.5%;">
               		<p>
               			<a href="/mng/boardList?parentSeq=${comment.parentSeq}&&commentSeq=${comment.commentSeq}" name="CommentDel" class="w-btn-red delBtnWish" Style="background-color: rgba(0,0,0,0);" >x</a>
               		</p>
               </div>
            </li>
            </c:forEach>
         </ul>

         <div class="row">
              <div class="col-lg-10" style="left:43%;">
                <div class="pagination">
               <ul class="pagination justify-content-center">
                  <c:if test="${!empty cPaging}">
                     <c:if test="${cPaging.prevBlockPage gt 0}">   <!-- prevBlockPage이 0 보다 크냐 -->
                     <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingC(${cPaging.prevBlockPage})">이전</a></li>
                     </c:if>
                     <c:forEach var="i" begin="${cPaging.startPage}" end="${cPaging.endPage}">
                        <c:choose>
                           <c:when test="${i ne curPage}">
                              <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingC(${i})">${i}</a></li>
                           </c:when>
                           <c:otherwise>
                              <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default">${i}</a></li>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                     <c:if test="${cPaging.nextBlockPage gt 0}">         
                        <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_pagingC(${cPaging.nextBlockPage})">다음</a></li>
                     </c:if>       
                  </c:if> 
                     <form name="bbsFormC" id="bbsFormC" method="post">
                        <input type="hidden" name="frCheck" value="3" />
                        <input type="hidden" name="curPage" value="${curPage}" />
               		</form>
               </ul>
                  </div>
              </div>
            <div class="col-lg-1">
               <!--div>
                    <div class="ticket-item2 gosu_modal" href="/mng/plusStudio">
                        <div class="down-content2">
                            <div class="main-dark-button btn_go wookhall">
                                <a href="/mng/plusStudio" class="studio_modal" >스튜디오 추가</a>
                            </div>    
                         </div>
                    </div>
               </div-->
            </div>
           </div>
         </div>
      </div>
      <!-- 댓글 끝 -->
    	
    </div>
</div>

		 <form class="d-flex" name="searchForm" id="searchForm" method="post" style="place-content: flex-end;">
		 <input type="hidden" name="curPage" value="" />
		 </form>

		 <input type="hidden" value="${msg}" id="msg" name="msg"/>
   <%@ include file="/WEB-INF/views/include/footer3.jsp" %>
</body>
</html>