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
var loginModCheck = 1;
var euisooM = 0;
$(function(){
   
   $("#id2").removeAttr("onclick");
   
   $("#loginbtn").on("click", function(){
      fn_loginCheck();      
   });
   
   $("#userId").on("keypress", function(e){
      
      if(e.which == 13)
      {   
         fn_loginCheck();
      }
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
   if($.trim($("#userId").val()).length <= 0)
   {
      //alert("아이디를 입력하세요.");
      Swal.fire({ 
         icon: 'warning',
         text: '아이디를 입력하세요.'
      });
      $("#userId").focus();
      return;
   }
   
   if($.trim($("#userPwd").val()).length <= 0)
   {
      //alert("비밀번호를 입력하세요.");
      Swal.fire({ 
         icon: 'warning',
         text: '비밀번호를 입력하세요.'
      });
      $("#userPwd").focus();
      return;
   }
   
   
   if(loginModCheck == 1) //일반사용자 ajax 시작
   {
   
   $.ajax({
      type : "POST",
      url : "/imokay",
      data : {
         userId:$("#userId").val(),
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
               //location.href = "/";
               const Toast = Swal.mixin({
                   toast: true,
                   position: 'center-center',
                   showConfirmButton: false,
                   timer: 1500,
                   timerProgressBar: true,
                   didOpen: (toast) => {
                       toast.addEventListener('mouseenter', Swal.stopTimer)
                       toast.addEventListener('mouseleave', Swal.resumeTimer)
                   }
               });
               
               Toast.fire({
                   icon: 'success',
                   title: '웰딩에 오신 여러분 환영합니다!'
               }).then(function(){
                  location.href = "/";
               });
            }
            else
            {
               if(code == -1)
               {
                  //alert("비밀번호가 올바르지 않습니다.");
                  //$("#userPwd").focus();
                  Swal.fire({ 
                     icon: 'error',
                     text: '비밀번호가 올바르지 않습니다.'
                  }).then(function(){
                     $("#userPwd").focus();
                  });
               }
               else if(code == 404)
               {
                  //alert("아이디와 일치하는 사용자 정보가 없습니다.");
                  //$("#userId").focus();
                  Swal.fire({ 
                     icon: 'error',
                     text: '아이디와 일치하는 사용자 정보가 없습니다.'
                  }).then(function(){
                     $("#userId").focus();
                  });
               }
               else if(code == 400)
               {
                  //alert("파라미터 값이 올바르지 않습니다.");
                  //$("#userId").focus();
                  Swal.fire({ 
                     icon: 'error',
                     text: '파라미터 값이 올바르지 않습니다.'
                  }).then(function(){
                     $("#userId").focus();
                  });
               }
               else if(code == 403)
               {
                  //alert("이용이 정지된 사용자입니다.");
                  //$("#userId").focus();
                  Swal.fire({ 
                     icon: 'error',
                     text: '이용이 정지된 사용자입니다.'
                  }).then(function(){
                     $("#userId").focus();
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
   
   }//일반사용자 ajax 끝
   else if(loginModCheck == 2) //관리자 ajax 시작
   {
      $.ajax({
         type : "POST",
         url : "/mng/login",
         data : {
            userId:$("#userId").val(),
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
                  //location.href = "/mng/userList";
                  //location.href = "/";
                  const Toast = Swal.mixin({
                      toast: true,
                      position: 'center-center',
                      showConfirmButton: false,
                      timer: 1500,
                      timerProgressBar: true,
                      didOpen: (toast) => {
                          toast.addEventListener('mouseenter', Swal.stopTimer)
                          toast.addEventListener('mouseleave', Swal.resumeTimer)
                      }
                  });
                  
                  Toast.fire({
                      icon: 'success',
                      title: '관리자님 환영합니다!'
                  }).then(function(){
                     location.href = "/";
                  });
               }
               else
               {
                  if(code == -1)
                  {
                     //alert("비밀번호가 올바르지 않습니다.");
                     //$("#userPwd").focus();
                     Swal.fire({ 
                        icon: 'error',
                        text: '비밀번호가 올바르지 않습니다.'
                     }).then(function(){
                        $("#userPwd").focus();
                     });
                  }
                  else if(code == 404)
                  {
                     //alert("아이디와 일치하는 사용자 정보가 없습니다.");
                     //$("#userId").focus();
                     Swal.fire({ 
                        icon: 'error',
                        text: '아이디와 일치하는 사용자 정보가 없습니다.'
                     }).then(function(){
                        $("#userId").focus();
                     });
                  }
                  else if(code == 400)
                  {
                     //alert("파라미터 값이 올바르지 않습니다.");
                     //$("#userId").focus();
                     Swal.fire({ 
                        icon: 'error',
                        text: '파라미터 값이 올바르지 않습니다.'
                     }).then(function(){
                        $("#userId").focus();
                     });
                  }
                  else if(code == 403)
                  {
                     //alert("이용이 정지된 사용자입니다.");
                     //$("#userId").focus();
                     Swal.fire({ 
                        icon: 'error',
                        text: '이용이 정지된 사용자입니다.'
                     }).then(function(){
                        $("#userId").focus();
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
}
function classChange(id){
      document.getElementById('id1').classList.remove('selected');
      document.getElementById('id2').classList.remove('selected');
      //document.getElementById('id3').classList.remove('selected');
      id.setAttribute('class','selected');
      
       if($('#id1').hasClass('selected')){
          loginModCheck = 1;
        }
        if($('#id2').hasClass('selected')){
           loginModCheck = 2;
        }
        //if($('#id3').hasClass('selected')){
       //    loginModCheck = 3;
        //}
   }

function fn_index()
{
   location.href = "/";   
}

function plusNum()
{
   euisooM = euisooM + 1;
   
   if(euisooM >= 8)
   {
      //alert("이제 관리자 계정으로 로그인이 가능합니다.");
      //$("#id2").attr("onclick", "classChange(this);");
      Swal.fire({ 
         icon: 'info',
         text: '이제 관리자 계정으로 로그인이 가능합니다.',
         allowOutsideClick : false //다른데 클릭 못하게 막기!!!***
      }).then(function(){
         document.getElementById('id1').classList.remove('selected');
         document.getElementById('id2').classList.add('selected');

         $("#id2").attr("onclick", "classChange(this);");
         $('#id2').hasClass('selected');
      
         //2번버튼 클릭상태로만들기 ~~! 바로 로그인쌉가능 예이
         $("#id2").trigger("click");
      });
   }
}

</script>
</head>
<body>

   <div class="limiter">
      <div class="container-login100">
         <div class="wrap-login100">
            <form class="login100-form validate-form">
               <span class="login100-form-title">
                  <h1 id="logo"><img src="../resources/images/theWellding.png" width="140" height="auto" onclick="fn_index()" style="cursor: pointer; padding-bottom: 10px;" /></h1>

               </span>
               <span class="login100-form-title" style="padding-bottom: 40px;">
                  <!-- <i class="zmdi zmdi-font"></i> -->
                  <div class="mTab eTab">
                     <ul>
                        
                        <li id="id1" class="selected" onclick="classChange(this)"><a href="javascript:void(0)">회원</a></li>
                        <li id="id2" onclick="classChange(this)"><a href="javascript:void(0)" >관리자</a></li>
                        <!-- <li id="id3" onclick="classChange(this)"><a href="javascript:void(0)" >전문가</a></li>-->
                        <!-- <li class="selected"><a href="#" onclick="changeLogin('3', 'F', 'F');">전문가</a></li> -->
                     </ul>
                  </div>
                  
               </span>

               <div>

               

               <div class="wrap-input100 validate-input" data-validate = "Valid email is: a@b.c">
                  <input class="input100" type="text" name="userId" id="userId" >
                  <span class="focus-input100" data-placeholder="ID"></span>
               </div>

               <div class="wrap-input100 validate-input" data-validate="Enter password">
                  <span class="btn-show-pass">
                     <i class="zmdi zmdi-eye"></i>
                  </span>
                  <input class="input100" type="password" name="userPwd" id="userPwd" >
                  <span class="focus-input100" data-placeholder="Password"></span>
               </div>

               <div class="container-login100-form-btn">
                  <div class="wrap-login100-form-btn">
                     <div class="login100-form-bgbtn"></div>
                     <button type="button" id="loginbtn" class="login100-form-btn">
                        Login
                     </button>
                  </div>
               </div>
               

               <div class="text-center" style="padding-top: 50px;">
                  <span class="txt1">
                     Wellding에 처음이세요?&nbsp;
                  </span>

                  <a class="txt2" href="/board/regform">
                     회원가입하기
                  </a>
               </div>
               
               <div class="text-center" style="padding-top: 5px;">
                  <span class="txt1">
                     아이디 혹은 비밀번호를 잊으셨나요? &nbsp;
                  </span>


                     <a class="txt2" href="/user/FindingId">
                        아이디 찾기
                     </a>
                     <p style="cursor:default; color: #888; display: inline-block;">&nbsp;&nbsp;or&nbsp;&nbsp; </p>
                     <a class="txt2" href="/user/FindingPwd">
                        비밀번호 찾기
                     </a>

               </div>
               
                  <input type="button" onclick="plusNum()" value="d" style="width: 50px; height: 50px; background-color: white; color: white; cursor: default;"/>
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
