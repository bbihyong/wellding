<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head2.jsp" %>
<style>
*, ::after, ::before {
   box-sizing: unset;
}
.table-hover th, td{
   border: 1px solid #c4c2c2;
   text-align: center;
}

.sel{
   background: #f5a4aa;
}
.wookhall{
   width: 120px;
}

/*다크모드관련*/
.btn-toggle
{
	background: none;
    position: absolute;
    top: 5px;
    right: 0;
    border: none;
    outline: none;
    color: #ccc;
    font-size: 13px;
    text-decoration: underline;
}

button:focus
{
	outline: none;
}
.btn-toggle:active
{
	outline: none!important;
}
/*다크모드 */
body {  color: #efefef; background: #121212;} 
a 
{ 
	color: red;
    font-weight: 600; 
} 
td,th {color: #eee;}
span {color: #efefef;}
p{color: #efefef;}
.page-link
{
	background: #555!important;
   /* border: none;*/
}
/* Dark Mode 아닐떄 */ 
body.dark-theme { color: #222; background: #fff; } 
body.dark-theme a { }
body.dark-theme td,th {color: #333;}
body.dark-theme .page-link.active
{
	    background: #f5a4aa!important;
}

</style>
<script type="text/javascript" src="../resources/js/jquery.colorbox.js"></script>
<script>

$(document).ready(function(){
    $(".detailView").colorbox({
          iframe:true, 
          innerWidth:1200,
          innerHeight:700,
          scrolling:true,
          onComplete:function()
          {
             $("#colorbox").css("width", "1200px");
             $("#colorbox").css("height", "700px");
             $("#colorbox").css("border-radius", "10px");
             
             $('html').css("overflow","hidden");
          } , 
          onClosed: function()
	          {
	            $('html').css("overflow","auto");
	          }  
        
    });
    
	    //다크모드
	    const btn = document.querySelector('.btn-toggle');
	    btn.addEventListener('click', function() {
	    	document.body.classList.toggle('dark-theme'); 
	    	});
    
		
	});

function fn_search()
{
   document.searchForm.curPage.value = 1; //검색한단 이야기는 첨부터 한다는 뜻이라 1부터
   document.searchForm.action = "/mng/payMentList";
   document.searchForm.submit();
}

function fn_paging(curPage)
{
   document.searchForm.curPage.value = curPage; //매개변수로 받은 현재페이지를 가져옴
   document.searchForm.action = "/mng/payMentList";
   document.searchForm.submit();
}

function fn_pageInit() //서치타입과 서치밸유에대한 설정
{
   $("#searchType option:eq(0)").prop("selected", true);//eq(0): 아무것도 선택안함
   $("#searchValue").val("");
   
   fn_search();      
}

function fn_confirm()
{
	if(confirm("결제 취소 요청을 승인하시겠습니까?"))
	{
		alert("결제 취소 요청이 승인되었습니다.");
	}
	else
	{
		alert("결제 취소 요청이 거부되었습니다.");
	}	
}

</script>
</head>
<body id="school_list" class="light-theme || dark-theme"> 
	
	<jsp:include page="/WEB-INF/views/include/adminNav.jsp" >
       <jsp:param name="userName" value="${wdAdmin.admName}" />
       </jsp:include>
       
<div>
<button class="btn-toggle">다크모드</button>
</div>       
       
<div class="container">
    <div class="row">
    	<div class="col-lg-12" style="width:100%; height:20px;"></div>
    	
        <div class="col-lg-12">       
		   <div id="school_list" style="width:90%; margin:auto; margin-top:20px;">
	      <div class="mnb" style="display:flex; margin-bottom:0.8rem;">
	         <h2 style="margin-right:auto; color: #525252;">결제 내역 리스트</h2>
	         <form class="d-flex" name="searchForm" id="searchForm" method="post" style="place-content: flex-end;">
	            <select id="rezStatus" name="rezStatus" style="font-size: 1rem; width: 6rem; height: 3rem;">
	               <option value="">상태</option>
	               <option value="Y" <c:if test="${rezStatus == 'Y'}">selected</c:if>>결제완료</option>
	               <option value="N" <c:if test="${rezStatus == 'N'}">selected</c:if>>예약완료</option>
	               <option value="C" <c:if test="${rezStatus == 'C'}">selected</c:if>>취소대기</option>
	               <option value="D" <c:if test="${rezStatus == 'D'}">selected</c:if>>취소완료</option>
	            </select>
	            <select id="searchType" name="searchType" style="font-size: 1rem; width: 8rem; height: 3rem; margin-left:.5rem; ">
	               <option value="1" <c:if test="${searchType eq '1'}">selected</c:if>>회원아이디</option>
	               <option value="2" <c:if test="${searchType eq '2'}">selected</c:if>>예약번호</option>
	            </select>
	            <input name="searchValue" id="searchValue" class="form-control me-sm-2" style="width:15rem; margin-left:.5rem;" type="text" value="${searchValue}">
	            <a class="btn my-2 my-sm-0" href="javascript:void(0)" onclick="fn_search()" style="width:7rem; margin-left:.5rem; background-color: rgb(239, 239, 239); border-color:rgb(118, 118, 118);">조회</a>
	            <input type="hidden" name="curPage" value="" />
	            
	         </form>
	      </div>
	      <div class="school_list_excel">
	         <table class="table table-hover" style="border:1px solid #c4c2c2;">
	            <thead style="border-bottom: 1px solid #c4c2c2;">
	            <tr class="table-thead-main" style="background: #ddd;">
	               <th scope="col" style="width:20%;">아이디</th>
	               <th scope="col" style="width:15%;">예약번호</th>
	               <th scope="col" style="width:15%;">상품</th>
	               <th scope="col" style="width:15%;">가격</th>
	               <th scope="col" style="width:15%;">상태</th>
	               <th scope="col" style="width:20%;">취소승인 관리</th>
	               
	            </tr>
	            </thead>
	            <tbody>
	            <c:if test="${!empty list}">
	            <c:forEach  var="payment" items="${list}" varStatus="status">
	            <tr>
	                <th scope="row" class="table-thead-sub" style="border: 1px solid #c4c2c2;">${payment.userId}</th>
	                <td><a href="/mng/detailView?rezNo=${payment.rezNo}" class ="detailView" name ="detailView">${payment.rezNo}</a></td>	             
	                <td>
	                <c:if test="${!empty payment.hCode}">H</c:if>
	                <c:if test="${!empty payment.sCode}">S</c:if>
	                <c:if test="${!empty payment.dNo }">D</c:if>
	                <c:if test="${!empty payment.mCode}">M</c:if>
	                </td>
	                <td><fmt:formatNumber type="number" maxFractionDigits="0" value="${payment.rezFullPrice}"/></td>
	                <td><c:if test="${payment.rezStatus == 'Y'}">결제완료</c:if><c:if test="${payment.rezStatus == 'N'}">예약완료</c:if><c:if test="${payment.rezStatus == 'C'}">취소대기</c:if><c:if test="${payment.rezStatus == 'D'}">취소완료</c:if></td>
	                <td><c:if test="${payment.rezStatus == 'C'}"><a href="/mng/payMentList?rezNo=${payment.rezNo}" onclick="fn_confirm()">결제 취소</a></c:if></td>
	            </tr>		
	            </c:forEach>
	            </c:if>
	            <c:if test="${empty list}">
	            <tr>
	            	<td colspan="5">등록된 결제 내역 정보가 없습니다.</td>
	            </tr>
	            </c:if>
	            </tbody>
	         </table>
	               
      <ul class="pagination justify-content-center">
		<c:if test="${!empty paging}">
			
			<c:if test="${paging.prevBlockPage gt 0}">
	        <!-- 이전 블럭이 있다는 뜻임, 이전 블럭 페이지가 0보다 크면. -->
	         	<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_paging(${paging.prevBlockPage})">이전</a></li>
			</c:if>
			
	   		<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">

	   			<c:choose>
	   				<c:when test="${i ne curPage}">
	         			<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_paging(${i})">${i}</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor: default;">${i}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
                  <!-- 페이지 종료 -->
                  <!--  다음 블럭 시작 -->
                  <c:if test="${paging.nextBlockPage gt 0}">
                     <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_paging(${paging.nextBlockPage})">다음</a></li>
               </c:if>
                  <!--  다음 블럭 종료 -->
            </c:if>
               <!-- 페이징 샘플 종료 -->
               </ul>
            </div>
         </div>
      </div>
   </div>
  </div>
 
  
	<%@ include file="/WEB-INF/views/include/footer3.jsp" %>
</body>
</html>
