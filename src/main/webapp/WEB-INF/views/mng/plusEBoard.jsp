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
	
});

function fn_userUpdate()
{
	if(icia.common.isEmpty($("#bTitle").val()))
	{
		alert("제목을 입력해주세요");
		$("#bTitle").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#bContent").val()))
	{
		alert("내용을 입력해주세요");
		$("#bContent").focus();
		return;
	}
	
	//등록 취소
	if(!confirm("게시물을 등록 하시겠습니까?"))
	{
		//NO
		return;
	}
	
	var form = $("#regForm")[0];
    //폼 자체의 타입으로 보내기 위한 객체 생성.
    var formData = new FormData(form);
	
	$.ajax({
		type:"POST",
		enctype:'multipart/form-data',
		url: "/mng/eBoardWrite",
		data: formData,
		async : false,			//비동기 여부
        processData:false,      //Data를 contentTpye에 맞게 변환
        contentType:false,      //content-type 헤더가 multipart/form-data로 전송한다는 것
        cache:false,
        timeout:600000,
        beforeSend:function(xhr) //XHR Header를 포함해서 HTTP Request를 하기전에 호출됩니다.
        {
           xhr.setRequestHeader("AJAX", "true");
        },
		success: function(res)
		{
			icia.common.log(res);
			
			if(res.code == 0)
			{
				alert("이벤트 게시물 등록이 완료되었습니다.");
				fn_colorbox_close(parent.fn_pageInit);
			}
			else if(res.code == -1)
			{
				alert("이벤트 게시물  제목과 내용이 등록되지 않았습니다.");
			}
			else if(res.code == -2)
			{
				alert("이벤트 게시물 이미지가 등록되지 않았습니다.");
			}
			else if(res.code == -400)
			{
				alert("알 수 없는 오류 입니다.");
			}
			else if(res.code == 500)
			{
				alert("게시물 등록 중 오류가 발생했습니다.");
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

</script>
</head>
<body>   
<div class="container">
    <div class="row" style="width: 100%; text-align: center;">
 <!-- /////////////////////////////////////////// --> 
<div class="layerpopup" style="width:1123px; margin:auto;">
   <h1 style="font-size: 1.6rem; margin-top: 3rem; margin-bottom: 1.6rem; padding: .5rem 0 .5rem 1rem; background-color: #e9e9ed;">이벤트 게시글 추가</h1>
   <div class="layer-cont">
      <form name="regForm" id="regForm" method="post" enctype="multipart/form-data" >
         <table>
            <tbody>
               <tr>
                  <th scope="row">제목</th>
                  <td>
                     <input type="text" style="background-color: #fff;" id="bTitle" name="bTitle" placeholder="제목을 입력해주세요"/>
                  </td>
               </tr>
               <tr>
                  <th scope="row">내용</th>
                  <td style="padding: 15px 15px 15px 9px;">
                  <textarea class="form-control" rows="10" name="bContent" id="bContent" style="ime-mode: active; resize: none; width:100%; float:left; height:140px; font-size:14px; padding:7px;" placeholder="내용을 입력해주세요" required></textarea>
                  </td>
               </tr>
               
               <tr>
               	  <th scope="row">이미지 첨부</th>
               	  <td>
					<div class="filebox bs3-primary preview-image">
					    <input class="upload-name" value="파일선택" disabled="disabled">
					
					    <label for="img">업로드</label> 
					    <input type="file" id="img" name="img" class="upload-hidden"> 
					</div>
               	  </td>
               </tr>

            </tbody>
         </table>
      

      <div class="pop-btn-area" style="float: right;">
         <button onclick="fn_userUpdate()" class="btn-type01"><span>등록</span></button>
         <button onclick="fn_colorbox_close()" id="colorboxClose" class="btn-type01" style="margin-left: 1rem;"><span>닫기</span></button>
         
      </div>
      </form>
   </div>
</div>


	<%@ include file="/WEB-INF/views/include/footer3.jsp" %>
 <!-- ///////////////////////////////////////////// -->
	</div>
</div>
       
</body>
</html>