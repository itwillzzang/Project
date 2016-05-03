<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/top.css">
</head>

<style>
.arrow_box {
	position: relative;
	background: #88b7d5;
	border: 4px solid #c2e1f5;
	width:300px;
	height:50px;
	margin: 0 auto;
}
.arrow_box:after, .arrow_box:before {
	top: 100%;
	left: 50%;
	border: solid transparent;
	content: " ";
	height: 0;
	width: 0;
	position: absolute;
	pointer-events: none;
}

.arrow_box:after {
	border-color: rgba(136, 183, 213, 0);
	border-top-color: #88b7d5;
	border-width: 30px;
	margin-left: -30px;
}
.arrow_box:before {
	border-color: rgba(194, 225, 245, 0);
	border-top-color: #c2e1f5;
	border-width: 36px;
	margin-left: -36px;
}

#notice p{
color:#070762;
font-size:20px;
font-style: italic;
margin-left:27px;
margin-top:6px;
}

</style>

<body>

<jsp:include page="../inc/top3.jsp"/>
<h1>오직 관리자만이 </br>
이곳을 허락한다!</h1>


<div id="notice" class="arrow_box">
<p>ID:admin Password:1234</p>
</div>


<div id="1">
<form action="aloginPro.jsp" method="post" name="fr">
아이디:<input type="text" name="id2"><br>
비밀번호:<input type="password" name="passwd"><br>
<input type="submit" value="로그인">
<input type="button" value="고객화면으로" onclick="document.location='../index.jsp'">
</form>

</div>





<script src="../j/jquery-1.12.1.js"></script>
	<script>
	$(document).ready(function(){
	
		//div태그 click()
		$('h1').css('margin','0 auto').css('text-align','center').css('padding','100px').css('color','#0000FF').css('font-size','150px')	
		$('#1').css('width','500px').css('height','300px').css('margin','0 auto')
		$('label').css('margin','5px').css('font-size','20px')
				$('input').css('margin','5px').css('font-size','20px')	
		$('body').css('background','#C0E0FF');	
		
	});
	
	$('#notice').click(function(){
		$(this).before().toggle('fast',function(){
			
		});
	});

	
	</script>



</body>
</html>

