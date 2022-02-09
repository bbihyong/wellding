<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script>
$(document).ready(function(){
	//다른화보보기 슬라이더 - 홀뷰
	$('.post-wrapper2').slick({
		  slidesToShow: 1,
		  slidesToScroll: 1,
		  autoplay: true,
		  autoplaySpeed : 2000,
		  pauseOnHover : true,
		  prevArrow : "<button type='button' class='slick-prev2'></button>",		// 이전 화살표 모양 설정
		  nextArrow : "<button type='button' class='slick-next2'></button>"		// 다음 화살표 모양 설정
		});
	$(".btnListt").on("click", function(){
		document.hallForm.action = "/hsdm/halllist";
		document.hallForm.submit();
	});
	
	
	//홀 담기 버튼 시작
/*	$("#chae").on("click",function(){
		if(confirm("해당 홀을 장바구니에 담으시겠습니까?"))
		{
			//ajax통신 시작
			$.ajax({
			type:"POST",
			url:"/hsdm/hallRezProc",
			data:
			{
				whCode: $("#WHCode").val(),
				hCode: $("#HCode").val(),
				year: $("#year").val(),
				month: $("#month").val(),
				day: $("#day").val()
			},
			datatype:"JSON",
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{
					alert("장바구니에 해당 상품을 담았습니다.");
					if(confirm("장바구니로 이동하시겠습니까?"))
					{
						location.href = "/user/wishlist";
					}
				}
				else if(response.code == 403)
				{
					alert("서버와의 연결 상태를 확인해주세요.");
				}
				else if(response.code == 502)
				{
					alert("장바구니에 이미 다른 홀이 담겨 있습니다.");
					if(confirm("장바구니로 이동하시겠습니까?"))
					{
						location.href = "/user/wishlist";
					}
				}
				else
				{
					alert("장바구니에 상품을 담는 중 오류가 발생했습니다.");
				}
			},
			complete:function(data){
				icia.common.log(data);
			},
			error:function(xhr, status, error)
			{
				icia.common.error(error);
			}
			});
			//ajax통신 종료
		}
		
	});*/
	
	$("#chae2").on("click",function(){
		Swal.fire({
			   title: '홀 선택 완료!',
			   text: '해당 홀을 장바구니에 담으시겠습니까?',
			   icon: 'success',
			   
			   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			   confirmButtonText: '장바구니에 담기', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   
			   reverseButtons: false, // 버튼 순서 거꾸로
			   
			}).then(result => {
				   // 만약 Promise리턴을 받으면,
				   if (result.isConfirmed) 
				   { // 만약 모달창에서 confirm 버튼을 눌렀다면
						//ajax통신 시작
					$.ajax({
						type:"POST",
						url:"/hsdm/hallRezProc",
						data:
						{
							whCode: $("#WHCode").val(),
							hCode: $("#HCode").val(),
							year: $("#year").val(),
							month: $("#month").val(),
							day: $("#day").val()
						},
						datatype:"JSON",
						beforeSend:function(xhr){
							xhr.setRequestHeader("AJAX", "true");
						},
						success:function(response){
							if(response.code == 0)
							{
								//alert("장바구니에 해당 상품을 담았습니다.");
								//if(confirm("장바구니로 이동하시겠습니까?"))
								//{
								//	location.href = "/user/wishlist";
								//}
								Swal.fire({ 
									icon: 'success',
									text: '장바구니에 해당 상품을 담았습니다.'
								}).then((result) => {
									if (result.isConfirmed) 
									{ 
										Swal.fire({ 
											icon: 'question',
											text: '장바구니로 이동하시겠습니까?',
													
										    showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
										    confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
										    cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
										    confirmButtonText: '장바구니로 이동', // confirm 버튼 텍스트 지정
										    cancelButtonText: '취소', // cancel 버튼 텍스트 지정
										    reverseButtons: false // 버튼 순서 거꾸로
										}).then((result) => {
											if (result.isConfirmed) 
											{
												location.href = "/user/wishlist";
											}
											else if (result.isDismissed) 
										    { // 만약 모달창에서 cancel 버튼을 눌렀다면
												return;
										    }
										});
									}
								});
							}
							else if(response.code == 403)
							{
								//alert("서버와의 연결 상태를 확인해주세요.");
								Swal.fire({ 
									icon: 'error',
									text: '서버와의 연결 상태를 확인해주세요.'
								}).then(function(){
									return;
								});
							}
							else if(response.code == 502)
							{
								//alert("장바구니에 이미 다른 드레스가 담겨 있습니다.");
								//if(confirm("장바구니로 이동하시겠습니까?"))
								//{
								//	location.href = "/user/wishlist";
								//}
								Swal.fire({ 
									icon: 'warning',
									text: '장바구니에 이미 다른 홀이 담겨 있습니다.'
								}).then((result) => {
									if (result.isConfirmed) 
									{ 
										Swal.fire({ 
											icon: 'question',
											text: '장바구니로 이동하시겠습니까?',
													
										    showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
										    confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
										    cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
										    confirmButtonText: '장바구니로 이동', // confirm 버튼 텍스트 지정
										    cancelButtonText: '취소', // cancel 버튼 텍스트 지정
										    reverseButtons: false // 버튼 순서 거꾸로
										}).then((result) => {
											if (result.isConfirmed) 
											{
												location.href = "/user/wishlist";
											}
											else if (result.isDismissed) 
										    { // 만약 모달창에서 cancel 버튼을 눌렀다면
												return;
										    }
										});
									}
								});
							}
							else if(response.code == 500)
							{
								Swal.fire({ 
									icon: 'error',
									text: '로그인이 필요합니다.'
								}).then(function(){
									location.href="/board/login";
								});
							}
							else
							{
								//alert("장바구니에 상품을 담는 중 오류가 발생했습니다.");
								Swal.fire({ 
									icon: 'error',
									text: '장바구니에 상품을 담는 중 오류가 발생했습니다.'
								}).then(function(){
									return;
								});
							}
						},
						complete:function(data){
							icia.common.log(data);
						},
						error:function(xhr, status, error)
						{
							icia.common.error(error);
						}
						});
						//ajax통신 종료
				   }
				   else if (result.isDismissed) 
				   { // 만약 모달창에서 cancel 버튼을 눌렀다면
						return;
				   }
			});
	});
	//홀 담기 버튼 종료
	
});

