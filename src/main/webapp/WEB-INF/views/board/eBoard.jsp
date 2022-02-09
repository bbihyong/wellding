
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<title>이벤트</title>

<script>   
$(document).ready(function(){
	$("#btnSearch").on("click", function(){
	  fn_search();
   });
	
	/* $("_searchValue").on("keypress", function(e){
		
		if(e.which == 13)
		{	
			fn_search();
		} */
});

function fn_search(){
	
	if($.trim($("#_searchValue").val()).length <= 0)
	{
		//alert("조회값을 입력하세요.");
		Swal.fire({ 
			icon: 'warning',
			text: '조회값을 입력하세요.'
		});
		$("#_searchValue").focus();
		return;
	}
	 document.eBoardForm.eBSeq.value = "" ; 
     document.eBoardForm.searchType.value = $("#_searchType").val();
     document.eBoardForm.searchValue.value = $("#_searchValue").val();
     document.eBoardForm.curPage.value = 1;
     document.eBoardForm.action = "/board/eBoard";
     document.eBoardForm.submit(); 
}

function fn_paging(curPage)
{
	document.eBoardForm.eBSeq.value = "";
	document.eBoardForm.curPage.value = curPage;
	document.eBoardForm.action = "/board/eBoard";
	document.eBoardForm.submit();
}

function fn_view(eBSeq)
{
	document.eBoardForm.eBSeq.value = eBSeq;
	document.eBoardForm.action = "/board/eView";
	document.eBoardForm.submit();
}
</script>
</head>
<body>
	  <jsp:include page="/WEB-INF/views/include/navigation.jsp" >
       <jsp:param name="userName" value="${wdUser.userNickname}" />
       </jsp:include>

	<section class="top">
		<div class="back"></div>
	</section>

	<!-- ***** About Us Page ***** -->
	<div class="page-heading-shows-events5">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<h2></h2>
				</div>
			</div>
		</div>
	</div>
	<div class="category2" style="padding-top: 70px; padding-bottom: 8px;">
		<p>WELLDING EVENT</p>
	</div>	
	<!--h2 class="e_title">EVENT</h2-->
	<p style="text-align: center; margin-bottom: 20px;">웰딩 이벤트를 확인해보세요!</p>
	<br />
      
                <div class="tickets-page">
       			 <div class="container">
          		  <div class="row">
                <div class="col-lg-12">
                    <div class="heading">
                        <h2><!-- Event --></h2>
                    </div>
                </div>
 				
					                             
		<div class="container">
			<div class="row">
				<div class="col-lg-12" id="search-box" style="margin-bottom: 30px;">
					<div class="search-box search-box2">
						<form id="subscribe" action="" method="get">
							<div class="row">
								<div class="col-lg-5">
									<div class="search-heading">

										<h4>찾고 계신 이벤트가 있으시다면 검색을 이용해보세요!</h4>
									</div>
								</div>
								<div class="col-lg-7">
									<div class="row">
										<div class="col-lg-3">
											<select value="searchType" name="_searchType" id="_searchType">
												<option value="">조회 항목</option>
												<option value="1"
													<c:if test="${searchType eq '1'}">selected</c:if>>제목</option>
												<option value="2"
													<c:if test="${searchType eq '2'}">selected</c:if>>내용</option>
											</select>
										</div>
										<div class="col-lg-7">
											<input type="text" name="_searchValue" id="_searchValue"
												value="${searchValue}" maxlength="25" class="svalue"
												placeholder="조회값을 입력하세요." />
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

				<!--div class="col-lg-1"></div-->
				<div class="col-lg-12">
					<div class="row">
					
						<div class="event-item">
							<div class="row">
								<div class="col-lg-7" id="eback">
										<div class="left-content" style="padding: 25px;">
											<a href="/board/eBoardCoupon">
											<h1 class="display-5 fw-bolder" id="etitle">
                                         	<div class="pink_boxx" style=" position: relative; top: -7px;">
                                            	<span style="color:white;">공지</span>
                                         	</div>
											 쿠폰 발급 이벤트
											 </h1>
											<div class="caption_desc">웰딩에서 준비한 쿠폰이벤트! 웰딩 회원이라면 모두 발급 가능합니다 ^^</div>
											<div class="e_write">admin</div>
											<div class="e_date">2022.01.01</div></a>
										</div>
									</div>
								
									<div class="col-lg-5" id="eback2">
										<div class="thumb" >
											<a href="/board/eBoardCoupon">
												<img src="/resources/images/ccc.png" alt="할인쿠폰" style="border-radius: 4%;">
											</a>
										</div>
									</div>
								</div>
							</div>
									
					
						<c:forEach var="eboard" items="${eBoard}" varStatus="status">
							<div class="event-item" onclick="fn_view(${eboard.eBSeq})">
								<div class="row">
									<div class="col-lg-7" id="eback">
										<div class="left-content" style="padding: 25px;">
											<h1 class="display-5 fw-bolder" id="etitle">${eboard.eBTitle}</h1>
											<div class="caption_desc">${eboard.eBContent}</div>
											<div class="e_write">${eboard.adminId}</div>
											<div class="e_date">${eboard.regDate}</div>
										</div>
									</div>
									<div class="col-lg-5" id="eback2">
										<div class="thumb">
											<img src="/resources/board/${eboard.eBImgName}" alt="" style="border-radius: 4%;">
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
						
						<div style="width:100%; height: 2px; background-color: #ddd; margin-bottom:30px;"></div>
						
					</div>
				</div>
					<!-- div class="col-lg-1"></div-->


						<div class="col-lg-12">
		                    <div class="pagination">
								<ul class="pagination justify-content-center">
									<c:if test="${!empty paging}">
										<c:if test="${paging.prevBlockPage gt 0}">	<!-- prevBlockPage이 0 보다 크냐 -->
										<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_paging(${paging.prevBlockPage})">이전</a></li>
										</c:if>
										<c:forEach var="i" begin = "${paging.startPage}" end="${paging.endPage}">
											<c:choose>
												<c:when test="${i ne curPage}">
													<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_paging(${i})">${i}</a></li>
												</c:when>
												<c:otherwise>
													<li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default">${i}</a></li>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										<c:if test="${paging.nextBlockPage gt 0}">         
											<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_paging(${paging.nextBlockPage})">다음</a></li>
										</c:if>       
									</c:if> 
								</ul>
		                    </div>
		                </div>
		                
					</div>
				</div>
			</div>
			<form name="eBoardForm" id="eBoardForm" method="post">
				<input type="hidden" name="eBSeq" value="" /> <input type="hidden"
					name="searchType" value="${searchType}" /> <input type="hidden"
					name="searchValue" value="${searchValue}" /> <input type="hidden"
					name="curPage" value="${curPage}" />
			</form>
		</div>

		<%@ include file="/WEB-INF/views/include/footer.jsp"%>

</body>
</html>