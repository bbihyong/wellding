<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en">

<head>
       <%@ include file="/WEB-INF/views/include/head.jsp" %>
       <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Bitter:ital@0;1&family=The+Nautigal&display=swap" rel="stylesheet">
<script>
function fn_view(rezNo)
{
   document.bbsForm.rezNo.value = rezNo;
   document.bbsForm.action = "/user/payCancelListView";
   document.bbsForm.submit();

}

function fn_view2(rezNo)
{
   document.bbsForm.rezNo.value = rezNo;
   document.bbsForm.action = "/user/payCancelListView2";
   document.bbsForm.submit();

}

$(document).ready(function(){
	$("#cou").on("click", function(){
	    var option="width = 1000, height = 500, top = 100, left = 200, location = no, menubar = no, scrollbars=no";
	    window.open("/board/Coupon", "PopUP", option);
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
						<h2 style="font-family: 'Bitter'; margin-top: 50px; padding-left: 10px;">결제내역</h2>
						<nav class="bcItem">
							<ol class="breadcrumb bc" >
								<li class="breadcrumb-item active" >
									<a href="/user/payList">결제내역</a>
								</li>
								<li class="breadcrumb-item" >
									<a style="font-size: large; font-weight: bold;">취소내역</a>
								</li>
								<li class="breadcrumb-item">
									<a href="javascript:void(0)" id="cou">쿠폰보유현황</a>
								</li>
								<li class="breadcrumb-item">
									<a href="/user/modify">회원정보수정</a>
								</li>
								<li class="breadcrumb-item">
									<a href="/user/userDrop">회원탈퇴</a>
								</li>
								
		                        <li style="position: absolute; right:50px;">
		                           <div>보유 포인트 : <span style="color:red;"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdUser.userPoint}" /></span> Point
		                           </div>
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
                        <c:choose>
                        <c:when test="${!empty list}">
                            <tr style="border-top: 3px solid #444; background: #efefef;">
                            	<th>상태</th>
                                <th>예약번호</th>
                                <th>예약날짜</th>
                                <th>가격</th>
                            </tr>

                           <c:forEach var="wdRez" items="${list}" varStatus="status">
                           
                            <tr style="width: 100%;">
                               <!-- 예약번호 -->
                                  <td>
                                  <div class="col-lg-12" style="text-align:center">
                                  	<c:if test="${wdRez.rezStatus eq 'C'}">
                                     <p class="rezview3" style="color:#ff4500;">취소요청중</p>
                                     </c:if>
                                  	<c:if test="${wdRez.rezStatus eq 'D'}">
                                     <p class="rezview3" style="color: #999;">취소완료</p>
                                     </c:if>
                                  </div>
                                  </td>
                                
                               <!-- 예약번호 -->
                                <td>
                                <div class="col-lg-12" style="text-align:center">
                                <c:if test="${wdRez.rezStatus eq 'C'}">
                                    <a href="javascript:void(0)" onclick="fn_view(${wdRez.rezNo})">
                                        <p class="rezview rezview2"><c:out value="${wdRez.rezNo}" /></p><p class="rezview3"></p>
                                    </a>
                                </c:if>
                                <c:if test="${wdRez.rezStatus eq 'D'}">
                                    <a href="javascript:void(0)" onclick="fn_view2(${wdRez.rezNo})">
                                        <p class="rezview rezview2"><c:out value="${wdRez.rezNo}" /></p><p class="rezview3"></p>
                                    </a>
                                </c:if>
                                </div>
                                </td>
                                <!-- 예약날짜 -->

                                  <td>
                                  <div class="col-lg-12" style="text-align:center">

                                    <p class="rezview rezview4" style="color:#555;">${wdRez.rezDate}</p>
                                  </div>
                                  </td>
                                  
                                  <!-- 금액 -->
                                <td>
                                <div class="col-lg-12" style="text-align:center; width: 100%;">
                                	<div style="width: 100%; float: left; text-align: center;">
	                                   	<p class="rezview"><fmt:formatNumber type="number" maxFractionDigits="3" value="${wdRez.rezFullPrice}" />원</p>
	                               	</div>
                                </div>  
                                </td> 
                              </tr>                         
                       	</c:forEach>
                       	</c:when>
                        <c:when test="${empty list}">
                        <tr>
                           <td colspan="3">
                             <div style="text-align: center;">
                             	<img src="../resources/images/icons/exclamation.png" style="width:100px; margin:30px;"/>
                       			<p style="padding-bottom:30px;">취소내역이 없습니다. </p>
                       		</div>
                           </td>
                        </tr>
                     	</c:when>                          
                     </c:choose>
                   	</table>
                   

               </div>
               
               <div class="col-lg-1"></div>
            
            </div>
         </div>         
      </div>

   		<form name="reviewForm" id="reviewForm">
         <input type="hidden" name="FormRezNo" id="FormRezNo" value="" />
        </form>
         <form name="bbsForm" id="bbsForm" method="post" action="/user/payListView">
            <input type="hidden" name="rezNo" value="" />
         </form>

   </div>

      <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  </body>

</html>