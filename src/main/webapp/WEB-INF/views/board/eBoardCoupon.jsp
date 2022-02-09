<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap"
	rel="stylesheet">
<script>
$(document).ready(function() {
	$("#btnList").on("click", function() {
		document.eBoardForm.action = "/board/eBoard";
		document.eBoardForm.submit();
		});
});

function fn_coupon()
{
	$.ajax({
  	  type: "POST",
  	  url: "/board/eBoardCouponProc",
  	  data:{
  		
  	  },
  	  datatype: "JSON",
  	  beforeSend:function(xhr){
  		  xhr.setRequestHeader("AJAX", "true");
  		  },
  	  success:function(response)
  	  {
  		  if(response.code == 0)
  		  {
  			  //alert("쿠폰이 정상적으로 발급되었습니다.");
  			  //location.href = "/board/eBoard";
				Swal.fire({ 
					icon: 'success',
					text: '쿠폰이 정상적으로 발급되었습니다!'
				}).then(function(){
					//location.href = "/board/eBoard";
				       var option="width = 1000, height = 500, top = 100, left = 200, location = no, menubar = no, scrollbars=no";
				       window.open("/board/Coupon", "PopUP", option);
				});
  		  }
  		  else if(response.code == -1)
  		  {
  			  //alert("쿠폰 발급 중에 오류가 발생했습니다.");
				Swal.fire({ 
					icon: 'error',
					text: '쿠폰 발급 중에 오류가 발생했습니다.'
				}).then(function(){
					return;
				});
  		  }
  		  else if(response.code == 401)
  		  {
  			  //alert("이미 쿠폰을 발급받으셨습니다.");
  			  //location.href = "/";
				Swal.fire({ 
					icon: 'warning',
					text: '이미 쿠폰을 발급받으셨습니다.'
				}).then(function(){
				       var option="width = 1000, height = 500, top = 100, left = 200, location = no, menubar = no, scrollbars=no";
				       window.open("/board/Coupon", "PopUP", option);
				});
  		  }
  		  else if(response.code == 400)
  		  {
  			  //count가 0보다 작을 때
  			  //alert("사용자 정보가 없습니다. 로그인 되어있는지 확인해주세요.");
  			  //location.href ="/board/login";
				Swal.fire({ 
					icon: 'error',
					text: '사용자 정보가 없습니다. 로그인 되어있는지 확인해주세요.'
				}).then(function(){
					location.href ="/board/login";
				});
  		  }
  		  else
  		  {
  			  //alert("알 수 없는 접근 방식입니다.");
				Swal.fire({ 
					icon: 'error',
					text: '알 수 없는 접근 방식입니다.'
				}).then(function(){
					return;
				});
  		  }
  	  },
  	  complete:function(data)
  	  {
  		  icia.common.log(data);
  	  },
  	  error:function(xhr, status, error)
  	  {
  		  icia.common.error(error);
  	  }
    });	
}
</script>

</head>
<body>
	<jsp:include page="/WEB-INF/views/include/navigation.jsp">
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

	<h2 class="e_title">EVENT</h2>
	<p style="text-align: center; margin-bottom: 20px;">웰딩 이벤트를 확인해보세요!</p>
	<br />

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<table class="table">
					<thead>
						<tr class="dongdong2">
							<td style="width: 60%; padding-left: 25px; font-size: 18px; color: #222; font-weight: 600;">
								[★] 쿠폰 발급 이벤트
							</td>

							<td style="width: 40%; padding-right: 25px; color: #444; font-size: 16px;" class="text-right">2022.01.01</td>
						</tr>
						<tr style="height: 46px;">
							<td style="width: 60%; padding-left: 20px; font-size: 15px; color: #666;">
								<c:out value="admin" />
							</td>
							<td style="width: 40%; padding-right: 20px; font-size: 15px; color: #666;"
								class="text-right">
								<div>
									
								</div>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="2" style="width: 100%; border-bottom: 1px solid #555;">
								<div style="padding: 10px">
									<div class="e_imgbox" style="position:relative;">
										<img src="/resources/images/couponbg5.jpg" style="width: 1000px;">
										<div style="position:absolute; top: 41%; left: 25%; width: 50%;">
											<a a href="javascript:void(0);" style="cursor:default;"><img src="/resources/images/couponimg.png" style="cursor:default;"></a>
											<a a href="javascript:void(0);" onclick="fn_coupon();"><img src="/resources/images/download.png" style="margin-top: 10px;"></a>
										</div>
										<br/>
										웰딩에서 준비한 쿠폰이벤트! 웰딩 회원이라면 모두 발급 가능합니다 ^^
									</div>
								</div>
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2" style="padding: 20px 0 50px;">
							<button type="button" id="btnList"
									class="w-btn w-btn-green2" style="float: right">리스트</button></td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>

	<form name="eBoardForm" id="eBoardForm" method="post">
		<input type = "hidden" name = "cCode" value ="" />
	</form>

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>