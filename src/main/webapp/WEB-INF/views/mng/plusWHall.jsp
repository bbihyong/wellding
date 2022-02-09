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
	$("#weddinghallName").focus();
});

function fn_userUpdate()
{
	if(icia.common.isEmpty($("#weddinghallName").val()))
	{
		alert("웨딩홀 이름을 입력해주세요");
		$("#weddinghallName").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#weddinghallLocation").val()))
	{
		alert("웨딩홀 주소를 입력해주세요");
		$("#weddinghallLocation").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#weddinghallNumber").val()))
	{
		alert("웨딩홀 전화번호를 입력해주세요");
		$("#weddinghallNumber").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#weddinghallContent").val()))
	{
		alert("웨딩홀 설명을 입력해주세요.");
		$("#weddinghallContent").focus();
		return;
	}
	
	//등록 취소
	if(!confirm("웨딩홀을 등록 하시겠습니까?"))
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
		url: "/mng/weddinghallWrite",
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
				alert("웨딩홀 등록이 완료되었습니다.");
				top.window.location.reload(true);
				fn_colorbox_close(parent.fn_pageInit);
			}
			else if(res.code == -1)
			{
				alert("웨딩홀 등록 중 오류가 발생하였숩니다.");
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

</script>
</head>
<body>   
<div class="container">
    <div class="row" style="width: 100%; text-align: center;">
 <!-- /////////////////////////////////////////// --> 
<div class="layerpopup" style="width:1123px; margin:auto;">
   <h1 style="font-size: 1.6rem; margin-top: 3rem; margin-bottom: 1.6rem; padding: .5rem 0 .5rem 1rem; background-color: #e0e4fe;">웨딩홀 추가</h1>
   <div class="layer-cont">
      <form name="regForm" id="regForm" method="post">
         <table>
            <tbody>

               <tr>
                  <th scope="row">웨딩홀 이름</th>
                  <td>
                     <input type="text" style="background-color: #fff;" id="weddinghallName" name="weddinghallName" placeholder="웨딩홀 이름을 입력해주세요"/>
                  </td>
               </tr>
               <tr>
                  <th scope="row">웨딩홀 주소</th>
                  <td>
                     <input type="text" style="background-color: #fff;" id="weddinghallLocation" name="weddinghallLocation" placeholder="웨딩홀 주소를 입력해주세요"/>
                  </td>
               </tr>
               <tr>
                   <th scope="row">웨딩홀 전화번호</th>
                  <td>
                     <input type="text" style="background-color: #fff;" id="weddinghallNumber" name="weddinghallNumber" placeholder="웨딩홀 번호를 입력해주세요"/>
                  </td>
               </tr>
               <tr>
                  <th scope="row">웨딩홀 설명</th>
                  <td>
                  <textarea class="form-control" rows="3" name="weddinghallContent" id="weddinghallContent" style="ime-mode: active; resize: none; width:100%; float:left; height:76px; font-size:14px;" placeholder="웨딩홀 설명을 입력해주세요" required></textarea>
                  </td>
               </tr>

            </tbody>
         </table>
      </form>
      <div class="pop-btn-area" style="float: right;">
         <button onclick="fn_userUpdate()" class="btn-type01"><span>등록</span></button>
         <button onclick="fn_colorbox_close()" id="colorboxClose" class="btn-type01" style="margin-left: 1rem;"><span>닫기</span></button>
      </div>
   </div>
</div>


	<%@ include file="/WEB-INF/views/include/footer3.jsp" %>
 <!-- ///////////////////////////////////////////// -->
	</div>
</div>
       
</body>
</html>