function fn_view(whCode, hCode)
{
   document.hallForm.WHCode.value = whCode;
   document.hallForm.HCode.value = hCode;
   document.hallForm.action = "/hsdm/HallView";  
   document.hallForm.submit();
}
</script>
</head> 
<body>
	<!-- 메뉴바 시작 -->
    	<jsp:include page="/WEB-INF/views/include/navigation.jsp" >
    	<jsp:param name="userName" value="${wdUser.userNickname}" />
    	</jsp:include>
	<!-- 메뉴바 종료 -->
<!-- ############################ 여기부터 내용 시작 ############################ -->
<section class="top">
	<div class="back"></div>
</section>

<div class="big_title_hall">
    <div class="container">
        <div class="row">
            <div class="col-lg-12" style="text-align: center;">

	                <h2 class="whname">${wdHall.whName }</h2>
				         <button type="button" id="btnList" class="btnListt listButton2">
		        			<img src="../resources/images/icons/leftButton.png" class="listIcon" alt="리스트" width="32" height="32">
		        		</button>
		            <div class="hibixbi">
		                <h2>${wdHall.HName }</h2>
		            </div>
            </div>
        </div>
    </div>
</div>

    <div class="ticket-details-page-hall">
        <div class="container">
            <div class="row">
            <div class="col-lg-12 line">
            </div>
	
            <div class="left-image-hall">
                <!--div class="col-lg-12"-->
          			<div class="post-slider2">
		        		<div class="post-wrapper2">
		        			<div class="post2"><img src="../resources/images/hallrepimage/${wdHall.HImgName }" alt=""></div>
		        		<c:forEach var="i" items="${subImg }" varStatus="status">
		          			<div class="post2"><img src="../resources/images/hallrepimage/hallsubimage/${i}" alt=""></div>
		            	</c:forEach>
		        		</div>
					</div>
            	<!-- /div-->
           </div>
           

                <div class="col-lg-12" style="padding: 0;">	
                <br>
                    <div class="com_detail">
                        <div class="right-content">
                            
                            <span>${wdHall.HContent }<br /><p style="display:inline-block; padding-top:10px;">${wdHall.whName }&nbsp;Tel. ${wdHall.whNumber }</p></span>
                            <!--ul>
                                <li>${wdHall.whName }&nbsp;Tel. ${wdHall.whNumber }</li>
                            </ul-->
                            
                            <div class="total">
		                        <div class="det_price2" style="border-bottom: 1px solid #ccc; width: 55%">
		                        	<div style="padding: 0 25px;">
		                            	<ul>
			                                <li class="dis_price2">
			                            		<div class="discount2"><c:out value="${wdHall.hDiscount}" />%</div>
				                                <div class="price2"><fmt:formatNumber type="number" maxFractionDigits="3" value="${wdHall.HPrice}" /></div>
			                                </li>
			                            </ul>
			                            <div id="wook"><p>홀대관료</p><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdHall.HPrice * (1-wdHall.hDiscount*0.01)}" />원</div>
	                            	</div>
	                            </div>
                            
		                        <div class="det_price2" style="border-bottom: 1px solid #ccc; width: 44%">
		                        	<div style="border-left: 1px solid #ddd; width: 100%; height:57px; padding: 0 25px;">
			                            <ul>
			                                <li class="dis_price2">
				                                <div class="price3">1인당 식비 <p><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdHall.HFood }" />원</p> X 최소인원 <p> ${wdHall.HMin }명</p></div>
			                                </li>
			                            </ul>
			                            <div id="wook2"><p>식비 </p><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdHall.HFood * wdHall.HMin}" />원</div>
	                            	</div>
	                            </div>
	                            
		                        <div class="det_price2" style="width: 100%; padding-top: 35px; padding-bottom:10px; padding-right:15px; background: #efefef; border-radius: 13px; margin: 20px 0;">
		                           <div style="display: inline-block; width:85%; padding-right: 10px;">
										<ul>
			                                <li class="dis_price2">
				                                <div class="price4">홀대관료 <p><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdHall.HPrice * (1-wdHall.hDiscount*0.01)}" />원</p> <p style="font-weight:300;">X</p> 식비 <p> <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdHall.HFood * wdHall.HMin}" />명</p></div>
			                                </li>
										</ul>
		                           	 	<div id="wook3"><p>총액 </p><fmt:formatNumber type="number" maxFractionDigits="0" value="${(wdHall.HFood * wdHall.HMin) + (wdHall.HPrice * (1-wdHall.hDiscount*0.01))}" />원</div>
	                            	</div> 
									<div style="width:100%; display: inline-block; width:14%; position: relative; top: -17px;">
			                           <div class="col-lg-12 main-dark-button" style="margin-right:12px;">
			                           		<a href="#" id="chae2">현재 홀 담기</a>
			                           </div>
									</div>
	                            </div>
	                        </div>
                        </div>
                        	
                    </div>
                </div>
                <!--div class="col-lg-12 main-dark-button" style="margin-right:12px;"><a href="#" id="chae">현재 홀 담기</a></div-->
                
                <div class="col-lg-12" style="padding: 0;">
                	<div class="det_navi-hall">
                		<ul>
                			<li><a href="javascript:void(0)"><c:out value="${wdHall.whName}" />의 다른 홀 보기</a></li>
                		</ul>
                	</div>
                </div>
                
              <!-- 같은 샵 다른상품 보기 시작 -->
