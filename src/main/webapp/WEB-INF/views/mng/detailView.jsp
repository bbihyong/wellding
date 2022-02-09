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

</script>
</head>
<body>
<div class="container">
    <div class="row">
       <div class="col-lg-12">  
		<div class="layerpopup" style="width:100%; margin:auto;">
			<h1 style="font-size: 1.6rem; margin-top: 3rem; margin-bottom: 1.6rem; padding: .5rem 0 .5rem 1rem; background-color: #e0e4fe;">예약 내용 상세보기</h1>
		   <div class="layer-cont">
		      <form name="regForm" id="regForm" method="post">
		         <table>
		            <tbody>
		            	<tr>
		                  <th scope="row">예약번호</th>
		                  <td style="text-align: left;">
		                  	${wdRez.rezNo}
		                  </td>
		            	</tr>
		            	<tr>
		                  <th scope="row">결혼날짜</th>
		                  <td style="text-align: left;">
		                  	${wdRez.wDate}
		                  </td>
		            	</tr>
		            	
		            	<tr>
		                  <th scope="row">아이디</th>
		                  <td style="text-align: left;">
		                  	${wdRez.userId}	    
		                  </td>
		            	</tr>
<c:if test="${!empty wdRez.whName}">
		            	<tr>
		                  <th scope="row">웨딩홀 업체명</th>
		                  <td style="text-align: left;">
		                  	${wdRez.whName}		    
		                  </td>
		            	</tr>
		               <tr>
		                  <th scope="row">홀 이름</th>
		                  <td style="text-align: left;">
		                  	${wdRez.hName}	                  
		                  </td>
		               </tr>
</c:if> 
<c:if test="${!empty wdRez.sName}">
		               <tr>
		                  <th scope="row">스튜디오 이름</th>
		                  <td>
		                    ${wdRez.sName} (스튜디오 촬영일: ${wdRez.sDate})
		                  </td>
		                </tr>
</c:if>
<c:if test="${!empty wdRez.dcName}">
		               <tr>
		                  <th scope="row">드레스 업체명</th>
		                  <td style="text-align: left;">
		                  	${wdRez.dcName}	                  
		                  </td>
		               </tr>
</c:if>
<c:if test="${!empty wdRez.dName}">
		               <tr>
		                  <th scope="row">드레스명</th>
		                  <td style="text-align: left;">
		                  	${wdRez.dName}	                  
		                  </td>
		               </tr>
</c:if>
<c:if test="${!empty wdRez.mName}">
		               <tr>
		                  <th scope="row">메이크업 업체명</th>
		                  <td style="text-align: left;">
		                  	${wdRez.mName}	                  
		                  </td>
		               </tr>
</c:if>         
		            </tbody>
		         </table>
		      </form>
		  </div>
	</div>
	
			<table style="border:none; margin-bottom: 60px;">
				<tr style="border:none;">
					<td style="border:none;">
					      <div class="pop-btn-area" style="display: block; float: right;">					        
					         <button onclick="fn_colorbox_close()" id="colorboxClose" class="btn-type01" style="margin-left: 1rem;"><span>닫기</span></button>
					      </div>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/include/footer3.jsp" %>
</body>
</html>