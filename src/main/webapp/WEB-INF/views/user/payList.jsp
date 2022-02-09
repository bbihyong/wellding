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
function fn_view(rezNo)
{
   document.bbsForm.rezNo.value = rezNo;
   document.bbsForm.action = "/user/payListView";
   document.bbsForm.submit();

}

$(document).ready(function(){
   $("#cou").on("click",function(){
       var option="width = 1000, height = 500, top = 100, left = 200, location = no, menubar = no, scrollbars=no";
       window.open("/board/Coupon", "PopUP", option); 
   });
   
	$("#qrTest").on("click",function(){
        var option="width = 540, height = 590, top = 140, left = 520, location = no, menubar = no, scrollbars=no";
        window.open("/board/qrTest", "PopUP", option); 
	}); 
	
	/*$("#qrTest1").on("click",function(){
        var option="width = 340, height = 590, top = 140, left = 520, location = no, menubar = no, scrollbars=no";
        window.open("/board/foodCpnM", "PopUP", option); 
	}); 
	
	$("#qrTest2").on("click",function(){
        var option="width = 340, height = 590, top = 140, left = 520, location = no, menubar = no, scrollbars=no";
        window.open("/board/foodCpnF", "PopUP", option); 
	}); */
});

function foodCpnM(rezNo){
    var option="width = 340, height = 590, top = 140, left = 520, location = no, menubar = no, scrollbars=no";
    window.open("/board/foodCpnM?rezNo="+rezNo, "PopUP", option); 
}

function foodCpnF(rezNo){
    var option="width = 340, height = 590, top = 140, left = 520, location = no, menubar = no, scrollbars=no";
    window.open("/board/foodCpnF?rezNo="+rezNo, "PopUP", option); 
}

function reviewWrite(rezNo){
	   document.reviewForm.FormRezNo.value = rezNo;
	   
		$.ajax({
			type : "POST",
			url : "/board/reviewWrite",
			data : {
				rezNo:$("#FormRezNo").val()
			},
			datatype : "JSON",																																																					
			beforeSend : function(xhr){
	            xhr.setRequestHeader("AJAX", "true");
	        },
			success : function(response) {
				
				if(!icia.common.isEmpty(response))
				{
					icia.common.log(response);
					
					// var data = JSON.parse(obj);
					var code = icia.common.objectValue(response, "code", -500);
					
					if(code == 0)
					{
	                     document.reviewForm.action = "/board/reviewWriteGo";
	                     document.reviewForm.submit();
					}
					else if(code == 400)
                    {
                       //alert("예약내역이 없거나 결제가 완료되지 않아 리뷰 작성이 불가능합니다.");
							Swal.fire({ 
								icon: 'error',
								text: '예약내역이 없거나 결제가 완료되지 않아 리뷰 작성이 불가능합니다.'
							}).then(function(){
								return;
							});
                    }
                    else if(code == 401)
                    {
                       //alert("아직 결혼식이 진행되지 않아 리뷰 작성이 불가능 합니다.");
						Swal.fire({ 
							icon: 'warning',
							text: '아직 결혼식이 진행되지 않아 리뷰 작성이 불가능 합니다.'
						}).then(function(){
							return;
						});
                    }
                    else if(code == 501)
                    {
                    	//alert("이미 리뷰를 작성하였습니다.");
						Swal.fire({ 
							icon: 'warning',
							text: '이미 리뷰를 작성하였습니다.'
						}).then(function(){
							return;
						});
                    }
                    else
                    {
				  		//alert("오류가 발생하였습니다.");
						//$("#userId").focus();
						Swal.fire({ 
							icon: 'error',
							text: '오류가 발생하였습니다.'
						}).then(function(){
							$("#userId").focus();
						});
                    }

				}
			},
			complete : function(data) 
			{ 
				// 응답이 종료되면 실행, 잘 사용하지않는다
				icia.common.log(data);
			},
			error : function(xhr, status, error) 
			{
				icia.common.error(error);
			}
		});
}
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
									<a style="font-size: large; font-weight: bold;">결제내역</a>
								</li>
								<li class="breadcrumb-item" >
									<a a href="/user/payCancelList">취소내역</a>
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
                                <th>예약번호</th>
                                <th>예약날짜</th>
                                <th>가격</th>
                                <th>식권</th>
                            </tr>

                           <c:forEach var="wdRez" items="${list}" varStatus="status">
                            <tr style="width: 100%;">
                               <!-- 예약번호 -->
                                <td>
                                <div class="col-lg-12" style="text-align:center">
                                    <a href="javascript:void(0)" onclick="fn_view(${wdRez.rezNo})">
                                        <p class="rezview rezview2"><c:out value="${wdRez.rezNo}" /></p>
                                    </a>
                                </div>
                                </td>
                                <!-- 예약날짜 -->

                                  <td>
                                  <div class="col-lg-12" style="text-align:center">
                                     <a href="javascript:void(0)" onclick="fn_view(${wdRez.rezNo})"><p class="rezview rezview2" style="color:#555;">${wdRez.rezDate}</p></a>
                                  </div>
                                  </td>
                                  
                                  <!-- 금액 -->
                                <td>
                                <div class="col-lg-12" style="text-align:center; width: 100%;">
                                	<div style="width: 55%; float: left; text-align: right;">
	                                   	<p class="rezview"><fmt:formatNumber type="number" maxFractionDigits="3" value="${wdRez.rezFullPrice}" />원</p>
	                               	</div>
	                               	<div style="width: 45%; float: left; text-align: left; padding-left: 3px; margin-top: 3px;">
	                                   	<button class="rez_btn" onclick="reviewWrite('${wdRez.rezNo}')" >리뷰쓰기</button>
	                                   	<!-- a href="javascript:void(0)" class="rez_btn2" id="qrTest">청첩장 QR</a-->
	                                </div> 
                                </div>  
                                </td> 
                                <td>
	                               	<div style="width: 100%; float: left; text-align: center; padding-left: 5px;">
	                                   	<a href="javascript:void(0)" class="rez_btn3" id="qrTest1" onclick="foodCpnM('${wdRez.rezNo}')">신랑측</a>
	                                   	<a href="javascript:void(0)" class="rez_btn4" id="qrTest2" onclick="foodCpnF('${wdRez.rezNo}')">신부측</a>
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
                       			<p style="padding-bottom:30px;">결제내역이 없습니다. </p>
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