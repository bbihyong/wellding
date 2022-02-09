<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="../resources/css/regform.css">
<!--===============================================================================================-->
<script>

$(document).ready(function(){

	//$("#btnReg").prop("disabled", true);

	$("#btnEmailCheck").on("click",function(){
			var emailtest = $("#email").val();

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

			$("#btnEmailCheck").prop("disabled", true);

			if (!$("#checkinput").length > 0) 
			{
				$("#dd").append("<div class='input2' style='margin-bottom: 35px; margin-top: 5px;'><input type='text' id='checkinput' name='checkinput' placeholder='인증번호를 입력해주세요'><button onclick='imnotok()' class='btn_check2'>인증확인</button><br><p class='msg2'></p></div>");
				document.contact.receiveMail.value = $("#email").val();
				//document.contact.action = "/board/check.do";
				//document.contact.submit();
				var form = $("#contact")[0];
				var formData = new FormData(form);

				$.ajax({
							type : "POST",
							url : "/board/check.do",
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
									//alert("이메일이 전송 되었습니다.");
									const Toast = Swal.mixin({
									    toast: true,
									    position: 'center-center',
									    showConfirmButton: false,
									    timer: 2000,
									    timerProgressBar: true,
									    didOpen: (toast) => {
									        toast.addEventListener('mouseenter', Swal.stopTimer);
									        toast.addEventListener('mouseleave', Swal.resumeTimer);
									    }
									});
									
									Toast.fire({
									    icon: 'success',
									    title: '이메일이 전송되었습니다!'
									});
								} 
								else 
								{
									//alert("이메일 발송실패");
									//$("#btnEmailCheck").prop("disabled", false);
									Swal.fire({ 
										icon: 'error',
										text: '이메일 발송 실패!'
									}).then(function(){
										$("#btnEmailCheck").prop("disabled", false);
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
		});
	
	$("#id").focus();
	
	// 모든 공백 체크 정규식
	var emptCheck = /\s/g;
	// 영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
	var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
	var pwCheck = /^[a-zA-Z0-9]{4,12}$/;

	$("#id").keyup(function(e) {

		if ($("#id").val().length <= 0) 
		{	
			$('p').eq(0).text("아이디를 입력해 주세요");
			$('p').eq(0).css('color', 'red');
			$("#id").focus();
			return;
		} 
		else if (emptCheck.test($("#id").val())) 
		{
			$('p').eq(0).text("아이디는 공백을 포함할 수 없습니다");
			$('p').eq(0).css('color', 'red');
			$("#id").focus();
			return;
		}
		else if (!idPwCheck.test($("#id").val())) 
		{
			$('p').eq(0).text("영문/숫자 4자 이상을 입력해 주세요.");
			$('p').eq(0).css('color', 'red');
			$("#id").focus();
			return;
		} 
		else 
		{
			$('p').eq(0).text("좋은 아이디 입니다");
			$('p').eq(0).css("color", "green");
			$('p').eq(0).css("font-weight", "700");

			return;
		}

	});

	//$("#pwd1").keydown(function(e) 
	$("#pwd1").keyup(function(e) 
	{

		if ($("#pwd1").val().length <= 0) 
		{
			$('p').eq(1).text("비밀번호를 입력해 주세요");
			$('p').eq(1).css('color', 'red');
			$("#pwd1").focus();
			return;

		}

		else if (emptCheck.test($("#pwd1").val())) 
		{
			$('p').eq(1).text("비밀번호는 공백을 포함할 수 없습니다");
			$('p').eq(1).css('color', 'red');
			$("#pwd1").focus();
			return;
		}

		else if (!pwCheck.test($("#pwd1").val())) 
		{
			$('p').eq(1).text("비밀번호는 영문 대소문자와 숫자로 4~12자리 입니다.");
			$('p').eq(1).css('color', 'red');
			$("#pwd1").focus();
			return;
		}

		else {
			$('p').eq(1).text("좋은 비밀번호 입니다");
			$('p').eq(1).css("color", "green");
			$('p').eq(1).css("font-weight","700");

			return;
		}
	});

	$("#pwd2").keyup(function() {

		var pwd1 = $("#pwd1").val();
		var pwd2 = $("#pwd2").val();

		if (pwd1 != pwd2) {
			$('p').eq(2).text("비밀번호가 일치하지않습니다");
			$('p').eq(2).css('color', 'red');
			$("#pwd2").focus();
			return;

		} else {
			$('p').eq(2).text("비밀번호가 일치합니다");
			$('p').eq(2).css("color", "green");
			$('p').eq(2).css("font-weight", "700");

			return;
		}

	});

	$("#name").keyup(function() {

		if ($.trim($("#name").val()).length <= 2) {
			$('p').eq(3).text("이름을 입력해주세요.");
			$('p').eq(3).css('color', 'red');
			$("#name").focus();
			return;
		} else {
			$('p').eq(3).hide();
			return;
		}

	});

	$("#id").keyup(function() {

		$("#pwd1").val($("#pwd2").val());

		$.ajax({

			type : "POST",
			url : "/user/idCheck",
			data : {
				userId : $("#id").val()
			},
			datatype : "JSON",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("AJAX", "true");
			},

			success : function(response) {
				if (response.code == 0) {
				} else if (response.code == 100) {
					$('p').eq(0).text("중복된 아이디입니다.");
					$('p').eq(0).css('color', 'red');
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
	
	
	$("#btnReg").on("click", function(){
		
	      if($.trim($("#id").val()).length <= 0 )
	      {
	         //값이 없음
	        // alert("제목을 입력하세요.");
				Swal.fire({ 
					icon: 'warning',
					title: '정보가 입력되지 않았습니다!',
					text: '모든 정보를 입력해야 회원가입이 완료됩니다.'
				});
	         $("#id").val("");
	         $("#id").focus();
	         
	         $("#btnReg").prop("disabled", true);
	         return;
	      }
	    var inputValue = $("input[name='gender']:checked").val();
	      
	      
		$.ajax({
			type : "POST",
			url : "/user/regProc",
			data : {
				id : $("#id").val(),
				pwd1 : $("#pwd1").val(),
				name : $("#name").val(),
				number : $("#number").val(),
				year : $("#year").val(),
				month : $("#month").val(),
				day : $("#day").val(),
				gender : inputValue,
				nickname : $("#nickname").val(),
				email : $("#email").val(),
				uCheck : $("#checkinput").val(),
				
			},
			datatype : "JSON",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("AJAX", "true");
			},
			success : function(response) 
			{
				if (response.code == 0) 
				{
					//alert("회원가입이 완료되었습니다.");
					//location.href = "/board/login";
					Swal.fire({ 
						icon: 'success',
						text: '회원가입이 완료되었습니다.'
					}).then(function(){
						location.href = "/board/login";
					});
				} 
				else if (response.code == 400) 
				{
					//alert("회원가입 중 오류가 발생했습니다..");
					//location.href = "/board/regform";
					Swal.fire({ 
						icon: 'error',
						text: '회원가입 중 오류가 발생했습니다..'
					}).then(function(){
						location.href = "/board/regform";
					});
				} 
				else if (response.code == 500) 
				{
					//alert("회원가입 중 오류가 발생했습니다.");
					//location.href = "/board/regform";
					Swal.fire({ 
						icon: 'error',
						text: '회원가입 중 오류가 발생했습니다.'
					}).then(function(){
						location.href = "/board/regform";
					});
				} 
				else {
					//alert("오류가 발생했습니다.");
					//$("#id").focus();
					Swal.fire({ 
						icon: 'error',
						text: '오류가 발생했습니다.'
					}).then(function(){
						$("#id").focus();
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

	});

	$("#btnCC").on("click", function() 
	{
		//alert("회원가입이 취소되었습니다.");
		Swal.fire({ 
			icon: 'error',
			text: '회원가입이 취소되었습니다.'
		}).then(function(){
			location.href = "/";
		});
		
	});
	
});

function imnotok() {

	$.ajax({

		type : "POST",
		url : "/user/emailCheck",
		data : {
			uCheck : $("#checkinput").val()
		},
		datatype : "JSON",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("AJAX", "true");
		},

		success : function(response) {
			if (response.code == 0) {
				$('p').eq(7).text("인증이 완료되었습니다.");
				$('p').eq(7).css('color', 'green');
				$("#btnReg").prop("disabled", false);
			} else if (response.code == 100) {
				$('p').eq(7).text("인증번호가 일치하지 않습니다..");
				$('p').eq(7).css('color', 'red');
			}

		},
		complete : function(data) {
			icia.common.log(data);
		},
		error : function(xhr, status, error) {
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

	<section class="join_section">
		<div class="join_header">
			<h1 class="logo">
				<img src="../resources/images/theWellding.png" width="120px" height="auto" />
			</h1>

		</div>
		<div class="join_form">

			<dl class="join_write">

				<dt>아이디</dt>
				<dd>
					<div class="input">
						<input type="text" id="id" name="id" placeholder="아이디를 입력해 주세요" value="">
					</div>
					<p class="msg">영문/숫자 4자 이상을 입력해 주세요.</p>
				</dd>

				<dt>비밀번호</dt>
				<dd>
					<div class="input">
						<input type="password" id="pwd1" name="pwd1" placeholder="비밀번호를 입력해 주세요" maxlength="20">

					</div>
					<p class="msg">4~16자의 영문 대/소문자, 숫자를 사용하세요.</p>

				</dd>
				<dt>비밀번호 확인</dt>
				<dd>
					<div class="input">
						<input type="password" id="pwd2" name="pwd2" placeholder="비밀번호를 다시 한번 입력해 주세요" maxlength="20">
					</div>
					<p class="msg">비밀번호를 다시 입력해주세요</p>
				</dd>
				<dt>이름</dt>
				<dd>
					<div class="input">
						<input type="text" id="name" name="name" placeholder="이름을 입력해주세요">
						<p class="msg"></p>

					</div>

				</dd>
				<dt>전화번호</dt>
				<dd>
					<div class="input">
						<input type="text" id="number" name="number" placeholder="전화번호를 입력해주세요">
					</div>
					<p class="msg"></p>
				</dd>

				<dt>결혼예정일</dt>
				<dd class="date">
					<select id="year" class="year">
						<option>년도</option>
						<option value="2022">2022</option>
						<option value="2023">2023</option>


					</select> <select id="month" class="month">
						<option>월</option>
						<option value="01">1</option>
						<option value="02">2</option>
						<option value="03">3</option>
						<option value="04">4</option>
						<option value="05">5</option>
						<option value="06">6</option>
						<option value="07">7</option>
						<option value="08">8</option>
						<option value="09">9</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
					</select> <select id="day" class="day">
						<option>일</option>
						<option value="01">1</option>
						<option value="02">2</option>
						<option value="03">3</option>
						<option value="04">4</option>
						<option value="05">5</option>
						<option value="06">6</option>
						<option value="07">7</option>
						<option value="08">8</option>
						<option value="09">9</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
						<option value="13">13</option>
						<option value="14">14</option>
						<option value="15">15</option>
						<option value="16">16</option>
						<option value="17">17</option>
						<option value="18">18</option>
						<option value="19">19</option>
						<option value="20">20</option>
						<option value="21">21</option>
						<option value="22">22</option>
						<option value="23">23</option>
						<option value="24">24</option>
						<option value="25">25</option>
						<option value="26">26</option>
						<option value="27">27</option>
						<option value="28">28</option>
						<option value="29">29</option>
						<option value="30">30</option>
						<option value="31">31</option>
					</select>
				</dd>

				<dt>성별</dt>
				<dd class="two_selector">
					<label class="selector"><input type="radio" name="gender" value="M">
						<span>남자</span>
					</label> 
					<label class="selector">
						<input type="radio" name="gender" value="F">
						<span>여자</span>
					</label>
				</dd>
				<dt>닉네임</dt>
				<dd>
					<div class="input">
						<input type="text" id="nickname" name="nickname" placeholder="닉네임을 입력해주세요">
					</div>
					<p class="msg"></p>

				</dd>
				<dt>이메일</dt>
				<dd id="dd">
					<div class="input2" id="emaildiv">
						<form id="contact" name="contact" method="post">
							<input id="email" name="email" data-bind="email" type="text" placeholder="이메일을 입력해주세요" value="">
							<input name="senderName" type="hidden" id="senderName" value="웰딩" />
							<input name="senderMail" type="hidden" id="senderMail" value="wellding@gmail.com" />
							<input type="hidden" name="receiveMail" id="receiveMail" value="" />
							<!-- 메일을 받을 사용자의 메일주소 -->
						</form>
					</div>
					<input type="button" value="인증하기" id="btnEmailCheck" class="btn_check">
					<p class="msg2"></p>
				</dd>
				<div class="button_area">
					<button class="btn_type1" id="btnReg">가입하기</button>
					<button class="btn_type2" id="btnCC">취소</button>
					
				</div>
			</dl>
		</div>

		<div class="footer">
			<div class="copyright">COPYRIGHT. WELLDING INC. ALL RIGHTS RESERVED</div>
		</div>

	</section>

</body>
</html>