<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Bitter:ital@0;1&family=The+Nautigal&display=swap" rel="stylesheet">


<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="../resources/css/modify.css">
<!--===============================================================================================-->
<script type="text/javascript">
	$(document).ready(function() {

		$("#pwd1").focus();

		// 모든 공백 체크 정규식
		var emptCheck = /\s/g;
		// 영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
		var idPwCheck = /^[a-zA-Z0-9]{3,12}$/;

		$("#pwd1").keyup(function(e) {

			if ($("#pwd1").val().length <= 0) {
				$('p').eq(0).text("비밀번호를 입력해주세요");
				$('p').eq(0).css('color', 'red');
				$("#pwd1").focus();
				return;
			} else if (emptCheck.test($("#pwd1").val())) {
				$('p').eq(0).text("비밀번호는 공백을 포함할 수 없습니다");
				$('p').eq(0).css('color', 'red');
				$("#pwd1").focus();
				return;
			} else if (!idPwCheck.test($("#pwd1").val())) {
				$('p').eq(0).text("비밀번호는 영문 대소문자와 숫자로 4~12자리 입니다.");
				$('p').eq(0).css('color', 'red');
				$("#pwd1").focus();
				return;
			}

			else {
				$('p').eq(0).text("좋은 비밀번호 입니다");
				$('p').eq(0).css("color", "green");
				$('p').eq(0).css("font-weight", "700");

				return;
			}

		});

		$("#pwd2").keyup(function() {
			var pwd1 = $("#pwd1").val();
			var pwd2 = $("#pwd2").val();

			if ($("#pwd2").val().length <= 0) {
				$('p').eq(1).text("비밀번호를 다시 입력해주세요");
				$('p').eq(1).css("color", "red");
				$("#pwd2").focus();
				return;
			} else if (emptCheck.test($("#pwd2").val())) {
				$('p').eq(1).text("비밀번호는 공백을 포함할 수 없습니다.");
				$('p').eq(1).css("color", "red");
				$("#pwd2").focus();
				return;
			} else if (pwd1 != pwd2) {
				$('p').eq(1).text("비밀번호가 일치하지않습니다");
				$('p').eq(1).css('color', 'red');
				$("#pwd2").focus();
				return;
			}

			else {
				$('p').eq(1).text("비밀번호가 일치합니다.");
				$('p').eq(1).css("color", "green");
				$('p').eq(1).css("font-weight", "700");

				return;
			}
		});

		$("#btn").on("click", function() {

			$.ajax({
				type : "POST",
				url : "/user/update",
				data : {
					pwd1 : $("#pwd1").val(),
					name : $("#name").val(),
					number : $("#number").val(),
					year : $("#year").val(),
					month : $("#month").val(),
					day : $("#day").val(),
					nickname : $("#nickname").val(),
					email : $("#email").val()
				},
				datatype : "JSON",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("AJAX", "true");
				},
				success : function(response) {
					if(response.code == 0)
		               {
		                  //alert("회원수정이 완료되었습니다.");
		                  //location.href = "/board/login";
							Swal.fire({ 
								icon: 'success',
								text: '회원수정이 완료되었습니다.'
							}).then(function(){
								location.href = "/user/modify";
							});
		               } 
		               else if(response.code == 400)
		               {
		                  //alert("회원수정 중 오류가 발생했습니다..");
		                  //$("#pwd1").focus();
							Swal.fire({ 
								icon: 'error',
								text: '회원수정 중 오류가 발생했습니다..'
							}).then(function(){
								$("#pwd1").focus();
								return;
							});
		               }
		               else if(response.code == 500)
		               {
		                  //alert("회원수정 중 오류가 발생했습니다.");
		                 // $("#pwd1").focus();
							Swal.fire({ 
								icon: 'error',
								text: '회원수정 중 오류가 발생했습니다..'
							}).then(function(){
								$("#pwd1").focus();
								return;
							});
		               }
		               else
		               {
		                  //alert("오류가 발생했습니다.");
		                  ///$("#pwd1").focus();
							Swal.fire({ 
								icon: 'error',
								text: '회원수정 중 오류가 발생했습니다..'
							}).then(function(){
								$("#pwd1").focus();
								return;
							});

					}
				},
				complete : function(data) {
					icia.common.log(data);
				},
				error : function(xhr, status, error) {
					icia.common.error(error);
				}
			});
		
		      
		});
		
	   $("#btn_cc").on("click", function(){
			 //alert("회원정보수정이 취소되었습니다.");
			  Swal.fire({ 
				  icon: 'warning',
				  text: '회원정보 수정이 취소되었습니다.'
			  });
			 location.href = "/user/wishlist";
	   });
	   
	   $("#cou").on("click",function(){
		    var option="width = 1000, height = 500, top = 100, left = 200, location = no, menubar = no, scrollbars=no";
		    window.open("/board/Coupon", "PopUP", option); 
		});  
	   
	});
	   
	   
