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
	$("#hName").focus();
});

function hallUpdate()
{
	if(icia.common.isEmpty($("#hName").val()))
	{
		alert("업체 이름을 입력해주세요");
		$("#hName").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#hPrice").val()))
	{
		alert("홀 가격을 입력해주세요");
		$("#hPrice").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#hFood").val()))
	{
		alert("1인당 식사가격을 입력해주세요");
		$("#hFood").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#hMin").val()))
	{
		alert("홀 최소인원을 입력해주세요.");
		$("#hMin").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#hMax").val()))
	{
		alert("홀 최대인원을 입력해주세요.");
		$("#hMax").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#hContent").val()))
	{
		alert("홀 설명을 입력해주세요.");
		$("#hContent").focus();
		return;
	}
	
	//등록 취소
	if(!confirm("홀을 수정하시겠습니까?"))
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
		url: "/mng/hallUpdateProc",
		data: formData,
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
				alert("홀 수정이 완료되었습니다.");
				fn_colorbox_close(parent.fn_pageInit);
			}
			else if(res.code == -1)
			{
				alert("홀 수정 중 오류가 발생하였숩니다.");
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

function hallDelete()
{
	if(confirm("정말 삭제하시겠습니까?") == true)
	{
		$.ajax({
			type: "POST",
			url: "/mng/hallDelete",
			data:{
				whCode: $("#whCode").val(),
				hCode: $("#hCode").val()
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
					alert("웨딩홀이 삭제되었습니다.");
					fn_colorbox_close(parent.fn_pageInit);
				}
				else if(res.code == 400)
				{
					alert("파라미터값이 올바르지 않습니다..");
				}
				else if(res.code == 404)
				{
					alert("웨딩홀을 찾을 수 없습니다.");
					fn_colorbox_close();
				}
				else
				{
					alert("웨딩홀 삭제 중 오류가 발생했습니다.");
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
			<h1 style="font-size: 1.6rem; margin-top: 3rem; margin-bottom: 1.6rem; padding: .5rem 0 .5rem 1rem; background-color: #e0e4fe;">홀 상세보기</h1>
		   <div class="layer-cont" style="display: block;">
		      <form name="regForm" id="regForm" method="post">
		         <table>
		            <tbody>
		               <tr>
		                  <th scope="row">홀 전화번호</th>
		                  <td>
		                  	<input type="hidden" id="whCode" name="whCode" value="${wdHall.WHCode }">
		                  	${wdHall.HCode}
		                     <input type="hidden" id="hCode" name="hCode" value="${wdHall.HCode}" />
		                  </td>
		               </tr>
		               <tr>
		                  <th scope="row">홀 이름</th>
		                  <td>
		                     <input type="text" style="background-color: #fff;" id="hName" name="hName" value="${wdHall.HName}" />
		                  </td>
		               </tr>
		               <tr>
		                  <th scope="row">홀 가격</th>
		                  <td>
		                     <input type="text" style="background-color: #fff;" id="hPrice" name="hPrice" value="${wdHall.HPrice}" />
		                  </td>
		               </tr>
		               <tr>
		                   <th scope="row">홀 1인당 식비</th>
		                  <td>
		                     <input type="text" style="background-color: #fff;" id="hFood" name="hFood" value="${wdHall.HFood}"/>
		                  </td>
		               </tr>
		               <tr>
		                   <th scope="row">홀 최소인원</th>
		                  <td>
		                     <input type="text" style="background-color: #fff;" id="hMin" name="hMin" value="${wdHall.HMin}"/>
		                  </td>
		               </tr>
		               <tr>
		                   <th scope="row">홀 최대인원</th>
		                  <td>
		                     <input type="text" style="background-color: #fff;" id="hMax" name="hMax" value="${wdHall.HMax}"/>
		                  </td>
		               </tr>
		               <tr>
		                  <th scope="row">홀 설명</th>
		                  <td style="padding: 15px 15px 15px 9px;">
		                  <textarea class="form-control" rows="3" name="hContent" id="hContent" style="ime-mode: active; resize: none; width:100%; float:left; height:76px; font-size:14px; padding:7px;" required>${wdHall.HContent}</textarea>
		                  </td>
		               </tr>
		            </tbody>
		      </form>
		   
			<table style="border:none;">
				<tr style="border:none;">
					<td style="border:none;">
					      <div class="pop-btn-area" style="display: block; float: right;">
					         <button onclick="hallUpdate()" class="btn-type01"><span>수정</span></button>
					         <button onclick="hallDelete()" class="btn-type01" style="margin-left: 1rem;"><span>삭제</span></button>
					         <button onclick="fn_colorbox_close()" id="colorboxClose" class="btn-type01" style="margin-left: 1rem;"><span>닫기</span></button>
					      </div>
					   </div>
					</td>
				</tr>
			</table>

		</div>

	<%@ include file="/WEB-INF/views/include/footer3.jsp" %>
	
	</div>
</div>
</body>
</html>