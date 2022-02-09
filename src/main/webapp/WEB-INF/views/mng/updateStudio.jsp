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
  background-color: #e9e9ed;
  width: 250px;
}
input[type=text], input[type=password]{
  height:2rem;
  width: 100%;
  border-radius: .2rem;
  border: .2px solid rgb(204,204,204);
  background-color: rgb(246,246,246);
  font-size:15px;
}

input::placeholder 
{
  font-size: 14px;
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
	$("#sName").focus();
});
function fn_studioDelete()
{
	if(confirm("정말 삭제 하시겠습니까?") == true)
	{
		$.ajax({
			type: "POST",
			url: "/mng/studioDelete",
			data:{
				sCode: $("#studioCode").val()
			},
			datatype: "JSON",
			success: function(response)
			{
				if(response.code == 0)
				{
					alert("스튜디오가 삭제되었습니다.");
					top.window.location.reload(true);
					fn_colorbox_close(parent.fn_pageInit);
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
				}
				else if(response.code == 404)
				{
					alert("스튜디오를 찾을수 없습니다.");
					fn_colorbox_close();
				}
				else
				{
					alert("스튜디오 삭제 중 오류가 발생했습니다.");
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

function fn_studioUpdate()
{	
	if(icia.common.isEmpty($("#studioName").val()))
	{
		alert("스튜디오 이름을 입력해주세요");
		$("#studioName").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#studioPrice").val()))
	{
		alert("스튜디오 가격을 입력해주세요");
		$("#studioPrice").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#studioLocation").val()))
	{
		alert("스튜디오 주소를 입력해주세요");
		$("#studioLocation").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#studioNumber").val()))
	{
		alert("스튜디오 전화번호를 입력해주세요");
		$("#studioNumber").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#studioContent").val()))
	{
		alert("스튜디오 설명을 입력해주세요");
		$("#studioContent").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#studioDiscount").val()))
	{
		alert("스튜디오 할인율을 입력해주세요");
		$("#studioDiscount").focus();
		return;
	}
	
    var form = $("#regForm")[0];
    //폼 자체의 타입으로 보내기 위한 객체 생성.
    var formData = new FormData(form);
	
	if(confirm("정말 수정하시겠습니까?") == true)
	{
		//ajax통신
		$.ajax({
			type:"POST",
			enctype:'multipart/form-data',
			url: "/mng/studioUpdateProc",
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
					alert("정보 수정 중 오류가 발생하였습니다.");
				}
				else if(res.code == 400)
				{
					alert("파라미터 값이 잘못 되었습니다.");
				}
				else if(res.code == 404)
				{
					alert("오류가 발생하였습니다.");
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

<div class="layerpopup" style="width:1123px; margin:auto; margin-top:5%;">
	<h1 style="font-size: 1.6rem; margin-top: 3rem; margin-bottom: 1.6rem; padding: .5rem 0 .5rem 1rem; background-color: #e0e4fe;">스튜디오 수정</h1>
	<div class="layer-cont">
      <form name="regForm" id="regForm" method="post">
         <table>
            <tbody>
                <input type="hidden" id="studioCode" name="studioCode" value="${wdStudio.sCode}"/>
            	<tr>
                  <th scope="row">스튜디오 이름</th>
                  <td>
                     <input type="text" id="studioName" name="studioName" value="${wdStudio.sName}"/>
                  </td>
               </tr>
               <tr>
                  <th scope="row">스튜디오 가격</th>
                  <td>
                     <input type="text" id="studioPrice" name="studioPrice" value="${wdStudio.sPrice}"/>
                  </td>
               </tr>
               <tr>
                   <th scope="row">스튜디오 주소</th>
                  <td>
                     <input type="text" id="studioLocation" name="studioLocation" value="${wdStudio.sLocation}"/>
                  </td>
               </tr>
               <tr>
                  <th scope="row">스튜디오 전화번호</th>
                  <td>
                  	<input type="text" id="studioNumber" name="studioNumber" value="${wdStudio.sNumber}"/>
                  </td>
               </tr>
               <tr>
                  <th scope="row">스튜디오 설명</th>
                  <td>
                  	<textarea class="form-control" rows="3" name="studioContent" id="studioContent" style="ime-mode: active; resize: none; width:100%; float:left; height:76px; font-size:14px;" required>${wdStudio.sContent}</textarea>
                  </td>
               </tr>
               <tr>
                  <th scope="row">할인율</th>
                  <td>
                  	<input type="number" id="studioDiscount" name="studioDiscount" value="${wdStudio.sDiscount}"/>
                  </td>
               </tr>
            </tbody>
         </table>
      </form>
      <div class="pop-btn-area" style="float: right;">
         <button onclick="fn_studioUpdate()" class="btn-type01"><span>수정</span></button>
         <button onclick="fn_studioDelete()" class="btn-type01" style="margin-left: 1rem;"><span>삭제</span></button>
         <button onclick="fn_colorbox_close()" id="colorboxClose" class="btn-type01" style="margin-left: 1rem;"><span>닫기</span></button>
      </div>
   </div>
</div>

	<%@ include file="/WEB-INF/views/include/footer3.jsp" %>
</body>
</html>