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
	<link rel="icon" type="image/png" href="../resources/images/icons/favicon.ico"/>
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
	
	$("#backBtn").on("click", function(){
		location.href = "/user/wishlist";
	});
	
	$("#dropBtn").on("click", function(){
		fn_loginCheck();		
	});
	
	$("#userPwd").on("keypress", function(e){
		
		if(e.which == 13)
		{	
			fn_loginCheck();
		}
	});
});

function fn_loginCheck()
{
	
	if($.trim($("#userPwd").val()).length <= 0)
	{
		//alert("비밀번호를 입력하세요.");
		Swal.fire({ 
			icon: 'warning',
			text: '비밀번호를 입력해주세요.'
		});
		
		$("#userPwd").focus();
		
	}
	
	$.ajax({
		type : "POST",
		url : "/user/userDropProc",
		data : {
			userPwd:$("#userPwd").val() 
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
					//alert("회원 탈퇴가 완료되었습니다.");
					//location.href = "/";
					Swal.fire({ 
						icon: 'success',
						text: '회원 탈퇴가 완료되었습니다.'
					}).then(function(){
						location.href = "/";
					});
				}
				else if(code == 404)
				{
					//alert("비밀번호를 입력하세요");
					//$("#userPwd").focus();
					Swal.fire({ 
						icon: 'warning',
						text: '비밀번호를 입력해주세요.'
					});
					
					$("#userPwd").focus();
				}
				else if(code == 400)
				{
					//alert("비밀번호가 일치하지 않습니다.");
					
					Swal.fire({ 
						icon: 'warning',
						text: '비밀번호가 일치하지 않습니다.'
					});
										
					$("#userPwd").focus();
				}
				else
				{
					//alert("오류가 발생하였습니다.");
					Swal.fire({ 
						icon: 'error',
						text: '오류가 발생하였습니다.'
					});
					$("#userPwd").focus();
				}	
					
			}
			else
			{
				//alert("오류가 발생하였습니다.");
				Swal.fire({ 
					icon: 'error',
					text: '오류가 발생하였습니다.'
				});
				$("#userId").focus();
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

	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<form class="login100-form validate-form" style="padding-top: 15px;">
					<span class="login100-form-title p-b-26">
						<h1 id="logo"><img src="../resources/images/theWellding.png" width="150" height="auto"/></h1>
						<h2 class="drop_title">회원탈퇴</h2>
					</span>				

						<h3 class="drop_content">회원탈퇴를 원하신다면<br/>비밀번호를 입력해주세요.</h3>

					<div class="wrap-input100 validate-input" data-validate="Enter password">
						<span class="btn-show-pass">
							<i class="zmdi zmdi-eye"></i>
						</span>
						<input class="input100" type="password" name="userPwd" id="userPwd" >
						<span class="focus-input100" data-placeholder="Password"></span>
					</div>

					<div class="container-login100-form-btn2">
						<div class="wrap-login100-form-btn2">
							<div class="login100-form-bgbtn2"></div>
							<button type="button" id="dropBtn" class="login100-form-btn2">
								탈퇴하기
							</button>
						</div>
						<div class="wrap-login100-form-btn2">
							<div class="login100-form-bgbtn2"></div>
							<button type="button" id="backBtn" class="login100-form-btn2">
								돌아가기
							</button>
						</div>
					</div>
					
				</form>
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