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
</style>
<script type="text/javascript" src="../resources/js/jquery.colorbox.js"></script>
<script type="text/javascript" src="../resources/js/colorBox.js"></script>
<script>
$(document).ready(function(){
	
	    
	//삭제버튼
	$("#btnDelete").on("click", function(){
		if(confirm("정말 삭제 하시겠습니까?") == true)
		{
			//정말 삭제하겠다고 했을 때, ajax 통신
			$.ajax({
				type:"POST",
				url:"/mng/fDelete",
				data:
				{
					bSeq: <c:out value="${wdFBoard.bSeq}" />
				},
				datatype:"JSON",
				beforeSend:function(xhr){
					xhr.setRequestHeader("AJAX", "true");
				},
				success:function(response){
					if(response.code == 0)
					{
						alert("게시물이 삭제되었습니다.");
						fn_colorbox_close(parent.fn_pageInit);
					}
					else if(response.code == 404)
					{
						alert("게시물을 찾을 수 없습니다.");
						fn_colorbox_close(parent.fn_pageInit);
					}
					else
					{
						alert("게시물 삭제 중 오류가 발생했습니다.");
					}
				},
				complete:function(data){
					icia.common.log(data);
				},
				error:function(xhr, status, error)
				{
					icia.common.error(error);
				}
			});
			
		}
	
	});
});
</script>
</head>
<body id="school_list" class="light-theme || dark-theme">

	<div class="container">
		<div class="row" style="padding: 60px 0;">
		
			
			<div class="col-lg-12">
			
				<table class="table">
					<thead>
						<tr class="dongdong2">
							<td style="width: 60%; padding-left: 25px; font-size: 18px; color: #222; font-weight: 600;">
								<c:out value="${wdFBoard.bTitle}" />
							</td>
							<td style="width: 40%; padding-right: 25px; color: #444; font-size: 16px; text-align: right;">
								${wdFBoard.regDate}</td>
						</tr>
						<tr style="height: 46px;">
							<td style="width: 60%; padding-left: 20px; font-size: 15px; color: #666;">
								<c:out value="${wdFBoard.userNickname}" />
							</td>
							<td style="width: 40%; padding-right: 20px; font-size: 15px; color: #666;"
								class="text-right">
									조회 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${wdFBoard.bReadCnt}" />
							</td>
						</tr>
					</thead>
					<tbody>

					<c:if test="${!empty wdFBoard.wdBoardFile}">
						<tr>
							<td colspan="2" style="text-align: center; padding-bottom: 10px; background:#efefef;">
								<!-- 첨부파일은 있을 때만 보여주면 됨 -->
									<div style="width: 100%; border:none; font-size: 14px; text-align: right; padding-right: 10px; padding-top: 10px;">
										<!-- GET방식으로 넘어감 --> 
										<a href="/board/fdownload?bSeq=${wdFBoard.wdBoardFile.bSeq}" style="color: #0080ff;">
											[첨부파일]&nbsp; ${wdFBoard.wdBoardFile.fileOrgName}
										</a>
									<div>
							</td>
						</tr>
					</c:if>
						<tr>
							<td colspan="2" style="text-align: center">	
								<div style="padding: 30px 20px; text-align: left; font-size: 16px;">
										<c:out value="${wdFBoard.bContent}" />
								</div>
							</td>
						</tr>
					</tbody>
					
					<tfoot>
						<tr>
							<td colspan="2">


									<button type="button" id="btnDelete" class="w-btn w-btn-green3" style="float: right; margin-right: 10px; margin-top: 20px; margin-bottom: 40px;">삭제</button>
			
							</td>
						</tr>
					</tfoot>
				</table>
			</div>

			

			</div>

		</div>
	</div>


	<form name="bbsForm" id="bbsForm" method="post">
		<input type="hidden" name="bSeq" value="${bSeq}" /> 
		<input type="hidden" name="searchType" value="${searchType}" /> 
		<input type="hidden" name="searchValue" value="${searchValue}" /> 
		<input type="hidden" name="curPage" value="${curPage}" />
	</form>

</body>
</html>