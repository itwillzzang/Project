<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="../j/jquery-1.12.1.js"></script>
<style>

body{
background:#FBF5F7;
}
#main{
width:300px;
margin:0 auto;
padding-top:50px;
padding:20px;
border-color:#F5B2C5;
border-style:inset;
margin-top:100px;
}
h1{
color:#F31252;

}
label{
font-size:20px;
}
</style>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/top.css">
</head>

<body>
<jsp:include page="../inc/top.jsp"/>
<%
//세션값 가져오기
String id3=(String)session.getAttribute("id3");
//세션값 없으면 loginForm.jsp
if(id3==null){
	response.sendRedirect("login.jsp");
}
%>
<div id="main">
<h1>회원탈퇴</h1>
<form action="delectPro.jsp" method="post" name="fr">
<label>아이디:</label><input type="text" name="id" value="<%=id3 %>" readonly><br>
<label>비밀번호:</label><input type="password" name="passwd"><br>
<center style="margin-top:20px;"><input type="submit" value="회원삭제" ></center>
</form>
<a href="../index.jsp">메인으로이동</a>




</body>
</div>
<div id="name"></div>

<script>
$('#main').mouseover(function(){

	$('#name').html(function(index,html){
		
		if(<%=id3%>!==null){
		return html +"<%=id3%> 님 정말 탈퇴할꺼야?!!!!~ <br>다시생각해봥!"
				}else{
					return html + "헐~"
				}
	
	
		
		
	}).css('font-size','25px').css('color','#F7053E').css('width','350px').css('margin','0 auto').css('margin-top','50px')})
	.mouseout(function(){
		$('#name').empty();
		
	})
	





</script>

</html>