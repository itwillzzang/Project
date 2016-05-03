<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
background:#ECF3D8;
}
#main{
width:400px;
margin:0 auto;
margin-top:50px;
padding-left:50px;
border-style:inset;
border-color:#C1E8C4;
}
h1{
color:#0E2B17;
}
label{
margin:20px;
padding:5px;
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
//세션값 없으면 login.jsp
if(id3==null){
	response.sendRedirect("login.jsp");
}

//디비객체 생성 MemberDAO   mdao
MemberDAO mdao=new MemberDAO();
//변수 MemberBean mb=메서드호출  getMember(id)
MemberBean mb=mdao.getMember(id3);
		String gender=mb.getGender();
		if(gender==null){
			gender="남";//성별이 null 기본 남 설정
		}
%>
<div id="main">
<h1>회원수정</h1>
<form action="updatePro.jsp" method="post" name="fr">
<label>아이디:</label><input type="text" name="id" value="<%=mb.getId()%>" readonly><br>
<label>비밀번호:</label><input type="password" name="passwd"><br>
<label>이름:</label><input type="text" name="name" value="<%=mb.getName()%>"><br>
<label>성별:</label><input type="radio" name="gender" value="남" <% if(gender.equals("남")){%> checked <%} %>>남
<input type="radio" name="gender" value="여" <% if(gender.equals("여")){%> checked <%} %> >여<br>
<label>이메일주소:</label><input type="text" name="email" value="<%=mb.getEmail()%>"><br>
<center style="margin-top:20px;"><input type="submit" value="회원수정"></center>
</form>
<label><a href="../index.jsp">홈으로 GO!</a></label>




</body>

</div>
<div id="name"></div>

<script>
$('#main').mouseover(function(){

	$('#name').html(function(index,html){
		
		if(<%=id3%>!==null){
		return html +"<%=id3%> 님.... 뭘바꿀려고 그래?~~~~~~ㅋ"
				}else{
					return html + "잉?"
				}
		
	}).css('font-size','20px').css('color','#0E2B17').css('margin','0 auto').css('width','400px').css('margin-top','100px')})
	.mouseout(function(){
		$('#name').empty();
		
	})
	





</script>




</html>