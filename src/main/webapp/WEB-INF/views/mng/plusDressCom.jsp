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
	$("#dresscomName").focus();
});

function fn_userUpdate()
{
	if(icia.common.isEmpty($("#dresscomName").val()))
	{
		alert("업체 이름을 입력해주세요");
		$("#dresscomName").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#dresscomlocation").val()))
	{
		alert("업체주소를 입력해주세요");
		$("#dresscomlocation").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#dresscomnumber").val()))
	{
		alert("업체 전화번호를 입력해주세요");
		$("#dresscomnumber").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#dresscomcontent").val()))
	{
		alert("업체 설명을 입력해주세요.");
		$("#dresscomcontent").focus();
		return;
	}
	
	//등록 취소
	if(!confirm("드레스 업체를 등록 하시겠습니까?"))
	{
		//NO
		return;
	}
	
	var formData = {
			dcName: $("#dresscomName").val(),
			dcLocation: $("#dresscomlocation").val(),
			dcNumber: $("#dresscomnumber").val(),
			dcContent: $("#dresscomcontent").val()
	};
	
	//ajax통신
	icia.ajax.post({
		url: "/mng/dressComWrite",
		data: formData,
		success: function(res)
		{
			icia.common.log(res);
			
			if(res.code == 0)
			{
				alert("업체등록이 완료되었습니다.");
				fn_colorbox_close(parent.fn_pageInit);
			}
			else if(res.code == -1)
			{
				alert("업체 등록 중 오류가 발생하였숩니다.");
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
   <h1 style="font-size: 1.6rem; margin-top: 3rem; margin-bottom: 1.6rem; padding: .5rem 0 .5rem 1rem; background-color: #e9e9ed;">드레스 업체 추가</h1>
   <div class="layer-cont">
      <form name="regForm" id="regForm" method="post">
         <table>
            <tbody>
               <tr>
                  <th scope="row">드레스 업체명</th>
                  <td>
                     <input type="text" style="background-color: #fff;" id="dresscomName" name="dresscomName" placeholder="드레스 업체명을 입력해주세요"/>
                  </td>
               </tr>
               <tr>
                  <th scope="row">드레스업체 주소</th>
                  <td>
                     <input type="text" style="background-color: #fff;" id="dresscomlocation" name="dresscomlocation" placeholder="드레스 업체주소를 입력해주세요"/>
                  </td>
               </tr>
               <tr>
                   <th scope="row">드레스업체 전화번호</th>
                  <td>
                     <input type="text" style="background-color: #fff;" id="dresscomnumber" name="dresscomnumber" placeholder="드레스 업체 번호를 입력해주세요"/>
                  </td>
               </tr>
               <tr>
                  <th scope="row">드레스업체 설명</th>
                  <td style="padding: 15px 15px 15px 9px;">
                  <textarea class="form-control" rows="3" name="dresscomcontent" id="dresscomcontent" style="ime-mode: active; resize: none; width:100%; float:left; height:76px; font-size:14px; padding:7px;" placeholder="업체설명을 입력해주세요" required></textarea>
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