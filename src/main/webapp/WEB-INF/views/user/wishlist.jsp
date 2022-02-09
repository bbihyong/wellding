<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en">

<head>
       <%@ include file="/WEB-INF/views/include/head.jsp" %>
       <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Bitter:ital@0;1&family=The+Nautigal&display=swap" rel="stylesheet">
<script>
    $(document).ready(function(){

       //결혼예정일 수정하기
       $("#btnMarry").on("click",function(){
        
         $.ajax({
           type:"POST",
           url:"/user/marryUpdate",
           data:
           {
              year: $("#year").val(),
              month:$("#month").val(),
              day: $("#day").val(),
               rezNo: $("#rezNo").val(),
                 wdUser: $("#dongdong").val()
           },
           datatype:"JSON",
           beforeSend:function(xhr){
              xhr.setRequestHeader("AJAX", "true");
           },
           success:function(response){
              if(response.code == 0)
              {       
                 Swal.fire({ 
                      icon: 'warning',
                      text: '결혼 예정일자가 수정되었습니다.'
                   }).then(function(){
                      return;
                   });
              }
              else if(response.code == 500)
              {
                 //alert("날짜가 제대로 입력되지 않았습니다.");
                 //return;
                  Swal.fire({ 
                      icon: 'warning',
                      text: '날짜가 제대로 입력되지 않았습니다.'
                   }).then(function(){
                      return;
                   });
              }
              else if(response.code == -1){
                // alert("오류가 발생했습니다.");
                 //return;
                  Swal.fire({ 
                      icon: 'warning',
                      text: '오류가 발생했습니다.'
                   }).then(function(){
                      return;
                   });
              }
              else
              {
                 ///alert("오류가 발생했습니다.");
                  Swal.fire({ 
                      icon: 'warning',
                      text: '오류가 발생했습니다.'
                   }).then(function(){
                      return;
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
      });

//장바구니에서 홀 삭제
<c:if test="${!empty wdRez.whCode}">
 /*      $("#delBtnWishH").on("click", function(){
          if(confirm("정말 장바구니에서 해당 상품을 삭제하시겠습니까?"))
          {
             //ajax통신 시작
             $.ajax({
            type:"POST",
            url:"/user/updateHproc",
            data:
            {
               rezNo: <c:out value="${wdRez.rezNo}" />
            },
            datatype:"JSON",
            beforeSend:function(xhr){
               xhr.setRequestHeader("AJAX", "true");
            },
            success:function(response){
               if(response.code == 0)
               {
                  alert("장바구니에서 해당 상품을 제거했습니다.");
                  //업데이트가 성공하면 해당 tr 삭제
                   $("#wishH").remove();
                   location.href = "/user/wishlist";
                  
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
             //ajax통신 종료
          }
      });*/
      
      $("#delBtnWishH").on("click", function(){
  		Swal.fire({
			   text: '정말 장바구니에서 해당 상품을 삭제하시겠습니까?',
			   icon: 'success',
			   
			   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			   confirmButtonColor: '#d33', // confrim 버튼 색깔 지정
			   cancelButtonColor: '#3085d6', // cancel 버튼 색깔 지정
			   confirmButtonText: '삭제', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   
			   reverseButtons: false, // 버튼 순서 거꾸로
			   
			}).then(result => {
				   // 만약 Promise리턴을 받으면,
				   if (result.isConfirmed) 
				   { // 만약 모달창에서 confirm 버튼을 눌렀다면
			             //ajax통신 시작
			             $.ajax({
			            type:"POST",
			            url:"/user/updateHproc",
			            data:
			            {
			               rezNo: <c:out value="${wdRez.rezNo}" />
			            },
			            datatype:"JSON",
			            beforeSend:function(xhr){
			               xhr.setRequestHeader("AJAX", "true");
			            },
			            success:function(response){
			               if(response.code == 0)
			               {			                  
								Swal.fire({ 
									icon: 'success',
									text: '장바구니에서 해당 상품을 제거했습니다.'
								}).then(function(){
									//업데이트가 성공하면 해당 tr 삭제
					                   $("#wishH").remove();
					                   location.href = "/user/wishlist";
								});
			               }
			               else
			               {
			                  //alert("게시물 삭제 중 오류가 발생했습니다.");
								Swal.fire({ 
									icon: 'error',
									text: '게시물 삭제 중 오류가 발생했습니다.'
								}).then(function(){
									//업데이트가 성공하면 해당 tr 삭제
					                   return;
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
			             //ajax통신 종료
				   }
				   else if (result.isDismissed) 
				   { // 만약 모달창에서 cancel 버튼을 눌렀다면
						return;
				   }
				   
			});
      });
      
       //삭제버튼 클릭 종료
</c:if>
//장바구니에서 홀 삭제

//장바구니에서 스튜디오 삭제
<c:if test="${!empty wdRez.sCode}">
      /* $("#delBtnWishS").on("click", function(){
          if(confirm("정말 장바구니에서 해당 상품을 삭제하시겠습니까?"))
          {
             //ajax통신 시작
             $.ajax({
            type:"POST",
            url:"/user/updateSproc",
            data:
            {
               rezNo: <c:out value="${wdRez.rezNo}" />
            },
            datatype:"JSON",
            beforeSend:function(xhr){
               xhr.setRequestHeader("AJAX", "true");
            },
            success:function(response){
               if(response.code == 0)
               {
                  alert("장바구니에서 해당 상품을 제거했습니다.");
                  //업데이트가 성공하면 해당 tr 삭제
                   $("#wishS").remove();
                   location.href = "/user/wishlist";
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
             //ajax통신 종료
          }
      });*/
       
       $("#delBtnWishS").on("click", function(){
     		Swal.fire({
 			   text: '정말 장바구니에서 해당 상품을 삭제하시겠습니까?',
 			   icon: 'success',
 			   
 			   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
 			   confirmButtonColor: '#d33', // confrim 버튼 색깔 지정
 			   cancelButtonColor: '#3085d6', // cancel 버튼 색깔 지정
 			   confirmButtonText: '삭제', // confirm 버튼 텍스트 지정
 			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
 			   
 			   reverseButtons: false, // 버튼 순서 거꾸로
 			   
 			}).then(result => {
 				   // 만약 Promise리턴을 받으면,
 				   if (result.isConfirmed) 
 				   { // 만약 모달창에서 confirm 버튼을 눌렀다면
 			             //ajax통신 시작
				           $.ajax({
				          type:"POST",
				          url:"/user/updateSproc",
				          data:
				          {
				             rezNo: <c:out value="${wdRez.rezNo}" />
				          },
				          datatype:"JSON",
				          beforeSend:function(xhr){
				             xhr.setRequestHeader("AJAX", "true");
				          },
 			            success:function(response){
 			               if(response.code == 0)
 			               {			                  
 								Swal.fire({ 
 									icon: 'success',
 									text: '장바구니에서 해당 상품을 제거했습니다.'
 								}).then(function(){
 									//업데이트가 성공하면 해당 tr 삭제
 									 $("#wishS").remove();
 					                   location.href = "/user/wishlist";
 								});
 			               }
 			               else
 			               {
 			                  //alert("게시물 삭제 중 오류가 발생했습니다.");
 								Swal.fire({ 
 									icon: 'error',
 									text: '게시물 삭제 중 오류가 발생했습니다.'
 								}).then(function(){
 									//업데이트가 성공하면 해당 tr 삭제
 					                   return;
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
 			             //ajax통신 종료
 				   }
 				   else if (result.isDismissed) 
 				   { // 만약 모달창에서 cancel 버튼을 눌렀다면
 						return;
 				   }
 				   
 			});
       });
       //삭제버튼 클릭 종료
</c:if>
//장바구니에서 스튜디오 삭제 종료


//장바구니에서 드레스 삭제
<c:if test="${!empty wdRez.dNo}">
      /*$("#delBtnWishD").on("click", function(){
          if(confirm("정말 장바구니에서 해당 상품을 삭제하시겠습니까?"))
          {
             //ajax통신 시작
             $.ajax({
            type:"POST",
            url:"/user/updateDproc",
            data:
            {
               rezNo: <c:out value="${wdRez.rezNo}" />
            },
            datatype:"JSON",
            beforeSend:function(xhr){
               xhr.setRequestHeader("AJAX", "true");
            },
            success:function(response){
               if(response.code == 0)
               {
                  alert("장바구니에서 해당 상품을 제거했습니다.");
                  //업데이트가 성공하면 해당 tr 삭제
                   $("#wishD").remove();
                   location.href = "/user/wishlist";
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
             //ajax통신 종료
          }
      });*/
      
      $("#delBtnWishD").on("click", function(){
   		Swal.fire({
			   text: '정말 장바구니에서 해당 상품을 삭제하시겠습니까?',
			   icon: 'success',
			   
			   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			   confirmButtonColor: '#d33', // confrim 버튼 색깔 지정
			   cancelButtonColor: '#3085d6', // cancel 버튼 색깔 지정
			   confirmButtonText: '삭제', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   
			   reverseButtons: false, // 버튼 순서 거꾸로
			   
			}).then(result => {
				   // 만약 Promise리턴을 받으면,
				   if (result.isConfirmed) 
				   { // 만약 모달창에서 confirm 버튼을 눌렀다면
			             //ajax통신 시작
			             $.ajax({
			            type:"POST",
			            url:"/user/updateDproc",
			            data:
			            {
			               rezNo: <c:out value="${wdRez.rezNo}" />
			            },
			            datatype:"JSON",
			            beforeSend:function(xhr){
			               xhr.setRequestHeader("AJAX", "true");
			            },
			            success:function(response){
			               if(response.code == 0)
			               {			                  
								Swal.fire({ 
									icon: 'success',
									text: '장바구니에서 해당 상품을 제거했습니다.'
								}).then(function(){
									//업데이트가 성공하면 해당 tr 삭제
									$("#wishD").remove();
					                   location.href = "/user/wishlist";
								});
			               }
			               else
			               {
			                  //alert("게시물 삭제 중 오류가 발생했습니다.");
								Swal.fire({ 
									icon: 'error',
									text: '게시물 삭제 중 오류가 발생했습니다.'
								}).then(function(){
									//업데이트가 성공하면 해당 tr 삭제
					                   return;
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
			             //ajax통신 종료
				   }
				   else if (result.isDismissed) 
				   { // 만약 모달창에서 cancel 버튼을 눌렀다면
						return;
				   }
				   
			});
     });
       //삭제버튼 클릭 종료
</c:if>
//장바구니에서 드레스 삭제 종료

//장바구니에서 메이크업 삭제
<c:if test="${!empty wdRez.mCode}">
       /*$("#delBtnWishM").on("click", function(){
          if(confirm("정말 장바구니에서 해당 상품을 삭제하시겠습니까?"))
          {
             //ajax통신 시작
             $.ajax({
            type:"POST",
            url:"/user/updateMproc",
            data:
            {
               rezNo: <c:out value="${wdRez.rezNo}" />
            },
            datatype:"JSON",
            beforeSend:function(xhr){
               xhr.setRequestHeader("AJAX", "true");
            },
            success:function(response){
               if(response.code == 0)
               {
                  alert("장바구니에서 해당 상품을 제거했습니다.");
                  //업데이트가 성공하면 해당 tr 삭제
                   $("#wishM").remove();
                  location.href = "/user/wishlist";
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
             //ajax통신 종료
          }
      });*/
      
      $("#delBtnWishM").on("click", function(){
     		Swal.fire({
  			   text: '정말 장바구니에서 해당 상품을 삭제하시겠습니까?',
  			   icon: 'success',
  			   
  			   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
  			   confirmButtonColor: '#d33', // confrim 버튼 색깔 지정
  			   cancelButtonColor: '#3085d6', // cancel 버튼 색깔 지정
  			   confirmButtonText: '삭제', // confirm 버튼 텍스트 지정
  			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
  			   
  			   reverseButtons: false, // 버튼 순서 거꾸로
  			   
  			}).then(result => {
  				   // 만약 Promise리턴을 받으면,
  				   if (result.isConfirmed) 
  				   { // 만약 모달창에서 confirm 버튼을 눌렀다면
  			             //ajax통신 시작
			             $.ajax({
			            type:"POST",
			            url:"/user/updateMproc",
			            data:
			            {
			               rezNo: <c:out value="${wdRez.rezNo}" />
			            },
			            datatype:"JSON",
			            beforeSend:function(xhr){
			               xhr.setRequestHeader("AJAX", "true");
			            },
  			            success:function(response){
  			               if(response.code == 0)
  			               {			                  
  								Swal.fire({ 
  									icon: 'success',
  									text: '장바구니에서 해당 상품을 제거했습니다.'
  								}).then(function(){
  									//업데이트가 성공하면 해당 tr 삭제
  									$("#wishM").remove();
  				                  	location.href = "/user/wishlist";
  								});
  			               }
  			               else
  			               {
  			                  //alert("게시물 삭제 중 오류가 발생했습니다.");
  								Swal.fire({ 
  									icon: 'error',
  									text: '게시물 삭제 중 오류가 발생했습니다.'
  								}).then(function(){
  									//업데이트가 성공하면 해당 tr 삭제
  					                   return;
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
  			             //ajax통신 종료
  				   }
  				   else if (result.isDismissed) 
  				   { // 만약 모달창에서 cancel 버튼을 눌렀다면
  						return;
  				   }
  				   
  			});
       });
       //삭제버튼 클릭 종료
</c:if>
//장바구니에서 메이크업 삭제 종료

$("#cou").on("click",function(){
    var option="width = 1000, height = 500, top = 100, left = 200, location = no, menubar = no, scrollbars=no";
    window.open("/board/Coupon", "PopUP", option); 
});    

$("#payMent").on("click", function(){
	
	var today = new Date();   
	
	var year = today.getFullYear(); // 년도
	var month = today.getMonth() + 1;  // 월
	var date = today.getDate();  // 날짜
	
	month = "0"+month;	
	today = year + month + date;
	
	var wyear = $("#year").val();
	var wmonth = $("#month").val();
	var wdate = $("#day").val();
	
	var wdate = wyear + wmonth + wdate;
	
	today = Number(today);
	wdate = Number(wdate);
	
	if(wdate < today)
	{
		Swal.fire({ 
			icon: 'warning',
			text: '결혼날짜를 다시 확인해주세요.'
		}).then(function(){
			return;
		});
		return;
	}
	
   document.rezForm.action = "/user/payMent";
   document.rezForm.submit();
});
       
    });
    
    function fn_view1(whCode, hCode)
    {
      document.rezForm.WHCode.value = whCode; 
       document.rezForm.HCode.value = hCode;
       document.rezForm.action = "/hsdm/HallView";  
       document.rezForm.submit();
    } 
    function fn_view2(sCode)
    {
       document.rezForm.sCode.value = sCode; 
       document.rezForm.action = "/hsdm/studioView";
       document.rezForm.submit();
    }
    function fn_view3(dNo)
    {
       document.rezForm.dNo.value = dNo;
       document.rezForm.action = "/hsdm/dressView";
       document.rezForm.submit();
    }
    function fn_view4(mCode)
    {
       document.rezForm.mCode.value = mCode; 
       document.rezForm.action = "/hsdm/makeupView";   
       document.rezForm.submit();
    }
       
</script>
</head>
    
<body>
    <jsp:include page="/WEB-INF/views/include/navigation.jsp" >
    <jsp:param name="userName" value="${wdUser.userNickname}" />
    </jsp:include>
    
    <div class="page-heading-rent-venue2">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                </div>
            </div>
        </div>
    </div>
    
   <div class="container-fluid">
      <div class="row">
         <div class="col-lg-12 bcline">
            
            <div class="row">
               <div class="col-lg-1">
               </div>
               <div class="col-lg-10">
                  <h2 style="font-family: 'Bitter', serif; margin-top: 50px; padding-left: 10px;">Shopping Basket</h2>
                  <nav class="bcItem">
                     <ol class="breadcrumb bc" >
                        <li class="breadcrumb-item active">
                           <h5>장바구니</h5>
                        </li>
                        <li style="position: absolute; right:50px;">
                           <div>보유 포인트 : <span style="color:red;"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdUser.userPoint}" /></span> Point
                           </div>
                        </li>
                     </ol>
                  </nav>
                  
               </div>
               <div class="col-lg-1">
               </div>
               
               <!-- 다음 라인 -->
               <div class="col-lg-1">
               
               </div>
               <!-- 경계선 및 내용 -->
               <div class="col-lg-10 lineListMypage">
               
                  
                        <table class="table tableWish">
                     <tr>
                        <div class="rez_sta">
                           <h5 class="rez_date">결혼예정일자 &nbsp;&nbsp; 
                           <!-- 달력 넣기 -->
                           
                           
                           <span>
                                 <select id="year" class="year">
                                    <option value="">년도</option>
                                    <option value="2022" <c:if test="${year eq '2022'}">selected</c:if>>2022</option>
                                    <option value="2023" <c:if test="${year eq '2023'}">selected</c:if>>2023</option>
                                 </select>
                                        
                                 <select id="month" class="month">
                                    <option value="">월</option>
                                    <option value="01" <c:if test="${month eq '01'}">selected</c:if>>1</option>
                                    <option value="02" <c:if test="${month eq '02'}">selected</c:if>>2</option>
                                    <option value="03" <c:if test="${month eq '03'}">selected</c:if>>3</option>
                                    <option value="04" <c:if test="${month eq '04'}">selected</c:if>>4</option>
                                    <option value="05" <c:if test="${month eq '05'}">selected</c:if>>5</option>
                                    <option value="06" <c:if test="${month eq '06'}">selected</c:if>>6</option>
                                    <option value="07" <c:if test="${month eq '07'}">selected</c:if>>7</option>
                                    <option value="08" <c:if test="${month eq '08'}">selected</c:if>>8</option>
                                    <option value="09" <c:if test="${month eq '09'}">selected</c:if>>9</option>
                                    <option value="10" <c:if test="${month eq '10'}">selected</c:if>>10</option>
                                    <option value="11" <c:if test="${month eq '11'}">selected</c:if>>11</option>
                                    <option value="12" <c:if test="${month eq '12'}">selected</c:if>>12</option>
                                 </select>
                                        
                                 <select id="day" class="day">
                                    <option value="">일</option>
                                    <option value="01" <c:if test="${day eq '01'}">selected</c:if>>1</option>
                                    <option value="02" <c:if test="${day eq '02'}">selected</c:if>>2</option>
                                    <option value="03" <c:if test="${day eq '03'}">selected</c:if>>3</option>
                                    <option value="04" <c:if test="${day eq '04'}">selected</c:if>>4</option>
                                    <option value="05" <c:if test="${day eq '05'}">selected</c:if>>5</option>
                                    <option value="06" <c:if test="${day eq '06'}">selected</c:if>>6</option>
                                    <option value="07" <c:if test="${day eq '07'}">selected</c:if>>7</option>
                                    <option value="08" <c:if test="${day eq '08'}">selected</c:if>>8</option>
                                    <option value="09" <c:if test="${day eq '09'}">selected</c:if>>9</option>
                                    <option value="10" <c:if test="${day eq '10'}">selected</c:if>>10</option>
                                    <option value="11" <c:if test="${day eq '11'}">selected</c:if>>11</option>
                                    <option value="12" <c:if test="${day eq '12'}">selected</c:if>>12</option>
                                    <option value="13" <c:if test="${day eq '13'}">selected</c:if>>13</option>
                                    <option value="14" <c:if test="${day eq '14'}">selected</c:if>>14</option>
                                    <option value="15" <c:if test="${day eq '15'}">selected</c:if>>15</option>
                                    <option value="16" <c:if test="${day eq '16'}">selected</c:if>>16</option>
                                    <option value="17" <c:if test="${day eq '17'}">selected</c:if>>17</option>
                                    <option value="18" <c:if test="${day eq '18'}">selected</c:if>>18</option>
                                    <option value="19" <c:if test="${day eq '19'}">selected</c:if>>19</option>
                                    <option value="20" <c:if test="${day eq '20'}">selected</c:if>>20</option>
                                    <option value="21" <c:if test="${day eq '21'}">selected</c:if>>21</option>
                                    <option value="22" <c:if test="${day eq '22'}">selected</c:if>>22</option>
                                    <option value="23" <c:if test="${day eq '23'}">selected</c:if>>23</option>
                                    <option value="24" <c:if test="${day eq '24'}">selected</c:if>>24</option>
                                    <option value="25" <c:if test="${day eq '25'}">selected</c:if>>25</option>
                                    <option value="26" <c:if test="${day eq '26'}">selected</c:if>>26</option>
                                    <option value="27" <c:if test="${day eq '27'}">selected</c:if>>27</option>
                                    <option value="28" <c:if test="${day eq '28'}">selected</c:if>>28</option>
                                    <option value="29" <c:if test="${day eq '29'}">selected</c:if>>29</option>
                                    <option value="30" <c:if test="${day eq '30'}">selected</c:if>>30</option>
                                    <option value="31" <c:if test="${day eq '31'}">selected</c:if>>31</option>
                                 </select>
                                        </span>
                           <input type="button" id="btnMarry" name="btnMarry" value="변경" style="border: solid 1px black; background:white; position:relative; color:black; height:25px;">
                           </h5>
                           <!-- 달력 넣기 끝 -->
<c:choose>
   <c:when test="${!empty wdRez.whCode or wdRez.whCode !='' or !empty wdRez.sCode or wdRez.sCode !='' or !empty wdRez.dNo or wdRez.dNo !='' or !empty wdRez.mCode or wdRez.mCode !=''}">
                           <h5 class="rez_number">예약번호&nbsp;&nbsp; <span>${wdRez.rezNo}</span></h5>
   </c:when>
   <c:otherwise>
                           <h5 class="rez_number">예약번호&nbsp;&nbsp; <span></span></h5>
   </c:otherwise>
</c:choose>
                        </div>
                     </tr>
                     
                            <tr style="border-top: 3px solid #444;">
                                <th>이미지</th>
                                <th>상품정보</th>
                                <th>참고사항</th>
                                <th>총가격</th>
                                <th>삭제</th>
                            </tr>
                        
<c:if test="${!empty wdRez}">
                            <!-- 홀 -->
<c:if test="${!empty wdRez.whCode}">
                            
                            <tr id="wishH">
                                <td class="image-prod">
                                   <div class="imgbox" onclick="fn_view1('${wdRez.whCode}','${wdRez.hCode}')">
                                      <img src="../resources/images/hallrepimage/${wdRez.hImgName}" id="prod" class="wishImg">
                                   </div>
                                </td>
                                
                                <td class="product-name alignleft" style="width: 18%;">
                             <p class="my_hall"><c:out value="${wdRez.whName}" /></p>
                             <p><h4>&nbsp;<c:out value="${wdRez.hName}" /></h4></p>
                             <!-- 주소 넣어야 할까유?? ㄴㄴㄴㄴ무쓸모 -->
                          </td>
                                
                                <td class="HpriceTd alignleft">
                                   <p class="Hpc">홀대관비&nbsp; <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hPrice *(1- wdRez.hDiscount*0.01)}" />원
                                   &nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;식비&nbsp; <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hFood * wdRez.hMin}" />원</p>
                                   <p class="sangsaeP">
                                      <span class="chamgo">
                                         대관료할인: <span id="discountSpan">${wdRez.hDiscount}%</span> &nbsp;&nbsp;</span>
                                         <span id="xPrice"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hPrice}" />원 </span>&nbsp;&nbsp;
                                         <span id="nPrice"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hPrice *(1- wdRez.hDiscount*0.01)}" />원</span>
                                      
                                   </p>   
                                   <p class="sangsaeP">
                                      <span class="chamgo">                                        
                                         1인당 식비: <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hFood}" />원 x ${wdRez.hMin}명 = <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hFood * wdRez.hMin}" />원
                                      </span>
                                   </p>
                                </td>
                                

                                <td class="HpriceTotal" id="hollprice">
                                   <h4>
                                      <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hPrice *(1- wdRez.hDiscount*0.01) + (wdRez.hFood * wdRez.hMin)}" />원
                                   </h4>
                                </td>
                                
                                <td style="width: 5%;">
                                    <input type="button" value="x" class="w-btn-red delBtnWish" id="delBtnWishH">
                                </td>
                            </tr>
</c:if>
                            <!-- 스 -->
<c:if test="${!empty wdRez.sCode}">
                         
                            <tr id="wishS">
                                <td class="image-prod">
                                   <div class="imgbox"  onclick="fn_view2('${wdRez.sCode}')">
                                      <img src="../resources/images/studio/${wdRez.sImgName}" id="prod" class="wishImg">
                                   </div>
                                </td>
                                
                                <td class="product-name alignleft">
                             <p><h4>&nbsp;<c:out value="${wdRez.sName}" /></h4></p>
                             <!-- 주소 넣어야 할까유?? ㄴㄴ필요없을듯-->
                          </td>
                                
                                <td class="HpriceTd alignleft">
                                   <p class="Spc">스튜디오 예약일자 &nbsp<span style="font-weight:700; color: #333;"><c:out value="${wdRez.sDate}"/></span></p>
                                   <p class="sangsaeP">
                                      <span class="chamgo">
                                         할인: <span id="discountSpan">${wdRez.sDiscount}%</span> &nbsp;&nbsp;</span>
                                         <span id="xPrice"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.sPrice}" />원 </span>&nbsp;&nbsp;
                                         <span id="nPrice"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.sPrice *(1- wdRez.sDiscount*0.01)}" />원</span>
                                      
                                   </p>
                                   <p><span class="chamgo">
                                      예약일 변경 시 스튜디오와 직접 상의하시면 더 빠르게 처리가 가능합니다.
                                   </span></p>
                                </td>
                                
                                <td class="HpriceTotal" style="width: 18%;">
                                   <h4>
                                      <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.sPrice *(1- wdRez.sDiscount*0.01)}" />원
                                   </h4>
                                </td>
                                
                                <td>
                                    <input type="button" value="x" class="w-btn-red delBtnWish" id="delBtnWishS">
                                </td>
                            </tr>
</c:if>

                            <!-- 드 -->
<c:if test="${!empty wdRez.dNo}">
                            <tr id="wishD">
                                <td class="image-prod">
                                   <div class="imgbox" onclick="fn_view3('${wdRez.dNo}')">
                                      <img src="../resources/images/dress/${wdRez.dImgName}" id="prod" class="wishImg">
                                   </div>
                                </td>
                                
                                <td class="product-name alignleft">
                                   <p class="my_hall"><c:out value="${wdRez.dcName}" /></p>
                             <p><h4>&nbsp;<c:out value="${wdRez.dName}" /></h4></p>
                             <!-- 주소 넣어야 할까유?? -->
                          </td>
                                
                                <td class="HpriceTd alignleft">
                                   <p class="Dpc Hpc"><c:out value="${wdRez.dContent}" /></p>
                                                                      <p class="sangsaeP">
                                   <span class="chamgo">
                                      할인: <span id="discountSpan">${wdRez.dDiscount}%</span> &nbsp;&nbsp;</span>
                                      <span id="xPrice"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.dPrice}" />원 </span>&nbsp;&nbsp;
                                      <span id="nPrice"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.dPrice *(1- wdRez.dDiscount*0.01)}" />원</span>   
                                   </p>
                                   <p><span class="chamgo">
                                   </span></p>
                                </td>
                                
                                <td class="HpriceTotal">
                                   <h4>
                                      <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.dPrice *(1- wdRez.dDiscount*0.01)}" />원
                                   </h4>
                                </td>
                                
                                <td>
                                    <input type="button" value="x" class="w-btn-red delBtnWish" id="delBtnWishD">
                                </td>
                            </tr>
</c:if>

                            <!-- 메 -->
<c:if test="${!empty wdRez.mCode}">
                            <tr id="wishM">
                                <td class="image-prod">
                                   <div class="imgbox"  onclick="fn_view4('${wdRez.mCode}')">
                                      <img src="../resources/images/makeup/${wdRez.mImgName}" id="prod" class="wishImg">
                                   </div>
                                </td>
                                
                                <td class="product-name alignleft">
                             <p><h4>&nbsp;<c:out value="${wdRez.mName}" /></h4></p>
                             <!-- 주소 넣어야 할까유?? -->
                          </td>
                                
                                <td class="HpriceTd alignleft">
                                   <p class="Hpc">비용&nbsp; <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.mPrice *(1- wdRez.mDiscount*0.01)}" />원
<c:if test="${!empty wdRez.mPlusNum}"> 
                                   &nbsp;&nbsp;/&nbsp;&nbsp; 추가비용&nbsp; <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.mPlus * wdRez.mPlusNum}" />원</p>
</c:if>                                 
                                   <p class="sangsaeP">
                                      <span class="chamgo">
                                         할인: <span id="discountSpan">${wdRez.mDiscount}% &nbsp;&nbsp;</span></span>
                                         <span id="xPrice"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.mPrice}" />원 </span>&nbsp;&nbsp;
                                         <span id="nPrice"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.mPrice *(1- wdRez.mDiscount*0.01)}" />원</span>
                                      
                                   </p>   
<c:if test="${!empty wdRez.mPlusNum}">
                                   <p class="sangsaeP">
                                      <span class="chamgo">                                        
                                         추가비용: <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.mPlus}" />원 x ${wdRez.mPlusNum}명 = <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.mPlus * wdRez.mPlusNum}" />원
                                      </span>
                                   </p>
</c:if>
                                </td>
                                
                                <td class="HpriceTotal">
                                   <h4>
                                      <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.mPrice *(1- wdRez.mDiscount*0.01)+ (wdRez.mPlus*wdRez.mPlusNum)}" />원
                                   </h4>
                                </td>
                                
                                <td>
                                    <input type="button" value="x" class="w-btn-red delBtnWish" id="delBtnWishM">
                                </td>
                            </tr>
</c:if>
</c:if>
<c:if test="${empty wdRez.whCode and empty wdRez.sCode and empty wdRez.dNo and empty wdRez.mCode}">
                     <tr>
                     <td colspan="5">
                     <div style="text-align: center; padding-bottom: 30px;">
                     <img src="../resources/images/icons/basket.png" style="width:100px; margin:30px;"/>
                     <p>장바구니에 담긴 상품이 없습니다.</p>
                     </div>
                     </td>
                     </tr>
</c:if>
                        </table>
               
               </div>
               <!-- 경계선 종료 -->

               <div class="col-lg-1"></div>
            
               <div class="col-lg-1"></div>
               <div class="col-lg-10">
<c:if test="${!empty wdRez.rezNo and wdRez.rezNo !=''}">
<c:if test="${!empty wdRez.whCode or wdRez.whCode !='' or !empty wdRez.sCode or wdRez.sCode !='' or !empty wdRez.dNo or wdRez.dNo !='' or !empty wdRez.mCode or wdRez.mCode !=''}">
                  <div class="rez_sum">
                     <dl class="sumbox1">
                        <dt class="sumsec">총상품금액</dt>
                        <dd class="sumpay1" id="preP">
                           <fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hPrice + (wdRez.hFood * wdRez.hMin) + wdRez.sPrice + wdRez.dPrice + wdRez.mPrice + (wdRez.mPlus*wdRez.mPlusNum)}" />원
                        </dd>
                     </dl>
                     
                     <dl class="sumbox3">
                        <dt class="pam">-</dt>
                     </dl>
                     
                     <dl class="sumbox1">
                        <dt class="sumsec">예상할인금액</dt>

                        <dd class="sumpay2" id="saleP"><fmt:formatNumber type="number" maxFractionDigits="0" value="${wdRez.hPrice - (wdRez.hPrice *(1- wdRez.hDiscount*0.01)) + wdRez.sPrice - (wdRez.sPrice *(1- wdRez.sDiscount*0.01)) + wdRez.dPrice - (wdRez.dPrice *(1- wdRez.dDiscount*0.01)) + wdRez.mPrice - (wdRez.mPrice *(1- wdRez.mDiscount*0.01))}" />원</dd>

                     </dl>
                     
                     <dl class="sumbox3">
                        <dt class="pam">=</dt>
                     </dl>
                     
                     <div class="sumbox2">
                        <h5>총 주문금액 &nbsp;

                           <span id="aftP">
                              <fmt:formatNumber type="number" maxFractionDigits="0" 
                              value="${wdRez.hPrice *(1- wdRez.hDiscount*0.01) + (wdRez.hFood * wdRez.hMin) + wdRez.sPrice *(1- wdRez.sDiscount*0.01) + wdRez.dPrice *(1- wdRez.dDiscount*0.01) + wdRez.mPrice *(1- wdRez.mDiscount*0.01)+ (wdRez.mPlus*wdRez.mPlusNum)}" />원
                           </span>
                        </h5>
                     </div>
                     <!-- 총 주문금액 변수 i에 넣어서  totalAmount 에 넣어주기-->
                     <fmt:parseNumber var="i" type="number" value="${wdRez.hPrice *(1- wdRez.hDiscount*0.01) + (wdRez.hFood * wdRez.hMin) + wdRez.sPrice *(1- wdRez.sDiscount*0.01) + wdRez.dPrice *(1- wdRez.dDiscount*0.01) + wdRez.mPrice *(1- wdRez.mDiscount*0.01)+ (wdRez.mPlus*wdRez.mPlusNum)}" />
                     <!-- 카카오 페이 버튼 추가 -->
                     <button type="button" id="payMent" style="border: solid 1px black; background:white; position:relative; top:-18px; color:black;" class="btn btn-primary" title="결제페이지로 이동">결제페이지로 이동</button>
                  </div>
</c:if>
</c:if>
               </div>
               <div class="col-lg-1"></div>
            
            </div>
         </div>         
      </div>
   </div>   


<form name="rezForm" id="rezForm" method="post">
     <input type="hidden" name="WHCode" value="" /> 
      <input type="hidden" name="HCode" value="" /> 
      <input type="hidden" name="sCode" value="" />
      <input type="hidden" name="dNo" value="" />
      <input type="hidden" name="mCode" value="" /> 
</form>
<form name="marryForm" id="marryForm" method="post">
   <input type="hidden" name="year" id="year" value="${year}"/>
   <input type="hidden" name="month" id="month" value="${month}"/>
   <input type="hidden" name="day" id="day" value="${day}"/>
   <input type="hidden" name="rezNo" id="rezNo" value="${wdRez.rezNo}" />
   <input type="hidden" name="dongdong" id="dongdong" value="${wdUser.userId}" />
</form>
      <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  </body>

</html>