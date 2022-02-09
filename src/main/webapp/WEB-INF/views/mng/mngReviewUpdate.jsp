<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/include/head2.jsp"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap"
	rel="stylesheet">
<style>
.Wtitle {
	font-family: 'Gamja Flower', cursive;
	font-size: 64px;
	text-align: center;
}

/*별점 시작*/
span.star-prototype, span.star-prototype > * {
    height: 35px; 
    /*background: url(http://i.imgur.com/YsyS5y8.png) 0 -16px repeat-x;*/
    background: url(../resources/images/star1234.png) 0 -35px repeat-x;
    width: 170px;
    display: inline-block;
}
 
span.star-prototype > * {
    background-position: 0 0;
    max-width:170px;
}
/*별점 끝*/
</style>
<script>
$(document).ready(function(){
	//별점
	$.fn.generateStars = function() {
	    return this.each(function(i,e){$(e).html($('<span/>').width($(e).text()*34));});
	};
	
	// 숫자 평점을 별로 변환하도록 호출하는 함수
	$('.star-prototype').generateStars();
	//별점
	
	$("#reviewDel").on("click",function(){
		//등록 취소
		if(!confirm("해당 리뷰를 삭제 하시겠습니까?"))
		{
			//NO
			return;
		}
		
		
		//ajax통신
		icia.ajax.post({
			url: "/mng/reviewDelete",
			data: {
				RSeq : $("#RSeq").val()
			},
			success: function(res)
			{
				icia.common.log(res);
				
				if(res.code == 0)
				{
					alert("게시글 삭제가 완료되었습니다.");
					fn_colorbox_close(parent.fn_pageInit);
				}
				else if(res.code == -1)
				{
					alert("게시글 삭제 중 오류가 발생하였숩니다.");
				}
				else if(res.code == 400)
				{
					alert("파라미터 값이 잘못되었습니다.");
				}
				else
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
	});	
	    
});

</script>
</head>
<body id="school_list" class="light-theme || dark-theme">

	<div class="container" style="padding:100px 0px;">
		   <div class="row" style="margin-right:0; margin-left:0;">
		   	  <div class="col-lg-12">
		      <table class="table">
		         <thead>
		            <tr class="table-active dongdong">
		               <td style="width:60%">
		                  <c:out value="${wdReview.RTitle}"/>
		               </td>
		               <td style="width:40%" class="text-right">
		                                         조회 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${wdReview.RReadCnt}" />
		               </td>
		            </tr>
		            <tr>
		               <td style="width:60%">
		               	작성자 : <c:out value="${wdReview.UNickName}"/>
		               </td>
		               <td style="width:40%" class="text-right">
		                  <div>${wdReview.regDate}</div>
		               </td>
		            </tr>   
		
		         </thead>
		         <tbody>
		             <tr>
		             <!-- 첨부파일 다운 안해요 -->
		            </tr>
		            <tr>
		               <td colspan="2">
			               <div style="padding:10px">
			               	<div>
			               	<c:if test="${!empty wdReview.reviewFile}">
			               	<img src="../resources/upload/${wdReview.reviewFile.rFileName }">
			               	<br>
			               	</c:if>
			               		<c:out value="${wdReview.RContent}" />
			               	</div>
			               </div>
		               </td>
		            </tr>
		         </tbody>
		         <tfoot style="width: 100%;">
		         <tr>
		         <td colspan="2" width="100%">
		         <!-- 별점은 여기에  -->
		         	평가 : <span class="star-prototype">${wdReview.RScore }</span>
		         </td>
		         </tr>   
		         <tr>
		         	  <td colspan="2" style="text-align: right;">
		         	 	<div class="main-dark-button btn_go wookhall" style="display: inline-block; margin-top: 0; margin-right:20px;">
                              <a href="javascript:void(0)" id="reviewDel">삭제</a>
                     	</div>
                     </td>
                 </tr>
		         </tfoot>
		      </table>
		      </div>
		   </div>
		</div>

	<form name="bbsForm" id="bbsForm" method="post">
		<input type="hidden" name="RSeq" id="RSeq" value="${wdReview.RSeq}" /> 
	</form>

</body>
</html>