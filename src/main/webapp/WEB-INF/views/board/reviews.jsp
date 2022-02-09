<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp" %>

<script>
$(document).ready(function(){
   $("#btnSearch").on("click", function(){
      //새로 조회버튼을 누를 때에는 신규로 넣은 값을 가져가야 함.
      document.bbsForm.RSeq.value = 0;

      document.bbsForm.searchValue.value = $("#_searchValue").val();
      //조회를 했을 때 무조건 1페이지로 가야 함. 결색 결과가 몇페이지까지 나올지 모르니깐
      document.bbsForm.curPage.value = 1;
      document.bbsForm.action = "/board/reviews";
      document.bbsForm.submit();
   });
   

  /* $("#btnReviewWrite").on("click", function(){
      document.bbsForm.RSeq.value = "";
      var form = $("#bbsForm")[0];
      var formData = new FormData(form);

      $.ajax({
               type : "POST",
               url : "/board/reviewWrite",
               data : formData,
               processData : false,
               contentType : false,
               cache : false,
               timeout : 600000,
               beforeSend : function(xhr) 
               {
                  xhr.setRequestHeader("AJAX","true");
               },
               success : function(response) 
               {
                  if (response.code == 0) 
                  {
                     document.bbsForm.action = "/board/reviewWriteGo";
                     document.bbsForm.submit();
                  }
                  else if(response.code == 400)
                  {
                     alert("예약내역이 없거나 결제가 완료되지 않아 리뷰 작성이 불가능합니다.");
                     location.href = "/board/reviews";
                  }
                  else if(response.code == 401)
                  {
                     alert("아직 결혼식이 진행되지 않아 리뷰 작성이 불가능 합니다.");
                     location.href = "/board/reviews";
                  }
                  else 
                  {
                     alert("오류가 발생하였습니다. 다시 시도해주세요");
                     location.href = "/board/reviews";
                  }
               },
               complete : function(data) 
               {
                  icia.common.log(data);
               },
               error : function(xhr, status, error) 
               {
                  icia.common.error(error);
               }
            });
   });*/

});

function fn_view(RSeq)
{
   document.bbsForm.RSeq.value = RSeq;
   //searchType, searchValue는 안가져가나요?
   //조회 버튼을 안눌렀다면 굳이 가져갈 필요가 없음
   //조회 버튼을 눌렀다면 히든 타입 bbsForm에는 이미 값이 들어가 있음
   document.bbsForm.action = "/board/reviewInfo";
   document.bbsForm.submit();
}

//페이지 이동에 대한 버튼 처리
function fn_list(curPage)
{
   document.bbsForm.RSeq.value = "";
   document.bbsForm.curPage.value = curPage;
   document.bbsForm.action = "/board/reviews";
   document.bbsForm.submit();
}

</script>

</head>
<body>
    <jsp:include page="/WEB-INF/views/include/navigation.jsp" >
    <jsp:param name="userName" value="${wdUser.userNickname}" />
    </jsp:include>


<!-- ***** About Us Page ***** -->
    <div class="page-heading-rent-venue2">
        <div class="container">
            <div class="row">
                <div class="col-lg-12"></div>
            </div>
        </div>
    </div>
