<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>

<body>
    <div id="led_group" align="center">
    	<h5>청첩장</h5>
    	<textarea class="autosize" onkeydown="resize(this)" onkeyup="resize(this)" id="led_text" charset="UTF-8" >www.naver.com</textarea>
    	<button type="button" i="led_btn1" onclick="btn1_click()">확인</button>
    	<div id="qrcode" style="width: 100px; height: 100px; margin-top:15px;"></div>
    </div>
    
<script>
var qrcode = new QRCode(document.getElementById("qrcode"),{
	width: 100,
	height: 100
});

function makeCode()
{
	var elText = document.getElementById("led_text");
	
	if(!elText.value)
	{
		alert("InPut a Text");
		elText.focus();
		return;
	}
	//alert(elText.value);
	qrcode.makeCode(elText.value);
}

function btn1_click()
{
	makeCode();
/*	
	var areatext = $("#led_text").val();
	var cmd = "123";
	alert(areatext);
	areatext = encodeURIComponent(areatext);
	
	if(areatext !== "")
	{
		//구글API URL
		var gqrapi = "http://chart.apis.google.com/chart?chs=177x177&cht=qr&chl=";
		//이미지가 나타날 영역에 원하는 내용을 넣은 QR Code의 이미지를 출력합니다.
		//여기 주소 부분울 변경해주면 원하는 값을 언제든 ㄴ맘대로
		$("#qreimg").attr('src', gqrapi + cmd + areatext);
	}
	else
	{
		areatext.empty().text("인코딩할 데이터를 입력하세요" + '$choe=UTF-8');
	}*/
}

function resize(obj)
{
	obj.style.height = "1px";
	obj.style.height = (12 + obj.scrollHeight) + "px";
}
</script>    
    
</body>

</html>