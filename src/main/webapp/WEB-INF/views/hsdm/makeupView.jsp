<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>
$(document).ready(function(){
	//증감버튼
	var count = 0;
		
	if(count < 0)
	{
		$(".minus").prop("disabled", true);
	}
	else
	{
		$(".minus").prop("disabled", false);
		
		$(".minus").on("click", function(){
			count --;
			$("#quantity").val(count);
		});
		$(".plus").on("click", function(){
			count ++;
			$("#quantity").val(count);
		});
		$(".btnListt").on("click", function(){
			document.bbsForm.action = "/hsdm/makeUp";
			document.bbsForm.submit();
		});
	}
	
/*	
	//메이크업 담기 버튼 시작
	$("#chae").on("click",function(){
		if(confirm("해당 메이크업샵을 장바구니에 담으시겠습니까?"))
		{
			if($("#quantity").val() <0)
			{
				//alert("메이크업 추가 인원이 잘못되었습니다.");
				Swal.fire({ 
					icon: 'info',
					title: '메이크업 추가 인원이 잘못되었습니다.',
					text: '메이크업 추가인원은 0명 이상으로 선택해주세요.'
				});
				return;
			}
			
			//ajax통신 시작
			$.ajax({
			type:"POST",
			url:"/hsdm/makeUpRezProc",
			data:
			{
				mCode: $("#mCode").val(),
				mPlusNum: $("#quantity").val(),
				wDate: $("#wDate").val()
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
					alert("장바구니에 이미 다른 메이크업샵이 담겨 있습니다.");
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
		
	});
*/
	$("#chae").on("click",function(){
		
		if($("#quantity").val() <0)
		{
			//alert("메이크업 추가 인원이 잘못되었습니다.");
			Swal.fire({ 
				icon: 'info',
				title: '메이크업 추가 인원이 잘못되었습니다.',
				text: '메이크업 추가인원은 0명 이상으로 선택해주세요.'
			});
			return;
		}
		
		Swal.fire({
			   title: '메이크업 선택 완료!',
			   text: '해당 메이크업샵을 장바구니에 담으시겠습니까?',
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
						url:"/hsdm/makeUpRezProc",
						data:
						{
							mCode: $("#mCode").val(),
							mPlusNum: $("#quantity").val(),
							wDate: $("#wDate").val()
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
									text: '장바구니에 이미 다른 메이크업샵이 담겨 있습니다.'
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
	//메이크업 담기 버튼 종료
	
	$(".banner3").on("click", function(){
		location.href = "/board/specialist";
	});
	
});
function fn_view_st(sCode)
{
	document.bbsForm_studio.sCode.value = sCode;
	document.bbsForm_studio.action = "/hsdm/studioView";
	document.bbsForm_studio.submit();
} 

function fn_view(dNo)
{
	document.bbsForm_dress.dNo.value = dNo;
	document.bbsForm_dress.searchType.value = $("#_searchType").val();
	document.bbsForm_dress.searchValue.value = $("#_searchValue").val();
	document.bbsForm_dress.action = "/hsdm/dressView";
	document.bbsForm_dress.submit();
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
<c:if test="${!empty wdMakeup}">
<div class="big_title">
</div>

    <div class="ticket-details-page">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="left-image">
                        <img src="../resources/images/makeup/${wdMakeup.mImgName}" alt="">
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="com_detail9">
                        <div class="right-content2">
                            <h4>
                            	<c:out value="${wdMakeup.mName}" />
				             	<button type="button" id="btnList" class="btnListt listButton3">
				        			<img src="../resources/images/icons/leftButton.png" class="listIcon" alt="리스트" width="32" height="32">
				        		</button>
                            </h4>
                            <span><c:out value="${wdMakeup.mContent}" /></span>
                            <ul  class="loc_li">
			                    <li><i class="fa fa-map-marker"></i> <c:out value="${wdMakeup.mLocation}" /></li>
			                    <li><p style="margin-right:7px">Tel.</p><p style="font-weight:700"><c:out value="${wdMakeup.mNumber}" /></p></li>
			                </ul>
                            <div class="det_price9">
	                            <ul>
	                                <li class="dis_price">
	                            		<div class="discount"><c:out value="${wdMakeup.mDiscount}" />%</div>
		                                <div class="price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${wdMakeup.mPrice}" /></div>
	                                </li>
	                            </ul>
	                            <div class="dis-price"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdMakeup.mPrice * (1-wdMakeup.mDiscount*0.01)}" />원</div>
                            </div>
                            <div class="banner3">
                            	<a href="/board/specialist">
                                	<img src="../resources/images/vip.png" width="100%">
                            	</a>
                            </div>
                           <!---- 추가인원계산할때 쓸거-->
                            <div class="quantity-content">
                                <div class="left-content">
                                    <h6>메이크업 추가인원 (1인당)</h6>
                                    <p><fmt:formatNumber type="number" maxFractionDigits="3" value="${wdMakeup.mPlus}" />원</p>
                                </div>
                                <div class="right-content">
                                    <div class="quantity buttons_added">
                                        <div class="quantity buttons_added">
		                                    <input type="button" value="-" class="minus"><input type="number" step="1" min="0" max="" name="quantity" id="quantity" value="0" title="Qty" class="input-text qty text" size="4" pattern="" inputmode=""><input type="button" value="+" class="plus">
		                                </div>
                                    </div>
                                </div>
                            </div>
                            <!-- 추가인원 ---->
                            <div class="main-dark-button2" id="chae"><a href="#">이 메이크업샵 담기</a></div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-12">
                	<div class="det_navi3">
                		<ul>
                			<li><a href="javascript:void(0)">스튜디오 추천받기</a></li>
                		</ul>
                	</div>
                </div>
                
                <!-- 랜덤 스튜디오 추가 -->
<c:if test="${!empty studioRandom}">        
	<c:forEach var="wdStudio" items="${studioRandom}" varStatus="status">
               	<div class="col-lg-4">
                    <div class="ticket-item2">
                        <div class="thumb_ss" onclick="fn_view_st('${wdStudio.sCode}')" style="cursor:pointer">
                            <img src="../resources/images/studio/${wdStudio.sImgname}" alt="">
                        </div>
                        <div class="down-content dtbox">
                        	<div class="sd_title_ss"><c:out value="${wdStudio.sName}" /></div>
                            <ul>
                                <li class="dis_price2"><span class="discount2"><c:out value="${wdStudio.sDiscount}" />%</span> <span class="dis-price"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdStudio.sPrice * (1-wdStudio.sDiscount*0.01)}" />원</span></li>
                            </ul>
                        </div>
                    </div>
               	</div>    
     </c:forEach>
</c:if>
                <!-- 랜덤스튜디오 추가 끝 -->
				<div class="col-lg-12">
                	<div class="det_navi3">
                		<ul>
                			<li><a href="javascript:void(0)">드레스 추천받기</a></li>
                		</ul>
                	</div>
                </div>
                <!-- 랜덤 드레스 추가 -->
<c:if test="${!empty dressRandom}">        
	<c:forEach var="wdDress" items="${dressRandom}" varStatus="status">
               	<div class="col-lg-3">
                    <div class="ticket-item2">
                        <div class="thumb1" onclick="fn_view('${wdDress.dNo}')" style="cursor:pointer">
                            <img src="../resources/images/dress/${wdDress.dImgname}" alt="">
                        </div>
                        <div class="down-content dtbox">
                        	<div class="sd_title3">[<c:out value="${wdDress.dcName}" />] <c:out value="${wdDress.dName}" /></div>
                            <ul>
                                <li class="dis_price2"><span class="discount2"><c:out value="${wdDress.dDiscount}" />%</span> <span class="dis-price"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdDress.dPrice * (1-wdDress.dDiscount*0.01)}" />원</span></li>
                            </ul>
                        </div>
                    </div>
               	</div>    
     </c:forEach>
</c:if>
                <!-- 랜덤드레스 추가 끝 -->    
                <!-- 아래쪽 뒤로가기버튼 시작 -->
                <div class="col-lg-12" style="width: 100%; height: 1px; background:#eee; margin-top:50px;"></div>
            	<div class="alignleft2">
	             	<button type="button" id="btnList" class="btnListt listButton">
	        			<img src="../resources/images/icons/leftButton.png" class="listIcon" alt="리스트" width="32" height="32">
	        		</button>
            	</div>  
            	<!-- 아래쪽 뒤로가기버튼 끝 -->      

            </div>
        </div>
        
    </div>
</c:if>

<form name="bbsForm" id="bbsForm" method="post">
   <input type="hidden" name="mCode" id="mCode" value="${wdMakeup.mCode}" />
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
   <input type="hidden" name="curPage" value="${curPage}" />
</form>

<form name="bbsForm_studio" id="bbsForm_studio" method="post">
   <input type="hidden" name="sCode" value="${sCode}" />
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
   <input type="hidden" name="curPage" value="${curPage}" />
</form>

<form name="bbsForm_dress" id="bbsForm_dress" method="post">
   <input type="hidden" name="dNo" value="${dNo}" />
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
   <input type="hidden" name="curPage" value="${curPage}" />
   <input type="hidden" name="wDate" value="${wDate}" />
</form>

    
<!-- ############################ 여기까지 내용 끝 ############################ -->
	<!-- *** 욱채수정Footer 시작 *** -->
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<!-- *** 욱채수정Footer 종료 *** -->
</body>
</html>