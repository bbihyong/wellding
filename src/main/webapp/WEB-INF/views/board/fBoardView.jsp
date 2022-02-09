<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/include/head.jsp"%>
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
<script>
$(document).ready(function(){
	$("#btnList").on("click", function(){
		document.bbsForm.action = "/board/fBoard";
		document.bbsForm.submit();
	});
	
	
	<c:if test="${boardMe eq 'Y'}">
	$("#btnUpdate").on("click", function(){
		document.bbsForm.action = "/board/fUpdateForm";
		document.bbsForm.submit();
	});
/*	
	$("#btnDelete").on("click", function(){
		
		if(confirm("정말 삭제 하시겠습니까?") == true)
		{
			//정말 삭제하겠다고 했을 때, ajax 통신
			$.ajax({
				type:"POST",
				url:"/board/delete",
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
						location.href = "/board/fBoard";
					}
					else if(response.code == 400)
					{
						alert("로그인이 되어있지 않습니다.");
						//이동할 필요 없음
					}
					else if(response.code == 404)
					{
						alert("게시물을 찾을 수 없습니다.");
						location.href = "/board/fBoard";
					}
					else if(response.code == 405)
					{
						alert("사용자의 게시물이 아닙니다.");
						location.href = "/board/fBoard";
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
*/	
	$("#btnDelete").on("click", function(){
		Swal.fire({
			   title: '정말 삭제 하시겠습니까?',
			   text: '다시 되돌릴 수 없습니다. 신중하세요.',
			   icon: 'warning',
			   
			   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   
			   reverseButtons: false, // 버튼 순서 거꾸로
			   
			}).then(result => {
				   // 만약 Promise리턴을 받으면,
				   if (result.isConfirmed) 
				   { // 만약 모달창에서 confirm 버튼을 눌렀다면
						//정말 삭제하겠다고 했을 때, ajax 통신
						$.ajax({
							type:"POST",
							url:"/board/delete",
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
									//alert("게시물이 삭제되었습니다.");
									//location.href = "/board/fBoard";
									Swal.fire({ 
										icon: 'success',
										text: '게시물이 삭제되었습니다.'
									}).then(function(){
										location.href = "/board/fBoard";
									});
								}
								else if(response.code == 400)
								{
									//alert("로그인이 되어있지 않습니다.");
									//이동할 필요 없음
									Swal.fire({ 
										icon: 'error',
										text: '로그인이 되어있지 않습니다.'
									});
								}
								else if(response.code == 404)
								{
									//alert("게시물을 찾을 수 없습니다.");
									//location.href = "/board/fBoard";
									Swal.fire({ 
										icon: 'error',
										text: '게시물을 찾을 수 없습니다.'
									}).then(function(){
										location.href = "/board/fBoard";
									});
								}
								else if(response.code == 405)
								{
									//alert("사용자의 게시물이 아닙니다.");
									//location.href = "/board/fBoard";
									Swal.fire({ 
										icon: 'error',
										text: '사용자의 게시물이 아닙니다.'
									}).then(function(){
										location.href = "/board/fBoard";
									});
								}
								else
								{
									//alert("게시물 삭제 중 오류가 발생했습니다.");
									Swal.fire({ 
										icon: 'error',
										text: '게시물 삭제 중 오류가 발생했습니다.'
									});
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
				   else if (result.isDismissed) 
				   { // 만약 모달창에서 cancel 버튼을 눌렀다면
					   location.href = "/board/fBoard";
				   }
			});
	});
	</c:if>
	
	
    $("#btnComment").on("click",function(){
  	  
  	  $("#btnComment").prop("disabled", true);// 수정 버튼 비활성화 
  	  
  	  if($.trim($("#wdFBoardComment").val()).length <= 0){
  		 // alert("댓글내용을 입력하세요.");
			Swal.fire({ 
				icon: 'warning',
				text: '댓글내용을 입력하세요.'
			});
  		  $("#wdFBoardComment").val("");
  		  $("#wdFBoardComment").focus();
  		  $("#btnComment").prop("disabled", false);
  		  return;
  	  }
  	  
  	  var form = $("#commentForm")[0];
   	  var formData = new FormData(form);
   	 
  	  $.ajax({
	            type:"POST",
	            url:"/board/CommentProc",
	            data:formData,
	            processData:false,
	  			contentType:false,
	  		    cache:false,
	  		    timeout:600000,
	            beforeSend:function(xhr){
	               xhr.setRequestHeader("AJAX", "true");
	            },
	            success:function(response){
	               if(response.code == 0)
	               {
	                  //alert("댓글이 등록 되었습니다.");
	                  //document.bbsForm.action = "/board/fBoardView";
	                 // document.bbsForm.submit();
	                 // $("#btnComment").prop("disabled", false);
						Swal.fire({ 
							icon: 'success',
							text: '댓글이 등록되었습니다.'
						}).then(function(){
			                  document.bbsForm.action = "/board/fBoardView";
			                  document.bbsForm.submit();
			                  $("#btnComment").prop("disabled", false);
						});
	               }
	               else if(response.code == 400)
	               {
	                  //alert("파라미터 값이 올바르지 않습니다.");
	                  //$("#btnComment").prop("disabled", false);
						Swal.fire({ 
							icon: 'error',
							text: '파라미터 값이 올바르지 않습니다.'
						}).then(function(){
							$("#btnComment").prop("disabled", false);
						});
	               }
	               else if(response.code == 406)
	               {
	            	  //alert("로그인이 되어있지 않습니다."); 
						Swal.fire({ 
							icon: 'error',
							text: '로그인이 되어있지 않습니다.'
						}).then(function(){
							$("#btnComment").prop("disabled", false);
						});
	               }
	               else if(response.code == 404)
	               {
	                  //alert("게시물을 찾을수 없습니다.");
	                  //location.href = "/board/fBoard";
						Swal.fire({ 
							icon: 'error',
							text: '게시물을 찾을 수 없습니다.'
						}).then(function(){
							location.href = "/board/fBoard";
						});
	               }
	               else
	               {
	                  //alert("댓글 등록 중 오류가 발생했습니다.");
	                  //$("#btnComment").prop("disabled", false);
						Swal.fire({ 
							icon: 'error',
							text: '댓글 등록 중 오류가 발생했습니다.'
						}).then(function(){
							$("#btnComment").prop("disabled", false);
						});
	               }
	            },
	            complete:function(data){
	               icia.common.log(data);
	            },
	            error:function(xhr, status, error){
	               icia.common.error(error);
	            }
	         });
    });
    
});

function commentDelete(cSeq){
	
	document.commentForm.cSeq.value = cSeq;
	
	  var form = $("#commentForm")[0];
 	  var formData = new FormData(form);
 	 
	  $.ajax({
	            type:"POST",
	            url:"/board/commentDelete",
	            data:formData,
	            processData:false,
	  			contentType:false,
	  		    cache:false,
	  		    timeout:600000,
	            beforeSend:function(xhr){
	               xhr.setRequestHeader("AJAX", "true");
	            },
	            success:function(response){
	                if(response.code == 0)
	                {
	                   //alert("댓글이 삭제되었습니다.");
	                   //document.bbsForm.action = "/board/fBoardView";
		               //document.bbsForm.submit();
						Swal.fire({ 
							icon: 'success',
							text: '댓글이 삭제되었습니다.'
						}).then(function(){
			                  document.bbsForm.action = "/board/fBoardView";
			                  document.bbsForm.submit();
						});
	                }
	                else if(response.code == 400)
	                {
	                   //alert("로그인이 되어있지 않습니다.");
	                   //location.href = "/board/fBoard";
						Swal.fire({ 
							icon: 'error',
							text: '사용자의 게시물이 아닙니다.'
						}).then(function(){
							location.href = "/board/fBoard";
						});
	                }
	                else if(response.code == 404)
	                {
	                   //alert("댓글을 찾을 수 없습니다.");
	                   //location.href = "/board/fBoard";
						Swal.fire({ 
							icon: 'error',
							text: '사용자의 게시물이 아닙니다.'
						}).then(function(){
							location.href = "/board/fBoard";
						});
	                }
	                else
	                {
	                   //alert("댓글 삭제 중 오류가 발생했습니다.");
						Swal.fire({ 
							icon: 'error',
							text: '사용자의 게시물이 아닙니다.'
						}).then(function(){
							location.href = "/board/fBoard";
						});
	                }
	             },
	            complete:function(data){
	               icia.common.log(data);
	            },
	            error:function(xhr, status, error){
	               icia.common.error(error);
	            }
	         });
}

function commentUpdate(cSeq,tagId){


	
	if (!$("#updateComment").length > 0) 
	{
	    // textarea 추가
	    var nCareer = document.createElement("textarea");
	    nCareer.setAttribute("rows", 3);
	    nCareer.setAttribute("cols", 120);
	    nCareer.setAttribute("name", "updateComment");
	    nCareer.setAttribute("id", "updateComment");
	    nCareer.setAttribute("class", "form-control");
	    nCareer.setAttribute("style", "ime-mode:active;resize: none;");
	    nCareer.setAttribute("placeholder", "댓글을 입력해주세요");
	    document.getElementById(tagId).appendChild(nCareer)
	}
	else{
		  document.commentForm.cSeq.value = cSeq;
		  
	  	  if($.trim($("#updateComment").val()).length <= 0){
	  		  //alert("댓글내용을 입력하세요.");
			Swal.fire({ 
				icon: 'warning',
				text: '댓글내용을 입력하세요.'
			}).then(function(){
				$("#updateComment").val("");
		  		  $("#updateComment").focus();
		  		  return;
			});
	  		  
	  	  }
		  
	  	document.commentForm.upComment.value = $("#updateComment").val();
	  	  
		  var form = $("#commentForm")[0];
	 	  var formData = new FormData(form);
	 	 
		  $.ajax({
		            type:"POST",
		            url:"/board/commentUpdate",
		            data:formData,
		            processData:false,
		  			contentType:false,
		  		    cache:false,
		  		    timeout:600000,
		            beforeSend:function(xhr){
		               xhr.setRequestHeader("AJAX", "true");
		            },
		            success:function(response){
		                if(response.code == 0)
		                {
		                   //alert("댓글이 수정되었습니다.");
		                  // document.bbsForm.action = "/board/fBoardView";
			               //document.bbsForm.submit();
							Swal.fire({ 
								icon: 'success',
								text: '댓글이 수정되었습니다.'
							}).then(function(){
				                  document.bbsForm.action = "/board/fBoardView";
				                  document.bbsForm.submit();
							});
		                }
		                else if(response.code == 400)
		                {
		                   //alert("로그인이 되어있지 않습니다.");
		                   //document.bbsForm.action = "/board/fBoardView";
			               //document.bbsForm.submit();
		        			Swal.fire({ 
		        				icon: 'warning',
		        				text: '로그인이 되어있지 않습니다.'
		        			}).then(function(){
		        				document.bbsForm.action = "/board/fBoardView";
					            document.bbsForm.submit();
		        			});
		                }
		                else if(response.code == 404)
		                {
		                   //alert("댓글을 찾을 수 없습니다.");
		                   //document.bbsForm.action = "/board/fBoardView";
			               //document.bbsForm.submit();
		        			Swal.fire({ 
		        				icon: 'warning',
		        				text: '댓글을 찾을 수 없습니다.'
		        			}).then(function(){
		        				$("#updateComment").val("");
		        				document.bbsForm.action = "/board/fBoardView";
					            document.bbsForm.submit();
		        			});
		                }
		                else
		                {
		                   //alert("댓글 수정 중 오류가 발생했습니다.");
		                   //location.href = "/board/fBoard";
		        			Swal.fire({ 
		        				icon: 'warning',
		        				text: '댓글 수정 중 오류가 발생했습니다.'
		        			}).then(function(){
		        				location.href = "/board/fBoard";
		        			});
		                }
		             },
		            complete:function(data){
		               icia.common.log(data);
		            },
		            error:function(xhr, status, error){
		               icia.common.error(error);
		            }
		         });
	}
    
}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/navigation.jsp">
		<jsp:param name="userName" value="${wdUser.userNickname}" />
	</jsp:include>

	<div class="page-heading-rent-venue">
		<div class="container">
			<div class="row"></div>
		</div>
	</div>

	<h2 class="e_title">Know-How</h2>
	<p style="text-align: center; margin-bottom: 20px;">여러분들의 노하우를 공유해보세요</p>
	<br />

	<div class="container">
		<div class="row">
		
			
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
										<a href="/board/download?bSeq=${wdFBoard.wdBoardFile.bSeq}" style="color: #0080ff;">
											[첨부파일]&nbsp; ${wdFBoard.wdBoardFile.fileOrgName}
										</a>
									<div>
							</td>
						</tr>
					</c:if>
						<tr>
							<td colspan="2" style="text-align: center">	
								<div style="padding: 30px 20px; text-align: left; font-size: 16px;">
								<c:if test="${!empty wdFBoard.wdBoardFile}">
			                        <img src="../resources/upload/${wdFBoard.wdBoardFile.fileName }" style="width: 50%;" /> <br />
			                    </c:if>
										<c:out value="${wdFBoard.bContent}" />
								</div>
							</td>
						</tr>
					</tbody>

					<form name="commentForm" id="commentForm" method="post">
						<tbody>
							<tr>
								<td colspan="2" style="border-top:none; padding-bottom: 25px; padding-left:inherit; padding-right:inherit;">
									<textarea class="form-control" rows="3" name="wdFBoardComment" id="wdFBoardComment" style="ime-mode: active; resize: none; width:90%; float:left; height:76px; font-size:14px;" placeholder="댓글을 입력해주세요" required></textarea>
									<button type="button" id="btnComment" class="btn btn-secondary" style="float:left; width:100px; margin-left:5px; height: 76px; border: none; background: #ff957d; font-size:15px; font-weight:600;">댓글등록</button>
								</td>
							</tr>

							<!-- 댓글 내용이 들어갈 곳 -->
							<c:if test="${!empty commentList}">
								<c:forEach items="${commentList}" var="comment">
									<tr class="comment_tr">
										<td class="comment_td2" style="border-top:none;">${comment.wdFBoardComment }</td>
									</tr>
									<tr class="comment_tr2">
										<td class="comment_td" style="border-top:none; border-right:2px solid #ccc; /*padding-right:10px;*/ font-weight:600; line-height: 0px;">${comment.uNickName }</td>
										<td class="comment_td" style="border-top:none; margin-left: 10px; letter-spacing:0.5px; line-height: 0px;">${comment.regDate }</td>

										<td style="border-top:none; position:relative; top: -15px; right:5px;">
											<c:if test="${cookieUserId eq comment.userId }">
												<button type="button" class="btn btn-secondary btnCommentD" onclick="commentDelete(${comment.commentSeq})" style="margin-rignt:10px;">삭제</button>
												<button type="button" class="btn btn-secondary btnCommentU" onclick="commentUpdate(${comment.commentSeq},'update${comment.commentSeq }')">수정</button>
											</c:if>
										</td>
									</tr>
									<tr>
										<td id="update${comment.commentSeq }" colspan="2" style="border-top:none; padding-top:0px; padding-bottom:0px;"></td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
						<input type="hidden" name="bSeq" value="${bSeq}" /> <input
							type="hidden" name="cSeq" value="" /> <input type="hidden"
							name="upComment" value="" /> <input type="hidden"
							name="searchType" value="${searchType}" /> <input type="hidden"
							name="searchValue" value="${searchValue}" /> <input
							type="hidden" name="curPage" value="${curPage}" />
					</form>
					<tfoot>
						<tr>
							<td colspan="2">

								<button type="button" id="btnList" class="w-btn w-btn-green2" style="float: right; margin: 20px 0 40px;">리스트</button>
								<c:if test="${boardMe eq 'Y'}">
									<button type="button" id="btnDelete" class="w-btn w-btn-green3" style="float: right; margin-right: 10px; margin-top: 20px; margin-bottom: 40px;">삭제</button>
								</c:if>
								<c:if test="${boardMe eq 'Y'}">
									<button type="button" id="btnUpdate" class="w-btn w-btn-green" style="margin-right: 10px; margin-top: 20px; margin-bottom: 40px;">수정</button>
								</c:if>
								
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

	<!-- *** 욱채수정Footer 시작 *** -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<!-- *** 욱채수정Footer 종료 *** -->
</body>
</html>