<c:if test="${!empty sameCom}">        
	<c:forEach var="wdHall" items="${sameCom}" varStatus="status">
               	<div class="col-lg-6">
                    <div class="ticket-item2" onclick="fn_view('${wdHall.WHCode}', '${wdHall.HCode}')" style="cursor: pointer;">
                        <div class="thumb-hall">
                            <img src="../resources/images/hallrepimage/${wdHall.HImgName}" alt="">
                        </div>
                        <div class="down-content dtbox">
                        	<div class="sd_title3">[<c:out value="${wdHall.whName}" />] <c:out value="${wdHall.HName}" /></div>
                            <ul>
                                <li class="dis_price2"><span class="discount2"><c:out value="${wdHall.hDiscount}" />%</span> <span class="dis-price"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdHall.HPrice * (1-wdHall.hDiscount*0.01)}" />원</span></li>
                            </ul>
                        </div>
                    </div>
               	</div>    
     </c:forEach>
</c:if>
			<!-- 같은 샵 다른상품 보기 끝 -->
				<div class="col-lg-12" style="width: 100%; height: 1px; background:#eee; margin-top:50px;"></div>
            	<div class="alignleft2">
				         <button type="button" id="btnList" class="btnListt listButton2">
		        			<img src="../resources/images/icons/leftButton.png" class="listIcon" alt="리스트" width="32" height="32">
		        		</button>
            	</div>
            </div>
        </div>
    </div>

    
   <form name="hallForm" id="hallForm" method="post">
      <input type="hidden" name="WHCode" id="WHCode" value="${wdHall.WHCode}" /> 
      <input type="hidden" name="HCode" id="HCode" value="${wdHall.HCode}" />
      <input type="hidden" name="searchType" value="${searchType}" />
   	  <input type="hidden" name="searchValue" value="${searchValue}" />
      <input type="hidden" name="curPage" value="${curPage}" />
      <input type="hidden" name="year" id="year" value="${year}" />
      <input type="hidden" name="month" id="month" value="${month}" />
      <input type="hidden" name="day" id="day" value="${day}" />  
   </form>

    
<!-- ############################ 여기까지 내용 끝 ############################ -->
	<!-- *** 욱채수정Footer 시작 *** -->
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<!-- *** 욱채수정Footer 종료 *** -->
</body>
</html>