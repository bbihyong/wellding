<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
   // GNB 번호 (사용자관리)
   request.setAttribute("_gnbNo", 1);
%>
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
.wookbtnzxc {
	position: relative;
    left: 50px;
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
a { } 
td,th {color: #eee;}
span {color: #efefef;}
.page-link
{
	background: #555!important;
    border: none;
}
/* Dark Mode styles */ 
body.dark-theme { color: #222; background: #fff; } 
body.dark-theme a { }
body.dark-theme td,th {color: #333;}
body.dark-theme .eBoardUpdate {color: #333;}
/*body.dark-theme .page-link
{
	    background: #f5a4aa!important;
}*/

</style>
<script type="text/javascript" src="../resources/js/jquery.colorbox.js"></script>
<script>

$(document).ready(function(){
      $(".eBoardUpdate").colorbox({
            iframe:true, 
            innerWidth:1235,
            innerHeight:600,
            scrolling:true,
            onComplete:function()
            {
               $("#colorbox").css("width", "1235px");
               $("#colorbox").css("height", "600px");
               $("#colorbox").css("border-radius", "10px");
               
               $('html').css("overflow","hidden");
            } , 
            onClosed: function()
	          {
	            $('html').css("overflow","auto");
	          }  
      });
      
      $(".plusEBoard").colorbox({
          iframe:true, 
          innerWidth:1235,
          innerHeight:450,
          scrolling:false,
          onComplete:function()
          {
             $("#colorbox").css("width", "1235px");
             $("#colorbox").css("height", "450px");
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
   document.searchForm.curPage.value = "1"; //검색한단 이야기는 첨부터 한다는 뜻이라 1부터
   document.searchForm.action = "/mng/eBoardList";
   document.searchForm.submit();
}

function fn_paging(curPage)
{
   document.searchForm.curPage.value = curPage; //매개변수로 받은 현재페이지를 가져옴
   document.searchForm.action = "/mng/eBoardList";
   document.searchForm.submit();
}

function fn_pageInit() //서치타입과 서치밸유에대한 설정
{
   $("#searchType option:eq(0)").prop("selected", true);//eq(0): 아무것도 선택안함
   $("#searchValue").val("");
   
   fn_search();      
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
    <div class="row" style="width:100%;">
       <div class="col-lg-12" style="width:100%; height:20px;"></div>
       
        <div class="col-lg-12">       
         <div id="school_list" style="width:90%; margin:auto; margin-top:20px;">
         <div class="mnb" style="display:flex; margin-bottom:0.8rem;">
            <h2 style="margin-right:auto; color: #525252;">이벤트 관리</h2>
            <form class="d-flex" name="searchForm" id="searchForm" method="post" style="place-content: flex-end;">
               <select id="searchType" name="searchType" style="font-size: 1rem; width: 8rem; height: 3rem; margin-left:.5rem; ">
                  <option value="">검색타입</option>
                  <option value="1" <c:if test="${searchType eq '1'}">selected</c:if>>제목</option>
                  <option value="2" <c:if test="${searchType eq '2'}">selected</c:if>>내용</option>
               </select>
               <input name="searchValue" id="searchValue" class="form-control me-sm-2" style="width:15rem; margin-left:.5rem;" type="text" value="${searchValue}"  placeholder="조회값을 입력하세요.">
               <a class="btn my-2 my-sm-0" href="javascript:void(0)" onclick="fn_search()" style="width:7rem; margin-left:.5rem; background-color: rgb(239, 239, 239); border-color:rgb(118, 118, 118);">조회</a>
               <input type="hidden" name="curPage" value="" />
            </form>
         </div>
         <div class="school_list_excel">
            <table class="table table-hover" style="border:1px solid #c4c2c2;">
               <thead style="border-bottom: 1px solid #c4c2c2;">
               <tr class="table-thead-main" style="background: #ddd;">
                  <th scope="col" style="width:15%;">번호</th>
                  <th scope="col" style="width:40%;">제목</th>
                  <th scope="col" style="width:15%;">작성자</th>
                  <th scope="col" style="width:15%;">날짜</th>
                  <th scope="col" style="width:15%;">조회</th>
               </tr>
               </thead>
               <tbody>
               <c:if test="${!empty eBoard}">
               <c:forEach items="${eBoard}" var="eboard" varStatus="status">
               <tr>
               	   <td><a href="/mng/eBoardUpdate?eBSeq=${eboard.eBSeq}" name="eBoardUpdate" class="eBoardUpdate">${eboard.eBSeq}</a></td>
                   <th scope="row" class="table-thead-sub" style="border: 1px solid #c4c2c2;">
                   	<a href="/mng/eBoardUpdate?eBSeq=${eboard.eBSeq}" name="eBoardUpdate" class="eBoardUpdate">${eboard.eBTitle}</a>
                   </th>
                   <td>${eboard.adminId}</td>
                   <td>${eboard.regDate}</td>
                   <td>${eboard.eBReadCnt}</td>
               </tr>
               </c:forEach>
               </c:if>
               <c:if test="${empty eBoard}">
               <tr>
                  <td colspan="5">등록된 게시물이 없습니다.</td>
               </tr>
               </c:if>
               </tbody>
            </table>
         
 			<div class="row">
              <div class="col-lg-12">
                 <div>
                 	 <a href="/mng/plusEBoard" id="btnWrite" class="hsdm_btn plusEBoard" style="margin-right:30px; margin-top: 0;">추가하기</a>
                 </div>
            </div>
         </div>
		     <div class="col-lg-12" style="left:43%;">
                <div class="pagination">
               <ul class="pagination justify-content-center">
                  <c:if test="${!empty paging}">
                     <c:if test="${paging.prevBlockPage gt 0}">   <!-- prevBlockPage이 0 보다 크냐 -->
                     <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_paging(${paging.prevBlockPage})">이전</a></li>
                     </c:if>
                     <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
                        <c:choose>
                           <c:when test="${i ne curPage}">
                              <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_paging(${i})">${i}</a></li>
                           </c:when>
                           <c:otherwise>
                              <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default">${i}</a></li>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                     <c:if test="${paging.nextBlockPage gt 0}">         
                        <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_paging(${paging.nextBlockPage})">다음</a></li>
                     </c:if>       
                  </c:if> 
               </ul>
                  </div>
              </div>
         
         </div>
      </div>
   </div>
  </div>
</div>
	<%@ include file="/WEB-INF/views/include/footer3.jsp" %>
</body>
</html>
