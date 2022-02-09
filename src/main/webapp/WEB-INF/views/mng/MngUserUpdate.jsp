<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
html, body{
  color:  #525252;
}
table{
  width:100%;
  border: 1px solid #c4c2c2;
}
table th, td{
  border-right: 1px solid #c4c2c2;
  border-bottom: 1px solid #c4c2c2;
  height: 4rem;
  padding-left: .5rem;
  padding-right: 1rem;
}
table th{
  background-color: #e0e4fe;
}
input[type=text], input[type=password]{
  height:2rem;
  width: 100%;
  border-radius: .2rem;
  border: .2px solid rgb(204,204,204);
  background-color: rgb(246,246,246);
}
button{
  width: 5rem;
  margin-top: 1rem;
  border: .1rem solid rgb(204,204,204);
  border-radius: .2rem;
  /*box-shadow: 1px 1px #666;*/
}
button:active {
  background-color: rgb(186,186,186);
  box-shadow: 0 0 1px 1px #666;
  transform: translateY(1px);
}
</style>
<script type="text/javascript" src="../resources/js/jquery.colorbox.js"></script>
<script type="text/javascript" src="../resources/js/colorBox.js"></script>
<script>
$(document).ready(function(){
   $("#userName").focus();
});

function fn_userUpdate()
{
   //비밀번호
   if(icia.common.isEmpty($("#userPwd").val()))
   {
      alert("비밀번호를 입력하세요");
      $("#userPwd").focus();
      return;
   }
   
   if(!fn_idPwdCheck($("#userPwd").val()))
   {
      //정규표현식이 맞지 않을떄
      alert("비밀번호는 영문 대소문자, 숫자 4~12자로 입력해주세요.");
      $("#userPwd").focus();
      return;
   }
   
   //이름
   if(icia.common.isEmpty($("#userName").val()))
   {
      alert("이름을 입력하세요");
      $("#userName").focus();
      return;
   }
   
   //이메일
   if(icia.common.isEmpty($("#userEmail").val()))
   {
      alert("이메일을 입력하세요.");
      $("#userEmail").focus();
      return;
   }
   
   //닉네임
   if(icia.common.isEmpty($("#userNickname").val()))
   {
      alert("닉네임을 입력하세요.");
      $("#userNickname").focus();
      return;
   }
   
   //포인트
   if(icia.common.isEmpty($("#userPoint").val()))
   {
      alert("포인트를 입력하세요.");
      $("#userPoint").focus();
      return;
   }
   
   if(!fn_validateEmail($("#userEmail").val()))
   {
      //정규표현식이 맞지 않을떄
      alert("이메일 형식이 올바르지 않습니다.");
      $("#userEamil").focus();
      return;
   }
   
   //수정 취소
   if(!confirm("회원정보를 수정하시겠습니까?"))
   {
      //NO
      return;
   }
   
   var form = $("#regForm")[0];
   //폼 자체의 타입으로 보내기 위한 객체 생성.
   var formData = new FormData(form);
	
	//ajax통신
	$.ajax({
		type:"POST",
		url: "/mng/userupdateProc",
		data: formData,
		async: false,			//아마 이러면 모달이 확정적으로 석세스 넘어가지 않을까?
       processData:false,      //formData를 String으로 변환하지 않음
       contentType:false,      //content-type 헤더가 multipart/form-data로 전송한다는 것
       cache:false,
       timeout:600000,
       beforeSend:function(xhr)
       {
          xhr.setRequestHeader("AJAX", "true");
       },
      success: function(res)
      {
         icia.common.log(res);
         
         if(res.code == 0)
         {
            alert("회원정보가 수정되었습니다.");
            top.window.location.reload(true);
            fn_colorbox_close(parent.fn_pageInit);
         }
         else if(res.code == -1)
         {
            alert("회원정보 수정 중 오류가 발생하였숩니다.");
         }
         else if(res.code == 400)
         {
            alert("파라미터 값이 잘못되었습니다.");
         }
         else if(res.code == 404)
         {
            alert("회원정보가 존재하지 않습니다.");
            ///칼라박스 내용이 잘못됬다는거니까 칼라박스를 닫게하자
            fn_colorbox_close();
         }
      },
      complete: function(data)
      {
         icia.common.log(data);
      },
      error: function(xhr, status, error)
      {
         icia.common.error(error);
      }
   });
   
}

//이메일 및 아이디패스워드 정규표현식
function fn_validateEmail(value)
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
}

function fn_idPwdCheck(val)
{
   var regex = /^[a-zA-Z0-9]{4,12}$/;

   return regex.test(val);
}
</script>
</head>
<body>
<div class="layerpopup" style="width:1123px; margin:auto; margin-top:5%;">
   <h1 style="font-size: 1.6rem; margin-top: 3rem; margin-bottom: 1.6rem; padding: .5rem 0 .5rem 1rem; background-color: #e0e4fe;">사용자 수정</h1>
   <div class="layer-cont">
      <form name="regForm" id="regForm" method="post">
         <table>
            <tbody>

               <tr>
                  <th scope="row">아이디</th>
                  <td>
                 ${wdAdminUser.userId}
                     <input type="hidden" id="userId" name="userId" value="${wdAdminUser.userId}" />
                  </td>
                  <th scope="row">비밀번호</th>
                  <td>
                     <input type="text" id="userPwd" name="userPwd" value="${wdAdminUser.userPwd}" style="font-size:1rem;;" maxlength="15" placeholder="비밀번호" />
                  </td>
               </tr>
               <tr>
                  <th scope="row">이름</th>
                  <td>
                     <input type="text" id="userName" name="userName" value="${wdAdminUser.userName}" style="font-size:1rem;;" maxlength="50" placeholder="이름" />
                  </td>
                  <th scope="row">닉네임</th>
                  <td>
                     <input type="text" id="userNickname" name="userNickname" value="${wdAdminUser.userNickname}" style="font-size:1rem;;" maxlength="50" placeholder="닉네임" />
                  </td>
               </tr>
               <tr>
                   <th scope="row">이메일</th>
                  <td>
                 ${wdAdminUser.userEmail}
                     <input type="hidden" id="userEmail" name="userEmail" value="${wdAdminUser.userEmail}" />
                  </td>
                  <th scope="row">상태</th>
                  <td>
                     <select id="status" name="status" style="font-size: 1rem; width: 7rem; height: 2rem;">
                        <option value="Y" <c:if test="${wdAdminUser.status == 'Y'}">selected</c:if>>정상</option>
                        <option value="N" <c:if test="${wdAdminUser.status == 'N'}">selected</c:if>>정지</option>
                     </select>
                  </td>
               </tr>
               <tr>
                  <th scope="row">등록일</th>
                  <td>${wdAdminUser.regDate}</td>
                  <th scope="row">포인트</th>
                  <td>
                  <input type="text" id="userPoint" name="userPoint" value="${wdAdminUser.userPoint}" style="font-size:1rem;" maxlength="50" placeholder="포인트" />
                  </td>
               </tr>



            </tbody>
         </table>
      </form>
      <div class="pop-btn-area" style="float: right;">
         <button onclick="fn_userUpdate()" class="btn-type01"><span>수정</span></button>
         <button onclick="fn_colorbox_close()" id="colorboxClose" class="btn-type01" style="margin-left: 1rem;"><span>닫기</span></button>
      </div>
   </div>
</div>


   <%@ include file="/WEB-INF/views/include/footer3.jsp" %>
</body>
</html>