<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

    <!-- jQuery -->
    <script src="../resources/js/jquery-2.1.0.min.js"></script>
    <script type="text/javascript" src="../resources/js/jquery.colorbox.js"></script>
    
    <!-- 보현추가 -->
   <script type="text/javascript" src="../resources/js/slick.min.js"></script>

    <!-- Bootstrap -->
    <script src="../resources/js/popper.js"></script>
    <script src="../resources/js/bootstrap.min.js"></script>
    <script src="../resources/js/bootstrap.js"></script>

    <!-- Plugins -->
    <script src="../resources/js/jquery.colorbox.js"></script>
    <script src="../resources/js/jquery.bxslider.js"></script>
    <script src="../resources/js/jquery.bxslider.min.js"></script>
    <script src="../resources/js/scrollreveal.min.js"></script>
    <script src="../resources/js/waypoints.min.js"></script>
    <script src="../resources/js/jquery.counterup.min.js"></script>
    <script src="../resources/js/imgfix.min.js"></script> 
    <script src="../resources/js/mixitup.js"></script> 
    <script src="../resources/js/accordions.js"></script>
    <script src="../resources/js/owl-carousel.js"></script>

    <script>
function termsofuse(){
   $('#MoaModal .modal-content').load("/Termsofuse");
   $('#MoaModal').modal();
}
</script>
    


<script>    
	$(document).ready(function(){
		   $("#policy").colorbox({
			      iframe:true, 
			      innerWidth:1235,
			      innerHeight:400,
			      overlayClose:true,
			      escKey:true,
			      closeButton:true,
			      scrolling:true,
			      onComplete:function()
			      {
			         $("#colorbox").css("width", "1235px");
			         $("#colorbox").css("height", "400px");
			         $("#colorbox").css("border-radius", "10px");
			 
			         $('html').css("overflow","hidden");
			      },
			      onClosed:function()
			      {
			    	 $('html').css("overflow","auto");
			      }
			   });
	});
	
	$(document).ready(function(){
		   $("#terms").colorbox({
			      iframe:true, 
			      innerWidth:1235,
			      innerHeight:400,
			      overlayClose:true,
			      escKey:true,
			      closeButton:true,
			      scrolling:true,
			      onComplete:function()
			      {
			         $("#colorbox").css("width", "1235px");
			         $("#colorbox").css("height", "400px");
			         $("#colorbox").css("border-radius", "10px");
			         
			         $('html').css("overflow","hidden");
			      },
			      onClosed:function()
			      {
			    	 $('html').css("overflow","auto");
			      }
			   });
	});
</script>    