<div id="divB">
    <div class="shows-events-schedule2" id="divB">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-heading" style="padding: 20px 0;">
                        <div class="category2">
                            <p>Review</p>
                        </div>
                         <p style="text-align:center; margin-top: 10px;">여러분들의 웰딩 후기를 공유해보세요</p>
                    </div>
                </div>
            </div>
        </div>      

                <div class="tickets-page" id="divB">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="search-box search-box2"> <!--id="mint"  -->
                                    <form id="subscribe" action="" method="get">
                                        <div class="row">
                                            <div class="col-lg-5">
                                                <div class="search-heading">
                                                    <h4> 검색 조건이 있으신가요? </h4>
                                                </div>
                                            </div>
                                            <div class="col-lg-7">
                                                <div class="row">
                                                    <div class="col-lg-3">
                                                        <select value="searchType" name="_searchType" id="_searchType">
                                                            <option value="1">홀 이름</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-lg-7">
                                                        <input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" maxlength="25" class="svalue" placeholder="조회값을 입력하세요." />
                                                    </div>
                                                    <div class="col-lg-2">
                                                        <fieldset>
                                                        <button type="button" id="btnSearch" class="btn"><img class="imgNav" src="/resources/images/icons/search.jpg" width="auto" height="22px"></button>
                                                        </fieldset>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            
                            <div class="col-lg-12">
								<div class="fb_ht"></div>
							</div>                                                      
						
                     <div class="col-lg-12">
						<ul>

							<li id="divB1" style="background: #efefef;">
								<div class="row">
									<div class="col-lg-1">
										<div class="divB_tb" style="text-align: center;">
											<span>번호</span>
										</div>
									</div>
									<div class="col-lg-2" style="text-align: center;">
										<div class="divB_tb">
											<span>선택 홀</span>
										</div>
									</div>
									<div class="col-lg-4" style="text-align: center;">
										<div class="divB_tb">
											<span>제목</span>
										</div>
									</div>
									<div class="col-lg-2" style="text-align: center;">
										<div class="divB_tb">
											<span>작성자</span>
										</div>
									</div>
									<div class="col-lg-2" style="text-align: center;">
										<div class="divB_tb">
											<span>작성시간</span>
										</div>
									</div>
									<div class="col-lg-1" style="text-align: center;">
										<div class="divB_tb">
											<span>조회수</span>
										</div>
									</div>
								</div>
							</li>
                              <c:forEach var="review" items="${list}" varStatus="status">                                
                                <li id="divB">
                                	<div onclick="fn_view(${review.RSeq})">
	                                    <div class="row" id="minthover">
	                                        <div class="col-lg-1">
	                                            <div class="divB_tb2 tbstyle">
	                                                <span>${review.RSeq}</span>
	                                            </div>
	                                        </div>
	                                        <div class="col-lg-2" style="text-align: left;">
	                                            <div class="divB_tb2 tbstyle6">
	                                            	<span>${review.hName }</span>
	                                            </div>
	                                        </div>
	                                        
	                                        <div class="col-lg-4" style="text-align: left;">
	                                            <div class="divB_tb2 tbstyle5">
	                                            	<span>${review.RTitle}</span>
	                                            </div>
	                                        </div>
	                                        <div class="col-lg-2">
	                                            <div class="divB_tb2 tbstyle2">
	                                            	<span>${review.UNickName}</span>
	                                            </div>
	                                        </div>
	                                        <div class="col-lg-2">
	                                            <div class="divB_tb2 tbstyle3">
	                                            	<span>${review.regDate}</span>
	                                            </div>
	                                        </div>
	                                        <div class="col-lg-1">
	                                            <div class="divB_tb2 tbstyle4">
	                                                <span>${review.RReadCnt}</span>
	                                            </div>
	                                        </div>
	                                    </div>
                                	</div>
                                </li>
                                
                              </c:forEach>
                            </ul>
                        </div>
                        
						<div class="col-lg-12">
							<div>
								<form id="subscribe" action="" method="get">
									<div class="row">
										<div class="col-lg-5"></div>
										<div class="col-lg-7">
											<div class="row">
												<div class="col-lg-3"></div>
												<div class="col-lg-6"></div>
												<div class="col-lg-3">
												</div>
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
						
						<div class="col-lg-12">
		                    <div class="pagination">
								<ul class="pagination justify-content-center" style="border-top:none;">
									<c:if test="${!empty paging}">
										<c:if test="${paging.prevBlockPage gt 0}">	<!-- prevBlockPage이 0 보다 크냐 -->
										<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">이전</a></li>
										</c:if>
										<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
											<c:choose>
												<c:when test="${i ne curPage}">
													<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
												</c:when>
												<c:otherwise>
													<li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default">${i}</a></li>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										<c:if test="${paging.nextBlockPage gt 0}">         
											<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음</a></li>
										</c:if>       
									</c:if> 
								</ul>
		                    </div>
		                </div>

                    </div>
                </div>
            </div>
        </div>
  </div>

    <form name="bbsForm" id="bbsForm" method="post">
        <input type="hidden" name="RSeq" value="" /> <!-- 상세페이지 들어갈때 필요하니까 그때만 이 값이 들어가면됨 -->
        <input type="hidden" name="searchType" value="${searchType}" />
        <input type="hidden" name="searchValue" value="${searchValue}" />
        <input type="hidden" name="curPage" value="${curPage}" />
    </form>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>