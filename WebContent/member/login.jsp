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
<body>

<jsp:include page="../inc/top.jsp"/>
<h1>얌얌의 세계로 온것을 </br>
환영한다!</h1>
<div id="1">
<form action="loginPro.jsp" method="post" name="fr">
<label>아이디</label> : <input type="text" name="id"><br>
<label>비밀번호</label> : <input type="password" name="passwd"><br>
<input type="submit" value="로그인">
<input type="button" value="회원가입" onclick="location.href='join.jsp'">
</form>
</div>





<script src="../j/jquery-1.12.1.js"></script>
	<script>
	$(document).ready(function(){
	
		//div태그 click()
		$('h1').css('margin','0 auto').css('text-align','center').css('padding','100px').css('color','#E9626C').css('font-size','150px')	
		$('#1').css('width','500px').css('height','300px').css('margin','0 auto')
		$('label').css('margin','5px').css('font-size','20px')
				$('input').css('margin','5px').css('font-size','20px')	
		$('body').css('background','#FFE0E0');	
		
	});
	</script>



</body>
</html>

