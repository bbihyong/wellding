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
	$("#bTitle").focus();
});

function fn_nBoardUpdate()
{
	//내용확인
	if(icia.common.isEmpty($("#bTitle").val()))
	{
		alert("글 제목을 입력해주세요");
		$("#bTitle").focus();
		return;
	}
	
	if(icia.common.isEmpty($("#bContent").val()))
	{
		alert("글 내용을 입력해주세요");
		$("#bContent").focus();
		return;
	}
	
	//수정 취소
	if(!confirm("게시글을 수정하시겠습니까?"))
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
		url: "/mng/nBoardUpdateProc",
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
				alert("게시물이 수정되었습니다.");
				top.window.location.reload(true);
				fn_colorbox_close(parent.fn_pageInit);
			}
			else if(res.code == -1)
			{
				alert("게시물 수정 중 오류가 발생하였숩니다.");
			}
			else if(res.code == 400)
			{
				alert("파라미터 값이 잘못되었습니다.");
			}
			else if(res.code == 404)
			{
				alert("게시물이 존재하지 않습니다.");
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

function fn_nBoardDelete()
{
	if(confirm("정말 삭제하시겠습니까?") == true)
	{
		$.ajax({
			type: "POST",
			url: "/mng/nBoardDelete",
			data:{
				bSeq: <c:out value="${nBList.bSeq}" />
			},
			datatype: "JSON",
			success: function(response)
			{
				if(response.code == 0)
				{
					alert("게시물이 삭제되었습니다.");
					top.window.location.reload(true);
					fn_colorbox_close(parent.fn_pageInit);
				}
				else if(response.code == 400)
				{
					alert("파라미터값이 올바르지않습니다.");
				}
				else if(response.code == 404)
				{
					alert("게시물을 찾을 수 없습니다.");
					fn_colorbox_close();
				}
				else
				{
					alert("게시물 삭제 중 오류가 발생했습니다.");
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
			<div class="layerpopup" style="width:100%; margin:auto; margin-top:5%;">
				<h1 style="font-size: 1.6rem; margin-top: 3rem; margin-bottom: 1.6rem; padding: .5rem 0 .5rem 1rem; background-color: #e0e4fe; text-align: center;">공지사항 게시글 수정</h1>
			   <div class="layer-cont">
			      <form name="regForm" id="regForm" method="post">
			         <table>
			            <tbody>
			            	<tr>
			                  <th scope="row">글 번호</th>
			                  <td>
			                  	${nBList.bSeq}
			                     <input type="hidden" id="bSeq" name="bSeq" value="${nBList.bSeq}"/>
			                  </td>
			            	</tr>
			               <tr>
			                  <th scope="row">작성자</th>
			                  <td>
			                  	${nBList.adminId}
			                     <input type="hidden" id="adminId" name="adminId" value="${nBList.adminId}"/>
			                  </td>
			               </tr>
			               <tr>
			                  <th scope="row">제목</th>
			                  <td>
			                     <input type="text" style="background-color: #fff;" id="bTitle" name="bTitle" value="${nBList.bTitle}"/>
			                  </td>
			               </tr>
			               <tr>
			                   <th scope="row">내용</th>
			                  <td>
			                  	 <textarea class="form-control" rows="3" name="bContent" id="bContent"style="ime-mode: active; resize: none; width:100%; float:left; height:76px; font-size:14px;" required>${nBList.bContent}</textarea>
			                  </td>
			               </tr>
			               <tr>
			                  <th scope="row">등록일</th>
			                  <td>
			                  ${nBList.regDate}
			                  </td>
			               </tr>
			            </tbody>
			         </table>
			      </form>
			      <div class="pop-btn-area" style="float: right;">
			         <button onclick="fn_nBoardUpdate()" class="btn-type01"><span>수정</span></button>
			         <button onclick="fn_nBoardDelete()" class="btn-type01" style="margin-left: 1rem;"><span>삭제</span></button>
			         <button onclick="fn_colorbox_close()" id="colorboxClose" class="btn-type01" style="margin-left: 1rem;"><span>닫기</span></button>
			      </div>
			   </div>
			</div>
</div>

	<%@ include file="/WEB-INF/views/include/footer3.jsp" %>
</body>
</html>