function fn_validateEmail(value)
{
  var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
  
  return emailReg.test(value);
}
	
</script>

</head>
<body>
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
		<div class="row" style="background:#feede8;">
			<div class="col-lg-12">
				
				<div class="row">
					<div class="col-lg-1"></div>
					
					<div class="col-lg-10">
						<h2 style="font-family: 'Bitter', serif; margin-top: 50px; padding-left: 10px;">My Page</h2>
						<nav class="bcItem">
							<ol class="breadcrumb bc" style="background: #feede8;">
								<li class="breadcrumb-item" >
									<a href="/user/payList">결제내역</a>
								</li>
								<li class="breadcrumb-item" >
									<a href="/user/payCancelList">취소내역</a>
								</li>
								<li class="breadcrumb-item">
									<a href="javascript:void(0)" id="cou">쿠폰보유현황</a>
								</li>
								<li class="breadcrumb-item active" style="position: relative; top: -2px; margin-left:4px;">
									<a href="javascript:void(0)" id="modify" style="font-size: large; font-weight: bold; color: #000;">회원정보수정</a>
								</li>
								<li class="breadcrumb-item">
									<a href="/user/userDrop">회원탈퇴</a>
								</li>
							</ol>
						</nav>
					
					</div>
					<div class="col-lg-1">
					</div>
				</div>
			</div>
		</div>
	</div>
					
					

	<div class="join_form">
		<dl class="join_write">
			<div class="join_header">
				<h1 class="logo">
					<img src="../resources/images/theWellding.png" width="120px" height="auto"/>
				</h1>
				<h1>회원정보수정</h1>
			</div>
			<dt>비밀번호</dt>
			<dd>
				<div class="input">
					<input type="password" id="pwd1" name="pwd1"
						value="${wdUser.userPwd}" maxlength="20">
				</div>
				<p class="msg">비밀번호를 입력해 주세요.</p>

			</dd>
			<dt>비밀번호 확인</dt>
			<dd>
				<div class="input">
					<input type="password" id="pwd2" name="pwd2"
						value="${wdUser.userPwd}" maxlength="20">
				</div>
				<p class="msg">비밀번호를 다시 입력해 주세요</p>
			</dd>
			
			<dt>이름</dt>
			<dd>
				<div class="input">
					<input type="text" id="name" name="name" value="${wdUser.userName}">
				</div>
			</dd>
			
			<dt>전화번호</dt>
			<dd>
				<div class="input">
					<input type="text" id="number" value="${wdUser.userNumber}">
				</div>
				<p class="msg"></p>
			</dd>

			<dt>닉네임</dt>
			<dd>
				<div class="input">
					<input type="text" id="nickname" value="${wdUser.userNickname}">
				</div>
				<p class="msg">
				<p class="msg"></p>
				</dd>
				<!--이메일 주석-->
			<dt>이메일</dt>
			<dd>
				<div class="input">
					<input id="email" data-bind="email" type="text"

						value="${wdUser.userEmail}" value="">
				</div>
				<p class="msg"></p>
				
			<dt>결혼예정일</dt>
			<dd class="date">
				<select id="year" class="year" >
					<option value="">년도</option>
                    <option value="2022" <c:if test="${year eq '2022'}">selected</c:if>>2022</option>
                    <option value="2023" <c:if test="${year eq '2023'}">selected</c:if>>2023</option>
				</select> 
				<select id="month" class="month">
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
			   <select id="day" class="day">
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
		

			<div class="button_area">
				<button class="btn_type" id="btn">수정</button>
				<button class="btn_type" id="btn_cc">돌아가기</button>
			</div>

			<div class="footer">
				<div class="copyright">COPYRIGHT. WELLDING INC. ALL RIGHTS RESERVED</div>
			</div>
		</dl>
	</div>
	
		<%@ include file="/WEB-INF/views/include/footer.jsp" %>



</body>
</html>