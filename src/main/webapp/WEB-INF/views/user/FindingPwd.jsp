<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<title>Login V2</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/vendor/loginvendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/vendor/loginvendor/bootstrap/css/bootstrap.min.css.map">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/fonts/loginfonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/fonts/loginfonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/vendor/loginvendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="../resources/vendor/loginvendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/vendor/loginvendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/vendor/loginvendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="../resources/vendor/loginvendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../resources/css/loginutil.css">
	<link rel="stylesheet" type="text/css" href="../resources/css/loginmain.css">
<!--===============================================================================================-->
	<script src="../resources/js/jquery-3.5.1.min.js"></script>
<!--===============================================================================================-->
	<script src="../resources/js/icia.common.js"></script>
<script>


	
$(function(){
	
	$("#userEmail").on("keypress", function(e){
		if(e.which == 13)
		{	
			fn_findCheck();
		}
		
	});
	
	$("#btn_cc").on("click", function(){

	    Swal.fire({ 
		icon: 'warning',
		text: '로그인 페이지로 돌아갑니다.'
	  }).then(function(){
		  location.href = "/board/login";
	  });
	});

  
});
	
function fn_findCheck()
{
		document.contact.receiveMail.value = $("#email").val();
		
		var emailtest = $("#email").val();
		var id = $("#id").val();
		var name = $("#name").val();

		
		if ($.trim(id).length == 0) {
			//alert('이메일을 입력해주세요');
			Swal.fire({ 
				icon: 'warning',
				text: '아이디를 입력하세요.'
			});
			$("#id").val("");
			$("#id").focus();
			return;
		}
		
		if ($.trim(name).length == 0) {
			//alert('이메일을 입력해주세요');
			Swal.fire({ 
				icon: 'warning',
				text: '이름을 입력하세요.'
			});
			$("#name").val("");
			$("#name").focus();
			return;
		}
		
		if ($.trim(emailtest).length == 0) {
			//alert('이메일을 입력해주세요');
			Swal.fire({ 
				icon: 'warning',
				text: '이메일을 입력하세요.'
			});
			$("#email").val("");
			$("#email").focus();
			return;
		}
		
		
		

		if (!fn_validateEmail(emailtest)) {
			//alert("이메일을 제대로 입력해주세요.");
			Swal.fire({ 
				icon: 'error',
				text: '이메일을 제대로 입력해주세요.'
			});
			$("#email").val("");
			$("#email").focus();
			return;
		}

		$("#Findbtn").prop("disabled", true);

			var form = $("#contact")[0];
			var formData = new FormData(form);

			$.ajax({
						type : "POST",
						url : "/board/tpwd.do",
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
								//alert("이욱채 짱짱귀요미");
								//alert("임시 비밀번호를 메일로 전송하였습니다");
								/*const Toast = Swal.mixin({
								    toast: true,
								    position: 'center-center',
								    showConfirmButton: false,
								    timer: 2000,
								    timerProgressBar: true,
								    didOpen: (toast) => {
								        toast.addEventListener('mouseenter', Swal.stopTimer)
								        toast.addEventListener('mouseleave', Swal.resumeTimer)
								    }

								});
								
								Toast.fire({
								    icon: 'success',
								    title: '이메일로  임시비밀번호를 전송하였습니다!'
								});*/
								Swal.fire({ 
									icon: 'success',
									title: '임시비밀번호 발송 완료!',
									text: '입력하신 이메일 주소로 임시 비밀번호를 발송했습니다. 로그인 후 마이페이지에서 비밀번호를 바꿔주세요!'
								}).then(function(){
									location.href="/board/login";
								});
							}
							else if(response.code == 400){
								Swal.fire({ 
									icon: 'error',
									title: '존재하지 않는 유저정보 입니다.'
								}).then(function(){
									return;
								});
							}
							else 
							{
								//alert("실패!");
								//alert("일치하는 정보가 없습니다");
								//alert("이메일 발송실패");
								//$("#btnEmailCheck").prop("disabled", false);
								/*Swal.fire({ 
									icon: 'error',
									text: '정보가 일치하지 않습니다!'
								}).then(function(){
									$("#Findbtn").prop("disabled", false);
								});*/

								Swal.fire({ 
									icon: 'error',
									title: '이메일 발송실패,,'
								}).then(function(){
									return;
								});
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
	}
function fn_validateEmail(value) {
	var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

	return regExp.test(value);
};
</script>
</head>
<body>

	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
					<span class="login100-form-title">
						<h1 id="logo"><img src="../resources/images/theWellding.png" width="150" height="auto" onclick="fn_index()" style="cursor: pointer;" /></h1>

					</span>
					<div>
							<ul>
                     		</ul>
                     	</div>
					<span class="login100-form-title">
						<!-- <i class="zmdi zmdi-font"></i> -->
						
						<div class="mTab eTab">	
								<ol id="gusdkqkqh">
									<h3>비밀번호 찾기</h3>
									<p class="id_list">아이디와 이름, 가입하신 이메일 주소를 입력해주세요.</p>	
								</ol>
						</div>
					</span>
					<div>
					<form id="contact" name="contact" method="post">
					
						<div class="wrap-input1002 validate-input" data-validate = "Valid email is: a@b.c">
							<input id="id" name="id" data-bind="id" type="text" class="input100" value="">
							<span class="focus-input100" data-placeholder="ID"></span>
						</div>
						
						<div class="wrap-input1002 validate-input" data-validate = "Valid email is: a@b.c">
							<input id="name" name="name" data-bind="name" type="text" class="input100" value="">
							<span class="focus-input100" data-placeholder="NAME"></span>
						</div>
						
						<div class="wrap-input1002 validate-input" data-validate = "Valid email is: a@b.c">
							<input id="email" name="email" data-bind="email" type="text"  class="input100" value="">
							<span class="focus-input100" data-placeholder="EMAIL"></span>							
						</div>	
										
							<input name="senderName" type="hidden" id="senderName" value="웰딩" />
							<input name="senderMail" type="hidden" id="senderMail" value="wellding@gmail.com" />
							<input type="hidden" name="receiveMail" id="receiveMail" value="" />
					</form>
					</div>
						
					
					<div class="container-login100-form-btn3">
						<div class="wrap-login100-form-btn2">
							<div class="login100-form-bgbtn2"></div>
							<button type="button" id="Findbtn" onclick="fn_findCheck()" class="login100-form-btn2" >
								찾기
							</button>
						</div>
						<div class="wrap-login100-form-btn2">
							<div class="login100-form-bgbtn2"></div>
							<button type="button" id="btn_cc" class="login100-form-btn2">
								돌아가기
							</button>
						</div>
						
						
					</div>
					
						<input type="button" onclick="plusNum()" value="d" style="width: 50px; height: 50px; background-color: white; color: white; cursor: default;"/>
			</div>
		</div>
	</div>

	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
	
<!--===============================================================================================-->
	<script src="../resources/vendor/loginvendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="../resources/vendor/loginvendor/bootstrap/js/popper.js"></script>
	<script src="../resources/vendor/loginvendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="../resources/vendor/loginvendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="../resources/vendor/loginvendor/daterangepicker/moment.min.js"></script>
	<script src="../resources/vendor/loginvendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="../resources/vendor/loginvendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="../resources/js/loginmain.js"></script>

</body>
</html>