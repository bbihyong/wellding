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
  text-align: left;
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
   $("#makeupName").focus();
});

function fn_userUpdate()
{
	if(icia.common.isEmpty($("#makeupName").val()))
	   {
	      alert("메이크업 이름을 입력해주세요");
	      $("#makeupName").focus();
	      return;
	   }
	   
	   if(icia.common.isEmpty($("#makeupLocation").val()))
	   {
	      alert("메이크업 주소를 입력해주세요");
	      $("#makeupLocation").focus();
	      return;
	   }
	   
	   if(icia.common.isEmpty($("#makeupnumber").val()))
	   {
	      alert("메이크업 번호를 입력해주세요");
	      $("#makeupnumber").focus();
	      return;
	   }
	   
	   if(icia.common.isEmpty($("#makeupprice").val()))
	   {
	      alert("메이크업 금액을 입력해주세요");
	      $("#makeupprice").focus();
	      return;
	   }
	  
	   
	 
	   if(icia.common.isEmpty($("#makeupContent").val()))
	   {
	      alert("메이크업 설명을 입력해주세요.");
	      $("#makeupContent").focus();
	      return;
	   }
	   if(icia.common.isEmpty($("#makeupPlus").val()))
	   {
	      alert("추가 인원당 금액을 입력해주세요");
	      $("#makeupPlus").focus();
	      return;
	   }
	   if(icia.common.isEmpty($("#makeupdiscount").val()))
	   {
	      alert("할인율을 입력해주세요");
	      $("#makeupdiscount").focus();
	      return;
	   }
	   
	   
	   //등록 취소
	   if(!confirm("메이크업을 등록 하시겠습니까?"))
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
		enctype:'multipart/form-data',
		url: "/mng/makeupupdateProc",
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
            alert("정보 수정이 완료되었습니다.");
            top.window.location.reload(true);
            fn_colorbox_close(parent.fn_pageInit);
         }
         else if(res.code == -1)
         {
            alert("정보 수정 중 오류가 발생하였숩니다.");
         }
         else if(res.code == 400)
         {
            alert("파라미터 값이 잘못되었습니다.");
         }
         else if(res.code == 404)
         {
            alert("오류가 발생하였습니다.");
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
function makeupComDelete()
{
	if(confirm("정말 삭제하시겠습니까?") == true)
	{
		$.ajax({
			type: "POST",
			url: "/mng/makeupComDelete",
			data:{
				mCode: $("#mCode").val()
			},
			datatype: "JSON",
			beforeSend: function(xhr)
			{
				xhr.setRequestHeader("AJAX", "true");
			},
			success: function(res)
			{
				icia.common.log(res);
				
				if(res.code == 0)
				{
					alert("업체가 삭제되었습니다.");
					top.window.location.reload(true);
					fn_colorbox_close(parent.fn_pageInit);
				}
				else if(res.code == 400)
				{
					alert("파라미터값이 올바지않습르니다.");
				}
				else if(res.code == 404)
				{
					alert("업체를 찾을 수 없습니다.");
					fn_colorbox_close();
				}
				else
				{
					alert("업체 삭제 중 오류가 발생했습니다.");
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
}
</script>
</head>
<body>
<div class="container">
    <div class="row" style="width: 100%; text-align: center;">
 <!-- /////////////////////////////////////////// --> 
<div class="layerpopup" style="width:1123px; margin:auto;">
   <h1 style="font-size: 1.6rem; margin-top: 3rem; margin-bottom: 1.6rem; padding: .5rem 0 .5rem 1rem; background-color: #e0e4fe;">메이크업 수정</h1>
   <div class="layer-cont">
      <form name="regForm" id="regForm" method="post">
         <table>
            <tbody>
				<input type="hidden" id="mCode" name="mCode" value="${wdmakeup.mCode}" />
               <tr>
                  <th scope="row">메이크업 이름</th>
                  <td>
                 
                     <input type="text" style="background-color: #fff;" id="makeupName" name="makeupName" value="${wdmakeup.mName}"/>
                  </td>
               </tr>
               <tr>
                  <th scope="row">메이크업 주소</th>
                  <td>
                     <input type="text" style="background-color: #fff;" id="makeupLocation" name="makeupLocation" value="${wdmakeup.mLocation}"/>
                  </td>
               </tr>
               <tr>
                   <th scope="row">메이크업 전화번호</th>
                  <td>
                     <input type="text" style="background-color: #fff;" id="makeupnumber" name="makeupnumber" value="${wdmakeup.mNumber}"/>
                  </td>
               </tr>
                <tr>
                   <th scope="row">대표 이미지</th>
                  <td>
                     <!--input type="file" style="background-color: #fff;" id="makeupimgname" name="makeupimgname" value="${wdmakeup.mImgName}"/-->
					<div class="filebox bs3-primary">
					    <input class="upload-name" value="파일선택" disabled="disabled">
					
					    <label for="makeupimgname">업로드</label> 
					    <input type="file" id="makeupimgname" name="makeupimgname" class="upload-hidden"> 
					</div>
                  </td>
               </tr>
                <tr>
                   <th scope="row">금액</th>
                  <td>
                     <input type="text" style="background-color: #fff;" id="makeupprice" name="makeupprice" value="${wdmakeup.mPrice}"/>
                  </td>
               </tr>
               <tr>
                  <th scope="row">메이크업 설명</th>
                  <td>
                  <textarea class="form-control" rows="3" name="makeupContent" id="makeupContent" style="ime-mode: active; resize: none; width:100%; float:left; height:76px; font-size:14px;">${wdmakeup.mContent}</textarea>
                  </td>
               </tr>
                <tr>
                   <th scope="row">추가 인원당 금액</th>
                  <td>
                     <input type="text" style="background-color: #fff;" id="makeupPlus" name="makeupPlus" value="${wdmakeup.mPlus}"/>
                  </td>
               </tr>
                <tr>
                   <th scope="row">할인율</th>
                  <td>
                     <input type="number" style="background-color: #fff;" id="makeupdiscount" name="makeupdiscount" value="${wdmakeup.mDiscount}"/>
                  </td>
               </tr>

            </tbody>
         </table>
      </form>
      <div class="pop-btn-area" style="float: right;">
         <button onclick="fn_userUpdate()" class="btn-type01"><span>수정</span></button>
         <button onclick="makeupComDelete()" class="btn-type01" style="margin-left: 1rem;"><span>삭제</span></button>
         <button onclick="fn_colorbox_close()" id="colorboxClose" class="btn-type01" style="margin-left: 1rem;"><span>닫기</span></button>
      </div>
   </div>
</div>


   <%@ include file="/WEB-INF/views/include/footer3.jsp" %>
</body>
</html>