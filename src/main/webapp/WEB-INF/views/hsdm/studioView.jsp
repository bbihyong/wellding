<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script>
$(document).ready(function(){

	//다른화보보기 슬라이더
	$('.post-wrapper').slick({
		  slidesToShow: 1,
		  slidesToScroll: 1,
		  autoplay : true,			// 자동 스크롤 사용 여부
		  autoplaySpeed : 2000, 		// 자동 스크롤 시 다음으로 넘어가는데 걸리는 시간 (ms)
		  pauseOnHover : true,		// 슬라이드 이동	시 마우스 호버하면 슬라이더 멈추게 설정
		  prevArrow : "<button type='button' class='slick-prev'></button>",		// 이전 화살표 모양 설정
		  nextArrow : "<button type='button' class='slick-next'></button>"		// 다음 화살표 모양 설정
		});
	$(".btnListt").on("click", function(){
		document.bbsForm.action = "/hsdm/studio";
		document.bbsForm.submit();
	});
	
	//스튜디오 담기 버튼 시작
	$("#chae").on("click",function(){
		
		if($("#year").val() == "")
		{
			//alert("예약할 연도를 입력해주세요.");
			Swal.fire({ 
				icon: 'warning',
				text: '예약할 연도를 입력하세요.'
			});
			return;
		}
		else if($("#month").val() == "")
		{
			//alert("예약할 달을 입력해주세요.");
			Swal.fire({ 
				icon: 'warning',
				text: '예약할 달을 입력하세요.'
			});
			return;
		}
		else if($("#day").val() == "")
		{
			//alert("예약할 날짜를 입력해주세요.");
			Swal.fire({ 
				icon: 'warning',
				text: '예약할 일자를 입력하세요.'
			});
			return;
		}
/*		
		else if(confirm("해당 스튜디오를 장바구니에 담으시겠습니까?"))
		{
			//ajax통신 시작
			$.ajax({
			type:"POST",
			url:"/hsdm/studioRezProc",
			data:
			{
				sCode: $("#sCode").val(),
				year: $("#year").val(),
				month:$("#month").val(),
				day:$("#day").val()
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
				else if(response.code == 402)
				{
					alert("스튜디오 예약날짜를 입력해주세요.");
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
*/		
		Swal.fire({
			   title: '스튜디오 선택 완료!',
			   text: '해당 스튜디오를 장바구니에 담으시겠습니까?',
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
						url:"/hsdm/studioRezProc",
						data:
						{
							sCode: $("#sCode").val(),
							year: $("#year").val(),
							month:$("#month").val(),
							day:$("#day").val()
						},
						datatype:"JSON",
						beforeSend:function(xhr){
							xhr.setRequestHeader("AJAX", "true");
						},
						success:function(response){
							if(response.code == 0)
							{
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
								Swal.fire({ 
									icon: 'warning',
									text: '장바구니에 이미 다른 스튜디오가 담겨 있습니다.'
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
<c:if test="${!empty wdStudio}">
<div class="big_title">
</div>
    <div class="ticket-details-page">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <div class="left-image2">
                        <img src="../resources/images/studio/${wdStudio.sImgname}" alt="">
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="com_detail9">
                        <div class="right-content2">
                            <h4>
                            	<c:out value="${wdStudio.sName}" />
				             	<button type="button" id="btnList" class="btnListt listButton3">
				        			<img src="../resources/images/icons/leftButton.png" class="listIcon" alt="리스트" width="32" height="32">
				        		</button>
                            </h4>

                            <span><c:out value="${wdStudio.sContent}" /></span>
                            <ul  class="loc_li">
			                    <li><i class="fa fa-map-marker"></i> <c:out value="${wdStudio.sLocation}" /></li>
			                    <li><p style="margin-right:7px">Tel.</p><p style="font-weight:700"><c:out value="${wdStudio.sNumber}" /></p></li>
			                </ul>
                            <div class="det_price9">
	                            <ul>
	                                <li class="dis_price">
	                            		<div class="discount"><c:out value="${wdStudio.sDiscount}" />%</div>
		                                <div class="price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${wdStudio.sPrice}" /></div>
	                                </li>
	                            </ul>
	                            <div class="dis-price"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdStudio.sPrice * (1-wdStudio.sDiscount*0.01)}" />원</div>
                            </div>
                            <div class="banner2">
                                <!--img src="../resources/images/tour.png" width="100%"-->
                            </div>
                            
                            <!--  스튜디오 예약일 추가 시작 -->
							<dl class="st_dl">
								 <dt class="st_dt">스튜디오 예약일&nbsp;:</dt>
				                  <dd class="date st_dd">
									<select id="year" class="year select_date" style="margin-right: 8px;">
										<option value="">년도</option>
										<option value="2022" <c:if test="${year eq '2022'}">selected</c:if>>2022</option>
										<option value="2023" <c:if test="${year eq '2023'}">selected</c:if>>2023</option>
									</select> 
									<select id="month" class="month select_date2" style="margin-right: 8px;">
										<option value="">월</option>
										<option value="01" <c:if test="${month eq '01'}">selected</c:if>>1</option>
										<option value="02" <c:if test="${month eq '02'}">selected</c:if>>2</option>
										<option value="03" <c:if test="${month eq '03'}">selected</c:if>>3</option>
										<option value="04" <c:if test="${month eq '04'}">selected</c:if>>4</option>
										<option value="05" <c:if test="${month eq '05'}">selected</c:if>>5</option>
										<option value="06" <c:if test="${month eq '06'}">selected</c:if>>6</option>
										<option value="07" <c:if test="${month eq '07'}">selected</c:if>>7</option>
										<option value="08" <c:if test="${month eq '08'}">selected</c:if>>8</option>
										<option value="09" <c:if test="${month eq '09'}">selected</c:if>>9</option>
										<option value="10" <c:if test="${month eq '10'}">selected</c:if>>10</option>
										<option value="11" <c:if test="${month eq '11'}">selected</c:if>>11</option>
										<option value="12" <c:if test="${month eq '12'}">selected</c:if>>12</option>
									</select>
									<select id="day" class="day select_date2">
										<option value="">일</option>
										<option value="01" <c:if test="${day eq '01'}">selected</c:if>>1</option>
										<option value="02" <c:if test="${day eq '02'}">selected</c:if>>2</option>
										<option value="03" <c:if test="${day eq '03'}">selected</c:if>>3</option>
										<option value="04" <c:if test="${day eq '04'}">selected</c:if>>4</option>
										<option value="05" <c:if test="${day eq '05'}">selected</c:if>>5</option>
										<option value="06" <c:if test="${day eq '06'}">selected</c:if>>6</option>
										<option value="07" <c:if test="${day eq '07'}">selected</c:if>>7</option>
										<option value="08" <c:if test="${day eq '08'}">selected</c:if>>8</option>
										<option value="09" <c:if test="${day eq '09'}">selected</c:if>>9</option>
										<option value="10" <c:if test="${day eq '10'}">selected</c:if>>10</option>
										<option value="11" <c:if test="${day eq '11'}">selected</c:if>>11</option>
										<option value="12" <c:if test="${day eq '12'}">selected</c:if>>12</option>
										<option value="13" <c:if test="${day eq '13'}">selected</c:if>>13</option>
										<option value="14" <c:if test="${day eq '14'}">selected</c:if>>14</option>
										<option value="15" <c:if test="${day eq '15'}">selected</c:if>>15</option>
										<option value="16" <c:if test="${day eq '16'}">selected</c:if>>16</option>
										<option value="17" <c:if test="${day eq '17'}">selected</c:if>>17</option>
										<option value="18" <c:if test="${day eq '18'}">selected</c:if>>18</option>
										<option value="19" <c:if test="${day eq '19'}">selected</c:if>>19</option>
										<option value="20" <c:if test="${day eq '20'}">selected</c:if>>20</option>
										<option value="21" <c:if test="${day eq '21'}">selected</c:if>>21</option>
										<option value="22" <c:if test="${day eq '22'}">selected</c:if>>22</option>
										<option value="23" <c:if test="${day eq '23'}">selected</c:if>>23</option>
										<option value="24" <c:if test="${day eq '24'}">selected</c:if>>24</option>
										<option value="25" <c:if test="${day eq '25'}">selected</c:if>>25</option>
										<option value="26" <c:if test="${day eq '26'}">selected</c:if>>26</option>
										<option value="27" <c:if test="${day eq '27'}">selected</c:if>>27</option>
										<option value="28" <c:if test="${day eq '28'}">selected</c:if>>28</option>
										<option value="29" <c:if test="${day eq '29'}">selected</c:if>>29</option>
										<option value="30" <c:if test="${day eq '30'}">selected</c:if>>30</option>
										<option value="31" <c:if test="${day eq '31'}">selected</c:if>>31</option>
									</select>
								</dd>
							</dl>
							<!-- 스튜디오 예약일 추가 끝 -->
							
                            <div class="main-dark-button2"><a href="#" id="chae">이 스튜디오 담기</a></div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-12">
                	<div class="det_navi2">
                		<ul>
                			<li><a href="javascript:void(0)"><c:out value="${wdStudio.sName}" />의 다른 화보 보기</a></li>
                		</ul>
                	</div>
                </div>

			    <div class="col-lg-12">
				   <div class="post-slider">
				        <div class="post-wrapper">
				        	<c:forEach var="i" items="${subImg }" varStatus="status">
				          		<div class="post"><img src="../resources/images/studio_det/${i}" alt=""></div>
				            </c:forEach>
				        </div>
					</div>
			    </div>
			    
				<div class="col-lg-12" style="width: 100%; height: 1px; background:#eee; margin-top:50px;"></div>
            	<div class="alignleft2">
	             	<button type="button" id="btnList" class="btnListt listButton">
	        			<img src="../resources/images/icons/leftButton.png" class="listIcon" alt="리스트" width="32" height="32">
	        		</button>
            	</div>
            	
            </div>
        </div>

    </div>
</c:if>

<form name="bbsForm" id="bbsForm" method="post">
   <input type="hidden" name="sCode" id="sCode" value="${sCode}" />
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
   <input type="hidden" name="curPage" value="${curPage}" />
</form>

    
<!-- ############################ 여기까지 내용 끝 ############################ -->
	<!-- *** 욱채수정Footer 시작 *** -->
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<!-- *** 욱채수정Footer 종료 *** -->
</body>
</html>