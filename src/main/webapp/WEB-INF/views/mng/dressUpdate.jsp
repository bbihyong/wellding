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
  padding: 10px;
  text-align: left;
}
table th{
  background-color: #e0e4fe;
  text-align: center;
  width: 200px;
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
   $("#dName").focus();
});

function dressUpdate()
{
	if(icia.common.isEmpty($("#dcName").val()))
	{
		alert("드레스 업체명을 입력해주세요");
		$("#dcName").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#dName").val()))
	{
		alert("드레스명을 입력해주세요");
		$("#dName").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#dContent").val()))
	{
		alert("드레스 설명을 입력해주세요.");
		$("#dContent").focus();
		return;
	}
	
	//등록 취소
	if(!confirm("드레스 업체를 등록 하시겠습니까?"))
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
		url: "/mng/dressUpdateProc",
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
				alert("드레스 정보가 수정되었습니다.");
				top.window.location.reload(true);
				fn_colorbox_close(parent.fn_pageInit);
				
				top.window.location.reload(true); //부모창리프레시
			}
			else if(res.code == 400)
			{
				alert("파라미터값이 올바지않습르니다.");
			}
			else if(res.code == 404)
			{
				alert("드레스 정보를 찾을 수 없습니다.");
				fn_colorbox_close();
			}
			else
			{
				alert("드레스 정보 수정 중 오류가 발생했습니다.");
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

function dressDelete()
{
   if(confirm("정말 삭제하시겠습니까?") == true)
   {
      $.ajax({
         type: "POST",
         url: "/mng/dressDelete",
         data:{
            dcCode: $("#dcCode").val(),
            dNo : $("#dNo").val()
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
               alert("드레스가 삭제되었습니다.");
				top.window.location.reload(true);
               fn_colorbox_close(parent.fn_pageInit);
            }
            else if(res.code == 400)
            {
               alert("파라미터값이 올바지않습르니다.");
            }
            else if(res.code == 404)
            {
               alert("드레스를 찾을 수 없습니다.");
               fn_colorbox_close();
            }
            else
            {
               alert("드레스 삭제 중 오류가 발생했습니다.");
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
    
      <div class="layerpopup" style="width:1123px; margin:auto;">
         <h1 style="font-size: 1.6rem; margin-top: 3rem; margin-bottom: 1.6rem; padding: .5rem 0 .5rem 1rem; background-color: #e0e4fe;">드레스 상세보기</h1>
         <div class="layer-cont" style="display: block;">
            <form name="regForm" id="regForm" method="post">
               <table>
                  <tbody>
                     <tr>
                        <th scope="row">드레스업체 번호</th>
                        <td>
                           ${dList.dcCode}
                           <input type="hidden" id="dcCode" name="dcCode" value="${dList.dcCode}" />
                        </td>
                     </tr>
                     <tr>
                        <th scope="row">드레스 번호</th>
                        <td>
                           ${dList.dNo}
                           <input type="hidden" id="dNo" name="dNo" value="${dList.dNo}" />
                        </td>
                     </tr>
                     <tr>
                        <th scope="row">드레스 업체명</th>
                        <td>
                        ${dList.dcName}
                           <input type="hidden" style="background-color: #fff;" id="dcName" name="dcName" value="${dList.dcName}" />
                        </td>
                     </tr>
                     <tr>
                        <th scope="row">드레스명</th>
                        <td>
                           <input type="text" style="background-color: #fff;" id="dName" name="dName" value="${dList.dName}" />
                        </td>
                     </tr>
                     <tr>
                        <th scope="row">드레스 가격</th>
                        <td>
                           <input type="text" style="background-color: #fff;" id="dPrice" name="dPrice" value="${dList.dPrice}" />
                        </td>
                     </tr>
                     <!--tr>
                        <th scope="row">드레스 대표 이미지</th>
                        <td>
                           <input type="file" style="background-color: #fff;" id="dressimgname" name="dressimgname" value="${dList.dImgname}" />
                        </td>
                     </tr-->
                     <tr>
                        <th scope="row">드레스 설명</th>
                        <td style="padding: 15px 15px 15px 9px;">
                        <textarea class="form-control" rows="3" name="dContent" id="dContent" style="ime-mode: active; resize: none; width:100%; float:left; height:76px; font-size:14px; padding:7px;" required>${dList.dContent}</textarea>
                        </td>
                     </tr>
      
                  </tbody>
            </form>
            
         <table style="border:none;">
            <tr style="border:none;">
               <td style="border:none;">
                     <div class="pop-btn-area" style="display: block; float: right;">
                        <button onclick="dressUpdate()" class="btn-type01"><span>수정</span></button>
                        <button onclick="dressDelete()" class="btn-type01" style="margin-left: 1rem;"><span>삭제</span></button>
                        <button onclick="fn_colorbox_close()" id="colorboxClose" class="btn-type01" style="margin-left: 1rem;"><span>닫기</span></button>
                     </div>
                  </div>
               </td>
            </tr>
         </table>

         </div>

      </div>

   <%@ include file="/WEB-INF/views/include/footer3.jsp" %>
   
   </div>
</div>
</body>
</html>